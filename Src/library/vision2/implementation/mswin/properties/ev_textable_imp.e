indexing
	description: 
		"EiffelVision text container, gtk implementation"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE_IMP
	
inherit
	EV_TEXTABLE_I

feature -- Status setting

	set_center_alignment is
			-- Set text alignment of current label to center.
		deferred
           end

	set_right_alignment is
			-- Set text alignment of current label to right.
		deferred
		end

	set_left_alignment is
			-- Set text alignment of current label to left.
		deferred
		end
	
	destroyed: BOOLEAN is
		deferred
		end

feature -- Inapplicable

	set_default_minimum_size is
			-- Set to the size of the text
		do
		end

end -- class EV_TEXTABLE_IMP

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
