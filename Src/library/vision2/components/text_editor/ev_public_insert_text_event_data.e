--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "A edit control based on EV_RICH_TEXT optimized for%
					 %source code editing. It supports various advanced %
					 %editing mechanisms and a rudimentary support for%
					 %syntax highlighting"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PUBLIC_INSERT_TEXT_EVENT_DATA
inherit
	EV_INSERT_TEXT_EVENT_DATA
create
	make
feature -- Element change

	set_all (a_rich_text: EV_RICH_TEXT; a_position: INTEGER; a_text: STRING) is
			-- Fill all the values of the data.
		do
			implementation.set_all (a_rich_text, a_position, a_text)
		end

end -- class EV_PUBLIC_INSERT_TEXT_EVENT_DATA

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2000/02/14 11:40:24  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.2  2000/01/27 19:29:23  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.1  1999/11/24 17:29:39  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:01  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
