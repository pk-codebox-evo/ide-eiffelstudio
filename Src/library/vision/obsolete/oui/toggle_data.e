indexing

	description:
		"Information given by EiffelVision when a toggle button's value has been %
		%changed";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TOGGLE_DATA 

obsolete
	"Use class CONTEXT_DATA instead."

inherit 

	CONTEXT_DATA
		rename
			make as context_data_make
		end

creation

	make

feature 

	state: BOOLEAN;
			-- New state of toggle button

	make (a_widget: WIDGET; a_state: BOOLEAN) is
			-- Create a context_data for `value changed' action.
		do
			widget := a_widget;
			state := a_state
		end

end


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

