note
	description: "Summary description for {AFX_INTRA_FEATURE_TRACE_COLLECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AFX_INTRA_FEATURE_TRACE_COLLECTOR

inherit

--	AFX_SHARED_PROGRAM_EXECUTION_TRACE_REPOSITORY

	EPA_DEBUGGER_UTILITY

	AFX_SHARED_STATE_SERVER

	AFX_UTILITY

	AFX_SHARED_EVENT_ACTIONS

	EQA_TEST_EXECUTION_MODE

	AFX_SHARED_SERVER_EXPRESSIONS_TO_MONITOR

	AFX_SHARED_STATIC_ANALYSIS_REPORT

	AFX_SHARED_SESSION

	AFX_SHARED_DYNAMIC_ANALYSIS_REPORT

	REFACTORING_HELPER

--	AFX_SHARED_PROGRAM_STATE_EXPRESSIONS_SERVER

create
	make

feature -- Initialization

	make
			-- Initialization.
		do
			create test_case_start_actions
			create test_case_breakpoint_hit_actions
			create application_exited_actions

			create test_case_execution_status_collector.make (config)
		end

feature -- Actions

	test_case_start_actions: ACTION_SEQUENCE[TUPLE [EPA_TEST_CASE_INFO]]
			-- Actions to be performed when a test case is to be analyzed.
			-- The information about the test case is passed as the argument to the agent.

	test_case_breakpoint_hit_actions: ACTION_SEQUENCE [TUPLE [a_tc: EPA_TEST_CASE_INFO; a_state: EPA_STATE; a_bpslot: INTEGER]]
			-- Actions to be performed when a breakpoint is hit in a test case.
			-- `a_tc' is the test case currently analyzed.
			-- `a_state' is the state evaluated at the breakpoint.
			-- `a_bpslot' is the breakpoint slot number.

	application_exited_actions: ACTION_SEQUENCE [TUPLE [DEBUGGER_MANAGER]]
			-- Actions to be performed when application exited in debugger

feature -- Basic operation

	register_general_action_listeners
			-- Register general action listeners to respond to actions.
		do
			test_case_start_actions.extend (agent trace_repository.start_trace_for_test_case)
			test_case_breakpoint_hit_actions.extend (agent trace_repository.extend_current_trace_with_state_and_index)
			application_exited_actions.extend (agent unregister_test_case_handler)

				-- Setup test case execution status collector.
			test_case_start_actions.extend (agent test_case_execution_status_collector.on_test_case_start (?, False))
			test_case_breakpoint_hit_actions.extend (agent test_case_execution_status_collector.on_break_point_hit)
			application_exited_actions.extend (agent test_case_execution_status_collector.on_application_exited)
		end

	reset_collector
			-- Reset the state of collector.
		do
			reset_trace_repository

			test_case_start_actions.wipe_out
			test_case_breakpoint_hit_actions.wipe_out
			application_exited_actions.wipe_out

			current_test_case_info := Void
			current_test_case_breakpoint_manager := Void
			current_test_execution_mode := Mode_default
			enter_test_case_breakpoint_manager := Void
		end

	collect_trace
			-- Run current project to collect execution traces from test cases.
		local
--			l_state_expression_server: AFX_PROGRAM_STATE_EXPRESSIONS_SERVER
			l_app_stop_agent: PROCEDURE [ANY, TUPLE [DEBUGGER_MANAGER]]
			l_app_exit_agent: PROCEDURE [ANY, TUPLE [DEBUGGER_MANAGER]]
			l_new_tc_bp_manager: EPA_EXPRESSION_EVALUATION_BREAKPOINT_MANAGER
			l_expression_set: DS_HASH_SET [AFX_PROGRAM_STATE_EXPRESSION]
			l_class: CLASS_C
			l_feature: FEATURE_I
		do
			reset_collector

--			create l_state_expression_server.make (config, 5)
--			set_state_expression_server (l_state_expression_server)

			register_general_action_listeners

			-- Initialize debugger.
			debugger_manager.set_should_menu_be_raised_when_application_stopped (False)
			remove_breakpoint (debugger_manager, Test_case_super_class)

			-- Register debugger event listener.
			l_app_stop_agent := agent on_application_stopped
			l_app_exit_agent := agent on_application_exit
			debugger_manager.observer_provider.application_stopped_actions.extend (l_app_stop_agent)
			debugger_manager.observer_provider.application_exited_actions.extend (l_app_exit_agent)

			-- Start debugging the application.
			start_debugger (debugger_manager, "--analyze-tc " + config.interpreter_log_path + " false", config.working_directory, {EXEC_MODES}.Run, False)

			-- Unregister debugger event listener.
			debugger_manager.observer_provider.application_stopped_actions.prune_all (l_app_stop_agent)
			debugger_manager.observer_provider.application_exited_actions.prune_all (l_app_exit_agent)

			-- Clean up debugger.
			remove_breakpoint (debugger_manager, Test_case_super_class)
			remove_debugger_session

			if config.is_program_state_extended then
				-- Interprete state-expression based traces as state-aspect based ones.
				set_trace_repository (trace_repository.interpretation)
			end
			set_test_case_execution_status (test_case_execution_status_collector.status)
		end

feature{None} -- Implementation

	current_test_case_info: detachable EPA_TEST_CASE_INFO
			-- Information about currently analyzed test case

	current_test_case_breakpoint_manager: detachable EPA_EXPRESSION_EVALUATION_BREAKPOINT_MANAGER
			-- Breakpoint manager for current test case

	exception_summary: EPA_EXCEPTION_TRACE_SUMMARY
			-- Summary information about the exception.

	test_case_execution_status_collector: AFX_TEST_CASE_EXECUTION_STATUS_COLLECTOR
			-- Test case execution status collector.
			-- Include both passing and failing test cases.


feature{NONE} -- Execution mode

	current_test_execution_mode: INTEGER
			-- Execution mode of current test.

	is_in_mode_execute: BOOLEAN
			-- Is current test case running in 'Mode_execute'?
		do
			Result := current_test_execution_mode = Mode_execute
		end

	is_in_mode_monitor: BOOLEAN
			-- Is current test case running in 'Mode_monitor'?
		do
			Result := current_test_execution_mode = Mode_monitor
		end

feature{NONE} -- Event handler

	on_test_case_setup (a_breakpoint: BREAKPOINT; a_test_case_info: EPA_STATE)
			-- Action to be performed when a new test case has been setup.
			-- The handler is registered during the first exception handling.
		local
			l_class_under_test: CLASS_C
			l_execution_mode: INTEGER
			l_feature_under_test: FEATURE_I
			l_recipient_class_name, l_recipient_feature_name: STRING
			l_recipient_class: CLASS_C
			l_recipient: FEATURE_I
			l_exception_code: INTEGER
			l_bpslot: INTEGER
			l_tag: STRING
			l_passing: BOOLEAN
			l_table: HASH_TABLE [EPA_EXPRESSION_VALUE, STRING]
			l_spot: AFX_EXCEPTION_SPOT
			l_uuid: STRING
			l_trace: STRING
			l_start_index, l_end_index: INTEGER
			l_expression_set: DS_HASH_SET [AFX_PROGRAM_STATE_EXPRESSION]
			l_repository: like trace_repository
		do
			l_table := a_test_case_info.to_hash_table

			l_class_under_test := first_class_starts_with_name (l_table.item ({EQA_SERIALIZED_TEST_SET}.Txt_tci_class_under_test).out)
			l_execution_mode := l_table.item ({EQA_SERIALIZED_TEST_SET}.Txt_execution_mode).out.to_integer
			l_feature_under_test := l_class_under_test.feature_named (l_table.item ({EQA_SERIALIZED_TEST_SET}.Txt_tci_feature_under_test).out)
			l_recipient_class_name := l_table.item ({EQA_SERIALIZED_TEST_SET}.Txt_tci_exception_recipient_class).out
			l_recipient_feature_name := l_table.item ({EQA_SERIALIZED_TEST_SET}.Txt_tci_exception_recipient).out
			l_recipient_class := first_class_starts_with_name (l_recipient_class_name)
			l_recipient := l_recipient_class.feature_named (l_recipient_feature_name)
			l_exception_code := l_table.item ({EQA_SERIALIZED_TEST_SET}.Txt_tci_exception_code).out.to_integer
			l_bpslot := l_table.item ({EQA_SERIALIZED_TEST_SET}.Txt_tci_breakpoint_index).out.to_integer
			l_tag := l_table.item ({EQA_SERIALIZED_TEST_SET}.Txt_tci_assertion_tag).out
			l_passing := l_table.item ({EQA_SERIALIZED_TEST_SET}.Txt_tci_is_passing).out.to_boolean
			l_uuid := l_table.item ({EQA_SERIALIZED_TEST_SET}.Txt_tci_class_uuid).out
			l_trace := l_table.item ({EQA_SERIALIZED_TEST_SET}.Txt_tci_exception_trace).out

			io.put_string ("Entering test case " + l_uuid + "%N")

			current_test_execution_mode := l_execution_mode

			check
				in_monitor_mode: is_in_mode_monitor
				exception_info_available: exception_spot /= Void
			end
			current_test_case_info := exception_spot.test_case_info.deep_twin
			current_test_case_info.set_is_passing (l_passing)
			current_test_case_info.set_uuid (l_uuid)

			event_actions.notify_on_new_test_case_found (current_test_case_info)
			test_case_start_actions.call ([current_test_case_info])

			register_program_state_monitoring
		end

	on_breakpoint_hit_in_test_case (a_breakpoint: BREAKPOINT; a_state: EPA_STATE)
			-- Action to be performed when `a_breakpoint' is hit.
			-- `a_breakpoint' is a break point in a test case.
			-- `a_state' stores the values of all evaluated expressions'.
		do
			a_state.keep_if (
				agent (a_equation: EPA_EQUATION): BOOLEAN
					do
						Result := a_equation.value.is_boolean or else a_equation.value.is_integer
					end)

			test_case_breakpoint_hit_actions.call ([current_test_case_info, a_state, a_breakpoint.breakable_line_number])
			event_actions.notify_on_break_point_hit (current_test_case_info, a_breakpoint.breakable_line_number)
		end

	on_application_exit (a_dm: DEBUGGER_MANAGER)
			-- Action to be performed when application exited.
		do
			application_exited_actions.call ([a_dm])
			set_test_case_execution_status (test_case_execution_status_collector.status)
		end

	on_application_stopped (a_dm: DEBUGGER_MANAGER)
			-- Action to be performed when application is stopped in the debugger
		local
			l_new_tc_bp_manager: EPA_EXPRESSION_EVALUATION_BREAKPOINT_MANAGER
		do
			if a_dm.application_is_executing and then a_dm.application_is_stopped then
				if a_dm.application_status.reason_is_catcall then
					a_dm.controller.resume_workbench_application
				elseif a_dm.application_status.reason_is_overflow then
					a_dm.application.kill
				else
					if a_dm.application_status.exception_occurred then
						if not is_in_mode_monitor then
							static_exception_analysis (a_dm)

							register_test_case_entry_handler
							register_test_case_exit_handler
						else
							-- Mark the trace as from a FAILED execution.
							trace_repository.current_trace.set_status_as_failing
						end

						unregister_program_state_monitoring (Void, a_dm)
					end

					-- Resume anyway.
					a_dm.controller.resume_workbench_application
				end
			end
		end

