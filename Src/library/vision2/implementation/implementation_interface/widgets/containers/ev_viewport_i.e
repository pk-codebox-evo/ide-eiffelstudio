indexing
	description: "Eiffel Vision viewport. Implementation interface."
	status: "See notice at end of class"
	keywords: "container, virtual, display"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_VIEWPORT_I

inherit
	EV_CELL_I

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		deferred
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		deferred
		end

feature -- Element change

	set_x_offset (an_x: INTEGER) is
			-- Assign `an_x' to `x_offset'.
		deferred
		ensure
			assigned: x_offset = an_x
		end

	set_y_offset (a_y: INTEGER) is
			-- Assign `a_y' to `y_offset'.
		deferred
		ensure
			assigned: y_offset = a_y
		end

	set_offset (an_x, a_y: INTEGER) is
			-- Assign `an_x' to `x_offset'.
			-- Assign `a_y' to `y_offset'.
		do
			set_x_offset (an_x)
			set_y_offset (a_y)
		ensure
			assigned: x_offset = an_x
			assigned: y_offset = a_y
		end

end -- class EV_VIEWPORT_I

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.6  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.2.2  2000/12/22 19:01:33  rogers
--| Removed restrictive pre-conditions which ensured that if the item
--| was smaller than the viewport, the item had to be completely visible. The
--| vieewport can now be positioned so that the item is partially or
--| completely obscured.
--|
--| Revision 1.5.2.1  2000/05/03 19:09:05  oconnor
--| mergred from HEAD
--|
--| Revision 1.5  2000/04/24 16:04:18  brendel
--| Added set_offset.
--|
--| Revision 1.4  2000/04/21 22:01:56  brendel
--| Complies with interface.
--|
--| Revision 1.3  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.2  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.1.2.1  2000/01/28 19:29:01  brendel
--| Initial. New ancestor for EV_SCROLLABLE_AREA.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
