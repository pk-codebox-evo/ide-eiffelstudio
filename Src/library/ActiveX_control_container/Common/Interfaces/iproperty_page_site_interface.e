note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IPROPERTY_PAGE_SITE_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	on_status_change_user_precondition (dw_flags: INTEGER): BOOLEAN
			-- User-defined preconditions for `on_status_change'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_locale_id_user_precondition (p_locale_id: INTEGER_REF): BOOLEAN
			-- User-defined preconditions for `get_locale_id'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_page_container_user_precondition (ppunk: CELL [ECOM_INTERFACE]): BOOLEAN
			-- User-defined preconditions for `get_page_container'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	translate_accelerator_user_precondition (p_msg: TAG_MSG_RECORD): BOOLEAN
			-- User-defined preconditions for `translate_accelerator'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	on_status_change (dw_flags: INTEGER)
			-- No description available.
			-- `dw_flags' [in].  
		require
			on_status_change_user_precondition: on_status_change_user_precondition (dw_flags)
		deferred

		end

	get_locale_id (p_locale_id: INTEGER_REF)
			-- No description available.
			-- `p_locale_id' [out].  
		require
			non_void_p_locale_id: p_locale_id /= Void
			get_locale_id_user_precondition: get_locale_id_user_precondition (p_locale_id)
		deferred

		end

	get_page_container (ppunk: CELL [ECOM_INTERFACE])
			-- No description available.
			-- `ppunk' [out].  
		require
			non_void_ppunk: ppunk /= Void
			get_page_container_user_precondition: get_page_container_user_precondition (ppunk)
		deferred

		ensure
			valid_ppunk: ppunk.item /= Void
		end

	translate_accelerator (p_msg: TAG_MSG_RECORD)
			-- No description available.
			-- `p_msg' [in].  
		require
			non_void_p_msg: p_msg /= Void
			valid_p_msg: p_msg.item /= default_pointer
			translate_accelerator_user_precondition: translate_accelerator_user_precondition (p_msg)
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




end -- IPROPERTY_PAGE_SITE_INTERFACE

