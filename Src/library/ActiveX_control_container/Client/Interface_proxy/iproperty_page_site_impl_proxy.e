indexing
	description: "Implemented `IPropertyPageSite' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IPROPERTY_PAGE_SITE_IMPL_PROXY

inherit
	IPROPERTY_PAGE_SITE_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_iproperty_page_site_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	on_status_change (dw_flags: INTEGER) is
			-- No description available.
			-- `dw_flags' [in].  
		do
			ccom_on_status_change (initializer, dw_flags)
		end

	get_locale_id (p_locale_id: INTEGER_REF) is
			-- No description available.
			-- `p_locale_id' [out].  
		do
			ccom_get_locale_id (initializer, p_locale_id)
		end

	get_page_container (ppunk: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `ppunk' [out].  
		do
			ccom_get_page_container (initializer, ppunk)
		end

	translate_accelerator (p_msg: TAG_MSG_RECORD) is
			-- No description available.
			-- `p_msg' [in].  
		do
			ccom_translate_accelerator (initializer, p_msg.item)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_iproperty_page_site_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_on_status_change (cpp_obj: POINTER; dw_flags: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPageSite_impl_proxy %"ecom_control_library_IPropertyPageSite_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_get_locale_id (cpp_obj: POINTER; p_locale_id: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPageSite_impl_proxy %"ecom_control_library_IPropertyPageSite_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_get_page_container (cpp_obj: POINTER; ppunk: CELL [ECOM_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPageSite_impl_proxy %"ecom_control_library_IPropertyPageSite_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_translate_accelerator (cpp_obj: POINTER; p_msg: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPageSite_impl_proxy %"ecom_control_library_IPropertyPageSite_impl_proxy_s.h%"](ecom_control_library::tagMSG *)"
		end

	ccom_delete_iproperty_page_site_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IPropertyPageSite_impl_proxy %"ecom_control_library_IPropertyPageSite_impl_proxy_s.h%"]()"
		end

	ccom_create_iproperty_page_site_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IPropertyPageSite_impl_proxy %"ecom_control_library_IPropertyPageSite_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IPropertyPageSite_impl_proxy %"ecom_control_library_IPropertyPageSite_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IPROPERTY_PAGE_SITE_IMPL_PROXY

