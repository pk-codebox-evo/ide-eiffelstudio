indexing

	description: 
		"EiffelVision implementation of Motif gadget push button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	PUSH_BG_M 

inherit

	PUSH_BG_I;

	BUTTON_G_M
		undefine
			create_callback_struct
		end;

	FONTABLE_M;

	MEL_PUSH_BUTTON_GADGET
		rename
			make as mel_pb_make,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		select
			mel_pb_make, shown
		end

creation

	make

feature {NONE} -- Initialization

	make (a_push_bg: PUSH_BG; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif push button gadget.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_pb_make (a_push_bg.identifier, mc, man);
			a_push_bg.set_font_imp (Current);
			set_mnemonic_from_text (a_push_bg.identifier, False)
		end;

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is activated.
		do
			add_activate_callback (mel_vision_callback (a_command), argument)
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is armed.
		do
			add_arm_callback (mel_vision_callback (a_command), argument)
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is released.
		do
			add_disarm_callback (mel_vision_callback (a_command), argument)
		end;

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is activated.
		do
			remove_activate_callback (mel_vision_callback (a_command), argument)
		end;

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is armed.
		do
			remove_arm_callback (mel_vision_callback (a_command), argument)
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is released.
		do
			remove_disarm_callback (mel_vision_callback (a_command), argument)
		end;

end -- class PUSH_BG_M

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
