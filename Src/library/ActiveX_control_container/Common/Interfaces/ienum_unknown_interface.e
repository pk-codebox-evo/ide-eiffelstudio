indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IENUM_UNKNOWN_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	remote_next_user_precondition (celt: INTEGER; rgelt: CELL [ECOM_INTERFACE]; pcelt_fetched: INTEGER_REF): BOOLEAN is
			-- User-defined preconditions for `remote_next'.
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

	remote_next (celt: INTEGER; rgelt: CELL [ECOM_INTERFACE]; pcelt_fetched: INTEGER_REF) is
			-- No description available.
			-- `celt' [in].  
			-- `rgelt' [out].  
			-- `pcelt_fetched' [out].  
		require
			non_void_rgelt: rgelt /= Void
			non_void_pcelt_fetched: pcelt_fetched /= Void
			remote_next_user_precondition: remote_next_user_precondition (celt, rgelt, pcelt_fetched)
		deferred

		ensure
			valid_rgelt: rgelt.item /= Void
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

end -- IENUM_UNKNOWN_INTERFACE

