indexing
	description: "Compiles and executes unit tests in the background (in a separate process)"
	instructions: "[
					This class allows testing in the background through
					a poor mans implementation of cooperative multi-tasking.
					To start testing call `start' and then call `step' as long
					as `has_next_step' is `True'. It is guaranteed that `step' will
					not block for too long.
				  ]"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_EXECUTOR

inherit

	AUT_TASK

	CDD_ROUTINES
		export
			{NONE} all
		end

	KL_SHARED_OPERATING_SYSTEM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_cdd_manager: like cdd_manager) is
			-- Create a test executor.
		require
			a_cdd_manager_not_void: a_cdd_manager /= Void
		do
			cdd_manager := a_cdd_manager
			create root_class_printer.make (test_suite)
			create default_filter.make (test_suite)
			default_filter.add_client
			filter := default_filter
		ensure
			cdd_manager_set: cdd_manager = a_cdd_manager
			filter_set_to_default: filter = default_filter
		end

feature -- Status report

	has_next_step: BOOLEAN is
			-- Is the test executor currently either compiling or testing?
		do
			Result := is_compiling or is_executing
		ensure then
			definition: Result = (is_compiling xor is_executing)
		end

	is_compiling: BOOLEAN is
			-- Is the test executor currently compiling the test suite?
		do
			Result := compiler /= Void
		ensure
			definition: Result = (compiler /= Void)
		end

	is_executing: BOOLEAN is
			-- Is the test exeutor currently exeuting the test suite?
		do
			Result := proxy /= Void
		end

feature -- Access

	cdd_manager: CDD_MANAGER
			-- Manager controlling `Current'

	test_suite: CDD_TEST_SUITE is
			-- Test suite containing tests we want to test
		do
			Result := cdd_manager.test_suite
		ensure
			valid: Result = cdd_manager.test_suite
		end

	filter: CDD_FILTERED_VIEW
			-- Filter containing test routines beeing tested
			-- in the next testing session

	test_routines: DS_LINEAR [CDD_TEST_ROUTINE] is
			-- List of test routines which will be tested
			-- NOTE: this is a copy of the test routines
			-- in `filter' when testing was started
		require
			running: has_next_step
		do
			Result := test_routines_cursor.container
		end

	current_test_routine: CDD_TEST_ROUTINE is
			-- Routine currently beeing tested;
			-- Void if currently not testing
		require
			executing: is_executing
		do
			Result := test_routines_cursor.item
		ensure
			not_void: Result /= Void
			current_item: Result = test_routines_cursor.item
		end

	index: INTEGER is
			-- Index of test routine currently beeing tested
		require
			executing: is_executing
		do
			Result := test_routines_cursor.index
		ensure
			same_as_test_routines: Result = test_routines_cursor.index
		end

	pass_count: INTEGER
			-- Number of passing tests in current execution
			-- NOTE: `pass_count' only contains a meaningful
			-- value if `has_next_step' is `True'

	fail_count: INTEGER
			-- Number of failing tests in current execution
			-- NOTE: `fail_count' only contains a meaningful
			-- value if `has_next_step' is `True'

feature -- Status settings

	set_filter (a_filter: like filter) is
			-- Set `filter' to `a_filter'.
		require
			a_filter_not_void: a_filter /= Void
			a_filter_valid: a_filter.test_suite = test_suite
		do
			if filter /= default_filter then
				filter.remove_client
			end
			filter := a_filter
			if filter /= default_filter then
				filter.add_client
			end
			cdd_manager.status_update_actions.call ([create {CDD_STATUS_UPDATE}.make_with_code ({CDD_STATUS_UPDATE}.executor_filter_change)])
		ensure
			filter_set: filter = a_filter
		end

	reset_filter is
			-- Set `filter' to `default_filter'.
		do
			set_filter (default_filter)
		ensure
			filter_reset: filter = default_filter
		end

feature -- Basic operations

	start is
			-- Start compiling and testing in background.
		local
			l_target: CONF_TARGET
			l_system: CONF_SYSTEM
			l_list: DS_ARRAYED_LIST [CDD_TEST_ROUTINE]
		do
			if not filter.test_routines.is_empty then
				root_class_printer.print_class (cdd_manager.testing_directory)
				if root_class_printer.last_print_succeeded then
					create l_list.make_from_linear (filter.test_routines)
					test_routines_cursor := l_list.new_cursor
					create compiler.make
					compiler.set_output_handler (agent redirect_output)
					cdd_manager.status_update_actions.call ([update_step])
					l_target := test_suite.target
					l_system := l_target.system
					log.put_interpreter_compilation_message ("start")
					compiler.run (l_system.directory, l_system.file_name, tester_target_name (l_target))
				else
					-- TODO: notify observers that printing the root class has failed
				end
			else
				cdd_manager.status_update_actions.call ([update_step])
			end
		end

	cancel is
			-- Stop all running processes.
		do
			if is_compiling then
				if compiler.is_running then
					compiler.terminate
					log.put_interpreter_compilation_message ("abort")
				end
				compiler := Void
			else
				if proxy.is_launched then
					proxy.stop
					log.report_test_case_execution_abort
				end
				proxy := Void
			end
			test_routines_cursor.go_after
			test_routines_cursor := Void
			fail_count := 0
			pass_count := 0
			cdd_manager.status_update_actions.call ([update_step])
		end

	step is
			-- Execute one short testing step.
		do
			if is_compiling then
				step_compile
			elseif is_executing then
				step_executing
			end
		end

