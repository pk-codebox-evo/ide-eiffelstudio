indexing
	description: "Feature paramaters enumeration. Eiffel language compiler library. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IENUM_PARAMETER_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	next_user_precondition (pp_ieiffel_parameter_descriptor: CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE]; pul_fetched: INTEGER_REF): BOOLEAN is
			-- User-defined preconditions for `next'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	skip_user_precondition (ul_count: INTEGER): BOOLEAN is
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

	clone1_user_precondition (pp_ienum_parameter: CELL [IENUM_PARAMETER_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `clone1'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	ith_item_user_precondition (ul_index: INTEGER; pp_ieiffel_parameter_descriptor: CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `ith_item'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	count_user_precondition: BOOLEAN is
			-- User-defined preconditions for `count'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	next (pp_ieiffel_parameter_descriptor: CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE]; pul_fetched: INTEGER_REF) is
			-- No description available.
			-- `pp_ieiffel_parameter_descriptor' [out].  
			-- `pul_fetched' [out].  
		require
			non_void_pp_ieiffel_parameter_descriptor: pp_ieiffel_parameter_descriptor /= Void
			non_void_pul_fetched: pul_fetched /= Void
			next_user_precondition: next_user_precondition (pp_ieiffel_parameter_descriptor, pul_fetched)
		deferred

		ensure
			valid_pp_ieiffel_parameter_descriptor: pp_ieiffel_parameter_descriptor.item /= Void
		end

	skip (ul_count: INTEGER) is
			-- No description available.
			-- `ul_count' [in].  
		require
			skip_user_precondition: skip_user_precondition (ul_count)
		deferred

		end

	reset is
			-- No description available.
		require
			reset_user_precondition: reset_user_precondition
		deferred

		end

	clone1 (pp_ienum_parameter: CELL [IENUM_PARAMETER_INTERFACE]) is
			-- No description available.
			-- `pp_ienum_parameter' [out].  
		require
			non_void_pp_ienum_parameter: pp_ienum_parameter /= Void
			clone1_user_precondition: clone1_user_precondition (pp_ienum_parameter)
		deferred

		ensure
			valid_pp_ienum_parameter: pp_ienum_parameter.item /= Void
		end

	ith_item (ul_index: INTEGER; pp_ieiffel_parameter_descriptor: CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE]) is
			-- No description available.
			-- `ul_index' [in].  
			-- `pp_ieiffel_parameter_descriptor' [out].  
		require
			non_void_pp_ieiffel_parameter_descriptor: pp_ieiffel_parameter_descriptor /= Void
			ith_item_user_precondition: ith_item_user_precondition (ul_index, pp_ieiffel_parameter_descriptor)
		deferred

		ensure
			valid_pp_ieiffel_parameter_descriptor: pp_ieiffel_parameter_descriptor.item /= Void
		end

	count: INTEGER is
			-- No description available.
		require
			count_user_precondition: count_user_precondition
		deferred

		end

end -- IENUM_PARAMETER_INTERFACE

