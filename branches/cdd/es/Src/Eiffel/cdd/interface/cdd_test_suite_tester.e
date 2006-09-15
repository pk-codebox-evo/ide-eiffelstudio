indexing
	description: "Objects that execute test runs on test cases stored in a suite"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE_TESTER

inherit

	CDD_CONSTANTS

	SHARED_PLATFORM_CONSTANTS
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	SHARED_EXEC_ENVIRONMENT
		export
			{NONE} all
		end

create
	make_with_manager


feature {NONE} -- Initialization

	make_with_manager (a_manager: like manager) is
			-- Set 'test_suite' to 'a_test_suite' and initialize attributes.
		require
			a_manager_not_void: a_manager /= Void
		do
			manager := a_manager
			create test_suite_tools.make
			idle_action_agent := agent idle_action
			create output.make
		ensure
			manager_set: manager = a_manager
		end

feature -- Access

	manager: CDD_TEST_SUITE_MANAGER
			-- Manager for retrieving test suite

	test_suite: CDD_TEST_SUITE is
			-- Test suite containing test cases
		require

		do
			Result := manager.test_suite
		end

	is_running: BOOLEAN
			-- Is 'Current' running?

	is_paused: BOOLEAN
			-- Is current test execution paused?

	is_testing: BOOLEAN
			-- Is 'Current' running test cases?

	current_test_case: CDD_TEST_CASE is
			-- Test case currently under test
		require
			testing: is_testing
		do
			Result := cursor.item
		end

	manages_tool (a_tool: CDD_TEST_SUITE_TOOL): BOOLEAN is
			-- Does 'Current' manage 'a_tool'?
		require
			a_tool_not_void: a_tool /= Void
		do
			Result := test_suite_tools.has (a_tool)
		end


feature -- Execution control

	start is
			-- Start testing execution.
		require
			not_running: not is_running
			test_suite_not_empty: not test_suite.test_cases.is_empty
		local
			l_cmd: STRING
		do
			printer.print_test_case (test_suite)
			create l_cmd.make_empty
			l_cmd.append ("ec -config ")
			l_cmd.append (test_suite.tests_cluster.target.system.file_name)
			l_cmd.append (" -target ")
			l_cmd.append (test_suite.tester_target.name)
			l_cmd.append (" -c_compile -batch -stop")
			create_process (l_cmd, test_suite.tests_cluster.target.system.directory)
			is_running := True
			process.launch
			ev_application.add_idle_action (idle_action_agent)
			notify_all_tools (agent notify_start_testing)
		end

	pause is
			-- Pause testing execution.
		require
			running: is_running
			not_paused: not is_paused
		do
			ev_application.remove_idle_action (idle_action_agent)
			process.terminate
			is_paused := True
			notify_all_tools (agent notify_pause_testing)
		end

	resume is
			-- Resume testing execution.
		require
			paused: is_paused
		do
			is_paused := False
			process.launch
			ev_application.add_idle_action (idle_action_agent)
			notify_all_tools (agent notify_resume_testing)
		end

	stop is
			-- Stop testing.
		require
			running: is_running
		do
			ev_application.remove_idle_action (idle_action_agent)
			process.terminate
			process := Void
			cursor := Void
			is_running := False
			if is_testing then
				current_test_case.set_passes (False)
			end
			is_testing := False
			notify_all_tools (agent notify_stop_testing)
		end

feature {NONE} -- Status setting

	idle_action_agent: PROCEDURE [ANY, TUPLE]
			-- Agent for 'idle_action'

	idle_action is
			-- Check status of the process and its output
		require
			running: is_running
		local
			l_output: STRING
		do
			if process.has_exited then
				if is_testing then
					current_test_case.set_passes (process.exit_code = 0)
					cursor.forth
					if not cursor.after then
						test_current_test_case
					else
						is_running := False
						is_testing := False
						process := Void
						ev_application.remove_idle_action (idle_action_agent)
					end
				else
					if process.exit_code = 0 then
						cursor := test_suite.test_cases.new_cursor
						cursor.start
						is_testing := True
						test_current_test_case
					else
						-- TODO: notify tools that compilation has failed
						is_running := False
						process := Void
						ev_application.remove_idle_action (idle_action_agent)
					end
				end
			end
			if output.has_new_block then
				l_output := output.all_blocks (True).string_representation
				notify_all_tools (agent notify_append_output (?, l_output))
			end
			if process = Void then
				notify_all_tools (agent notify_finish_testing)
			end
		end

feature {NONE} -- Implementation

	test_current_test_case is
			-- Initialize process for testing 'current_test_case' and launch process.
		require
			testing: is_testing
		local
			l_cmd: STRING
		do
			current_test_case.start_testing
			create l_cmd.make_empty
			l_cmd.append ("./test_system ")
			l_cmd.append (current_test_case.test_class.name)
			create_process (l_cmd, test_suite.tests_cluster.target.system.directory + "/EIFGENs/" + test_suite.tester_target.name + "/W_code")
			process.launch
		ensure
			testing: is_testing
		end


