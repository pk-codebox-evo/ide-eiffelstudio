indexing
	description: "Objects that capture the state of some application"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_CAPTURER

inherit

	CDD_SUPPORT

feature -- Access

	reflected_call_stack: DS_LINKED_LIST [CDD_REFLECTION]
			-- List of all reflected call stack elements
			-- Note: Top element of the stack is first in the list

feature -- Basic operations

	reflect_call_stack (an_application_status: APPLICATION_STATUS) is
			-- Try to reflect current state of `an_application_status' for called feature in `a_cse'.
			-- Result is stored in `last_reflection'.
		require
			an_application_status_not_void: an_application_status /= Void
			valid_application_status: is_valid_status (an_application_status)
		local
			l_cse: EIFFEL_CALL_STACK_ELEMENT
			l_feature: E_FEATURE
			l_class: EIFFEL_CLASS_C
			l_is_creation_call: BOOLEAN
			l_reflection: CDD_REFLECTION
		do
			create reflected_call_stack.make
			l_cse ?= an_application_status.current_call_stack_element

			-- Check whether it is the callers fault
			if l_cse /= Void then
				if an_application_status.exception_code = {EXCEP_CONST}.precondition and
						l_cse.level_in_stack < an_application_status.current_call_stack.count then
					l_cse := caller (l_cse, an_application_status.current_call_stack)
				end
			end

			-- Make sure we are trying to reflect an eiffel class
			if l_cse /= Void and then l_cse.dynamic_class /= Void and then l_cse.dynamic_class.is_eiffel_class_c then
				from
					l_feature := l_cse.routine
				until
					l_cse = Void
				loop
					if l_cse.dynamic_class /= Void and then l_cse.dynamic_class.is_eiffel_class_c then
						l_class := l_cse.dynamic_class.eiffel_class_c
						l_is_creation_call := is_creation_procedure (l_class, l_feature)
						if l_is_creation_call or l_feature.export_status.is_all then
							create l_reflection.make (an_application_status, l_cse, l_is_creation_call)
							if l_reflection.reflection_succeded then
								reflected_call_stack.put_last (l_reflection)
							end
						end
					end
					l_cse := caller (l_cse, an_application_status.current_call_stack)
				end
			end
		end

feature {NONE} -- Implementation

	is_creation_procedure (a_class: EIFFEL_CLASS_C; a_feature: E_FEATURE): BOOLEAN is
			-- Is `l_feature' a creation procedure of `a_class'?
		require
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature /= Void
		do
			Result := a_class.creation_feature = a_feature.associated_feature_i
			if not Result then
				Result := a_class.creators /= Void and then a_class.creators.has (a_feature.name)
			end
		end

	caller (a_element: EIFFEL_CALL_STACK_ELEMENT; a_call_stack: EIFFEL_CALL_STACK): EIFFEL_CALL_STACK_ELEMENT is
			-- Call stack element which called the routine in `a_element' in `a_call_stack'.
			-- NOTE: Void if `a_element' is first element in `a_call_stack' or caller is not a eiffel call stack element.
		require
			a_element_not_void: a_element /= Void
			a_call_stack_not_void: a_call_stack /= Void
			a_element_valid: a_call_stack.i_th (a_element.level_in_stack) = a_element
		do
			if a_element.level_in_stack < a_call_stack.count then
				Result ?= a_call_stack.i_th (a_element.level_in_stack + 1)
			end
		end

end
