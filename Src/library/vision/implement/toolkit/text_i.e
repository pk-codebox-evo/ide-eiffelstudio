indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class TEXT_I 

inherit

	TEXT_FIELD_I

feature 

	add_modify_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute before
			-- text is deleted from or inserted in current text widget.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_modify_action

	add_motion_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute before insert
			-- cursor is moved to a new position.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_motion_action

	allow_action is
			-- Allow the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		deferred
		end; -- allow_action

	begin_of_selection: INTEGER is
			-- Position of the beginning of the current selection highlightened
		require
			selection_active: is_selection_active;
			realized: realized
		deferred
		ensure
			Result >= 0;
			Result < count
		end; -- begin_of_selection

	clear_selection is
			-- Clear a selection
		require
			selection_active: is_selection_active;
			realized: realized
		deferred
		ensure
			not is_selection_active
		end; -- clear_selection

	cursor_position: INTEGER is
			-- Current position of the text cursor (it indicates the position
			-- where the next character pressed by the user will be inserted)
		deferred
		ensure
			Result >= 0;
			Result <= count
		end; -- cursor_position

	disable_resize is
			-- Disable that current text widget attempts to resize its width and
			-- height to accommodate all the text contained.
		deferred
		end; -- disable_resize

	disable_resize_height is
			-- Disable that current text widget attempts to resize its height
			-- to accommodate all the text contained.
		deferred
		end; -- disable_resize_height

	disable_resize_width is
			-- Disable that current text widget attempts to resize its width
			-- to accommodate all the text contained.
		deferred
		end; -- disable_resize_width

	disable_verify_bell is
			-- Disable the bell when an action is forbidden
		deferred
		end

	enable_resize is
			-- Enable that current text widget attempts to resize its width and
			-- height to accommodate all the text contained.
		deferred
		end; -- enable_resize

	enable_resize_height is
			-- Enable that current text widget attempts to resize its height to
			-- accomodate all the text contained.
		deferred
		end; -- enable_resize_height

	enable_resize_width is
			-- Enable that current text widget attempts to resize its width to
			-- accommodate all the text contained.
		deferred
		end; -- enable_resize_width

	enable_verify_bell is
			-- Enable the bell when an action is forbidden
		deferred
		end;

	end_of_selection: INTEGER is
			-- Position of the end of the current selection highlightened
		require
			selection_active: is_selection_active;
			realized: realized
		deferred
		ensure
			Result > 0;
			Result <= count
		end; -- end_of_selection

	forbid_action is
			-- Forbid the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		deferred
		end; -- forbid_action

	is_any_resizable: BOOLEAN is
			-- Is width and height of current text resizable?
		deferred
		ensure
			Result implies is_width_resizable and is_height_resizable
		end; -- is_any_resizable

	is_bell_enabled: BOOLEAN is
			-- Is the bell enabled when an action is forbidden
		deferred
		end;

	is_height_resizable: BOOLEAN is
			-- Is height of current text resizable?
		deferred
		end; -- is_height_resizable

	is_read_only: BOOLEAN is
			-- Is current text in read only mode?
		deferred
		end; -- is_read_only

	is_selection_active: BOOLEAN is
			-- Is there a selection currently active ?
		require
			realized: realized
		deferred
		end; -- is_selection_active

	is_width_resizable: BOOLEAN is
			-- Is width of current text resizable?
		deferred
		end; -- is_width_resizable

	is_word_wrap_mode: BOOLEAN is
			-- Is specified that lines are to be broken at word breaks?
		deferred
		end; -- is_word_wrap_mode

	margin_height: INTEGER is
			-- Distance between top edge of text window and current text,
			-- and between bottom edge of text window and current text.
		deferred
		end; -- margin_height

	margin_width: INTEGER is
			-- Distance between left edge of text window and current text,
			-- and between right edge of text window and current text.
		deferred
		end; -- margin_width

	remove_modify_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute before
			-- text is deleted from or inserted in current text widget.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_modify_action

	remove_motion_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute before
			-- insert cursor is moved to a new position.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_motion_action

	set_cursor_position (a_position: INTEGER) is
			-- Set `cursor_position' to `a_position'.
		require
			a_position_positive_not_null: a_position >= 0;
			a_position_fewer_than_count: a_position <= count
		deferred
		ensure
			cursor_position = a_position
		end; -- set_cursor_position

	set_editable is
			-- Set current text to be editable.
		deferred
		end; -- set_editable

	set_margin_height (new_height: INTEGER) is
			-- Set `margin_height' to `new_height'.
		require
			new_height_large_enough: new_height >= 0
		deferred
		end; -- set_margin_height

	set_margin_width (new_width: INTEGER) is
			-- Set `margin_width' to `new_width'.
		require
			new_width_large_enough: new_width >= 0
		deferred
		end; -- set_margin_width

	set_read_only is
			-- Set current text to be read only.
		deferred
		end; -- set_read_only

	set_selection (first, last: INTEGER) is
			-- Select the text between `first' and `last'.
			-- This text will be physically highlightened on the screen.
		require
			first_positive_not_null: first >= 0;
			last_fewer_than_count: last <= count;
			first_fewer_than_last: first < last;
			realized: realized
		deferred
		ensure
			is_selection_active;
			begin_of_selection = first;
			end_of_selection = last
		end -- set_selection

	x_coordinate (char_pos: INTEGER): INTEGER is
			-- X coordinate relative to the upper left corner
			-- of Current text widget at character position `char_pos'.
		deferred
		end;

	y_coordinate (char_pos: INTEGER): INTEGER is
			-- Y coordinate relative to the upper left corner
			-- of Current text widget at character position `char_pos'.
		deferred
		end;

	character_position (x_pos, y_pos: INTEGER): INTEGER is
			-- Character position at cursor position `x' and `y'
		deferred
		end;

	top_character_position: INTEGER is
			-- Character position of first character displayed
		deferred
		end;

	set_top_character_position (char_pos: INTEGER) is
			-- Set first character displayed to `char_pos'.
		deferred
		end;

feature

	rows: INTEGER is
			-- Height of Current widget measured in character
			-- heights.
		require
			is_multi_line_mode: is_multi_line_mode
		deferred
		end;
 
	set_rows (i: INTEGER) is
			-- Set the character height of Current widget to `i'.
		require
			is_multi_line_mode: is_multi_line_mode;
			valid_i: i > 0
		deferred
		end;
 
	set_single_line_mode is
			-- Set editing for single line text.
		deferred
		end;
 
	set_multi_line_mode is
			-- Set editing for multiline text.
		deferred
		end;
 
	is_multi_line_mode: BOOLEAN is
			-- Is Current editing a multiline text?
		deferred
		end;
 
	is_cursor_position_visible: BOOLEAN is
			-- Is the insert cursor position marked
			-- by a blinking text cursor?
		deferred
		end;

	set_cursor_position_visible (flag: BOOLEAN) is
			-- Set is_cursor_position_visible to flag.
		deferred
		end;

end -- class TEXT_I



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