feature{NONE} -- Event handler registration/unregistration

	enter_test_case_breakpoint_manager: EPA_EXPRESSION_EVALUATION_BREAKPOINT_MANAGER
			-- Breakpoint manager for handling test-case-entry event.

	register_test_case_entry_handler
			-- Register test-case-entry handler at breakpoint.
		do
			if enter_test_case_breakpoint_manager = Void then
				create enter_test_case_breakpoint_manager.make (Test_case_super_class, Test_case_setup_feature)
				enter_test_case_breakpoint_manager.set_breakpoint_with_expression_and_action (1, test_case_info_skeleton, agent on_test_case_setup)
			end
			enter_test_case_breakpoint_manager.toggle_breakpoints (True)
		end

	register_program_state_monitoring
			-- Register program state monitoring at each breakpoint in the recipient feature.
		require
			current_test_case_attached: current_test_case_info /= Void
		local
			l_recipient_class: CLASS_C
			l_recipient: FEATURE_I
			l_expression_set, l_expression_set_from_failing_assertion: EPA_HASH_SET [AFX_PROGRAM_STATE_EXPRESSION]
			l_orig_failing_assertion: EPA_EXPRESSION
			l_failing_assertion: AFX_PROGRAM_STATE_EXPRESSION
			l_collector: AFX_EXPRESSIONS_TO_MONITOR_COLLECTOR
		do
			if current_test_case_breakpoint_manager = Void then
				-- Set of expressions to evaluate.
