indexing

	description: 
		"EiffelVision implementation of a Motif form.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FORM_M

inherit

	FORM_I;

	BULLETIN_M
		undefine
			create_widget
		redefine
			make
		end

    MEL_FORM
        rename
            make as form_make,
            foreground_color as mel_foreground_color,
            set_foreground_color as mel_set_foreground_color,
            background_color as mel_background_color,
            background_pixmap as mel_background_pixmap,
            set_background_color as mel_set_background_color,
            set_background_pixmap as mel_set_background_pixmap,
            destroy as mel_destroy,
            screen as mel_screen,
			attach_right as mel_attach_right,
			attach_left as mel_attach_left,
			attach_top as mel_attach_top,
			attach_bottom as mel_attach_bottom,
			detach_right as mel_detach_right,
			detach_left as mel_detach_left,
			detach_top as mel_detach_top,
			detach_bottom as mel_detach_bottom,
            is_shown as shown
		select
			form_make, make_no_auto_unmanage
        end

creation

	make

feature {NONE} -- Initialization

	make (a_form: FORM; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif form.
		do
			widget_index := widget_manager.last_inserted_position;
            form_make (a_form.identifier,
                    mel_parent (a_form, widget_index),
                    man);
		end

feature -- Element change

	attach_right (a_child: WIDGET_I; r_offset: INTEGER) is
			-- Attach right side of `a_child' to the left side of current form
			-- with `r_offset' spaces between each other.
		local
			w: MEL_RECT_OBJ
		do
			w ?= a_child;
			mel_attach_right (w);
			set_right_offset (w, r_offset)
		end;

	attach_left (a_child: WIDGET_I; l_offset: INTEGER) is
			-- Attach left side of `a_child' to the left side of current form
			-- with `l_offset' spaces between each other.
		local
			w: MEL_RECT_OBJ
		do
			w ?= a_child;
			mel_attach_left (w);
			set_left_offset (w, l_offset)
		end;

	attach_bottom (a_child: WIDGET_I; b_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the bottom side of current form
			-- with `b_offset' spaces between each other.
		local
			w: MEL_RECT_OBJ
		do
			w ?= a_child;
			mel_attach_bottom (w);
			set_bottom_offset (w, b_offset)
		end;

	attach_top (a_child: WIDGET_I; t_offset: INTEGER) is
			-- Attach top side of `a_child' to the top side of current form
			-- with `t_offset' spaces between each other.
		local
			w: MEL_RECT_OBJ
		do
			w ?= a_child;
			mel_attach_top (w);
			set_top_offset (w, t_offset)
		end;

	attach_right_widget (a_widget: WIDGET_I; a_child: WIDGET_I; r_offset: INTEGER) is
			-- Attach right side of `a_child' to the left side of
			-- `a_widget' with `r_offset' spaces between each other.
		local
			w, t: MEL_RECT_OBJ
		do
			t ?= a_widget;
			w ?= a_child;
			attach_right_to_widget (w, t);
			set_right_offset (w, r_offset);
		end;

	attach_left_widget (a_widget: WIDGET_I; a_child: WIDGET_I; l_offset: INTEGER) is
			-- Attach left side of `a_child' to the right side of
			-- `a_widget' with `l_offset' spaces between each other.
		local
			w, t: MEL_RECT_OBJ
		do
			t ?= a_widget;
			w ?= a_child;
			attach_left_to_widget (w, t);
			set_left_offset (w, l_offset);
		end;

	attach_bottom_widget (a_widget: WIDGET_I; a_child: WIDGET_I; b_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the top side of
			-- `a_widget' with `b_offset' spaces between each other.
		local
			w, t: MEL_RECT_OBJ
		do
			t ?= a_widget;
			w ?= a_child;
			attach_bottom_to_widget (w, t);
			set_bottom_offset (w, b_offset);
		end;

	attach_top_widget (a_widget: WIDGET_I; a_child: WIDGET_I; t_offset: INTEGER) is
			-- Attach top side of `a_child' to the bottom side of
			-- `a_widget' with `t_offset' spaces between each other.
		local
			w, t: MEL_RECT_OBJ
		do
			t ?= a_widget;
			w ?= a_child;
			attach_top_to_widget (w, t);
			set_top_offset (w, t_offset);
		end;

	attach_left_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach left side of `a_child' to a position that is
			-- relative to left side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			w: MEL_RECT_OBJ
		do
			w ?= a_child;
			attach_left_to_position (w, a_position);
		end;

	attach_right_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach right side of `a_child' to a position that is
			-- relative to right side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			w: MEL_RECT_OBJ
		do
			w ?= a_child;
			attach_right_to_position (w, a_position);
		end;

	attach_bottom_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach bottom side of `a_child' to a position that is
			-- relative to bottom side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			w: MEL_RECT_OBJ
		do
			w ?= a_child;
			attach_bottom_to_position (w, a_position);
		end;

	attach_top_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach top side of `a_child' to a position that is
			-- relative to top side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			w: MEL_RECT_OBJ
		do
			w ?= a_child;
			attach_top_to_position (w, a_position);
		end;

	detach_right (a_child: WIDGET_I) is
			-- Detach right side of `a_child'.
		local
			w: MEL_RECT_OBJ
		do
			w ?= a_child;
			mel_detach_right (w);
		end;

	detach_left (a_child: WIDGET_I) is
			-- Detach left side of `a_child'.
		local
			w: MEL_RECT_OBJ
		do
			w ?= a_child;
			mel_detach_left (w);
		end;

	detach_bottom (a_child: WIDGET_I) is
			-- Detach bottom side of `a_child'.
		local
			w: MEL_RECT_OBJ
		do
			w ?= a_child;
			mel_detach_bottom (w);
		end;

	detach_top (a_child: WIDGET_I) is
			-- Detach top side of `a_child'.
		local
			w: MEL_RECT_OBJ
		do
			w ?= a_child;
			mel_detach_top (w);
		end;

end -- class FORM_M

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
