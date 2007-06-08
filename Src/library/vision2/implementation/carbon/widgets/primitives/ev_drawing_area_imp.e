indexing
	description: "EiffelVision drawing area. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			interface,
			make,
			destroy,
			initialize
		end

	EV_PRIMITIVE_IMP
		undefine
			foreground_color,
			background_color,
			set_foreground_color,
			set_background_color,
			on_event
		redefine
			interface,
			default_key_processing_blocked,
			dispose,
			destroy,
			call_button_event_actions,
			initialize,
			set_tooltip,
			tooltip,
			on_pointer_enter_leave,
			on_key_event,
			set_focus
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES_IMP
		redefine
			interface
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		local
			ret: INTEGER
			struct_ptr: POINTER
		do
			base_make (an_interface)

			ret := hiimage_view_create_external (null, $struct_ptr)
			set_c_object (struct_ptr)
			ret := hiview_set_visible_external (struct_ptr, 1)
		end

	initialize is
			-- Initialize `Current'
		local
			ret: INTEGER
			target, h_ret: POINTER
		do

			Precursor {EV_PRIMITIVE_IMP}

			ret := hiview_set_drawing_enabled_external (c_object, 1)
			event_id := app_implementation.get_id (current)  --getting an id from the application
			target := get_control_event_target_external(c_object)
			--h_ret := app_implementation.install_event_handler (event_id, target, {carbonevents_anon_enums}.kEventClassControl, {carbonevents_anon_enums}.kEventMouseDown)
			expandable := false
			init_default_values
		end


feature -- Status setting

	enable_double_buffering is
			-- Allow `Current' to have all exposed area double buffered.
		do
		end

	disable_double_buffering is
			-- Disable double buffering for exposed areas.
		do
		end

feature {NONE} -- Implementation

	on_pointer_enter_leave (a_enter: BOOLEAN) is
			-- The mouse pointer has either just entered or left `Current'.
		do
		end

	update_tooltip (a_show_tooltip: BOOLEAN) is
			-- Set tooltip status to `a_show_tooltip'.
		do
		end

	reset_tooltip_position: BOOLEAN
		-- Should the tooltip window position be reset?

	update_tooltip_window is
			-- Update the tooltip window.
		do
		end

	tooltip_initial_x, tooltip_initial_y: INTEGER
		-- Initial x and y coordinates for the tooltip window.

	tooltip_window_y_offset: INTEGER is 20
		-- Amount of pixels tooltip window is offset down from the mouse pointer when shown.

	tooltip_repeater: EV_TIMEOUT
		-- Timeout repeater used for hiding/show tooltip.

	show_tooltips_if_activated: BOOLEAN
		-- Should tooltips be shown if activated?

	tooltips_pointer: POINTER
		-- Tooltips pointer for `Current'.

	set_tooltip (a_text: STRING_GENERAL) is
			-- Set `tooltip' to `a_text'.
		do
		end

	tooltip: STRING_32 is
			-- Tooltip for `Current'.
		do
		end

	internal_tooltip: STRING_32
		-- Used for storing `tooltip' of `Current'.

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN is
			-- Should default key processing be allowed for `a_key'.
		do
		end

	redraw is
			-- Redraw the entire area.
		do
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw the rectangle area defined by `a_x', `a_y', `a_width', a_height'.
		do
		end

	clear_and_redraw is
			-- Clear `Current' and redraw.
		do
		end

	clear_and_redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Clear the rectangle area defined by `a_x', `a_y', `a_width', `a_height' and then redraw it.
		do
		end

	flush is
			-- Redraw the screen immediately.
		do
		end

	update_if_needed is
			-- Update `Current' if needed.
		do
		end

feature {EV_DRAWABLE_IMP} -- Implementation

	drawable: POINTER is
			-- Pointer to the drawable object for `Current'.
		do
		end

	mask: POINTER is
			-- Mask of Current, which is always NULL.
		do
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	call_expose_actions (a_x, a_y, a_width, a_height: INTEGER) is
			-- Call the expose actions for the drawing area.
		do
		end

	lose_focus is
			-- Current has lost keyboard focus.
		do
		end

	set_focus is
			-- Grab keyboard focus.
		do
		end

feature {NONE} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN) is
			-- Used for key event actions sequences.
		do
		end

	call_button_event_actions (a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
		do
		end

	interface: EV_DRAWING_AREA
		-- Interface object of Current.

	destroy is
			-- Destroy implementation.
		do
		end

	dispose is
			-- Clean up
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DRAWING_AREA_IMP

