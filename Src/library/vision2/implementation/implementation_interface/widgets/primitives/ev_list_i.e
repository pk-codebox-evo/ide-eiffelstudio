--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Eiffel Vision list. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_LIST_I
	
inherit
	EV_LIST_ITEM_LIST_I
		redefine
			interface
		end

feature -- Access

	selected_items: ARRAYED_LIST [EV_LIST_ITEM] is
			-- Currently selected items.
		local
			original_position: INTEGER
		do
			original_position := interface.index
			create Result.make(2)
			from
				interface.start
			until
				interface.off
			loop
				if interface.item.is_selected then
					Result.extend (interface.item)
				end
				interface.forth
			end
			interface.go_i_th (original_position)
		end

feature -- Status report

	multiple_selection_enabled: BOOLEAN is
			-- Can more than one item be selected?
		deferred
		end

feature -- Status setting

	enable_multiple_selection is
			-- Allow multiple items to be selected.
		deferred
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		deferred
		end

feature {EV_LIST_I, EV_LIST_ITEM_IMP} -- Implementation

	interface: EV_LIST

end -- class EV_LIST_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
--| Revision 1.46  2000/06/07 17:27:50  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.34.4.3  2000/05/30 15:57:09  rogers
--| Removed unreferenced variables from selected_items.
--|
--| Revision 1.34.4.2  2000/05/10 18:50:37  king
--| Integrated ev_list_item_list
--|
--| Revision 1.34.4.1  2000/05/03 19:09:07  oconnor
--| mergred from HEAD
--|
--| Revision 1.45  2000/04/20 00:58:52  pichery
--| Removed `ev_children' from EV_LIST_I.
--| Now only defined on Windows in
--| EV_LIST_ITEM_LIST_IMP
--|
--| Revision 1.44  2000/04/19 01:26:18  pichery
--| Changed `selected_items' from LINKED_LIST to
--| ARRAYED_LIST
--|
--| Revision 1.43  2000/03/28 20:32:08  brendel
--| Revised.
--|
--| Revision 1.42  2000/03/01 18:09:08  king
--| Added lists_equal assertion feature
--|
--| Revision 1.41  2000/02/29 23:15:03  rogers
--| Simplified selected_items. Selected item is no longer deferred, but now implemented in this class.
--|
--| Revision 1.40  2000/02/29 19:39:24  rogers
--| Selected items now checks selected rather than selected_item /= Void before appending the selected item to the Result. Only when multiple selection is disabled.
--|
--| Revision 1.39  2000/02/29 19:04:16  rogers
--| Removed some redundent code in selected_items.
--|
--| Revision 1.38  2000/02/29 18:26:05  rogers
--| Removed the deferred status of selected_items and implemented it platform independently.
--|
--| Revision 1.37  2000/02/29 00:02:22  king
--| Made selected items deferred
--|
--| Revision 1.36  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.35  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.34.6.13  2000/02/10 17:19:40  king
--| Removed redundant command association commands
--|
--| Revision 1.34.6.12  2000/02/04 07:40:46  oconnor
--| removed old command features
--|
--| Revision 1.34.6.11  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.34.6.10  2000/02/01 20:11:16  king
--| Altered inheritence from item_list to deal with new generic item structure
--|
--| Revision 1.34.6.9  2000/01/28 19:08:36  king
--| Converted to fit in with generic structure of ev_item_list
--|
--| Revision 1.34.6.8  2000/01/27 19:30:04  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.34.6.7  2000/01/18 17:24:08  rogers
--| Changed is_multiple_Selection to multiple_selection_enabled.
--|
--| Revision 1.34.6.6  2000/01/18 01:14:59  king
--| Instantiated selected_items to satisfy invariant, needs implementing
--|
--| Revision 1.34.6.5  2000/01/15 00:53:44  oconnor
--| renamed is_multiple_selection -> multiple_selection_enabled, set_multiple_selection -> enable_multiple_selection & set_single_selection -> disable_multiple_selection
--|
--| Revision 1.34.6.4  1999/12/17 18:09:46  rogers
--| Redefined interface to be of more refined type. Item now comes from EV_ITEM_LIST_I. Commented out selected_items pending re-implementation.
--|
--| Revision 1.34.6.3  1999/12/03 07:47:01  oconnor
--| make_rgb (int) -> make_with_rgb (real)
--|
--| Revision 1.34.6.2  1999/11/30 22:46:56  oconnor
--| 8 bit to REAL color fix, redefine interface to more refined type
--|
--| Revision 1.34.6.1  1999/11/24 17:30:12  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.34.2.3  1999/11/04 23:10:44  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.34.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
