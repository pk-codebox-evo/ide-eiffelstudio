indexing
	description: "Objects that represent a title bar on SD_FLOATING_TOOL_BAR_ZONE.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_TITLE_BAR

inherit
	SD_TOOL_BAR_TITLE_BAR_IMP
		rename
			pointer_double_press_actions as pointer_double_press_actions_horizontal_box
		export
			{NONE} all
			{ANY} drawing_area
		end

feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_shared: SD_SHARED
			l_font: EV_FONT
		do
			create l_shared
			tool_bar.set_background_color (l_shared.tool_bar_title_bar_color)
			l_font := drawing_area.font
			l_font.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)
			drawing_area.set_font (l_font)

			drawing_area.expose_actions.extend (agent on_drawing_area_expose)

			init_pointer_double_press_actions

			close.select_actions.extend (agent on_close_selected)
			customize.select_actions.extend (agent on_custom_selected)
			create close_request_actions
			create custom_actions

			tool_bar.set_row_height (l_shared.floating_title_bar_height)
			tool_bar.compute_minimum_size

			customize.set_pixmap (l_shared.icons.tool_bar_floating_customize)
			customize.set_tooltip (l_shared.interface_names.tooltip_toolbar_tail_indicator)
			close.set_pixmap (l_shared.icons.tool_bar_floating_close)
			close.set_tooltip (l_shared.interface_names.tooltip_toolbar_floating_close)
			tool_bar.compute_minimum_size
		end

	init_pointer_double_press_actions is
			-- Initialize pointer double press actions.
		do
			create pointer_double_press_actions

			pointer_double_press_actions_horizontal_box.force_extend (agent on_pointer_double_press)
			drawing_area.pointer_double_press_actions.force_extend (agent on_pointer_double_press)
		end

feature -- Command

	set_content (a_content: SD_TOOL_BAR_CONTENT) is
			-- Set `content'.
		require
			not_void: a_content /= Void
		do
			content := a_content
		ensure
			set: content = a_content
		end

feature -- Query

	content: SD_TOOL_BAR_CONTENT
			-- Content which title is showing.

	pointer_double_press_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to performed when pointer double press on Current.

	close_request_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to performed when pointer press X at right top.

	custom_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to performed when pointer press down arrow ar right top.

	drag_rectangle: EV_RECTANGLE is
			-- Drag area rectangle
		do
			create Result.make (drawing_area.screen_x, drawing_area.screen_y, drawing_area.width, drawing_area.height)
		ensure
			not_void: Result /= Void
		end

	custom_rectangle: EV_RECTANGLE is
			-- `customize' button area rectangle.
		local
			l_rect: EV_RECTANGLE
		do
			l_rect := customize.rectangle
			create Result.make (tool_bar.screen_x + l_rect.x, tool_bar.screen_y + l_rect.y, l_rect.width, l_rect.height)
		end

feature {NONE} -- Implementation

	on_drawing_area_expose (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle `drawing_area' expose actions.
		local
			l_shared: SD_SHARED
		do
			create l_shared
			drawing_area.set_foreground_color (l_shared.tool_bar_title_bar_color)
			drawing_area.fill_rectangle (0, 0, drawing_area.width, drawing_area.height)

			drawing_area.set_foreground_color ((create {EV_STOCK_COLORS}).white)
			if content /= Void then
				drawing_area.draw_ellipsed_text_top_left (2, 1, content.title, drawing_area.width)
			end
		end

	on_pointer_double_press is
			-- Handle pointer double press actions.
		do
			pointer_double_press_actions.call (Void)
		end

	on_close_selected is
			-- Handle user press X button.
		do
			close_request_actions.call (Void)
		end

	on_custom_selected is
			-- Handle user press down arrow button.
		do
			custom_actions.call (Void)
		end

invariant

	not_void: pointer_double_press_actions /= Void
	not_void: close_request_actions /= Void
	not_void: custom_actions /= Void

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SD_TOOL_BAR_TITLE_BAR

