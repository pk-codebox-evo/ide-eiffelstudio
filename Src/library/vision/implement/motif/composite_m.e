indexing

	description: 
		"EiffelVision implementation of a MOTIF composite.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class COMPOSITE_M 

inherit

	WIDGET_M
		undefine
			mel_destroy, clean_up
		end;

	MEL_COMPOSITE
		rename
            background_color as mel_background_color,
            background_pixmap as mel_background_pixmap,
            set_background_color as mel_set_background_color,
            set_background_pixmap as mel_set_background_pixmap,
            destroy as mel_destroy,
			screen as mel_screen
        end

end -- class COMPOSITE_M

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
