-- List manager

indexing

	date: "$Date$";
	revision: "$Revision$"

class LIST_MAN 

feature -- Callback (adding and removing)

	add_selection_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when items are
			-- selected. 
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		do
			implementation.add_single_action (a_command, argument)
		end; 

	remove_selection_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' with `argument' to the list of action to execute 
			-- when items are selected.
		require
			Valid_command: a_command /= Void
		do
			implementation.remove_single_action (a_command, argument)
		end; -- remove_single_action

feature -- Access

	item: STRING is
			-- Item at cursor position
		require
			not_off: not off
		do
			Result := implementation.item
		end;

	last: STRING is
			-- Item at last position
		require
			not_empty: not empty
		do
			Result := implementation.last
		end; 

	search_equal (v: STRING) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where item is equal to `v' (shallow equality);
			-- go off right if none.
		require
			search_element_exists: not (v = Void)
		do
			implementation.search_equal (v)
		ensure
			(not off) implies (v.is_equal (item))
		end; 
	
feature -- Cursor

	back is
			-- Move cursor backward one position.
		do
			implementation.back
		ensure
			index = old index - 1
		end; -- back

	empty: BOOLEAN is
			-- Is current series empty?
		do
			Result := implementation.empty
		end; -- empty

	finish is
			-- Move cursor to last position
			-- (no effect if series is empty).
		do
			implementation.finish
		ensure
			empty or islast
		end; -- finish

	first: STRING is
			-- Item at first position
		require
			not_empty: not empty
		do
			Result := implementation.first
		end; -- first

	forth is
			-- Move cursor forward one position.
		require
			not empty and then index <= count
		do
			implementation.forth
		ensure
			index >= 1 and index <= count + 1
		end; -- forth

	go_i_th (i: INTEGER) is
			-- Move cursor to position `i'.
		require
			index_large_enough: i >= 0;
			index_small_enough: i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		do
			implementation.go_i_th (i)
		ensure
			index = i
		end; -- go

	has (v: STRING): BOOLEAN is
			-- Does `v' appear in current series?
		do
			Result := implementation.has (v)
		end; -- has

	i_th (i: INTEGER): STRING is
			-- Item at `i'_th position
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count;
		do
			Result := implementation.i_th (i)
		end; -- i_th

	index_of (v: STRING; i: INTEGER): INTEGER is
			-- Index of `i'-th item `v'; 0 if none
		require
			positive_occurrence: i > 0
		do
			Result := implementation.index_of (v, i)
		ensure
			Result >= 0
		end; 

	isfirst: BOOLEAN is
			-- Is cursor at first position in current series?
		do
			Result := implementation.isfirst
		ensure
			Result implies (not empty)
		end;

	islast: BOOLEAN is
			-- Is cursor at last position in current series?
		do
			Result := implementation.islast
		ensure
			Result implies (not empty)
		end;

	start is
			-- Move cursor to first position.
		do
			implementation.start
		ensure
			empty or isfirst
		end; -- start

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		require
			stay_right: index + i >= 0;
			stay_left: index + i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		do
			implementation.move (i)
		ensure
			index = old index + i
		end;

	off: BOOLEAN is
			-- Is cursor off?
		do
			Result := implementation.off
		end; 

	before: BOOLEAN is
			-- Is cursor off left edge?
		do
			Result := implementation.before
		end;

	after: BOOLEAN is
			-- Is cursor off right edge?
		do
			Result := implementation.after
		end; 

	index: INTEGER is
			-- Current cursor index 
		do
			Result := implementation.index
		end;

