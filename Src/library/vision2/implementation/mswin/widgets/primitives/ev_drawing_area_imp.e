indexing
	description: "EiffelVision drawing area. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DRAWING_AREA_IMP

inherit
	EV_DRAWING_AREA_I
		redefine
			interface
		end

	EV_DRAWABLE_IMP
		redefine
			initialize, interface, destroy, get_dc, release_dc
		end

	EV_PRIMITIVE_IMP
		undefine
			set_background_color,
			set_foreground_color,
			background_color,
			foreground_color
		redefine
			interface, initialize, on_left_button_down, 
			on_middle_button_down, on_right_button_down,
			destroy,
			process_tab_key,
			tab_action,
			on_key_down
		end

	EV_WEL_CONTROL_WINDOW
		undefine
			on_sys_key_down,
			wel_set_font,
			wel_font
		redefine
			on_paint,
			on_erase_background,
			class_background,
			default_style,
			class_style
		end

	WEL_CS_CONSTANTS
		export
			{NONE} all
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' empty with interface `an_interface'.
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize `Current'.
			-- Set up action sequence connections
			-- and `Precursor' initialization.
		do
			wel_make (default_parent, "Drawing area")
			create screen_dc.make (Current)
			internal_paint_dc := screen_dc
			internal_paint_dc.get
			Precursor {EV_DRAWABLE_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			is_tabable_from := False
		end	

feature -- Access

	dc: WEL_DC is
			-- The device context of the control.
		do
			Result := internal_paint_dc
		end

	is_tabable_to: BOOLEAN is
			-- May `Current' be tabbed to?
		do
			Result := flag_set (style, ws_tabstop)
		end

	is_tabable_from: BOOLEAN
			-- May `Current' be tabbed from?

feature {NONE} -- Implementation

	in_paint: BOOLEAN
			-- Are we inside an onPaint event?

	release_dc is
			-- Release the dc if not already released
		do
			if not in_paint then
				if internal_paint_dc.exists then
					internal_paint_dc.release
				end

				internal_initialized_font := False
				internal_initialized_text_color := False
			end
		end

	get_dc is
			-- Get the dc if not already get.
		do
			if not in_paint then
				if not internal_paint_dc.exists then
					internal_paint_dc.get
					internal_paint_dc.set_background_transparent
					if internal_pen /= Void then
						internal_paint_dc.select_pen (internal_pen)
					else
						internal_paint_dc.select_pen (empty_pen)
					end
	
					if internal_brush /= Void then
						internal_paint_dc.select_brush (internal_brush)
					else
						internal_paint_dc.select_brush (empty_brush)
					end
					if valid_rop2_constant (wel_drawing_mode) then
						internal_paint_dc.set_rop2 (wel_drawing_mode)	
					end
				end
			end
		end

	to_be_cleared: BOOLEAN
			-- Should the area be cleared?

	class_background: WEL_BRUSH is
			-- Set the class background to NULL in order
			-- to have full control on the WM_ERASEBKG event
			-- (on_erase_background)
		once
			create Result.make_by_pointer (Default_pointer)
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Process Wm_erasebkgnd message.
		do
			if to_be_cleared then
				to_be_cleared := False
				paint_dc.fill_rect(invalid_rect, our_background_brush)
			end

				-- Disable the default windows processing.
			disable_default_processing

				-- return a correct value to Windows, i.e. nonzero value
				-- to tell windows no to erase the background.
			set_message_return_value (to_lresult (1))
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_paint message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
				-- Call registered onPaint actions
			if expose_actions_internal /= Void then
					-- Switch the dc from screen_dc to paint_dc.
				internal_paint_dc := paint_dc
				in_paint := True
				
					-- Initialise the device for painting.
				dc.set_background_transparent
				internal_initialized_pen := False
				internal_initialized_background_brush := False
				internal_initialized_brush := False
				internal_initialized_text_color := False

				expose_actions_internal.call ([
					invalid_rect.x,
					invalid_rect.y,
					invalid_rect.width,
					invalid_rect.height
					])

					-- Switch back the dc from paint_dc to screen_dc.
				internal_paint_dc := screen_dc
				in_paint := False
				
					-- Without disabling it looks like we will not be getting all
					-- the WM_PAINT messages we expected to receive (leaving some
					-- unrefresh part on the drawing area).
				disable_default_processing
			end
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is pressed.
			-- Redefined as the button press does not set the
			-- focus automatically.
		do
			set_focus
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is pressed.
			-- Redefined as the button press does not set the
			-- focus automatically.
		do
			set_focus
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is pressed.
			-- Redefined as the button press does not set the
			-- focus automatically.
		do
			set_focus
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	clear_and_redraw_rectangle (x1, y1, a_width, a_height: INTEGER) is
			-- Redraw the rectangle at (`x1',`y1') with width `a_width' and
			-- height `a_height'.
		do
				-- Set the rectangle to be cleared.
			to_be_cleared := True

				-- Ask windows to redraw the rectangle
				-- Windows will then call on_background_erase and
				-- then on_paint.
			wel_rect.set_rect (x1, y1, x1 + a_width, y1 + a_height)
			invalidate_rect (wel_rect, True)
		end

	clear_and_redraw is
			-- Redraw the application screen
		do
				-- Set the rectangle to be cleared.
			to_be_cleared := True

				-- Ask windows to redraw the rectangle
				-- Windows will then call on_background_erase and
				-- then on_paint.
			invalidate
		end

	redraw_rectangle (x1, y1, a_width, a_height: INTEGER) is
			-- Redraw the rectangle at (`x1',`y1') with width
			-- `a_width' and height and `a_height'.
		do
				-- Ask windows to redraw the rectangle
				-- Windows will then call on_paint.
			wel_rect.set_rect (x1, y1, x1 + a_width, y1 + a_height)
			invalidate_rect(wel_rect, False)
		end

	redraw is
			-- Redraw the application screen
		do
				-- Ask windows to redraw the entire window
				-- Windows will call on_erase_background (which
				-- will do nothing since to_be_cleared = False)
				-- and then on_paint.
			invalidate
		end

	flush is
			-- Update immediately the screen if needed.
		do
			update
		end

	default_style: INTEGER is
			-- Default style that memories the drawings.
		do
			Result := Ws_child + Ws_visible + Ws_clipchildren + Ws_clipsiblings
		end

	class_style: INTEGER is
   			-- Standard style used to create the window class.
   			-- Can be redefined to return a user-defined style.
   			-- (from WEL_FRAME_WINDOW).
   		once
			Result := 
				cs_hredraw + 
				cs_vredraw + 
				cs_dblclks + 
				Cs_owndc + 
				Cs_savebits
 		end
 
 	enable_tabable_to is	
 			-- Ensure `is_tabable_to' is `True'.
 		do
		 	set_style (style | ws_tabstop | ws_group)
		end

	disable_tabable_to is
			-- Ensure `is_tabable_to' is `False'.
		local
			l_style: INTEGER
		do
			l_style := style
			l_style := clear_flag (l_style, ws_tabstop)
			l_style := clear_flag (l_style, ws_group)
			set_style (l_style)
		end

	enable_tabable_from is	
 			-- Ensure `is_tabable_from' is `True'.
 		do
 			is_tabable_from := True
		end

	disable_tabable_from is
			-- Ensure `is_tabable_from' is `False'.
		do
			is_tabable_from := False
		end

feature -- Commands.

	destroy is
			-- Destroy `Current', but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			Precursor {EV_DRAWABLE_IMP}
			Precursor {EV_PRIMITIVE_IMP}
		end

	process_tab_key (virtual_key: INTEGER) is
			-- Process a tab or arrow key press to give the focus to the next
			-- widget. Need to be called in the feature on_key_down when the
			-- control needs to process this kind of keys.
		do
			fixme ("EV_DRAWING_AREA_IMP.process_tab_key - refactor all tab handling code in this class")
			if virtual_key = ({WEL_INPUT_CONSTANTS}.Vk_tab) and then 
				flag_set (style, {WEL_WINDOW_CONSTANTS}.Ws_tabstop)
			then
				tab_action (not key_down ({WEL_INPUT_CONSTANTS}.Vk_shift))
			end
		end

	tab_action (direction: BOOLEAN) is
			-- Go to the next widget that takes the focus through to the tab
			-- key. If `direction' it goes to the next widget otherwise,
			-- it goes to the previous one.
		local
			l_null, hwnd: POINTER
			window: WEL_WINDOW
			l_top: like top_level_window_imp
		do
			l_top := top_level_window_imp
			if l_top /= Void then
				hwnd := next_dlgtabitem (l_top.wel_item, wel_item, direction)
			end
			if hwnd /= l_null then
				window := window_of_item (hwnd)
				if window /= Void then
					window.set_focus
				end
			end
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Executed when a key is pressed.
		do
			if is_tabable_from then
				process_tab_key (virtual_key)
			end
			process_standard_key_press (virtual_key)
		end

feature {NONE} -- Implementation

	interface: EV_DRAWING_AREA

feature {EV_DRAWABLE_IMP} -- Internal datas.

	internal_paint_dc: WEL_DC
			-- dc we use when painting

	screen_dc: WEL_CLIENT_DC
			-- dc we use when painting outside a WM_PAINT message

end -- class EV_DRAWING_AREA_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