--				l_recipient_class := current_test_case_info.recipient_class_
--				l_recipient := current_test_case_info.recipient_
				l_recipient_class := exception_spot.recipient_class_
				l_recipient := exception_spot.recipient_
				check l_recipient_class = current_test_case_info.recipient_class_ and then l_recipient = current_test_case_info.recipient_ end
				l_expression_set := server_expressions_to_monitor.set_of_expressions_to_monitor_without_bp_index (l_recipient_class, l_recipient)

				-- Add the failing assertion expression to the set of expressions.
				l_orig_failing_assertion := exception_spot.failing_assertion
				if l_orig_failing_assertion /= Void then
					create l_failing_assertion.make_with_text (l_orig_failing_assertion.class_, l_orig_failing_assertion.feature_, l_orig_failing_assertion.text,l_orig_failing_assertion.written_class, 0)
					l_failing_assertion.set_type (l_orig_failing_assertion.type)
					create l_expression_set_from_failing_assertion.make_equal (1)
					l_expression_set_from_failing_assertion.force (l_failing_assertion)
					create l_collector
					l_collector.collect_from (l_expression_set_from_failing_assertion)
					l_expression_set.append (l_collector.expressions_to_monitor)
				end

				-- Register expressions at all breakpoints.
				create current_test_case_breakpoint_manager.make (l_recipient_class, l_recipient)
				current_test_case_breakpoint_manager.set_all_breakpoints_with_expression_and_actions (l_expression_set, agent on_breakpoint_hit_in_test_case)
			end

			current_test_case_breakpoint_manager.toggle_breakpoints (True)
			check debugger_manager.breakpoints_manager.is_breakpoint_enabled (l_recipient.e_feature, 1) end
		end

	register_test_case_exit_handler
			-- Register test-case-exit handler at breakpoint.
		local
			l_class: CLASS_C
			l_bp_manager: BREAKPOINTS_MANAGER
			l_bp_location: BREAKPOINT_LOCATION
			l_breakpoint: BREAKPOINT
		do
			l_bp_manager := debugger_manager.breakpoints_manager

			-- Ending point of monitoring.
			l_bp_location := l_bp_manager.breakpoint_location (Test_case_exit_feature.e_feature, 1, False)
			l_breakpoint := l_bp_manager.new_user_breakpoint (l_bp_location)
			l_breakpoint.add_when_hits_action (create {BREAKPOINT_WHEN_HITS_ACTION_EXECUTE}.make (agent unregister_program_state_monitoring))
			l_breakpoint.set_continue_execution (True)
			l_bp_manager.add_breakpoint (l_breakpoint)
			l_bp_manager.notify_breakpoints_changes
		end

	unregister_test_case_handler (a_dm: DEBUGGER_MANAGER)
			-- Unregister test-case entry & exit handler.
		do
			if enter_test_case_breakpoint_manager /= Void then
				enter_test_case_breakpoint_manager.toggle_breakpoints (False)
			end
			remove_breakpoint (a_dm, Test_case_super_class)
		end

	unregister_program_state_monitoring (a_bp: BREAKPOINT; a_dm: DEBUGGER_MANAGER)
			-- Unregister program state monitoring at each breakpoint in the recipient feature.
		require
			current_test_case_attached: current_test_case_info /= Void
		do
			if current_test_case_breakpoint_manager /= Void then
				current_test_case_breakpoint_manager.toggle_breakpoints (False)
			end
			remove_breakpoint (a_dm, current_test_case_info.recipient_class_)
		end

