indexing 
	description:
		" EiffelVision text. A text area that contains%
		% a rich text."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT

inherit
	EV_TEXT_AREA
		redefine
			implementation,
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create an empty text area with `par' as
			-- parent.
		do
			!EV_TEXT_IMP!implementation.make
			widget_make (par)
		end

feature -- Implementation

	implementation: EV_TEXT_I

end -- class EV_TEXT

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
