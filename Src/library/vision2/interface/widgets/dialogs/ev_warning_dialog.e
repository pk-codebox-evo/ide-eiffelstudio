indexing
	description: "EiffelVision warning dialog. This dialog%
			% displays a window with a warning bitmap,%
			% a text inside and a title."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WARNING_DIALOG

inherit
	EV_MESSAGE_DIALOG
		redefine
			implementation,
			make_default,
			make
		end

creation
	make,
	make_default

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create the dialog box.
		do
			!EV_WARNING_DIALOG_IMP!implementation.make (par)
			{EV_MESSAGE_DIALOG} Precursor (par)
		end

	make_default (par: EV_WINDOW; msg, dtitle: STRING) is
			-- Create with default_options
		do
			!EV_WARNING_DIALOG_IMP! implementation.make (par)
			{EV_MESSAGE_DIALOG} Precursor (par, msg, dtitle)
		end

feature {NONE} -- Implementation

	implementation: EV_WARNING_DIALOG_I

end -- class EV_WARNING_DIALOG

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
