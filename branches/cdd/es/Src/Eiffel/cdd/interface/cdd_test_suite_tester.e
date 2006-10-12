indexing
	description: "Objects that execute test runs on test cases stored in a suite"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE_TESTER

inherit

	CDD_CONSTANTS
		export
			{NONE} all
		end

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

	CONF_ACCESS
		export
			{NONE} all
		end

	EB_SHARED_GRAPHICAL_COMMANDS
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
			idle_action_agent := agent idle_action
			create output.make
			create update_status_actions
			create output_actions
			create status_text.make_empty
			create testing_output_buffer.make_empty
		ensure
			manager_set: manager = a_manager
		end

feature -- Access

	manager: CDD_TEST_SUITE_MANAGER
			-- Manager for retrieving test suite

	test_suite: CDD_TEST_SUITE is
			-- Test suite containing test cases
		require
			testing_enabled: manager.is_testing_enabled
		do
			Result := manager.test_suite
		end

	can_start_background_testing: BOOLEAN is
			-- Can background testing be launched?
		do
			Result := not is_running and
				not manager.ise_project.is_read_only
		end

	can_start_debugged_testing: BOOLEAN is
			-- Can testing be launched in the debugger?
		do
			Result := can_start_background_testing and
				not manager.ise_project.is_compiling and
				not run_project_cmd.debugger_manager.application.is_running
		end

	is_running: BOOLEAN
			-- Is `Current' executing a test case?
			-- (In debugger or in background)

	is_debugging: BOOLEAN
			-- Is `Current' executing test cases in the debugger?

	is_paused: BOOLEAN
			-- Is current test execution paused?

	is_testing: BOOLEAN
			-- Is 'Current' running test cases?

	test_cases: DS_LIST [CDD_TEST_CASE] is
			-- Test cases currently beeing tested
		require
			running: is_running
		do
			Result := cursor.container
		end

	current_test_case: CDD_TEST_CASE is
			-- Test case currently under test
		require
			testing: is_testing
		do
			Result := cursor.item
		end

	current_index: INTEGER is
			-- Index of `current_test_case' in `test_cases'
		require
			testing: is_testing
		do
			Result := cursor.index
		end

	status_text: STRING
			-- Description of current operation