feature {NONE} -- Implementation (execution)

	step_compile is
			-- Execute one short step in compiling the test suite.
		require
			is_compiling: is_compiling
		do
			if compiler.is_running then
				compiler.process_output
			else
				if compiler.was_successful then
					log.put_interpreter_compilation_message ("success")
					create proxy.make (interpreter_pathname, create {KL_TEXT_OUTPUT_FILE}.make (cdd_manager.testing_directory.build_path ("", "cdd_interpreter.log")))
					log.report_test_case_execution_start
					proxy.start
					select_first_test_routine
				else
					log.put_interpreter_compilation_message ("error")
					cdd_manager.status_update_actions.call ([create {CDD_STATUS_UPDATE}.make_with_code ({CDD_STATUS_UPDATE}.execution_error_code)])
					test_routines_cursor := Void
				end
				compiler := Void
				cdd_manager.status_update_actions.call ([update_step])
			end
		end

	step_executing is
			-- Execute one short step in executing the test suite.
		require
			is_executing: is_executing
		local
			l_list: DS_ARRAYED_LIST [CDD_TEST_ROUTINE_UPDATE]
			l_time: DATE_TIME
		do
			if proxy.last_response /= Void then
				current_test_routine.add_outcome (proxy.last_response)
				create l_time.make_now
				log.report_test_case_execution (current_routine_execution_start_time, l_time, current_test_routine)
				if proxy.last_response.is_fail then
					fail_count := fail_count + 1
				elseif proxy.last_response.is_pass then
					pass_count := pass_count + 1
				end
				create l_list.make (1)
				l_list.put_first (create {CDD_TEST_ROUTINE_UPDATE}.make (current_test_routine, {CDD_TEST_ROUTINE_UPDATE}.changed_code))
				test_suite.test_routine_update_actions.call ([l_list])
				cdd_manager.status_update_actions.call ([update_step])
				select_next_test_routine
				if not proxy.is_ready then
					check proxy.last_response.has_bad_communication end
						-- Proxy seems jammed, restart and try again
					proxy.stop
					proxy.start
				end
			end
			if test_routines_cursor.after then
				proxy.stop
				proxy := Void
				log.report_test_case_execution_end
				test_routines_cursor := Void
				fail_count := 0
				pass_count := 0
				cdd_manager.status_update_actions.call ([update_step])
			else
				if proxy.is_ready then
					cdd_manager.status_update_actions.call ([update_step])
					create current_routine_execution_start_time.make_now
					proxy.execute_test_async (current_test_routine.test_class.test_class_name, current_test_routine.name)
				elseif proxy.is_executing_request then
					proxy.process_response
				end
			end
		end

	select_first_test_routine is
			-- Select first routine under test. Similar to
			-- `select_next_test_routine'.
		require
			is_executing: is_executing
		do
			test_routines_cursor.start
		end

	select_next_test_routine is
			-- Move `test_routine_cursor' and `test_routine_class' so that they point
			-- to the next routine under test. Set `test_routine_cursor' and `test_class_cursor'
			-- to void if no more routines are under test.
		require
			is_executing: is_executing
		do
			test_routines_cursor.forth
		end

	interpreter_pathname: FILE_NAME is
			-- Filename of compiled test suite
		do
			create Result.make_from_string (test_suite.target.system.directory)
			Result.extend ("EIFGENs")
			Result.extend (tester_target_name (test_suite.target))
			Result.extend ("W_code")
			if operating_system.is_unix then
				Result.extend (test_suite.target.system.name)
			else
				Result.extend (test_suite.target.system.name + ".exe")
			end
		ensure
			filename_not_void: Result /= Void
		end

	redirect_output (a_string: STRING) is
			-- Redirect `a_string' to cdd manager as new output.
		require
			a_string_not_void: a_string /= Void
		do
			cdd_manager.output_actions.call ([a_string])
		end

feature {NONE} -- Implementation

	default_filter: like filter
			-- Default filter containing all test routines

	compiler: AUT_ISE_EIFFEL_COMPILER
			-- Process for compiling the interpreter

	proxy: CDD_INTERPRETER_PROXY
			-- Proxy for communicating with interpreter

	test_routines_cursor: DS_LIST_CURSOR [CDD_TEST_ROUTINE]
			-- Cursor for iterating through routines which
			-- are tested during a test execution

	root_class_printer: CDD_INTERPRETER_CLASS_PRINTER
			-- Printer for root class (interpreter)

	update_step: CDD_STATUS_UPDATE is
			-- Update used after each step of `Current'
		once
			create Result.make_with_code ({CDD_STATUS_UPDATE}.executor_step_code)
		ensure
			not_void: Result /= Void
		end

	current_routine_execution_start_time: DATE_TIME

	log: CDD_LOGGER is
			-- CDD logger
		do
			Result := cdd_manager.log
		end

invariant

	cdd_manager_not_void: cdd_manager /= Void
	test_suite_not_void: test_suite /= Void
	filter_not_void: filter /= Void
	filter_valid: filter.test_suite = test_suite
	default_filter_not_void: default_filter /= Void
	root_class_printer_not_void: root_class_printer /= Void
	not_executing_and_compiling: not (is_executing and is_compiling)
	has_next_step_implies_test_routines_cursor_not_void: has_next_step = (test_routines_cursor /= Void)
	is_executing_implies_test_routines_cursor_not_off: is_executing implies not test_routines_cursor.off
	not_has_next_step_implies_fail_count_zero: (not has_next_step) implies (fail_count = 0)
	not_has_next_step_implies_pass_count_zero: (not has_next_step) implies (pass_count = 0)

end
