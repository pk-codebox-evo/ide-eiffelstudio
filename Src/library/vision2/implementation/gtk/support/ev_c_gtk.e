indexing
	description: "External C calls to the custom gtk_eiffel library."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_C_GTK

feature -- Externals

	c_gtk_menu_popup (menu: POINTER; x, y: INTEGER) is
			-- Show `menu' on (`x', `y').
		external
			"C | %"ev_menu_imp.h%""
		end

	c_match_font_name (pattern: POINTER): STRING is
			-- Match to first in list or return NULL.
			-- `pattern' and `Result': char *
		external
			" C | %"gtk_eiffel.h%""
		end
		
--	c_gdk_colormap_query_color (a_colormap: POINTER; a_pixel: INTEGER; a_gdkcolor_result: POINTER) is
--			-- Retrieve `a_gdkcolor_result' values from `a_pixel' using `a_colormap'.
--		external
--			" C (GdkColormap *, gulong, GdkColor)| %"gtk_eiffel.h%""
--		end

	gdk_display: POINTER is
			-- Display * Result
		external
			" C [macro <gdk/gdkx.h>]"
		alias
			"GDK_DISPLAY()"
		end

	gdk_current_time: INTEGER is
		external
			"C [macro <gtk/gtk.h>]: EIF_INTEGER"
		alias
			"GDK_CURRENT_TIME"
		end

feature -- Externals (XTEST extension)

	x_test_fake_motion_event (
		a_display: POINTER;
		a_scr_num,
		a_x,
		a_y,
		a_delay: INTEGER
	): BOOLEAN is
		external
			"C: EIF_BOOL| <X11/extensions/XTest.h>"
		alias
			"XTestFakeMotionEvent"
		end

	x_test_fake_button_event (
		a_display: POINTER;
		a_button: INTEGER;
		a_is_press: BOOLEAN;
		a_delay: INTEGER
	): BOOLEAN is
		external
			"C: EIF_BOOL| <X11/extensions/XTest.h>"
		alias
			"XTestFakeButtonEvent"
		end

	x_test_fake_key_event (
		a_display: POINTER;
		a_keycode: INTEGER
		a_is_press: BOOLEAN
		a_delay: INTEGER
	): BOOLEAN is
		external
			"C: EIF_BOOL| <X11/extensions/XTest.h>"
		alias
			"XTestFakeKeyEvent"
		end

	x_keysym_to_keycode (a_display: POINTER; a_keycode: INTEGER): INTEGER is
		external
			"C: EIF_INTEGER| <X11/Xlib.h>"
		alias
			"XKeysymToKeycode"
		end

	x_test_query_extension (
			a_display,
			a_event_base,
			a_error_base,
			a_major_version,
			a_minor_version: POINTER): BOOLEAN is
		external
			"C: EIF_BOOL| <X11/extensions/XTest.h>"
		alias
			"XTestQueryExtension"
		end

feature -- Externals

	c_gdk_window_iconify (a_window: POINTER) is
		external
			"C (GdkWindow *) | %"ev_titled_window_imp.h%""
		end

	c_gdk_window_deiconify (a_window: POINTER) is
		external
			"C (GdkWindow *) | %"ev_titled_window_imp.h%""
		end

	c_gdk_window_is_iconified (a_window: POINTER): BOOLEAN is
		external
			"C (GdkWindow *): gboolean | %"ev_titled_window_imp.h%""
		end
		
feature -- Externals

	c_gtk_window_set_modal (a_window: POINTER; a_modal: BOOLEAN) is 
		external " C | %"gtk_eiffel.h%"" end

end -- class EV_C_GTK

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

