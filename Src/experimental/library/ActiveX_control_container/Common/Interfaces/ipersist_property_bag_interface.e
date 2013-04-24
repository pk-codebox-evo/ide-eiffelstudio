note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IPERSIST_PROPERTY_BAG_INTERFACE

inherit
	IPERSIST_INTERFACE

feature -- Status Report

	init_new_user_precondition: BOOLEAN
			-- User-defined preconditions for `init_new'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	load_user_precondition (p_prop_bag: IPROPERTY_BAG_INTERFACE; p_error_log: IERROR_LOG_INTERFACE): BOOLEAN
			-- User-defined preconditions for `load'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	save_user_precondition (p_prop_bag: IPROPERTY_BAG_INTERFACE; f_clear_dirty: INTEGER; f_save_all_properties: INTEGER): BOOLEAN
			-- User-defined preconditions for `save'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	init_new
			-- No description available.
		require
			init_new_user_precondition: init_new_user_precondition
		deferred

		end

	load (p_prop_bag: IPROPERTY_BAG_INTERFACE; p_error_log: IERROR_LOG_INTERFACE)
			-- No description available.
			-- `p_prop_bag' [in].  
			-- `p_error_log' [in].  
		require
			load_user_precondition: load_user_precondition (p_prop_bag, p_error_log)
		deferred

		end

	save (p_prop_bag: IPROPERTY_BAG_INTERFACE; f_clear_dirty: INTEGER; f_save_all_properties: INTEGER)
			-- No description available.
			-- `p_prop_bag' [in].  
			-- `f_clear_dirty' [in].  
			-- `f_save_all_properties' [in].  
		require
			save_user_precondition: save_user_precondition (p_prop_bag, f_clear_dirty, f_save_all_properties)
		deferred

		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IPERSIST_PROPERTY_BAG_INTERFACE

