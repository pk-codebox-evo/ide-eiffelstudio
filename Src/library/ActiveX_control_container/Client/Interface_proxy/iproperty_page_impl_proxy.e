note
	description: "Implemented `IPropertyPage' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IPROPERTY_PAGE_IMPL_PROXY

inherit
	IPROPERTY_PAGE_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_iproperty_page_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	set_page_site (p_page_site: IPROPERTY_PAGE_SITE_INTERFACE)
			-- No description available.
			-- `p_page_site' [in].  
		local
			p_page_site_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_page_site /= Void then
				if (p_page_site.item = default_pointer) then
					a_stub ?= p_page_site
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_page_site_item := p_page_site.item
			end
			ccom_set_page_site (initializer, p_page_site_item)
		end

	activate (hwnd_parent: POINTER; p_rect: TAG_RECT_RECORD; b_modal: INTEGER)
			-- No description available.
			-- `hwnd_parent' [in].  
			-- `p_rect' [in].  
			-- `b_modal' [in].  
		do
			ccom_activate (initializer, hwnd_parent, p_rect.item, b_modal)
		end

	deactivate
			-- No description available.
		do
			ccom_deactivate (initializer)
		end

	get_page_info (p_page_info: TAG_PROPPAGEINFO_RECORD)
			-- No description available.
			-- `p_page_info' [out].  
		do
			ccom_get_page_info (initializer, p_page_info.item)
		end

	set_objects (c_objects: INTEGER; ppunk: CELL [ECOM_INTERFACE])
			-- No description available.
			-- `c_objects' [in].  
			-- `ppunk' [in].  
		do
			ccom_set_objects (initializer, c_objects, ppunk)
		end

	show (n_cmd_show: INTEGER)
			-- No description available.
			-- `n_cmd_show' [in].  
		do
			ccom_show (initializer, n_cmd_show)
		end

	move (p_rect: TAG_RECT_RECORD)
			-- No description available.
			-- `p_rect' [in].  
		do
			ccom_move (initializer, p_rect.item)
		end

	is_page_dirty
			-- No description available.
		do
			ccom_is_page_dirty (initializer)
		end

	apply
			-- No description available.
		do
			ccom_apply (initializer)
		end

	help (psz_help_dir: STRING)
			-- No description available.
			-- `psz_help_dir' [in].  
		do
			ccom_help (initializer, psz_help_dir)
		end

	translate_accelerator (p_msg: TAG_MSG_RECORD)
			-- No description available.
			-- `p_msg' [in].  
		do
			ccom_translate_accelerator (initializer, p_msg.item)
		end

feature {NONE}  -- Implementation

	delete_wrapper
			-- Delete wrapper
		do
			ccom_delete_iproperty_page_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_set_page_site (cpp_obj: POINTER; p_page_site: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPage_impl_proxy %"ecom_control_library_IPropertyPage_impl_proxy_s.h%"](::IPropertyPageSite *)"
		end

	ccom_activate (cpp_obj: POINTER; hwnd_parent: POINTER; p_rect: POINTER; b_modal: INTEGER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPage_impl_proxy %"ecom_control_library_IPropertyPage_impl_proxy_s.h%"](EIF_POINTER,ecom_control_library::tagRECT *,EIF_INTEGER)"
		end

	ccom_deactivate (cpp_obj: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPage_impl_proxy %"ecom_control_library_IPropertyPage_impl_proxy_s.h%"]()"
		end

	ccom_get_page_info (cpp_obj: POINTER; p_page_info: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPage_impl_proxy %"ecom_control_library_IPropertyPage_impl_proxy_s.h%"](ecom_control_library::tagPROPPAGEINFO *)"
		end

	ccom_set_objects (cpp_obj: POINTER; c_objects: INTEGER; ppunk: CELL [ECOM_INTERFACE])
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPage_impl_proxy %"ecom_control_library_IPropertyPage_impl_proxy_s.h%"](EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_show (cpp_obj: POINTER; n_cmd_show: INTEGER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPage_impl_proxy %"ecom_control_library_IPropertyPage_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_move (cpp_obj: POINTER; p_rect: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPage_impl_proxy %"ecom_control_library_IPropertyPage_impl_proxy_s.h%"](ecom_control_library::tagRECT *)"
		end

	ccom_is_page_dirty (cpp_obj: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPage_impl_proxy %"ecom_control_library_IPropertyPage_impl_proxy_s.h%"]()"
		end

	ccom_apply (cpp_obj: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPage_impl_proxy %"ecom_control_library_IPropertyPage_impl_proxy_s.h%"]()"
		end

	ccom_help (cpp_obj: POINTER; psz_help_dir: STRING)
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPage_impl_proxy %"ecom_control_library_IPropertyPage_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_translate_accelerator (cpp_obj: POINTER; p_msg: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPropertyPage_impl_proxy %"ecom_control_library_IPropertyPage_impl_proxy_s.h%"](ecom_control_library::tagMSG *)"
		end

	ccom_delete_iproperty_page_impl_proxy (a_pointer: POINTER)
			-- Release resource
		external
			"C++ [delete ecom_control_library::IPropertyPage_impl_proxy %"ecom_control_library_IPropertyPage_impl_proxy_s.h%"]()"
		end

	ccom_create_iproperty_page_impl_proxy_from_pointer (a_pointer: POINTER): POINTER
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IPropertyPage_impl_proxy %"ecom_control_library_IPropertyPage_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER
			-- Item
		external
			"C++ [ecom_control_library::IPropertyPage_impl_proxy %"ecom_control_library_IPropertyPage_impl_proxy_s.h%"]():EIF_POINTER"
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




end -- IPROPERTY_PAGE_IMPL_PROXY

