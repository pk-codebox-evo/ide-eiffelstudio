--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BUTTON_EVENT_DATA_IMP

inherit
	EV_BUTTON_EVENT_DATA_I

	EV_EVENT_DATA_IMP

feature -- Access	

	absolute_x: INTEGER is
			-- absolute x of the mouse pointer
		local
			ww: WEL_WINDOW
			pt: WEL_POINT
		do
	--FIXME		ww ?= widget.implementation
			!! pt.make (x, y)
			pt.client_to_screen (ww)
			Result := pt.x
		end

	absolute_y: INTEGER is
			-- absolute y of the mouse pointer
		local
			ww: WEL_WINDOW
			pt: WEL_POINT
		do
	--FIXME		ww ?= widget.implementation
			!! pt.make (x, y)
			pt.client_to_screen (ww)
			Result := pt.y
		end

end -- class EV_BUTTON_EVENT_DATA_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.10.3  2000/01/27 19:30:09  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.10.2  1999/12/17 17:27:24  rogers
--| Altered to fit in with the review branch.
--|
--| Revision 1.3.10.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.6.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
