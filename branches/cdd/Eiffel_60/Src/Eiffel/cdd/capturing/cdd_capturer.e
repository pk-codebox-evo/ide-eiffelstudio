indexing
	description: "Objects that capture the state of some application"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_CAPTURER

feature -- Access

	last_reflection: STRING -- CDD_REFLECTION
			-- Result of last `make_reflection'.
			-- Void if reflection failed.

feature -- Basic operations

	make_reflection (an_application_status: APPLICATION_STATUS) is
			-- Try to reflect current state of `an_application_status',
			-- result is stored in `last_reflection'.
		require
			an_application_status_not_void: an_application_status /= Void
			valid_application_status: True -- valid_status(an_application_status)
		local
--			l_cse: EIFFEL_CALL_STACK_ELEMENT
--			l_tag: STRING
--                        l_feature: E_FEATURE
--                        l_class: EIFFEL_CLASS_C
--                        l_abort, l_is_creation_call: BOOLEAN
                do
--                        l_cse ?= an_app_status.current_call_stack_element
--                        if l_cse /= Void then
--                                if an_app_status.exception_code = {EXCEP_CONST}.precondition and l_cse.level_in_stack < an_app_status.current_call_stack.count then
--                                        l_cse := caller (l_cse, an_app_status.current_call_stack)
--                                end
--                        end
--                        if l_cse /= Void and then l_cse.dynamic_class /= Void and then l_cse.dynamic_class.is_eiffel_class_c then
--                                from
--                                        l_feature := l_cse.routine
--                                until
--                                        l_abort or else (l_feature.export_status.is_all or l_is_creation_call)
--                                loop
--                                        l_class := l_cse.dynamic_class.eiffel_class_c
--                                        l_is_creation_call := is_creation_procedure (l_class, l_feature)
--                                        if not l_is_creation_call then
--                                                l_cse := caller (l_cse, an_app_status.current_call_stack)
--                                                if l_cse = Void or else l_cse.dynamic_class = Void or else not l_cse.dynamic_class.is_eiffel_class_c then
--                                                        l_abort := True
--                                                else
--                                                        l_feature := l_cse.routine
--                                                end
--                                        end
--                                end
--                                if not l_abort then
--                                        create Result.make (an_app_status, l_cse, l_is_creation_call)
--                                end
--                        end

		end

feature -- Implementation



end
