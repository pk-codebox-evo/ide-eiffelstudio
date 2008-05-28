indexing
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IENUM_UNKNOWN_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	next_user_precondition (celt: INTEGER; rgelt: ARRAY [ECOM_INTERFACE]; pcelt_fetched: INTEGER_REF): BOOLEAN is
			-- User-defined preconditions for `next'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	skip_user_precondition (celt: INTEGER): BOOLEAN is
			-- User-defined preconditions for `skip'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	reset_user_precondition: BOOLEAN is
			-- User-defined preconditions for `reset'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	clone1_user_precondition (ppenum: CELL [IENUM_UNKNOWN_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `clone1'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	next (celt: INTEGER; rgelt: ARRAY [ECOM_INTERFACE]; pcelt_fetched: INTEGER_REF) is
			-- No description available.
			-- `celt' [in].  
			-- `rgelt' [out].  
			-- `pcelt_fetched' [out].  
		require
			non_void_rgelt: rgelt /= Void
			next_user_precondition: next_user_precondition (celt, rgelt, pcelt_fetched)
		deferred

		ensure
			valid_rgelt: pcelt_fetched /= Void implies rgelt.count = pcelt_fetched.item
		end

	skip (celt: INTEGER) is
			-- No description available.
			-- `celt' [in].  
		require
			skip_user_precondition: skip_user_precondition (celt)
		deferred

		end

	reset is
			-- No description available.
		require
			reset_user_precondition: reset_user_precondition
		deferred

		end

	clone1 (ppenum: CELL [IENUM_UNKNOWN_INTERFACE]) is
			-- No description available.
			-- `ppenum' [out].  
		require
			non_void_ppenum: ppenum /= Void
			clone1_user_precondition: clone1_user_precondition (ppenum)
		deferred

		ensure
			valid_ppenum: ppenum.item /= Void
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




end -- IENUM_UNKNOWN_INTERFACE

