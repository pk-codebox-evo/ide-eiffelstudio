indexing
	description: "Implemented `IOleControlSite' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IOLE_CONTROL_SITE_IMPL_PROXY

inherit
	IOLE_CONTROL_SITE_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_iole_control_site_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	on_control_info_changed is
			-- No description available.
		do
			ccom_on_control_info_changed (initializer)
		end

	lock_in_place_active (f_lock: INTEGER) is
			-- No description available.
			-- `f_lock' [in].  
		do
			ccom_lock_in_place_active (initializer, f_lock)
		end

	get_extended_control (pp_disp: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `pp_disp' [out].  
		do
			ccom_get_extended_control (initializer, pp_disp)
		end

	transform_coords (p_ptl_himetric: X_POINTL_RECORD; p_ptf_container: TAG_POINTF_RECORD; dw_flags: INTEGER) is
			-- No description available.
			-- `p_ptl_himetric' [in, out].  
			-- `p_ptf_container' [in, out].  
			-- `dw_flags' [in].  
		do
			ccom_transform_coords (initializer, p_ptl_himetric.item, p_ptf_container.item, dw_flags)
		end

	translate_accelerator (p_msg: TAG_MSG_RECORD; grf_modifiers: INTEGER) is
			-- No description available.
			-- `p_msg' [in].  
			-- `grf_modifiers' [in].  
		do
			ccom_translate_accelerator (initializer, p_msg.item, grf_modifiers)
		end

	on_focus (f_got_focus: INTEGER) is
			-- No description available.
			-- `f_got_focus' [in].  
		do
			ccom_on_focus (initializer, f_got_focus)
		end

	show_property_frame is
			-- No description available.
		do
			ccom_show_property_frame (initializer)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_iole_control_site_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_on_control_info_changed (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleControlSite_impl_proxy %"ecom_control_library_IOleControlSite_impl_proxy_s.h%"]()"
		end

	ccom_lock_in_place_active (cpp_obj: POINTER; f_lock: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleControlSite_impl_proxy %"ecom_control_library_IOleControlSite_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_get_extended_control (cpp_obj: POINTER; pp_disp: CELL [ECOM_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleControlSite_impl_proxy %"ecom_control_library_IOleControlSite_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_transform_coords (cpp_obj: POINTER; p_ptl_himetric: POINTER; p_ptf_container: POINTER; dw_flags: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleControlSite_impl_proxy %"ecom_control_library_IOleControlSite_impl_proxy_s.h%"](ecom_control_library::_POINTL *,ecom_control_library::tagPOINTF *,EIF_INTEGER)"
		end

	ccom_translate_accelerator (cpp_obj: POINTER; p_msg: POINTER; grf_modifiers: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleControlSite_impl_proxy %"ecom_control_library_IOleControlSite_impl_proxy_s.h%"](ecom_control_library::tagMSG *,EIF_INTEGER)"
		end

	ccom_on_focus (cpp_obj: POINTER; f_got_focus: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleControlSite_impl_proxy %"ecom_control_library_IOleControlSite_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_show_property_frame (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleControlSite_impl_proxy %"ecom_control_library_IOleControlSite_impl_proxy_s.h%"]()"
		end

	ccom_delete_iole_control_site_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IOleControlSite_impl_proxy %"ecom_control_library_IOleControlSite_impl_proxy_s.h%"]()"
		end

	ccom_create_iole_control_site_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IOleControlSite_impl_proxy %"ecom_control_library_IOleControlSite_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IOleControlSite_impl_proxy %"ecom_control_library_IOleControlSite_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IOLE_CONTROL_SITE_IMPL_PROXY

