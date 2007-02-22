indexing
	description:
		"Objects that display class information in a widget."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FORMATTER

inherit
	SHARED_CONFIGURE_RESOURCES

	EB_RADIO_COMMAND_FEEDBACK

	EB_SHARED_WINDOW_MANAGER

	EB_CONSTANTS

	EV_STOCK_PIXMAPS

	EB_STONABLE

	EB_RECYCLABLE

feature -- Initialization

	make (a_manager: like manager) is
			-- Create a formatter associated with `a_manager'.
		do
			manager := a_manager
			capital_command_name := command_name.twin
			capital_command_name := interface_names.string_general_as_left_adjusted (capital_command_name)
				-- Set the first character to upper case.
			capital_command_name := interface_names.first_character_as_upper (capital_command_name)
			create post_execution_action
		ensure
			valid_capital_command_name: valid_string (capital_command_name)
		end

feature -- Properties

	manager: EB_STONABLE
			-- What sends and receives stones.

	output_line: EV_LABEL
			-- Where status information should be printed.

	widget: EV_WIDGET is
			-- Widget representing the associated system information.
		deferred
		end

	stone: STONE
			-- Stone representing Current

	viewpoints: CLASS_VIEWPOINTS
			-- Class view points

	post_execution_action: EV_NOTIFY_ACTION_SEQUENCE
			-- Called after execution

	empty_widget: EV_WIDGET is
			-- Widget displayed when no information can be displayed.
		do
			if internal_empty_widget = Void then
				new_empty_widget
			end
			Result := internal_empty_widget
		end

	element_name: STRING is
			-- name of associated element in current formatter.
			-- For exmaple, if a class stone is associated to current, `element_name' would be the class name.
			-- Void if element is not retrievable.
		deferred
		end

feature -- Status report

	is_dotnet_formatter: BOOLEAN is
			-- Is Current able to format .NET class texts?
		deferred
		end

feature -- Setting

	invalidate is
			-- Force `Current' to refresh itself next time `format' is called.
		do
			must_format := True
		end

	set_output_line (a_line: like output_line) is
			-- Set `output_line' to `a_line'.
		do
			output_line := a_line
		end

	set_accelerator (accel: EV_ACCELERATOR) is
			-- Set `accelerator' to `accel'.
		do
			accelerator := accel
		end

	set_manager (a_manager: like manager) is
			-- Change `Current's stone manager.
		require
			a_manager_not_void: a_manager /= Void
		do
			manager := a_manager
		end

	set_viewpoints (a_viewpoints: like viewpoints) is
			-- Viewpoints of current formatting
		do
			viewpoints := a_viewpoints
		ensure
			viewpoints_is_set: viewpoints = a_viewpoints
		end

	set_focus is
			-- Set focus to current formatter.
		deferred
		end

	reset_display is
			-- Clear all graphical output.
		deferred
		end

feature -- Formatting

	format is
			-- Refresh `widget' if `must_format' and `selected'.
		deferred
		end

	last_was_error: BOOLEAN
			-- Did an error occur during the last attempt to format?

feature -- Interface

	symbol: ARRAY [EV_PIXMAP] is
			-- Pixmaps for the default button (1 is color, 2 is grey, if any).
		deferred
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representation.
		deferred
		end

	new_menu_item: EV_RADIO_MENU_ITEM is
			-- Create a new menu item for `Current'.
		local
			mname: STRING_GENERAL
		do
			mname := menu_name.twin
			if accelerator /= Void then
				mname.append (Tabulation)
				mname.append (accelerator.out)
			end
			create Result.make_with_text (mname)
			set_menu_item (Result)
		end

	new_button: EV_TOOL_BAR_RADIO_BUTTON is
			-- Create a new tool bar button representing `Current'.
		local
			tt: STRING_GENERAL
		do
			create Result
			Result.set_pixmap (symbol @ 1)
			tt := capital_command_name.twin
			if accelerator /= Void then
				tt.append (Opening_parenthesis)
				tt.append (accelerator.out)
				tt.append (Closing_parenthesis)
			end
			Result.set_tooltip (tt)
			set_button (Result)
			Result.drop_actions.extend (agent on_stone_drop)
		end

	new_sd_button: SD_TOOL_BAR_RADIO_BUTTON is
			-- Create a new tool bar button representing `Current'
		local
			tt: STRING_GENERAL
		do
			create Result.make
			Result.set_pixmap (symbol @ 1)
			Result.set_pixel_buffer (pixel_buffer)
			tt := capital_command_name.twin
			if accelerator /= Void then
				tt.append (Opening_parenthesis)
				tt.append (accelerator.out)
				tt.append (Closing_parenthesis)
			end
			Result.set_tooltip (tt)
			Result.set_name (capital_command_name)
			Result.set_description (capital_command_name)
			set_sd_button (Result)
		end

feature -- Pop up

	popup is
			-- Make `widget' visible.
		do
			if widget_owner /= Void then
				if widget_owner.last_widget /= widget then
					widget_owner.set_widget (widget)
				end
				widget_owner.force_display
			end
			display_header
			if not popup_actions.is_empty then
				popup_actions.call (Void)
			end
		end

	widget_owner: WIDGET_OWNER
			-- Container of `widget'.

	set_widget_owner (new_owner: WIDGET_OWNER) is
			-- Set `widget_owner' to `new_owner'.
		do
			widget_owner := new_owner
		end

