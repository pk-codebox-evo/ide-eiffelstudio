indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE_TESTER

inherit

	THREAD

	CDD_CONSTANTS

create
	make_with_test_suite


feature {NONE} -- Initialization

	make_with_test_suite (a_test_suite: CDD_TEST_SUITE) is
			--
		require
			a_test_suite_not_void: a_test_suite /= Void
		do
			test_suite := a_test_suite
			create test_suite_tools.make
		end


feature -- Access

	test_suite: CDD_TEST_SUITE
			-- Test suite containing test cases

	is_running: BOOLEAN
			-- Are we currently running tests?

feature -- Execution

	execute is
			-- Start testing process
		require else
			can_execute: test_suite.can_be_tested
			not_running: not is_running
		local
			l_args: ARRAYED_LIST [STRING]
			l_cmd: STRING
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
		do
			is_running := True
			notify_all_tools (agent notify_start_testing)

			create l_cmd.make_empty
			l_cmd.append ("ec -config ")
			l_cmd.append (test_suite.config_file)
			l_cmd.append (" -target ")
			l_cmd.append (test_suite.tester_target.name)
			l_cmd.append (" -c_compile -batch -stop")
			execute_command (l_cmd, test_suite.project_directory)

			output_handler ("%N%NInterpreter generated%N%N")

			from
				l_cursor := test_suite.test_cases.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				create l_cmd.make_empty
				l_cmd.append ("./test_system ")
				l_cmd.append (l_cursor.item.test_class.name)
				execute_command (l_cmd,test_suite.project_directory + "/EIFGENs/" + test_suite.tester_target.name + "/W_code")
				l_cursor.forth
			end

			is_running := False
			notify_all_tools (agent notify_finish_testing)
		end



feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	extend (a_tool: CDD_TEST_SUITE_TOOL) is
			--
		require
			a_tool_not_void: a_tool /= Void
		do
			test_suite_tools.put_last (a_tool)
		ensure
			inserted: test_suite_tools.has (a_tool)
		end

	prune (a_tool: CDD_TEST_SUITE_TOOL) is
			--
		require
			a_tool_not_void: a_tool /= Void
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_SUITE_TOOL]
		do
			l_cursor := test_suite_tools.new_cursor
			l_cursor.start
			l_cursor.search_forth (a_tool)
			l_cursor.remove
		ensure
			removed: not test_suite_tools.has (a_tool)
		end

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

	output_handler (an_output: STRING) is
			--
		do
			from
				test_suite_tools.start
			until
				test_suite_tools.after
			loop
				test_suite_tools.item_for_iteration.append_output (an_output)
				test_suite_tools.forth
			end
		end


feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	process_factory: PROCESS_FACTORY is
			--
		once
			create Result
		end


	execute_command (a_cmd, a_wd: STRING) is
			--
		require
			running: is_running
			a_cmd_not_empty: a_cmd /= Void and then not a_cmd.is_empty
		local
			l_prc: PROCESS
			l_args: ARRAYED_LIST [STRING]
		do
			create l_args.make (2)
			l_args.extend ("-c")
			l_args.extend ("%'%'" + a_cmd + "")
			l_prc := process_factory.process_launcher ("/bin/sh", l_args, a_wd)

			l_prc.redirect_input_to_stream
			l_prc.redirect_output_to_agent (agent output_handler)
			l_prc.redirect_error_to_same_as_output
			l_prc.enable_launch_in_new_process_group
			l_prc.set_timer (create {PROCESS_VISION2_TIMER}.make (100))
			l_prc.set_buffer_size (128)
			l_prc.set_abort_termination_when_failed (False)
			l_prc.launch
			l_prc.wait_for_exit
		end


	test_suite_tools: DS_LINKED_LIST [CDD_TEST_SUITE_TOOL]

	notify_all_tools (a_proc: PROCEDURE [ANY, TUPLE [CDD_TEST_SUITE_TOOL]]) is
			--
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
			--
		do
			a_tool.start_testing
		end

	notify_finish_testing (a_tool: CDD_TEST_SUITE_TOOL) is
			--
		do
			a_tool.finish_testing
		end



invariant
	test_suite_not_void: test_suite /= Void

end
