indexing
	description: "Implemented `IOleInPlaceSiteEx' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IOLE_IN_PLACE_SITE_EX_IMPL_PROXY

inherit
	IOLE_IN_PLACE_SITE_EX_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_iole_in_place_site_ex_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	get_window (phwnd: CELL [POINTER]) is
			-- No description available.
			-- `phwnd' [out].  
		do
			ccom_get_window (initializer, phwnd)
		end

	context_sensitive_help (f_enter_mode: INTEGER) is
			-- No description available.
			-- `f_enter_mode' [in].  
		do
			ccom_context_sensitive_help (initializer, f_enter_mode)
		end

	can_in_place_activate is
			-- No description available.
		do
			ccom_can_in_place_activate (initializer)
		end

	on_in_place_activate is
			-- No description available.
		do
			ccom_on_in_place_activate (initializer)
		end

	on_uiactivate is
			-- No description available.
		do
			ccom_on_uiactivate (initializer)
		end

	get_window_context (pp_frame: CELL [IOLE_IN_PLACE_FRAME_INTERFACE]; pp_doc: CELL [IOLE_IN_PLACE_UIWINDOW_INTERFACE]; lprc_pos_rect: TAG_RECT_RECORD; lprc_clip_rect: TAG_RECT_RECORD; lp_frame_info: TAG_OIFI_RECORD) is
			-- No description available.
			-- `pp_frame' [out].  
			-- `pp_doc' [out].  
			-- `lprc_pos_rect' [out].  
			-- `lprc_clip_rect' [out].  
			-- `lp_frame_info' [in, out].  
		do
			ccom_get_window_context (initializer, pp_frame, pp_doc, lprc_pos_rect.item, lprc_clip_rect.item, lp_frame_info.item)
		end

	scroll (scroll_extant: TAG_SIZE_RECORD) is
			-- No description available.
			-- `scroll_extant' [in].  
		do
			ccom_scroll (initializer, scroll_extant.item)
		end

	on_uideactivate (f_undoable: INTEGER) is
			-- No description available.
			-- `f_undoable' [in].  
		do
			ccom_on_uideactivate (initializer, f_undoable)
		end

	on_in_place_deactivate is
			-- No description available.
		do
			ccom_on_in_place_deactivate (initializer)
		end

	discard_undo_state is
			-- No description available.
		do
			ccom_discard_undo_state (initializer)
		end

	deactivate_and_undo is
			-- No description available.
		do
			ccom_deactivate_and_undo (initializer)
		end

	on_pos_rect_change (lprc_pos_rect: TAG_RECT_RECORD) is
			-- No description available.
			-- `lprc_pos_rect' [in].  
		do
			ccom_on_pos_rect_change (initializer, lprc_pos_rect.item)
		end

	on_in_place_activate_ex (pf_no_redraw: INTEGER_REF; dw_flags: INTEGER) is
			-- No description available.
			-- `pf_no_redraw' [out].  
			-- `dw_flags' [in].  
		do
			ccom_on_in_place_activate_ex (initializer, pf_no_redraw, dw_flags)
		end

	on_in_place_deactivate_ex (f_no_redraw: INTEGER) is
			-- No description available.
			-- `f_no_redraw' [in].  
		do
			ccom_on_in_place_deactivate_ex (initializer, f_no_redraw)
		end

	request_uiactivate is
			-- No description available.
		do
			ccom_request_uiactivate (initializer)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_iole_in_place_site_ex_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_get_window (cpp_obj: POINTER; phwnd: CELL [POINTER]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_context_sensitive_help (cpp_obj: POINTER; f_enter_mode: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_can_in_place_activate (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"]()"
		end

	ccom_on_in_place_activate (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"]()"
		end

	ccom_on_uiactivate (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"]()"
		end

	ccom_get_window_context (cpp_obj: POINTER; pp_frame: CELL [IOLE_IN_PLACE_FRAME_INTERFACE]; pp_doc: CELL [IOLE_IN_PLACE_UIWINDOW_INTERFACE]; lprc_pos_rect: POINTER; lprc_clip_rect: POINTER; lp_frame_info: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"](EIF_OBJECT,EIF_OBJECT,ecom_control_library::tagRECT *,ecom_control_library::tagRECT *,ecom_control_library::tagOIFI *)"
		end

	ccom_scroll (cpp_obj: POINTER; scroll_extant: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"](ecom_control_library::tagSIZE *)"
		end

	ccom_on_uideactivate (cpp_obj: POINTER; f_undoable: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_on_in_place_deactivate (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"]()"
		end

	ccom_discard_undo_state (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"]()"
		end

	ccom_deactivate_and_undo (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"]()"
		end

	ccom_on_pos_rect_change (cpp_obj: POINTER; lprc_pos_rect: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"](ecom_control_library::tagRECT *)"
		end

	ccom_on_in_place_activate_ex (cpp_obj: POINTER; pf_no_redraw: INTEGER_REF; dw_flags: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"](EIF_OBJECT,EIF_INTEGER)"
		end

	ccom_on_in_place_deactivate_ex (cpp_obj: POINTER; f_no_redraw: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_request_uiactivate (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"]()"
		end

	ccom_delete_iole_in_place_site_ex_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"]()"
		end

	ccom_create_iole_in_place_site_ex_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IOleInPlaceSiteEx_impl_proxy %"ecom_control_library_IOleInPlaceSiteEx_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IOLE_IN_PLACE_SITE_EX_IMPL_PROXY