feature{NONE} -- Test case info

	test_case_info_skeleton: DS_HASH_SET [EPA_EXPRESSION]
			-- State skeleton of test case information.
		local
			l_class: CLASS_C
			l_feature: FEATURE_I
			l_expr: EPA_AST_EXPRESSION
			l_expr_set: like test_case_info_skeleton
		do
			if test_case_info_skeleton_cache = Void then
				create l_expr_set.make_equal (14)

				l_class := test_case_super_class
				l_feature := test_case_setup_feature

				create l_expr.make_with_text (l_class, l_feature, {EQA_SERIALIZED_TEST_SET}.Txt_tci_class_name, l_class)
				l_expr_set.force_last (l_expr)
				create l_expr.make_with_text (l_class, l_feature, {EQA_SERIALIZED_TEST_SET}.Txt_execution_mode, l_class)
				l_expr_set.force_last (l_expr)
				create l_expr.make_with_text (l_class, l_feature, {EQA_SERIALIZED_TEST_SET}.Txt_tci_class_uuid, l_class)
				l_expr_set.force_last (l_expr)
				create l_expr.make_with_text (l_class, l_feature, {EQA_SERIALIZED_TEST_SET}.Txt_tci_class_under_test, l_class)
				l_expr_set.force_last (l_expr)
				create l_expr.make_with_text (l_class, l_feature, {EQA_SERIALIZED_TEST_SET}.Txt_tci_feature_under_test, l_class)
				l_expr_set.force_last (l_expr)
				create l_expr.make_with_text (l_class, l_feature, {EQA_SERIALIZED_TEST_SET}.Txt_tci_breakpoint_index, l_class)
				l_expr_set.force_last (l_expr)
				create l_expr.make_with_text (l_class, l_feature, {EQA_SERIALIZED_TEST_SET}.Txt_tci_is_creation, l_class)
				l_expr_set.force_last (l_expr)
				create l_expr.make_with_text (l_class, l_feature, {EQA_SERIALIZED_TEST_SET}.Txt_tci_is_query, l_class)
				l_expr_set.force_last (l_expr)
				create l_expr.make_with_text (l_class, l_feature, {EQA_SERIALIZED_TEST_SET}.Txt_tci_is_passing, l_class)
				l_expr_set.force_last (l_expr)
				create l_expr.make_with_text (l_class, l_feature, {EQA_SERIALIZED_TEST_SET}.Txt_tci_exception_code, l_class)
				l_expr_set.force_last (l_expr)
				create l_expr.make_with_text (l_class, l_feature, {EQA_SERIALIZED_TEST_SET}.Txt_tci_assertion_tag, l_class)
				l_expr_set.force_last (l_expr)
				create l_expr.make_with_text (l_class, l_feature, {EQA_SERIALIZED_TEST_SET}.Txt_tci_exception_recipient_class, l_class)
				l_expr_set.force_last (l_expr)
				create l_expr.make_with_text (l_class, l_feature, {EQA_SERIALIZED_TEST_SET}.Txt_tci_exception_recipient, l_class)
				l_expr_set.force_last (l_expr)
				create l_expr.make_with_text (l_class, l_feature, {EQA_SERIALIZED_TEST_SET}.Txt_tci_exception_trace, l_class)
				l_expr_set.force_last (l_expr)

				test_case_info_skeleton_cache := l_expr_set
			end

			Result := test_case_info_skeleton_cache
		ensure
			result_size_correct: Result /= Void and then Result.count = 14
		end

