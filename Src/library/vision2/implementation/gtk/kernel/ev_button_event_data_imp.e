indexing
	description: "EiffelVision button event data. Gtk implementation";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_BUTTON_EVENT_DATA_IMP
	
inherit
	EV_BUTTON_EVENT_DATA_I
	
	EV_EVENT_DATA_IMP
		redefine
			initialize
		end

feature -- Access	
	
	absolute_x: INTEGER is
			-- absolute x of the mouse pointer
		do
			check
				not_yet_implemented: False
			end
		end

	absolute_y: INTEGER is
			-- absolute y of the mouse pointer
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Initialization
	
		initialize (p: POINTER) is
			-- Creation and initialization of 'parent's 
			-- fields according to C pointer 'p'
		do
			Precursor (p)			
			set_x (c_gdk_event_x (p))
			set_y (c_gdk_event_y (p))
--			set_state (c_gdk_event_state (p))
			set_button (c_gdk_event_button (p))
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

			
	
