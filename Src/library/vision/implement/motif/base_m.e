
-- Motif base implementation. 

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BASE_M 

inherit

	BASE_I
		export
			{NONE} all
		end;

	WM_SHELL_M;

	BASE_R_M
		export
			{NONE} all
		end;

	TOP_M

creation

	make

feature 

	make (a_base: BASE; application_class: STRING) is
		local
			ext_name_base, ext_name_appl: ANY
		do
			oui_top := a_base;
-- FIXME (Cf notes)
			ext_name_base := to_c_if_not_void (a_base.identifier);
			ext_name_appl := to_c_if_not_void (application_class);
			screen_object:= xt_create_app_shell (a_base.screen.implementation.screen_object, $ext_name_base, $ext_name_appl);
			a_base.set_wm_imp (Current);
			xm_delete_window_protocol (a_base.screen.implementation.screen_object, screen_object, Current, $delete_window_action)
		end

feature {NONE} -- External features

	xt_create_app_shell (src_obj: POINTER; b_name, a_name: ANY): POINTER is
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
