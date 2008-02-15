indexing
	description: "Objects representing the original outcome of an extracted test case"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_ORIGINAL_OUTCOME

inherit

	EXCEP_CONST
		export {NONE} all end

create
	make_passing,
	make_failing

feature {NONE} -- Initialization

	make_failing (a_covered_feature: E_FEATURE; a_status: APPLICATION_STATUS) is
			-- Initialize `Current' as failing outcome.
		require
			a_covered_feature_not_void: a_covered_feature /= Void
			a_status_not_void: a_status /= Void
			a_status_is_exception: a_status.exception_occurred
		do
			covered_feature := a_covered_feature

			exception_code := a_status.exception_code
			exception_recipient_name := a_status.current_call_stack_element.routine_name
			exception_break_point_slot := a_status.break_index
			exception_class_name := a_status.current_call_stack_element.class_name
			exception_trace := a_status.current_call_stack.to_string

				-- The exception tag can be void (e.g. exception for untagged pre-/postcondition violations)
			if a_status.exception_tag = Void then
				exception_tag_name := ""
			else
				exception_tag_name := a_status.exception_tag
			end

			is_failing := True
		ensure
			covered_feature_set: covered_feature = a_covered_feature
			outcome_is_failing: is_failing
		end

	make_passing (a_covered_feature: E_FEATURE) is
			-- Initialize `Current' as passing outcome.
		require
			a_covered_feature_not_void: a_covered_feature /= Void
		do
			covered_feature := a_covered_feature
		ensure
			covered_feature_set: covered_feature = a_covered_feature
			outcome_is_passing: is_passing
		end

feature -- Access

	covered_feature: E_FEATURE
			-- Feature initially covered by the test routine associated with `Current'

	exception_code: INTEGER
			-- Code of exception if failing

	exception_recipient_name: STRING
			-- Name of exception's recipient if failing

	exception_break_point_slot: INTEGER
			-- Break point slot in exception recipient that triggered exception if failing;
			-- Note that the number of slots available in a routine may change depending
			-- on the level of assertion monitoring.

	exception_class_name: STRING
			-- Name of exception's class name if failing

	exception_tag_name: STRING
			-- Name of exception's tag name if failing

	exception_trace: STRING
			-- Stack trace of exception if failing

	exception_name: STRING is
			-- Name of `exception'
		do
			if exception_code = Void_call_target then
				Result := "Void_call_target"
			elseif exception_code = No_more_memory then
				Result := "No_more_memory"
			elseif exception_code = Precondition then
				Result := "Precondition"
			elseif exception_code = Postcondition then
				Result := "Postcondition"
			elseif exception_code = Floating_point_exception then
				Result := "Floating_point_exception"
			elseif exception_code = Class_invariant then
				Result := "Class_invariant"
			elseif exception_code = Check_instruction then
				Result := "Check_instruction"
			elseif exception_code = Routine_failure then
				Result := "Routine_failure"
			elseif exception_code = Incorrect_inspect_value then
				Result := "Incorrect_inspect_value"
			elseif exception_code = Loop_variant then
				Result := "Loop_variant"
			elseif exception_code = Loop_invariant then
				Result := "Loop_invariant"
			elseif exception_code = Signal_exception then
				Result := "Signal_exception"
			elseif exception_code = Rescue_exception then
				Result := "Rescue_exception"
			elseif exception_code = External_exception then
				Result := "External_exception"
			elseif exception_code = Void_assigned_to_expanded then
				Result := "Void_assigned_to_expanded"
			elseif exception_code = Io_exception then
				Result := "Io_exception"
			elseif exception_code = Operating_system_exception then
				Result := "Operating_system_exception"
			elseif exception_code = Retrieve_exception then
				Result := "Retrieve_exception"
			elseif exception_code = Developer_exception then
				Result := "Developer_exception"
			elseif exception_code = Runtime_io_exception then
				Result := "Runtime_io_exception"
			elseif exception_code = Com_exception then
				Result := "Com_exception"
			elseif exception_code = Runtime_check_exception then
				Result := "Runtime_check_exception"
			else
					check
						dead_end: False
					end
			end
		end

feature -- Status report

	is_failing: BOOLEAN
			-- Does `Current' represent a failing outcome?

	is_passing: BOOLEAN is
			-- Does `Current' represent a passing outcome?
		do
			Result := not is_failing
		ensure
			definition: Result = not is_failing
		end

invariant
	covered_feature_set: covered_feature /= Void
	failing_ipmlies_exception_info_available: is_failing implies (
												exception_code /= 0 and then
												exception_recipient_name /= Void and then not exception_recipient_name.is_empty and then
												exception_break_point_slot >= 0 and then
												exception_class_name /= Void and then not exception_class_name.is_empty and then
												exception_tag_name /= Void and then
												exception_trace /= Void and then not exception_trace.is_empty)

end
