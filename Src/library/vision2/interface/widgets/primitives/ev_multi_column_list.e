indexing
	description: 
		"Displays a list of multi item rows from which the user can select."
	note: "The list start at the index 1, the titles are not count among%
		%the rows. The columns start also at the index 1."	
	status: "See notice at end of class"
	keywords: "list, multi, column, row, table"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			create_action_sequences
		end

	EV_ITEM_LIST [EV_MULTI_COLUMN_LIST_ROW]
		undefine
			create_action_sequences
		redefine
			implementation
		end

create
	default_create,
	make_with_columns,
	make_for_test

feature {NONE} -- Initialization

	make_with_columns (n_columns: INTEGER) is
			-- Create with `n_columns'.
		do
			default_create
			set_columns (n_columns)
		ensure
			columns_assigned: columns = n_columns
		end

feature -- Access

	columns: INTEGER is
			-- Column count.
		do
			Result := implementation.columns
		ensure
			bridge_ok: Result = implementation.columns
		end

	selected_item: EV_MULTI_COLUMN_LIST_ROW is
			-- Currently selected item.
			-- Topmost selected item if multiple items are selected.
			-- (For multiple selections see `selected_items')
		do
			Result := implementation.selected_item
		ensure
			bridge_ok: Result = implementation.selected_item
		end

	selected_items: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- Currently selected items.
		do
			Result := implementation.selected_items
		ensure
			bridge_ok: Result = implementation.selected_items
		end

feature -- Status report

	multiple_selection_enabled: BOOLEAN is
			-- Can more that one item be selected?
		do
			Result := implementation.multiple_selection_enabled
		ensure
			bridge_ok: Result = implementation.multiple_selection_enabled
		end
	
	title_shown: BOOLEAN is
			-- Is a row displaying column titles shown?
		do
			Result := implementation.title_shown
		ensure
			bridge_ok: Result = implementation.title_shown
		end

	column_title (a_column: INTEGER): STRING is
			-- Title of `a_column'.
		require
			a_column_within_range: a_column >= 1 and a_column <= columns
		do
			Result := implementation.column_title (a_column)
		ensure
			bridge_ok: Result.is_equal (implementation.column_title (a_column))
		end
	
	column_width (a_column: INTEGER): INTEGER is
			-- Width of `a_column' in pixels.
		require
			a_column_within_range: a_column >= 1 and a_column <= columns
		do
			Result := implementation.column_width (a_column)
		ensure
			bridge_ok: Result = implementation.column_width (a_column)
		end

feature -- Status setting
	
	set_columns (n_columns: INTEGER) is
			-- Assign `n_columns' to `columns'.
		require
			empty: empty
			n_columns_positive: n_columns > 0
		do
			implementation.set_columns (n_columns)
		ensure
			columns_assigned: columns = n_columns					
		end

	select_item (an_index: INTEGER) is
			-- Select item at `an_index'.
		require
			an_index_within_range: an_index > 0 and an_index <= count
		do
			implementation.select_item (an_index)
		ensure
			item_selected: selected_items.has (i_th (an_index))
		end

	deselect_item (an_index: INTEGER) is
			-- Deselect item at `an_index'.
		require
			an_index_within_range: an_index > 0 and an_index <= count
		do
			implementation.deselect_item (an_index)
		ensure
			item_deselected: not selected_items.has (i_th (an_index))
		end

	clear_selection is
			-- Make `selected_items' empty.
		do
			implementation.clear_selection
		ensure
			selected_items_empty: selected_items.empty
		end

	enable_multiple_selection is
			-- Allow more than one item to be selected.
		do
			implementation.enable_multiple_selection	
		ensure
			multiple_selection_enabled: multiple_selection_enabled
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.

		do
			implementation.disable_multiple_selection
		ensure
			not_multiple_selection_enabled: not multiple_selection_enabled
		end

	show_title_row is
			-- Show row displaying column titles.
		do
			implementation.show_title_row
		ensure
			title_shown: title_shown
		end

	hide_title_row is
			-- Hide row displaying column titles.
		do
			implementation.hide_title_row
		ensure
			not_title_shown: not title_shown
		end

	align_text_left (a_column: INTEGER) is
			-- Display text of `a_column' left aligned.
			-- First column is always left aligned.
		require
			a_column_withing_range: a_column > 1 and a_column <= columns
		do
			implementation.set_column_alignment (0, a_column)
			--|FIXME 0 is a magic number!
		end

	align_text_center (a_column: INTEGER) is
			-- Display text of `a_column' centered.
			-- First column is always left aligned.
		require
			a_column_within_range: a_column > 1 and a_column <= columns
		do
			implementation.set_column_alignment (2, a_column)
			--|FIXME 2 is a magic number!
		end
	
	align_text_right (a_column: INTEGER) is
			-- Display text of `a_column' right aligned.
			-- First column is always left aligned.
		require
			a_column_within_range: a_column > 1 and a_column <= columns
		do
			implementation.set_column_alignment (1, a_column)
			--|FIXME 1 is a magic number!
		end

