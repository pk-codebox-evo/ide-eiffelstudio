indexing

	description: 
		"EiffelVision implementation of a Motif error dialog.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	ERROR_D_M 

inherit

	ERROR_D_I;

	MESSAGE_D_M
		undefine
			create_widget
		redefine
			make, parent
		end;

	MEL_ERROR_DIALOG
		rename
			make as mel_error_make,
			make_no_auto_unmanage as mel_error_make_no_auto,
			foreground_color as mel_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_foreground_color as mel_set_foreground_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen,
			is_shown as shown
		undefine
			raise, lower, show, hide
		redefine
			parent
		select
			mel_error_make, mel_error_make_no_auto
		end

creation

	make

feature {NONE} -- Initialization

	make (an_error_dialog: ERROR_D; oui_parent: COMPOSITE) is
			-- Create a motif error dialog.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_error_make_no_auto (an_error_dialog.identifier, mc);
			an_error_dialog.set_dialog_imp (Current);
			initialize (parent)
		end;

feature -- Access

	parent: MEL_DIALOG_SHELL
			-- Dialog shell of the working dialog

end -- class ERROR_D_M

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
