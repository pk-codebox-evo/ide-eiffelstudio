indexing 
	description: "EiffelVision Combo-box. A combo-box contains a %
				% text field and a button. When the button is    %
				% pressed, a list of possible choices is opened."
	note: "The `height' of a combo-box is the one of the text  %
		% field. To have the height of the text field plus the %
		% list, use extended_height."
	status: "See notice at end of class"
	names: widget
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_COMBO_BOX

inherit
	EV_TEXT_FIELD
		redefine
			implementation,
			make
		end

	EV_LIST	
		export
			{NONE} set_multiple_selection, is_multiple_selection
			{NONE} selected_items
		redefine
			implementation,
			make
		end

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a combo-box with `par' as parent.
		do
			!EV_COMBO_BOX_IMP!implementation.make
			widget_make (par)
		end

feature -- Access

	extended_height: INTEGER is
			-- height of the combo-box when the children are
			-- visible.
		require
			exists: not destroyed
		do
			Result := implementation.extended_height
		end

feature -- Element change

	set_extended_height (value: INTEGER) is
			-- Make `value' the new extended-height of the box.
		require
			exists: not destroyed
			valid_value: value >= 0
		do
			implementation.set_extended_height (value)
		end

feature -- Implementation

	implementation: EV_COMBO_BOX_I

end -- class EV_COMBO_BOX

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