feature{NONE} -- Implementation

	static_exception_analysis (a_dm: DEBUGGER_MANAGER)
			-- Analyze exception statically.
		require
			exception_raised: a_dm /= Void and then a_dm.application_status.exception_occurred
			exception_info_not_set: exception_spot = Void
		local
			l_exception_trace: STRING
			l_exception_explainer: EPA_EXCEPTION_TRACE_EXPLAINER
			l_exception_summary: EPA_EXCEPTION_TRACE_SUMMARY
			l_recipient_id: STRING
			l_static_analyzer: AFX_EXCEPTION_STATIC_ANALYZER
			l_exception_spot: AFX_EXCEPTION_SPOT
		do
			l_exception_trace := a_dm.application_status.exception_text
			create l_exception_explainer
			l_exception_explainer.explain (l_exception_trace)
			l_exception_summary := l_exception_explainer.last_explanation

			-- Use exception information to initialize a test case info object.
			-- Since class/feature under test will not be used during fixing, we just use empty string.
			create current_test_case_info.make ("", "",
					l_exception_summary.recipient_context_class_name,
					l_exception_summary.recipient_feature_name,
					l_exception_summary.exception_code,
					l_exception_summary.failing_position_breakpoint_index,
					l_exception_summary.failing_assertion_tag,
					False, "")

			create l_static_analyzer.make
			l_static_analyzer.analyze_exception (current_test_case_info, a_dm.application_status.exception_text)
