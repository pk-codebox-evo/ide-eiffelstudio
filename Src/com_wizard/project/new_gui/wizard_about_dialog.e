indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ABOUT_DIALOG

inherit
	WIZARD_ABOUT_DIALOG_IMP


	WIZARD_SHARED_VERSION_NUMBER
		export
			{NONE}
		undefine
			default_create,
			copy
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			version_label.set_text (version_number)
		end

feature {NONE} -- Implementation

	on_web_click (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_release_actions' of `web_address_label'.
			-- Open web browser on `http://www.eiffel.com'.
		local
			l_cmd: STRING
			l_launcher: WEL_PROCESS_LAUNCHER
		do
			l_cmd := (create {EXECUTION_ENVIRONMENT}).get ("ComSpec")
			if l_cmd /= Void then
				l_cmd.append (" /c start http://www.eiffel.com")
				create l_launcher
				l_launcher.run_hidden
				l_launcher.spawn (l_cmd, Void)
			end
		end

	on_mouse_enter is
			-- Called by `pointer_enter_actions' of `web_address_label'.
			-- Change mouse cursor to "hyperlink hovering mouse cursor"
		local
			l_font: EV_FONT
		do
			default_font := web_address_label.font
			l_font := default_font.twin
			l_font.set_weight ((create {EV_FONT_CONSTANTS}).Weight_bold)
			web_address_label.set_font (l_font)
		end

	on_mouse_leave is
			-- Called by `pointer_leave_actions' of `web_address_label'.
			-- Restore mouse cursor.
		do
			web_address_label.set_font (default_font)
		end

	default_font: EV_FONT
			-- Default web label font

	on_ok is
			-- Called by `select_actions' of `ok_button'.
			-- Close dialog
		do
			destroy
		end

end -- class WIZARD_ABOUT_DIALOG

