indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class SCREEN_I 

inherit

	DRAWING_I
	
feature 

	buttons: BUTTONS is
			-- Current state of the mouse buttons
		deferred
		ensure
			not (Result = Void)
		end; -- buttons

	height: INTEGER is
			-- Height of screen (in pixel)
		deferred
		ensure
			height_large_enough: Result >= 0
		end; -- height

	screen_object: POINTER is
			-- Screen object associated
		deferred
		end; -- screen_object

	widget_pointed: WIDGET is
			-- Widget currently pointed by the pointer
		deferred
		end; -- widget_pointed

	width: INTEGER is
			-- Width of screen (in pixel)
		deferred
		ensure
			width_large_enough: Result >= 0
		end; -- width

	x: INTEGER is
			-- Current absolute horizontal coordinate of the mouse
		deferred
		ensure
			position_positive: Result >= 0;
			position_small_enough: Result < width
		end; -- x

	y: INTEGER is
			-- Current absolute vertical coordinate of the mouse
		deferred
		ensure
			position_positive: Result >= 0;
			position_small_enough: Result < height
		end; -- y

	is_valid: BOOLEAN is
			-- Is Current screen created?
		deferred
		end

end -- class SCREEN_I


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
