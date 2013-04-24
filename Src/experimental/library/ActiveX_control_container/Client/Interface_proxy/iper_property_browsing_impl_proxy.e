note
	description: "Implemented `IPerPropertyBrowsing' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	IPER_PROPERTY_BROWSING_IMPL_PROXY

inherit
	IPER_PROPERTY_BROWSING_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_iper_property_browsing_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	get_display_string (disp_id: INTEGER; p_bstr: CELL [STRING])
			-- No description available.
			-- `disp_id' [in].  
			-- `p_bstr' [out].  
		do
			ccom_get_display_string (initializer, disp_id, p_bstr)
		end

	map_property_to_page (disp_id: INTEGER; p_clsid: ECOM_GUID)
			-- No description available.
			-- `disp_id' [in].  
			-- `p_clsid' [out].  
		do
			ccom_map_property_to_page (initializer, disp_id, p_clsid.item)
		end

	get_predefined_strings (disp_id: INTEGER; p_ca_strings_out: TAG_CALPOLESTR_RECORD; p_ca_cookies_out: TAG_CADWORD_RECORD)
			-- No description available.
			-- `disp_id' [in].  
			-- `p_ca_strings_out' [out].  
			-- `p_ca_cookies_out' [out].  
		do
			ccom_get_predefined_strings (initializer, disp_id, p_ca_strings_out.item, p_ca_cookies_out.item)
		end

	get_predefined_value (disp_id: INTEGER; dw_cookie: INTEGER; p_var_out: ECOM_VARIANT)
			-- No description available.
			-- `disp_id' [in].  
			-- `dw_cookie' [in].  
			-- `p_var_out' [out].  
		do
			ccom_get_predefined_value (initializer, disp_id, dw_cookie, p_var_out.item)
		end

feature {NONE}  -- Implementation

	delete_wrapper
			-- Delete wrapper
		do
			ccom_delete_iper_property_browsing_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_get_display_string (cpp_obj: POINTER; disp_id: INTEGER; p_bstr: CELL [STRING])
			-- No description available.
		external
			"C++ [ecom_control_library::IPerPropertyBrowsing_impl_proxy %"ecom_control_library_IPerPropertyBrowsing_impl_proxy_s.h%"](EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_map_property_to_page (cpp_obj: POINTER; disp_id: INTEGER; p_clsid: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPerPropertyBrowsing_impl_proxy %"ecom_control_library_IPerPropertyBrowsing_impl_proxy_s.h%"](EIF_INTEGER,GUID *)"
		end

	ccom_get_predefined_strings (cpp_obj: POINTER; disp_id: INTEGER; p_ca_strings_out: POINTER; p_ca_cookies_out: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPerPropertyBrowsing_impl_proxy %"ecom_control_library_IPerPropertyBrowsing_impl_proxy_s.h%"](EIF_INTEGER,ecom_control_library::tagCALPOLESTR *,ecom_control_library::tagCADWORD *)"
		end

	ccom_get_predefined_value (cpp_obj: POINTER; disp_id: INTEGER; dw_cookie: INTEGER; p_var_out: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPerPropertyBrowsing_impl_proxy %"ecom_control_library_IPerPropertyBrowsing_impl_proxy_s.h%"](EIF_INTEGER,EIF_INTEGER,VARIANT *)"
		end

	ccom_delete_iper_property_browsing_impl_proxy (a_pointer: POINTER)
			-- Release resource
		external
			"C++ [delete ecom_control_library::IPerPropertyBrowsing_impl_proxy %"ecom_control_library_IPerPropertyBrowsing_impl_proxy_s.h%"]()"
		end

	ccom_create_iper_property_browsing_impl_proxy_from_pointer (a_pointer: POINTER): POINTER
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IPerPropertyBrowsing_impl_proxy %"ecom_control_library_IPerPropertyBrowsing_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER
			-- Item
		external
			"C++ [ecom_control_library::IPerPropertyBrowsing_impl_proxy %"ecom_control_library_IPerPropertyBrowsing_impl_proxy_s.h%"]():EIF_POINTER"
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




end -- IPER_PROPERTY_BROWSING_IMPL_PROXY

