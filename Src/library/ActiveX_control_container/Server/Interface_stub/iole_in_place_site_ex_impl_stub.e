indexing
	description: "Implemented `IOleInPlaceSiteEx' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IOLE_IN_PLACE_SITE_EX_IMPL_STUB

inherit
	IOLE_IN_PLACE_SITE_EX_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	get_window (phwnd: CELL [POINTER]) is
			-- No description available.
			-- `phwnd' [out].  
		do
			-- Put Implementation here.
		end

	context_sensitive_help (f_enter_mode: INTEGER) is
			-- No description available.
			-- `f_enter_mode' [in].  
		do
			-- Put Implementation here.
		end

	can_in_place_activate is
			-- No description available.
		do
			-- Put Implementation here.
		end

	on_in_place_activate is
			-- No description available.
		do
			-- Put Implementation here.
		end

	on_uiactivate is
			-- No description available.
		do
			-- Put Implementation here.
		end

	get_window_context (pp_frame: CELL [IOLE_IN_PLACE_FRAME_INTERFACE]; pp_doc: CELL [IOLE_IN_PLACE_UIWINDOW_INTERFACE]; lprc_pos_rect: TAG_RECT_RECORD; lprc_clip_rect: TAG_RECT_RECORD; lp_frame_info: TAG_OIFI_RECORD) is
			-- No description available.
			-- `pp_frame' [out].  
			-- `pp_doc' [out].  
			-- `lprc_pos_rect' [out].  
			-- `lprc_clip_rect' [out].  
			-- `lp_frame_info' [in, out].  
		do
			-- Put Implementation here.
		end

	scroll (scroll_extant: TAG_SIZE_RECORD) is
			-- No description available.
			-- `scroll_extant' [in].  
		do
			-- Put Implementation here.
		end

	on_uideactivate (f_undoable: INTEGER) is
			-- No description available.
			-- `f_undoable' [in].  
		do
			-- Put Implementation here.
		end

	on_in_place_deactivate is
			-- No description available.
		do
			-- Put Implementation here.
		end

	discard_undo_state is
			-- No description available.
		do
			-- Put Implementation here.
		end

	deactivate_and_undo is
			-- No description available.
		do
			-- Put Implementation here.
		end

	on_pos_rect_change (lprc_pos_rect: TAG_RECT_RECORD) is
			-- No description available.
			-- `lprc_pos_rect' [in].  
		do
			-- Put Implementation here.
		end

	on_in_place_activate_ex (pf_no_redraw: INTEGER_REF; dw_flags: INTEGER) is
			-- No description available.
			-- `pf_no_redraw' [out].  
			-- `dw_flags' [in].  
		do
			-- Put Implementation here.
		end

	on_in_place_deactivate_ex (f_no_redraw: INTEGER) is
			-- No description available.
			-- `f_no_redraw' [in].  
		do
			-- Put Implementation here.
		end

	request_uiactivate is
			-- No description available.
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IOLE_IN_PLACE_SITE_EX_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IOleInPlaceSiteEx_impl_stub %"ecom_control_library_IOleInPlaceSiteEx_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IOLE_IN_PLACE_SITE_EX_IMPL_STUB

