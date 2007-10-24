indexing
	description	: "Strings for the Graphical User Interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Generated by the New Vision2 Application Wizard."
	date		: "$Date$"
	revision	: "1.0.0"

class
	INTERFACE_NAMES

feature -- Access

	Button_ok_item: STRING is "OK"
			-- String for "OK" buttons.

	Menu_file_item: STRING is "&File"
			-- String for menu "File"

	Menu_file_new_item: STRING is "&New%TCtrl+N"
			-- String for menu "File/New"

	Menu_file_open_item: STRING is "&Open...%TCtrl+O"
			-- String for menu "File/Open"

	Menu_file_save_item: STRING is "&Save%TCtrl+S"
			-- String for menu "File/Save"

	Menu_file_saveas_item: STRING is "Save &As..."
			-- String for menu "File/Save As"

	Menu_file_close_item: STRING is "&Close"
			-- String for menu "File/Close"

	Menu_file_exit_item: STRING is "E&xit"
			-- String for menu "File/Exit"
			
	Menu_print_item: STRING is "&Print"

	Menu_help_item: STRING is "&Help"
			-- String for menu "Help"

	Menu_help_contents_item: STRING is "&Contents and Index"
			-- String for menu "Help/Contents and Index"

	Menu_help_about_item: STRING is "&About..."
			-- String for menu "Help/About"

	Label_confirm_close_window: STRING is "You are about to close this window.%NClick OK to proceed.";
			-- String for the confirmation dialog box that appears
			-- when the user try to close the first window.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class INTERFACE_NAMES
