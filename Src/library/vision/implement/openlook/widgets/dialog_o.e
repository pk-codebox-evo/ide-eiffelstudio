indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DIALOG_O 

inherit

	DIALOG_I
		export
			{NONE} all
		end;

	G_ANY_O
		export
			{NONE} all
		end;

	WM_SHELL_O
		export
			{NONE} all
		end;

	POPUP_S_O
		export
			{NONE} all
		undefine
			action_target
		end;


feature


    dialog_command_target is
        do
            action_target := xt_parent (screen_object);
        ensure then
            target_correct: action_target = xt_parent (screen_object);
        end;

    widget_command_target is
        do
            action_target := screen_object;
        ensure then
            target_correct: action_target = screen_object;
        end;

    action_target: POINTER;



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