feature -- Execution control

	start_background_testing is
			-- Run all marked test cases in background
		require
			can_start_background_testing: can_start_background_testing
		local
			l_target: CONF_TARGET
			l_cmd: STRING
			l_new_root: CONF_ROOT
		do
			is_running := True
			cursor := test_suite.test_cases.new_cursor
			create_root_class (True)
			if manager.ise_target.system.targets.has (tester_target_name) then
				remove_tester_target
			end
			l_target := conf_factory.new_target (tester_target_name, manager.ise_target.system)
			manager.ise_target.system.add_target (l_target)
			l_target.set_parent (manager.ise_target)
			create l_new_root.make (test_suite.tests_cluster.cluster_name, root_class_name, root_class_feature_name, False)
			l_target.set_root (l_new_root)
			manager.ise_target.system.store
			create l_cmd.make_empty
			l_cmd.append ("ec -config ")
			l_cmd.append (manager.ise_target.system.file_name)
			l_cmd.append (" -target ")
			l_cmd.append (tester_target_name)
			l_cmd.append (" -c_compile -batch -stop")
			create_process (l_cmd, test_suite.tests_cluster.target.system.directory)
			process.launch
			status_text := "Compiling Interpreter"
			update_status_actions.call ([])
			ev_application.add_idle_action (idle_action_agent)
		ensure
			running: is_running
		end

	start_debugged_testing (a_tc: CDD_TEST_CASE)
			-- Run `a_tc' in the debugger
		require
			a_tc_not_void: a_tc /= Void
			can_start_debugged_testing: can_start_debugged_testing
		local
			l_list: DS_ARRAYED_LIST [CDD_TEST_CASE]
			l_new_root: CONF_ROOT
		do
			is_running := True
			is_debugging := True
			create l_list.make (1)
			l_list.put (a_tc, 1)
			cursor := l_list.new_cursor
			cursor.start
			create_root_class (False)
			old_root := manager.ise_target.root
			create l_new_root.make (test_suite.tests_cluster.cluster_name, root_class_name, root_class_feature_name, False)
			manager.ise_target.set_root (l_new_root)
			manager.ise_target.system.store
			status_text := "Recompiling project"
			update_status_actions.call ([])
			melt_project_cmd.execute_and_wait
			if manager.ise_project.successful then
				is_testing := True
				run_project_cmd.execute
				status_text := "Running " + current_test_case.test_class.name + " in debugger"
				update_status_actions.call ([])
			else
				status_text := "Compilation failed"
				update_status_actions.call ([])
				is_running := False
				is_debugging := False
			end
		ensure
			debugging: is_debugging
		end

	pause is
			-- Pause testing execution.
		require
			running: is_running
			not_paused: not is_paused
		local
			l_app: APPLICATION_EXECUTION
		do
			if is_debugging then
				l_app := run_project_cmd.debugger_manager.application
				l_app.interrupt
			else
				ev_application.remove_idle_action (idle_action_agent)
				process.terminate
			end
			is_paused := True
			update_status_actions.call ([])
		end

	resume is
			-- Resume testing execution.
		require
			paused: is_paused
		local
			l_app: APPLICATION_EXECUTION
		do
			if is_debugging then
				l_app := run_project_cmd.debugger_manager.application
				l_app.continue
			else
				process.launch
				ev_application.add_idle_action (idle_action_agent)
			end
			is_paused := False
			update_status_actions.call ([])
		end

	stop is
			-- Stop testing.
		require
			running: is_running
		local
			l_app: APPLICATION_EXECUTION
		do
			if is_testing and current_test_case.is_tested then
				current_test_case.set_passes (False, "Aborted before testing was finish")
			end
			cursor := Void
			is_testing := False
			is_running := False
			if is_debugging then
				is_debugging := False
				l_app := run_project_cmd.debugger_manager.application
				if l_app.is_running then
					l_app.kill
				end
				manager.ise_target.set_root (old_root)
				manager.ise_target.system.store
				status_text := "Done"
				melt_project_cmd.execute_and_wait
			else
				ev_application.remove_idle_action (idle_action_agent)
				if process.is_running then
					process.terminate
				end
				process := Void
				remove_tester_target
				status_text := "Done"
			end
			update_status_actions.call ([])
		end

feature -- Actions

	update_status_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions performed when `Current' changes its status

	output_actions: ACTION_SEQUENCE [TUPLE [STRING]]
			-- Actions performed when reading an output from `process'	

feature {NONE} -- Status checking

	idle_action_agent: PROCEDURE [ANY, TUPLE]
			-- Agent for 'idle_action'

	idle_action is
			-- Check status of the process and its output
		require
			running: is_running
			not_debugging: not is_debugging
		local
			l_output: STRING
			l_pos: INTEGER
		do
			if output.has_new_block then
				l_output := output.all_blocks (True).string_representation
				if is_testing then
					testing_output_buffer.append (l_output)
					l_pos := testing_output_buffer.last_index_of ('%N', testing_output_buffer.count)
					if l_pos > 0 then
						testing_output_buffer := testing_output_buffer.substring (l_pos + 1, testing_output_buffer.count)
					end
				end
			end
			if process.has_exited then
				if is_testing then
					retrieve_test_case_status
					if cursor.is_last then
						stop
					else
						cursor.forth
						test_current_test_case
						status_text := "Testing " + current_test_case.test_class.name
					end
				else
					if process.exit_code = 0 then
						cursor.start
						is_testing := True
						test_current_test_case
						status_text := "Testing " + current_test_case.test_class.name
					else
						-- TODO: notify tools that compilation has failed
						is_running := False
						process := Void
						ev_application.remove_idle_action (idle_action_agent)
						status_text := "Compilation failed"
					end
				end
				update_status_actions.call ([])
			elseif is_testing then
				-- TODO: Kill if process is running to long...
			end
			if l_output /= Void then
				output_actions.call ([l_output])
			end
		end

	retrieve_test_case_status is
			-- Parse testing results for `current_test_case' from `testing_output_buffer'.
		require
			testing: is_testing
			not_debugging: not is_debugging
			process.has_exited
		local
			l_list: LIST [STRING]
			l_succeed: BOOLEAN
			l_exception: STRING
		do
			if process.exit_code = 0 then
				l_succeed := True
			else
				l_list := testing_output_buffer.split ('.')
				if l_list.count = 3 then
					l_exception := l_list.i_th (3)
					if process.exit_code = {EXCEP_CONST}.precondition then
						if l_list.i_th (1).is_equal (current_test_case.target_class.name) then
							l_succeed := True
							l_exception := Void
						end
					end
				else
					l_exception := "unknown"
				end
				current_test_case.set_passes (False, l_exception)
			end
			current_test_case.set_passes (l_succeed, l_exception)
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
			l_cmd.append ("./" + manager.ise_project.system.name + " ")
			l_cmd.append (current_test_case.test_class.name)
			create_process (l_cmd, manager.ise_target.system.directory + "/EIFGENs/" + tester_target_name + "/W_code")
			create testing_output_buffer.make_empty
			process.launch
		ensure
			testing: is_testing
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

	create_root_class (with_argument: BOOLEAN) is
			-- Write root class for interpreter to disc.
			-- When `with_argument' is True, the compiled executable will expect an argument.
		require
			can_start_background_testing: True
		local
			l_file: KL_OUTPUT_FILE
		do
			l_file := root_class_file
			l_file.open_write
			printer.print_root_class (test_cases, manager.ise_target.root.class_name, l_file, with_argument)
			l_file.close
		end

	remove_tester_target is
			-- Remove target with name `tester_target_name' from system.
		do
			manager.ise_target.system.remove_target (tester_target_name)
			manager.ise_target.system.store
		end