--			set_exception_spot (l_static_analyzer.last_spot)

--			if attached {AFX_DAIKON_FACILITY} daikon_facility as l_daikon then
--				l_daikon.set_exception_spot (exception_spot)
--			end
		end

feature{NONE} -- Constant

	Test_case_super_class: CLASS_C
			-- Super class of all test case classes.
		once
			Result := first_class_starts_with_name (once "EQA_SERIALIZED_TEST_SET")
		ensure
			result_attached: Result /= Void
		end

	Test_case_setup_feature: FEATURE_I
			-- Feature for setting up the test cases.
		once
			Result := test_case_super_class.feature_named (once "setup_before_test")
		ensure
			result_attached: Result /= Void
		end

	Test_case_exit_feature: FEATURE_I
			-- Feature for exiting the test cases.
		once
			Result := test_case_super_class.feature_named (once "cleanup_after_test")
		end

feature{NONE} -- Cache

	test_case_info_skeleton_cache: like test_case_info_skeleton
			-- Cache for `test_case_info_skeleton'.

--	analyze_exception (a_dm: DEBUGGER_MANAGER)
--			-- Get exception information from execution status, and make the result available in `exception_summary'.
--		local
--			l_recipient_id: STRING
--			l_static_analyzer: AFX_EXCEPTION_STATIC_ANALYZER

--			l_summary: EPA_EXCEPTION_TRACE_SUMMARY
--			l_status: APPLICATION_STATUS
--			l_call_stack: EIFFEL_CALL_STACK
--			l_call_stack_element: CALL_STACK_ELEMENT
--			l_class_under_test, l_feature_under_test: STRING
--			l_syntax_checker: EIFFEL_SYNTAX_CHECKER

--			l_exception_code: INTEGER

--			l_failing_class, l_failing_feature: STRING
--			l_failing_breakpoint_slot_index: INTEGER
--			l_failing_tag: STRING

--			l_recipient_class, l_recipient_feature: STRING
--			l_recipient_breakpoint_slot_index: INTEGER
--		do
--			l_status := a_dm.application_status

--			l_call_stack := l_status.current_call_stack
--			l_exception_code := l_status.exception.code

--			fixme ("Check the statuses of call stacks in occurrences of different exceptions.")

--			-- Information about the failing position.
--			l_call_stack_element := l_call_stack.i_th (1)
--			l_failing_class := l_call_stack_element.class_name

--			l_failing_tag := l_status.exception_message
--			create l_syntax_checker
--			if l_failing_tag = Void or else l_failing_tag.is_empty or else not l_syntax_checker.is_valid_identifier (l_failing_tag) then
--				l_failing_tag := "noname"
--			end

--			if l_exception_code /= {EXCEP_CONST}.Class_invariant then
--				l_failing_feature := l_call_stack_element.routine_name
--				l_failing_breakpoint_slot_index := l_call_stack_element.break_index
--			end

--			-- Information about the recipient.
--			if l_exception_code = {EXCEP_CONST}.Precondition then
--				-- Get recipient information from the call stack element next to the top, i.e. with index 2.
--				l_call_stack_element := l_call_stack.i_th (2)
--				l_recipient_class := l_call_stack_element.class_name
--				l_recipient_feature := l_call_stack_element.routine_name
--				l_recipient_breakpoint_slot_index := l_call_stack_element.break_index
--			else
--				l_recipient_class := l_failing_class
--				l_recipient_feature := l_failing_feature
--				l_recipient_breakpoint_slot_index := l_failing_breakpoint_slot_index
--			end

--			create exception_summary.make (l_exception_code,
--					l_failing_class, l_failing_feature,
--					l_failing_breakpoint_slot_index,
--					l_failing_tag,
--					l_recipient_class, l_recipient_feature,
--					l_recipient_breakpoint_slot_index)
--		end
end
