indexing
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IOLE_WINDOW_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	get_window_user_precondition (phwnd: CELL [POINTER]): BOOLEAN is
			-- User-defined preconditions for `get_window'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	context_sensitive_help_user_precondition (f_enter_mode: INTEGER): BOOLEAN is
			-- User-defined preconditions for `context_sensitive_help'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	get_window (phwnd: CELL [POINTER]) is
			-- No description available.
			-- `phwnd' [out].  
		require
			non_void_phwnd: phwnd /= Void
			get_window_user_precondition: get_window_user_precondition (phwnd)
		deferred

		ensure
			valid_phwnd: phwnd.item /= Void
		end

	context_sensitive_help (f_enter_mode: INTEGER) is
			-- No description available.
			-- `f_enter_mode' [in].  
		require
			context_sensitive_help_user_precondition: context_sensitive_help_user_precondition (f_enter_mode)
		deferred

		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IOLE_WINDOW_INTERFACE

