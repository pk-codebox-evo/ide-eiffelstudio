indexing
	description: "Objects representing the original outcome of an extracted test case"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_ORIGINAL_OUTCOME

inherit

	EXCEP_CONST
		export
			{NONE} all
		redefine
			out
		end

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
		local
			l_cs: EIFFEL_CALL_STACK
			l_cse: CALL_STACK_ELEMENT
			l_2nd_element_available: BOOLEAN
		do
			covered_feature := a_covered_feature

			exception_code := a_status.exception_code
				-- The exception tag can be void (e.g. exception for untagged pre-/postcondition violations)
			if a_status.exception_tag = Void then
				exception_tag_name := ""
			else
				exception_tag_name := a_status.exception_tag
			end

				-- NOTE: Through the runtime patch for invariant violation exception, the new semantics for
				-- for precondition violation apply:
				-- The recipient for a precondition violation is the caller of the feature whose precondition has been violated,
				-- and not the feature whose precondition has been violated itself.
			if
				a_status.exception_code = {EXCEP_CONST}.precondition and then
				a_status.current_call_stack.count > 1
					-- If for mystierious reasons not two call stack elements are available, we resort to top element anyway
			then
				l_cs := a_status.current_call_stack
				l_cs.start
				l_cs.forth
				l_cse := l_cs.item
				exception_recipient_name := l_cse.routine_name
				exception_break_point_slot := l_cse.break_index
				exception_class_name := l_cse.class_name
			else
				exception_recipient_name := a_status.current_call_stack_element.routine_name
				exception_break_point_slot := a_status.break_index
				exception_class_name := a_status.current_call_stack_element.class_name
			end

				-- NOTE: The above mentioned semantics for precondition violations currently is ignored for stack trace
				-- (we do not actively remove the first line thereof)
			exception_trace := a_status.current_call_stack.to_string

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

	original_class_file_name: STRING_8
			-- Original file name of the class containing the test routine associated with `Current'

	out: STRING_8 is
			-- String representation of `Current'
		do
			Result := "covers: {" + covered_feature.associated_class.name_in_upper + "}." + covered_feature.name + "%N"
			if is_passing then
				Result.append_string ("[normal]%N")
			else
				Result.append_string ("[exception]%N")
				Result.append_string ("%Tcode: " + exception_code.out + "%N")
				Result.append_string ("%Tname: " + exception_name + "%N")
				Result.append_string ("%Ttag: " + exception_tag_name + "%N")
				Result.append_string ("%Tfeature: " + exception_recipient_name + "@" + exception_break_point_slot.out + "%N")
				Result.append_string ("%Tclass: " + exception_class_name + "%N")
				Result.append_string ("Original failure stack trace:%N%N" + exception_trace + "%N")
			end
		end

	out_short: STRING_8 is
			-- String representation of `Current'
		do
			Result := "covers: {" + covered_feature.associated_class.name_in_upper + "}." + covered_feature.name + "%N"
			if is_passing then
				Result.append_string ("[normal]%N")
			else
				Result.append_string ("[exception]%N")
				Result.append_string ("%Tcode: " + exception_code.out + "%N")
				Result.append_string ("%Tname: " + exception_name + "%N")
				Result.append_string ("%Ttag: " + exception_tag_name + "%N")
				Result.append_string ("%Tfeature: " + exception_recipient_name + "@" + exception_break_point_slot.out + "%N")
				Result.append_string ("%Tclass: " + exception_class_name + "%N")
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

	is_same (other: like Current): BOOLEAN is
			-- Does `other' represent the same failure as `Current'?
		do
			Result :=	covered_feature.same_as (other.covered_feature) and then
						(
						 (is_passing and then
						  other.is_passing
						 ) or else
						 (is_failing and then
						  other.is_failing and then
						  exception_code = other.exception_code and then
						  exception_tag_name.is_equal (other.exception_tag_name) and then
						  exception_recipient_name.is_equal (other.exception_recipient_name) and then
						  exception_class_name.is_equal (other.exception_class_name)
						 )
						)

		end

feature -- Basic Operations

	set_original_class_file_name (a_name: STRING_8) is
			-- set `original_class_file_name' to `a_name'
		do
			original_class_file_name := a_name
		end

	set_covered_feature (a_feature: E_FEATURE)is
			-- Set `covered_feature' to `a_covered_feature'.
		do
			covered_feature := a_feature
		ensure
			covered_feature_set: covered_feature = a_feature
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