feature -- Actions

	on_shown is
			-- `Widget's parent is displayed.
		do
			internal_displayed := True
			if
				widget_owner /= Void and then
				selected
			then
				widget_owner.set_widget (widget)
				display_header
			end
			format
		end

	on_hidden is
			-- `Widget's parent is hidden.
		do
			internal_displayed := False
		end

	on_stone_drop (a_stone: STONE) is
			-- Notify `manager' of the dropping of `stone'.
		do
			if not selected then
				execute
			end
			manager.set_stone (a_stone)
		end

feature -- Commands

	execute is
			-- Execute as a command.
		do
			enable_select
			popup
			fresh_old_formatter
			format
			post_execution_action.call (Void)
		end

	save_in_file is
			-- Save output format into a file.
		do
--|FIXME XR: To be implemented.		
		end

	display_header is
			-- Show header for current formatter.
		do
			if output_line /= Void then
				output_line.set_text (header)
				output_line.refresh_now
			end
			if cur_wid = Void then
				--| Do nothing.
			else
				if old_cur /= Void then
					cur_wid.set_pointer_style (old_cur)
				end
				cur_wid := Void
			end
		end

feature -- Stonable

	refresh is
			-- Do nothing.
		do
		end

	force_stone (a_stone: STONE) is
			-- Directly set `stone' with `a_stone'
		do
			stone := a_stone
			manager.set_pos_container (Current)
			if stone /= Void and selected then
				stone.set_pos_container (Current)
			end
		end

feature -- Loacation

	fresh_position is
			-- Fresh stone position
		do
			if manager.stone /= Void then
				stone := manager.stone.twin
			end
			if stone /= Void then
				check
					manager.position >= 0
				end
				stone.set_pos_container (Current)
				stone.set_position (manager.position)
			end
		end

feature -- Agents

	popup_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performed when current format `popup's.
		do
			if popup_actions_internal = Void then
				create popup_actions_internal
			end
			Result := popup_actions_internal
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Location

	fresh_old_formatter is
			-- Fresh old formatter position
		local
			l_formatter: EB_FORMATTER
		do
			l_formatter ?= manager.previous_pos_container
			if l_formatter /= Void then
				l_formatter.fresh_position
			end
		end

	save_manager_position is
			-- Save container and position in manager
		do
			if stone /= Void then
				manager.set_previous_position (stone.position)
			else
				manager.set_previous_position (manager.position)
			end
			manager.set_previous_pos_container (Current)
		end

	setup_viewpoint is
			-- Setup viewpoint for formatting.
		deferred
		end

feature {NONE} -- Recyclable

	internal_recycle is
			-- Recycle
		do
			manager := Void
		end

feature {NONE} -- Implementation

	old_cur: EV_POINTER_STYLE
			-- Cursor saved while displaying the hourglass cursor.

	cur_wid: EV_WIDGET
			-- Widget on which the hourglass cursor was set.

	displayed: BOOLEAN is
			-- Is `widget' displayed?
		do
			Result := selected and then internal_displayed
		end

	internal_displayed: BOOLEAN
			-- Is `widget's parent visible?

	internal_widget: EV_WIDGET
			-- Widget corresponding to `editor's text area.

	must_format: BOOLEAN
			-- Is a call to `format' really necessary?
			-- (i.e. has the stone changed since last call?)

	display_info (str: STRING) is
			-- Print `str' in `output_line'.
		do
			output_line.set_text (str)
		end

	display_temp_header is
			-- Display a temporary header during the format processing.
			-- Display a hourglass-shaped cursor.
		do
			if window_manager.last_focused_development_window /= Void then
					-- Check is needed for session handling.
				cur_wid := Window_manager.last_focused_development_window.window
			end
			if cur_wid = Void then
				--| Do nothing.
			else
				old_cur := cur_wid.pointer_style
				cur_wid.set_pointer_style (Wait_cursor)
			end

			if output_line /= Void then
				output_line.set_text (temp_header)
				output_line.refresh_now
			end
		end

	header: STRING_GENERAL is
			-- Text displayed in the ouput_line when current formatter is displayed.
		deferred
		end

	temp_header: STRING_GENERAL is
			-- Text displayed in the ouput_line when current formatter is working.
		deferred
		end

	file_name: FILE_NAME is
			-- Name of the file in which displayed information may be stored
		require
			element_name_attached: element_name /= Void
		do
			create Result.make_from_string (element_name)
			Result.add_extension (post_fix)
		ensure
			result_attached: Result /= Void
		end

	post_fix: STRING is
			-- Postfix name of current format.
			-- Used as an extension while saving.
		deferred
		ensure
			Result_not_void: Result /= Void
			valid_extension: Result.count <= 3
		end

	Tabulation: STRING is "%T"
	Opening_parenthesis: STRING is " ("
	Closing_parenthesis: STRING is ")"

	has_breakpoints: BOOLEAN is deferred end
		-- Should `Current' display breakpoints?

	line_numbers_allowed: BOOLEAN is deferred end
		-- Does it make sense to show line numbers in Current?

	popup_actions_internal: like popup_actions
			-- Implementation of `popup_actions'

	internal_empty_widget: EV_WIDGET
			-- Widget displayed when no information can be displayed.	

	new_empty_widget is
			-- Initialize a default empty_widget.
		local
			l_frame: EV_FRAME
		do
			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			l_frame.set_background_color ((create {EV_STOCK_COLORS}).white)
			internal_empty_widget := l_frame
			if widget_owner /= Void then
				internal_empty_widget.drop_actions.extend (agent widget_owner.drop_stone)
			else
				internal_empty_widget.drop_actions.extend (agent on_stone_drop)
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_FORMATTER
