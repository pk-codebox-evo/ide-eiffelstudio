
-- Motif error dialog implementation.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class ERROR_D_M 

inherit

	ERROR_D_I
		export
			{NONE} all
		end;

	MESSAGE_D_M
		undefine
			make
		redefine
			define_cursor_if_shell, undefine_cursor_if_shell
		end;

	DIALOG_M

creation

	make

feature -- Creation

	make (an_error_dialog: ERROR_D) is
			-- Create a motif error dialog.
		local
			ext_name: ANY
		do
			ext_name := an_error_dialog.identifier.to_c;
			screen_object := create_error_d ($ext_name,
					an_error_dialog.parent.implementation.screen_object);
			an_error_dialog.set_dialog_imp (Current);
			forbid_resize;
			action_target := screen_object;
		end;

feature {ALL_CURS_X}

	define_cursor_if_shell (a_cursor: SCREEN_CURSOR) is
			-- Define `cursor' if the current widget is a shell.
		require else
			a_cursor_exists: not (a_cursor = Void)
		do
			dialog_define_cursor_if_shell (a_cursor)
		end;

	undefine_cursor_if_shell is
			-- Undefine the cursor if the current widget is a shell.
		do
			dialog_undefine_cursor_if_shell
		end;

feature {NONE} -- External features

	create_error_d (d_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end



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
