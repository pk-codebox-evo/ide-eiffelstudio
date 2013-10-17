note
	description: "Summary description for {AFX_EVENT_PRODUCER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AFX_EVENT_ACTIONS

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize Current.
		do
			create session_start_actions
			create session_end_actions
			create session_canceled_actions

			create test_case_analysis_start_actions
			create test_case_analysis_end_actions

			create fix_generation_start_actions
			create fix_generation_end_actions

			create fix_validation_start_actions
			create fix_validation_end_actions

			create contract_fixes_generation_end_actions
			create contract_fixes_validation_end_actions

			create report_generation_start_actions
			create report_generation_end_actions

			create new_test_case_found_actions
			create break_point_hit_actions

			create fix_candidate_validation_start_actions
			create fix_candidate_validation_end_actions

			create interpreter_start_actions
			create interpreter_start_failed_actions

			create test_case_execution_time_out_actions
		end

feature -- Subscribe

	subscribe_action_listener (a_listener: AFX_EVENT_LISTENER)
			-- Subscribe `a_listener' to listen to the current events.
		do
			session_start_actions.extend (agent a_listener.on_session_starts)
			session_end_actions.extend (agent a_listener.on_session_ends)
			session_canceled_actions.extend (agent a_listener.on_session_canceled)
			test_case_analysis_start_actions.extend (agent a_listener.on_test_case_analysis_starts)
			test_case_analysis_end_actions.extend (agent a_listener.on_test_case_analysis_ends)
			fix_generation_start_actions.extend (agent a_listener.on_fix_generation_starts)
			fix_generation_end_actions.extend (agent a_listener.on_fix_generation_ends)
			contract_fixes_generation_end_actions.extend (agent a_listener.on_contract_fixes_generation_ends)
			contract_fixes_validation_end_actions.extend (agent a_listener.on_contract_fixes_validation_ends)
			fix_validation_start_actions.extend (agent a_listener.on_fix_validation_starts)
			fix_validation_end_actions.extend (agent a_listener.on_fix_validation_ends)
			new_test_case_found_actions.extend (agent a_listener.on_new_test_case_found)
			break_point_hit_actions.extend (agent a_listener.on_break_point_hits)
			fix_candidate_validation_start_actions.extend (agent a_listener.on_fix_candidate_validation_starts)
			fix_candidate_validation_end_actions.extend (agent a_listener.on_fix_candidate_validation_ends)
			interpreter_start_actions.extend (agent a_listener.on_interpreter_starts)
			interpreter_start_failed_actions.extend (agent a_listener.on_interpreter_start_failed)
			test_case_execution_time_out_actions.extend (agent a_listener.on_test_case_execution_time_out)
		end

feature -- Access

	session_start_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when the whole AutoFix session starts

	session_end_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when the whole AutoFix session ends

	session_canceled_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when the whole AutoFix session is canceled.

	test_case_analysis_start_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when the analyzing of test cases starts

	test_case_analysis_end_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when the analyzing of test cases ends

	fix_generation_start_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when fix generation starts

	fix_generation_end_actions: ACTION_SEQUENCE [TUPLE [a_fixes: DS_LINKED_LIST [AFX_FIX]]]
			-- Actions to be performed when fix generation ends
			-- `a_candidate_count' indidates the number of generated fix candidates

	contract_fixes_generation_end_actions: ACTION_SEQUENCE [TUPLE [a_fixes: DS_LIST [AFX_CONTRACT_FIX_ACROSS_FEATURES]]]

	contract_fixes_validation_end_actions: ACTION_SEQUENCE [TUPLE [a_fixes: DS_LIST [AFX_CONTRACT_FIX_ACROSS_FEATURES]]]

	fix_validation_start_actions: ACTION_SEQUENCE [TUPLE[a_fixes: LINKED_LIST [AFX_MELTED_FIX]]]
			-- Actions to be performed when fix validation starts

	fix_validation_end_actions: ACTION_SEQUENCE [TUPLE[a_fixes: LINKED_LIST [AFX_FIX]]]
			-- Actions to be performed when fix validation ends

	report_generation_start_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be perforomed when report generation starts.

	report_generation_end_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when report generation ends.

	new_test_case_found_actions: ACTION_SEQUENCE [TUPLE [tc_info: EPA_TEST_CASE_INFO]]
			-- Actions to be performed when test case indicated by `tc_info' is found during test case analysis phase

	break_point_hit_actions: ACTION_SEQUENCE [TUPLE [tc_info: EPA_TEST_CASE_INFO; break_point_slot: INTEGER]]
			-- Actions to be performed when break point `break_point_slot' in `tc_info' is hit

	fix_candidate_validation_start_actions: ACTION_SEQUENCE [TUPLE [a_candidate: AFX_FIX]]
			-- Actions to be performed when a fix candidate `a_candidate' starts to be validated

	fix_candidate_validation_end_actions: ACTION_SEQUENCE [TUPLE [a_candidate: AFX_FIX; a_valid: BOOLEAN; a_passing_count: INTEGER; a_failing_count: INTEGER]]
			-- Actions to be performed when a fix candidate `a_candidate' finishes to be validated.
			-- `a_valid' indicates whether `a_candidate' is valid.
			-- `a_passing_count' and `a_failing_count' indicate the number of the test cases that `a_candidate' passes and failes, respectively.

	interpreter_start_actions: ACTION_SEQUENCE [TUPLE [a_port: INTEGER]]
			-- Actions to be performed when the interpreter starts
			-- `a_port' is the port number used for inter-process communication.

	interpreter_start_failed_actions: ACTION_SEQUENCE [TUPLE [a_port: INTEGER]]
			-- Actions to be performed when the interpreter start failed
			-- `a_port' is the port number used for inter-process communication.

	test_case_execution_time_out_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when test case execution during validation times out