feature -- Element change

	add_tool (a_tool: CDD_TEST_SUITE_TOOL) is
			-- Extend 'test_suite_tools' with 'a_tool'
		require
			a_tool_not_void: a_tool /= Void
			not_added_yet: not manages_tool (a_tool)
		do
			test_suite_tools.put_last (a_tool)
		ensure
			added: manages_tool (a_tool)
		end

	remove_tool (a_tool: CDD_TEST_SUITE_TOOL) is
			-- Remove 'a_tool' from 'test_suite_tools'
		require
			a_tool_not_void: a_tool /= Void
			added: manages_tool (a_tool)
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_SUITE_TOOL]
		do
			l_cursor := test_suite_tools.new_cursor
			l_cursor.start
			l_cursor.search_forth (a_tool)
			l_cursor.remove
		ensure
			removed: not manages_tool (a_tool)
		end

feature -- Process handlers

	output_handler (an_output: STRING) is
			-- Append 'an_output' to output.
		require
			an_output_not_void: an_output /= Void
		local
			l_storage: EB_PROCESS_IO_STRING_BLOCK
		do
			create l_storage.make (an_output, False, False)
			output.extend_block (l_storage)
		end

feature {NONE} -- Implementation

	process_factory: PROCESS_FACTORY is
			-- Factory for creating platform independent process instances
		once
			create Result
		end

	create_process (a_cl, a_wd: STRING) is
			-- Create a new process instance with default settings
			-- for calling 'a_cmd' in directory 'a_wd'.
		require
			a_cmd_valid: a_cl /= Void and then not a_cl.is_empty
			a_wd_valid: a_wd /= Void and then not a_wd.is_empty
			process_not_running: process /= Void implies not process.is_running
		local
			l_args: ARRAYED_LIST [STRING]
			l_cmd: STRING
		do
			if platform_constants.is_windows then
				l_cmd := Execution_environment.get ("COMSPEC")
				if l_cmd /= Void then
					create l_args.make (1)
					l_args.extend ("/c%""+a_cl+"%"")
				else
					l_cmd := a_cl
				end
			else
				create l_args.make (2)
				l_args.extend ("-c")
				l_args.extend ("%'%'"+a_cl+"%'%'")
				l_cmd := "/bin/sh"
			end
			if l_args = Void then
				process := process_factory.process_launcher_with_command_line (l_cmd, a_wd)
			else
				process := process_factory.process_launcher (l_cmd, l_args, a_wd)
			end
			process.redirect_output_to_agent (agent output_handler)
			process.redirect_error_to_same_as_output
			process.set_buffer_size (512)
			process.enable_launch_in_new_process_group
		ensure
			process_not_void: process /= Void
		end

	test_suite_tools: DS_LINKED_LIST [CDD_TEST_SUITE_TOOL]
			-- Managed tools

	notify_all_tools (a_proc: PROCEDURE [ANY, TUPLE [CDD_TEST_SUITE_TOOL]]) is
			-- Call 'a_proc' with each tool in 'test_suite_tools'.
		require
			a_proc_not_void: a_proc /= Void
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_SUITE_TOOL]
		do
			from
				l_cursor := test_suite_tools.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				a_proc.call ([l_cursor.item])
				l_cursor.forth
			end
		end

	notify_start_testing (a_tool: CDD_TEST_SUITE_TOOL) is
			-- Tell 'a_tool' that testing has started.
		require
			a_tool_not_void: a_tool /= Void
		do
			a_tool.start_testing
		end

	notify_stop_testing (a_tool: CDD_TEST_SUITE_TOOL) is
			-- Tell 'a_tool' that testing has stopped.
		require
			a_tool_not_void: a_tool /= Void
		do
			a_tool.stop_testing
		end

	notify_pause_testing (a_tool: CDD_TEST_SUITE_TOOL) is
			-- Tell 'a_tool' that testing has paused.
		require
			a_tool_not_void: a_tool /= Void
		do
			a_tool.pause_testing
		end

	notify_resume_testing (a_tool: CDD_TEST_SUITE_TOOL) is
			-- Tell 'a_tool' that testing has resumed.
		require
			a_tool_not_void: a_tool /= Void
		do
			a_tool.resume_testing
		end

	notify_finish_testing (a_tool: CDD_TEST_SUITE_TOOL) is
			-- Tell 'a_tool' that testing is finished.
		require
			a_tool_not_void: a_tool /= Void
		do
			a_tool.finish_testing
		end

	notify_append_output (a_tool: CDD_TEST_SUITE_TOOL; an_output: STRING) is
			-- Tell 'a_tool' to append 'an_output'.
		require
			a_tool_not_void: a_tool /= Void
			an_output_not_void: an_output /= Void
		do
			a_tool.append_output (an_output)
		end


feature -- Implementation

	process: PROCESS
			-- Currently executed process

	output: EB_PROCESS_IO_STORAGE
			-- stored output from the process

	cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
			-- cursor pointing to current test case

	printer: CDD_TESTER_PRINTER is
			-- printer for generating interpreter root class
		once
			create Result
		end


invariant
	manager_not_void: manager /= Void
	test_suite_tools_not_void: test_suite_tools /= Void
	idle_action_agent_not_void: idle_action_agent /= Void
	is_paused_implies_is_running: is_paused implies is_running
	is_testing_implies_is_running: is_testing implies is_running
	is_testing_implies_correct_cursor: is_testing implies (cursor /= Void and then not cursor.off)

	valid_process_status: is_running = (process /= Void)

end
