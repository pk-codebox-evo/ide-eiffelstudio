indexing
	description: "Ancestor to all Windows controls (button, list box, etc.)."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_CONTROL

inherit
	WEL_WINDOW
		redefine
			set_default_window_procedure,
			call_default_window_procedure
		end

	WEL_WS_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make_by_id (a_parent: WEL_DIALOG; an_id: INTEGER) is
			-- Make a control identified by `an_id' with `a_parent'
			-- as parent.
		require
			a_parent_not_void: a_parent /= Void
			positive_id: an_id > 0
		do
			parent := a_parent
			id := an_id
			a_parent.dialog_children.extend (Current)
		ensure
			parent_set: parent = a_parent
			id_set: id = an_id
		end

feature -- Access

	id: INTEGER
			-- Control id

	font: WEL_FONT is
			-- Font with which the control is drawing its text.
		require
			exists: exists
		do
			if has_system_font then
				Result := (create {WEL_SHARED_FONTS}).system_font
			else
				create Result.make_by_pointer (
					cwin_send_message_result (item, Wm_getfont,
					default_pointer, default_pointer))
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_font (a_font: WEL_FONT) is
			-- Set `font' with `a_font'.
		require
			exists: exists
			a_font_not_void: a_font /= Void
			a_font_exists: a_font.exists
		do
			cwin_send_message (item, Wm_setfont,
				a_font.item, cwin_make_long (1, 0))
		ensure
			font_set: not has_system_font implies font.item = a_font.item
		end

feature -- Status report

	has_system_font: BOOLEAN is
			-- Does the control use the system font?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, Wm_getfont,
				default_pointer, default_pointer) = default_pointer
		end

feature -- Basic operations

	default_process_notification (notification_code: INTEGER) is
			-- Process a `notification_code' which has not been
			-- processed by `process_notification'.
		require
			exists: exists
		do
		end

	go_to_next_tab_item (a_parent: WEL_COMPOSITE_WINDOW; after: BOOLEAN) is
			-- Find the previous or following control with the
			-- Wm_tabstop style in `a_parent depending on the
			-- value of `after'.
		require
			valid_parent: a_parent /= Void and then a_parent.exists
		local
			hwnd: POINTER
			window: WEL_WINDOW
		do
			hwnd := cwin_get_next_dlgtabitem (a_parent.item, item, after)
			window := window_of_item (hwnd)
			window.set_focus
		end

	go_to_next_group_item (a_parent: WEL_COMPOSITE_WINDOW; after: BOOLEAN) is
			-- Find the previous or following control with the 
			-- Wm_tabstop style in the current group in `a_parent'
			-- depending on the value of `after'.
		require
			valid_parent: a_parent /= Void and then a_parent.exists
		local
			hwnd: POINTER
			window: WEL_WINDOW
		do
			hwnd := cwin_get_next_dlggroupitem (a_parent.item, item, after)
			window := window_of_item (hwnd)
			window.set_focus
		end

feature {WEL_COMPOSITE_WINDOW}

	process_notification (notification_code: INTEGER) is
			-- Process a `notification_code' sent by Windows
		require
			exists: exists
		do
			default_process_notification (notification_code)
		end

	process_notification_info (notification_info:WEL_NMHDR) is
			-- Process a `notification_info' sent by Windows
		require
			exists: exists
		do
		end 

feature {WEL_DIALOG} -- Implementation

	set_default_window_procedure is
			-- Set `default_window_procedure' with the
			-- previous window procedure and set the
			-- new one with `cwel_window_procedure_address'
		local
			p: POINTER
		do
				-- Keep the previous one
			default_window_procedure := cwin_get_window_long (item, Gwlp_wndproc)

				-- Set the new one
			cwin_set_window_long (item, Gwlp_wndproc, cwel_window_procedure_address)
				
			p := internal_data
			feature {WEL_INTERNAL_DATA}.set_default_window_procedure (p, default_window_procedure)
		end

	call_default_window_procedure (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER is
		do
			Result := cwin_call_window_proc (default_window_procedure,
				hwnd, msg, wparam, lparam)
		end

	destroy_from_dialog is
			-- Destroy item and removes it from WEL_WINDOW_MANAGER.
		do
			destroy_item
		end

feature {NONE} -- Externals

	cwin_call_window_proc (proc, hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER is
			-- SDK CallWindowProc
		external
			"C [macro <wel.h>] (WNDPROC, HWND, UINT, WPARAM, LPARAM): LRESULT"
		alias
			"CallWindowProc"
		end

	cwin_get_next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- SDK GetNextDlgGroupItem
		external
			"C [macro <wel.h>] (HWND, HWND, BOOL): HWND"
		alias
			"GetNextDlgGroupItem"
		end

	cwin_get_next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- SDK GetNextDlgGroupItem
		external
			"C [macro <wel.h>] (HWND, HWND, BOOL): HWND"
		alias
			"GetNextDlgTabItem"
		end

end -- class WEL_CONTROL

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

