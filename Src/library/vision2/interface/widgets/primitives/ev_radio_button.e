indexing
	description:
		"Eiffel Vision radio button. Select state is mutualy exlusive%N%
		%with respect to other radio buttons in a container."
	status: "See notice at end of class"
	keywords: "toggle, radio, button"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_BUTTON

inherit
	EV_SELECT_BUTTON
		redefine
			implementation,
			create_implementation
		end

create
	default_create,
	make_with_text

feature -- Implementation

	implementation: EV_RADIO_BUTTON_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_implementation is
			-- Create the implementation for the toggle button.
		do
			Create {EV_RADIO_BUTTON_IMP} implementation.make (Current)
		end
	
end -- class EV_RADIO_BUTTON

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
--| Revision 1.14  2000/02/24 18:16:24  oconnor
--| New inheritance structure for buttons with state.
--| New class EV_SELECT_BUTTON provides `is_selected' and `enable_select'.
--| RADIO_BUTTON inherits this, as does TOGGLE_BUTTON which adds
--| `disable_select' and `toggle'.
--|
--| Revision 1.13  2000/02/22 18:39:52  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.12  2000/02/17 02:20:08  oconnor
--| released
--|
--| Revision 1.11  2000/02/17 01:42:05  king
--| Removed deprecated radio grouping features
--|
--| Revision 1.10  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.4  2000/01/27 19:30:56  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.3  2000/01/19 08:20:51  oconnor
--| formatting and comments
--|
--| Revision 1.9.6.2  2000/01/07 01:01:29  king
--| Redesigned interface to fit in with new structure
--|
--| Revision 1.9.6.1  1999/11/24 17:30:55  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