feature -- actions

	notify_on_session_starts
			-- Call actions in `session_start_actions'.
		do
			session_start_actions.call (Void)
		end

	notify_on_session_ends
			-- Call actions in `session_end_actions'.
		do
			session_end_actions.call (Void)
		end

	notify_on_session_canceled
			-- Call actions in `session_canceled_actions'.
		do
			session_canceled_actions.call(Void)
		end

	notify_on_test_case_analysis_starts
			-- Call actions in `test_case_analysis_start_actions'.
		do
			test_case_analysis_start_actions.call (Void)
		end

	notify_on_test_case_analysis_ends
			-- Call actions in `test_case_analysis_end_actions'.
		do
			test_case_analysis_end_actions.call (Void)
		end

	notify_on_fix_generation_starts
			-- Call actions in `fix_generation_end_actions'.
		do
			fix_generation_start_actions.call (Void)
		end

	notify_on_fix_generation_ends (a_fixes: DS_LINKED_LIST [AFX_FIX])
			-- Call actions in `fix_generation_end_actions'.
			-- `a_candidate_count' indidates the number of generated fix candidates.
		do
			fix_generation_end_actions.call ([a_fixes])
		end

	notify_on_contract_fixes_generation_ends (a_fixes: DS_LIST [AFX_CONTRACT_FIX_ACROSS_FEATURES])
		do
			contract_fixes_generation_end_actions.call ([a_fixes])
		end


	notify_on_contract_fixes_validation_ends (a_fixes: DS_LIST [AFX_CONTRACT_FIX_ACROSS_FEATURES])
		do
			contract_fixes_validation_end_actions.call ([a_fixes])
		end

	notify_on_fix_validation_starts (a_fixes: LINKED_LIST [AFX_MELTED_FIX])
			-- Call actions in `fix_validation_end_actions'.
		do
			fix_validation_start_actions.call ([a_fixes])
		end

	notify_on_fix_validation_ends (a_fixes: LINKED_LIST [AFX_FIX])
			-- Call actions in `fix_validation_end_actions'.
		do
			fix_validation_end_actions.call ([a_fixes])
		end

	notify_on_report_generation_starts
			-- Call actions in `report_generation_start_actions'.
		do
			report_generation_start_actions.call (Void)
		end

	notify_on_report_generation_ends
			-- Call actions in `report_generation_end_actions'.
		do
			report_generation_end_actions.call (Void)
		end

	notify_on_new_test_case_found (a_tc_info: EPA_TEST_CASE_INFO)
			-- Call actions in `new_test_case_found_actions'.
		do
			new_test_case_found_actions.call ([a_tc_info])
		end

	notify_on_break_point_hit (a_tc_info: EPA_TEST_CASE_INFO; a_bpslot: INTEGER)
			-- Call actions in `break_point_hit_actions'.
		do
			break_point_hit_actions.call ([a_tc_info, a_bpslot])
		end

	notify_on_fix_candidate_validation_starts (a_candidate: AFX_FIX)
			-- Call actions in `fix_candidate_validation_start_actions'.
		do
			fix_candidate_validation_start_actions.call ([a_candidate])
		end

	notify_on_fix_candidate_validation_ends (a_candidate: AFX_FIX; a_valid: BOOLEAN; a_passing_count: INTEGER; a_failing_count: INTEGER)
			-- Call actions in `fix_candidate_validation_end_actions'.
			-- `a_valid' indicates whether `a_candidate' is Valid.
			-- `a_passing_count' and `a_failing_count' indicate the number of the test cases that `a_candidate' passes and failes, respectively.
		do
			fix_candidate_validation_end_actions.call ([a_candidate, a_valid, a_passing_count, a_failing_count])
		end

	notify_on_interpreter_starts (a_port: INTEGER)
			-- Cal actions in `interpreter_start_actions'.
		do
			interpreter_start_actions.call ([a_port])
		end

	notify_on_interpreter_start_failed (a_port: INTEGER)
			-- Cal actions in `interpreter_start_failed_actions'.
		do
			interpreter_start_failed_actions.call ([a_port])
		end

	notify_on_test_case_execution_time_out
			-- Call actions in `test_case_execution_time_out_actions'.
		do
			test_case_execution_time_out_actions.call (Void)
		end
end