feature {NONE} -- Implementation

	old_root: CONF_ROOT
			-- Old root configuration before `Current' started test run in debugger

	root_class_file_name: STRING is
			-- File name for interpreter root class
		do
			Result := test_suite.tests_cluster.location.build_path ("", root_class_name.as_lower + ".e")
		ensure
			not_empty: Result /= Void and then not Result.is_empty
		end

	root_class_file: KL_OUTPUT_FILE is
			-- File where root class is written to
		do
			create {KL_TEXT_OUTPUT_FILE} Result.make (root_class_file_name)
		ensure
			not_void: Result /= Void
			valid: Result.name.is_equal (root_class_file_name)
		end

feature {NONE} -- Implementation

	process: PROCESS
			-- Currently executed process

	output: EB_PROCESS_IO_STORAGE
			-- Stored output from the process

	testing_output_buffer: STRING
			-- Output from testing process

	cursor: DS_LIST_CURSOR [CDD_TEST_CASE]
			-- cursor pointing to current test case

	printer: CDD_TESTER_PRINTER is
			-- printer for generating interpreter root class
		once
			create Result
		end

	conf_factory: CONF_FACTORY is
			-- Factory for creating new targets
		once
			create Result
		end

invariant
	manager_not_void: manager /= Void
	idle_action_agent_not_void: idle_action_agent /= Void
	is_debugging_implies_is_running: is_debugging implies is_running
	is_paused_implies_is_running: is_paused implies is_running
	is_testing_implies_is_running: is_testing implies is_running
	is_testing_implies_correct_cursor: is_testing implies (cursor /= Void and then not cursor.off)
	--valid_process_status: is_running = (process /= Void)
	update_status_actions_not_void: update_status_actions /= Void
	output_actions_not_void: output_actions /= Void
	correct_old_root: is_debugging implies old_root /= Void
	testing_output_buffer_not_void: testing_output_buffer /= Void

end
