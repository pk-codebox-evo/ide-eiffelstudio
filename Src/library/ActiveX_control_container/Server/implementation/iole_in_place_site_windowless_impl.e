indexing
	description: "Implemented `IOleInPlaceSiteWindowless' Interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IOLE_IN_PLACE_SITE_WINDOWLESS_IMPL

inherit
	IOLE_IN_PLACE_SITE_WINDOWLESS_INTERFACE

	OLE_CONTROL_PROXY

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

	can_windowless_activate is
			-- No description available.
		do
			-- Put Implementation here.
		end

	get_capture is
			-- No description available.
		do
			-- Put Implementation here.
		end

	set_capture (f_capture: INTEGER) is
			-- No description available.
			-- `f_capture' [in].  
		do
			-- Put Implementation here.
		end

	get_focus is
			-- No description available.
		do
			-- Put Implementation here.
		end

	set_focus (f_focus: INTEGER) is
			-- No description available.
			-- `f_focus' [in].  
		do
			-- Put Implementation here.
		end

	get_dc (p_rect: TAG_RECT_RECORD; grf_flags: INTEGER; ph_dc: CELL [POINTER]) is
			-- No description available.
			-- `p_rect' [in].  
			-- `grf_flags' [in].  
			-- `ph_dc' [out].  
		do
			-- Put Implementation here.
		end

	release_dc (h_dc: POINTER) is
			-- No description available.
			-- `h_dc' [in].  
		do
			-- Put Implementation here.
		end

	invalidate_rect (p_rect: TAG_RECT_RECORD; f_erase: INTEGER) is
			-- Enables an object to invalidate a specified 
			-- rectangle of its in-place image on the screen.
			-- 
			-- `p_rect' [in]. Rectangle to invalidate, in client
			-- coordinates of the containing window. If this 
			-- parameter is Void, the object's full extent is
			-- invalidated. 
			-- `f_erase' [in]. Specifies whether the background 
			-- within the update region is to be erased when the 
			-- region is updated. If this parameter is TRUE, the
			-- background is erased. If this parameter is FALSE, 
			-- the background remains unchanged. 
		do
			-- Put Implementation here.
		end

	invalidate_rgn (h_rgn: POINTER; f_erase: INTEGER) is
			-- No description available.
			-- `h_rgn' [in].  
			-- `f_erase' [in].  
		do
			-- Put Implementation here.
		end

	scroll_rect (dx: INTEGER; dy: INTEGER; p_rect_scroll: TAG_RECT_RECORD; p_rect_clip: TAG_RECT_RECORD) is
			-- No description available.
			-- `dx' [in].  
			-- `dy' [in].  
			-- `p_rect_scroll' [in].  
			-- `p_rect_clip' [in].  
		do
			-- Put Implementation here.
		end

	adjust_rect (prc: TAG_RECT_RECORD) is
			-- No description available.
			-- `prc' [in, out].  
		do
			-- Put Implementation here.
		end

	on_def_window_message (msg: INTEGER; w_param: INTEGER; l_param: INTEGER; pl_result: INTEGER_REF) is
			-- No description available.
			-- `msg' [in].  
			-- `w_param' [in].  
			-- `l_param' [in].  
			-- `pl_result' [out].  
		do
			-- Put Implementation here.
		end


end -- IOLE_IN_PLACE_SITE_WINDOWLESS_IMPL