feature -- Element change

	set_column_title (a_title: STRING; a_column: INTEGER) is
			-- Assign `a_title' to the `column_title'(`a_column').
		require
			a_column_within_range: a_column > 0 and a_column <= columns
			a_title_not_void: a_title /= Void
		do
			implementation.set_column_title (a_title, a_column)
		ensure
			a_title_assigned: a_title.is_equal (column_title (a_column))
		end

	set_column_titles (titles: ARRAY [STRING]) is         
			-- Assign `titles' to titles of columns in order.
		require
			titles_not_void: titles /= Void
			titles_count_is_columns: titles.count = columns
		do
			implementation.set_columns_title (titles)
				--|FIXME feature name in _I needs to be updated.
		end
		--|FIXME This nees a postcondition!

	set_column_width (a_width: INTEGER; a_column: INTEGER) is
			-- Assign `a_width' `column_width'(`a_column').
		require
			a_column_within_range: a_column > 0 and a_column <= columns
			a_width_positive: a_width > 0
		do
			implementation.set_column_width (a_width, a_column)
		ensure
			a_width_assigned: a_width = column_width (a_column)
		end

	set_column_widths (widths: ARRAY [INTEGER]) is         
			-- Assign `widths' to column widths in order.
		require
			widths_not_void: widths /= Void
			widths_count_is_columns: widths.count = columns
		do
			implementation.set_columns_width (widths)
				--|FIXME feature name in _I needs to be updated.
		end
		--|FIXME This nees a postcondition!

	set_row_height (a_height: INTEGER) is
			-- Assign `a_height' to ??.
			--| FIXME to what???
		require
			height_valid: a_height > 0
		do
			implementation.set_rows_height (a_height)
		end
		--|FIXME This nees a postcondition!

feature -- Event handling

	select_actions: EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE
		-- Actions performed when a row is selected.

	deselect_actions: EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE
		-- Actions performed when a row is deselected.

	column_click_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions performed when a column is clicked.

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_MULTI_COLUMN_LIST_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MULTI_COLUMN_LIST_IMP} implementation.make (Current)
		end

	create_action_sequences is
			-- See `{EV_ANY}.create_action_sequences'.
		do
			{EV_PRIMITIVE} Precursor
			create select_actions
			create deselect_actions
			create column_click_actions
		end

feature -- Obsolete

	rows: INTEGER is
			-- Number of rows.
		obsolete
			"Use count instead."
		do
			Result := implementation.count
		end

	selected: BOOLEAN is
			-- Is at least one item selected ?
		obsolete
			"use selected_item = Void or selected_items.empty"
		do
			Result := implementation.selected
		end

end -- class EV_MULTI_COLUMN_LIST

--!-----------------------------------------------------------------------------
--! EiffelVision Library: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.41  2000/03/21 02:42:34  oconnor
--| naming problem fixed
--|
--| Revision 1.40  2000/03/21 02:13:32  oconnor
--| Added contracts to most features.
--| Added FIXMES where contracts were not imediately implementable.
--| Formatting, comments...
--| Fixed broken feature names:
--| set_columns_with -> set_column_withs etc
--|
--| Revision 1.39  2000/03/06 20:15:48  king
--| Changed action sequence types
--|
--| Revision 1.38  2000/03/06 18:05:14  rogers
--| Changed types, select actions and deselect actions from
--| EV_NOTIFY_ACTION_SEQUENCE -> EV_ITEM_SELECT_ACTION_SEQUENCE.
--|
--| Revision 1.37  2000/03/03 21:26:24  king
--| Added valid_width precond to set_column_width
--|
--| Revision 1.36  2000/03/03 18:22:59  king
--| Renamed get_column_width -> column_width, added column_title
--|
--| Revision 1.35  2000/03/03 17:05:29  rogers
--| Added set_columns and make_with_columns.
--|
--| Revision 1.34  2000/03/02 22:07:03  king
--| Made cvs log to be 80 cols or less
--|
--| Revision 1.33  2000/03/02 18:45:54  rogers
--| Minor comment change. Previous revision comment should have read :
--| renamed set_multiple_selection -> enable_multiple_selection,
--| set_single_selection -> disable_multiple_selection,
--| set_left_alignment -> align_text_left,
--| set_right_alignment to align_text_right,
--| set_cent_alignment -> align_text_right.
--|
--| Revision 1.31  2000/03/01 19:48:53  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.30  2000/03/01 03:28:43  oconnor
--| added make_for_test
--|
--| Revision 1.29  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.28  2000/02/19 01:21:00  king
--| Reinstated column_click_actions
--|
--| Revision 1.27  2000/02/18 23:54:11  oconnor
--| released
--|
--| Revision 1.26  2000/02/18 18:45:33  king
--| Added select, deselect and column_click actions sequences
--|
--| Revision 1.25  2000/02/17 21:54:19  king
--| Added row height precond to be > 0
--|
--| Revision 1.24  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.23.6.7  2000/02/03 17:15:36  brendel
--| Removed old event features.
--| Corrected error in create_implementation.
--|
--| Revision 1.23.6.6  2000/02/02 23:53:34  king
--| Removed redundant initialization routines
--|
--| Revision 1.23.6.5  2000/01/29 01:05:04  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.23.6.4  2000/01/27 19:30:55  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.23.6.3  1999/12/17 19:36:51  rogers
--| redefined implementation to be a a more refined type. Changed index
--| wherever it appeared as a parameter.
--|
--| Revision 1.23.6.2  1999/12/01 19:10:02  rogers
--| Changed inheritance structure from EV_ITEM_HOLDER to EV_ITEM_LIST
--|
--| Revision 1.23.6.1  1999/11/24 17:30:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.23.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.23.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