feature -- Deletion

	remove is
			-- Remove current item. 
			-- Move cursor to its right neighbor
			-- (or after if no right neighbor).
		do
			implementation.remove
		ensure
			count = old count-1;
			not empty implies index = old index
		end;

	remove_all_occurrences (an_item: STRING) is
			-- Remove all items identical to `v'.
			-- Leave cursor `off'. 
		do
			implementation.remove_all_occurrences (an_item)
		ensure
			is_off: off
		end;

	remove_left (n: INTEGER) is
			-- Remove min (`n', position - 1) items
			-- to the left of cursor position.
			-- Do not move cursor
			-- (but its position will be decreased by up to n).
		require
			not_before: not before;
			non_negative_argument: n >= 0
		do
			implementation.remove_left (n)
		end;

	remove_right (n: INTEGER) is
			-- Remove min (`n', count - position) items
			-- to the right of cursor position.
			-- Do not move cursor.
		require
			not_after: not after;
			non_negative_argument: n >= 0
		do
			implementation.remove_right (n)
		end;

	wipe_out is
			-- Make list empty
		do
			implementation.wipe_out
		end 

feature -- Insertion

	put_left (an_item: STRING) is
			-- Put `an_item' to the left of cursor index.
			-- Do not move cursor.
			-- Synonym for `put_left'.
		do
			implementation.add_left (an_item)
		ensure
			count = old count+1;
			(not (index = 2)) implies (index = old index+1)
		end; 

	put_right (an_item: STRING) is
			-- Put item `v' to the right of cursor position.
			-- Do not move cursor.
			-- Synonym for `put_right'.
		do
			implementation.add_right (an_item)
		ensure
			count = old count+1;
			index = old index
		end; 

	merge_left (other: LIST [STRING]) is
			-- Merge `other' into the current list before
			-- cursor position.
			-- Do not move cursor.
			-- Empty other.
		require
			other_exists: not (other = Void)
		do
			implementation.merge_left (other)
		ensure
			count = old count+old other.count;
			other.empty
		end;

	merge_right (other: LIST [STRING]) is
			-- Merge `other' into the current list after
			-- cursor position.
			-- Do not move cursor.
			-- Empties other.
		require
			--not_off: not off;
			other_exists: not (other = Void)
		do
			implementation.merge_right (other)
		ensure
			other.empty
		end;

	put (an_item: STRING) is
			-- Put `an_item' at cursor position.
		require
			not_off: not off;
		do
			implementation.put (an_item)
		end;

	put_i_th (an_item: STRING; i: INTEGER) is
			-- Put `an_item' at `i'-th position.
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		do
			implementation.put_i_th (an_item, i)
		ensure
			not empty
		end; 

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		require
			cursor_not_off: not off;
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		do
			implementation.swap (i)
		end;

feature -- Duplication

	duplicate (n: INTEGER): LINKED_LIST [STRING] is
			-- Copy of the sub-list beginning at cursor position
			-- and comprising min (`n', count-position+1) items
		require
			not_off: not off;
			valid_sublist: n >= 0
		do
			Result := implementation.duplicate (n)
		end;

feature -- Number of elements

	count: INTEGER is
			-- Number of items in current series
		do
			Result := implementation.count
		end;  

feature -- Selection

	deselect_item is
			-- Deselect current selected items.
		do
			implementation.deselect_all
		ensure
			selected_list_is_empty: selected_count = 0
		end;

	first_visible_item_position: INTEGER is
			-- Position of the first visible item in the list
		do
			Result := implementation.first_visible_item_position
		ensure
			Result <= count;
			empty = (Result = 0)
		end;

	scroll_to_current is
			-- Make `item' the first visible item in the list if
			-- `position' < `first_visible_item_position'.
			-- Make `item' the last visible item in the list if
			-- `position' >= `first_visible_item_position'+`visible_item_count'.
			-- Do nothing if `item' is visible.
		require
			not_off: not off
		do
			implementation.scroll_to_current
		end; 

	select_item is
			-- Select item at current position.
		require
			not_off: not off
		do
			implementation.select_item
		end;

	select_i_th (i: INTEGER) is
			-- Select item at `i'-th position.
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		do
			implementation.select_i_th (i)
		end; 

	selected_count: INTEGER is
			-- Number of selected items in current list
		do
			Result := implementation.selected_count
		end;

	selected_item: STRING is
			-- Selected item if single or browse selection mode is selected
			-- Void if nothing is selected
		do
			Result := implementation.selected_item
		end; 

	selected_position: INTEGER is
			-- Position of selected item if single or browse selection mode is
			-- selected
			-- Null if nothing is selected
		do
			Result := implementation.selected_position
		end;

feature -- Visibilty

	set_visible_item_count (a_count: INTEGER) is
			-- Set the number of visible items to `a_count'.
		require
			a_count_large_enough: a_count >0
		do
			implementation.set_visible_item_count (a_count)
		end; 

	show_current is
			-- Make item at current position visible.
		require
			not_off: not off
		do
			implementation.show_current
		end;

	show_first is
			-- Make first item visible.
		do
			implementation.show_first
		end;

	show_i_th (i: INTEGER) is
			-- Make item at `i'-th position visible.
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count
		do
			implementation.show_i_th (i)
		end; 

	show_last is
			-- Make last item visible.
		do
			implementation.show_last
		end; 

	visible_item_count: INTEGER is
			-- Number of visible item of list
		do
			Result := implementation.visible_item_count
		ensure
			count_large_enough: Result >0
		end;

feature {LIST_MAN_I}

	set_list_imp (a_list_imp: LIST_MAN_I) is
			-- Set list implementation to `a_list_imp'.
		do
			implementation := a_list_imp
		end; 

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: LIST_MAN_I;
			-- Implementation of list

feature -- Obsolete

	add_single_action (a_command: COMMAND; argument: ANY) is
		do
			add_selection_action (a_command, argument)
		end;
	set_single_selection is do end;

	add_right (an_item: STRING) is
		Obsolete "Use `put_right'"
		do
			put_right (an_item)
		end;

	add_left (an_item: STRING) is
		Obsolete "Use `put_left'"
		do
			put_left (an_item)
		end;
end


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
