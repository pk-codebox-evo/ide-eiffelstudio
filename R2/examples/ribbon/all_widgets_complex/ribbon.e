note
	description: "[
					Generated by EiffelRibbon tool
					Don't edit this file, since it will be replaced by EiffelRibbon tool
					generated files everytime
																							]"
	date: "$Date$"
	revision: "$Revision$"

class
	RIBBON

inherit
	EV_RIBBON
		export
			{ANY} init_with_window_and_dll
		redefine
			init_with_window
		end
		
create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create_interface_objects			
		end

	create_interface_objects
			-- Create objects
		do
			create tab_button.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.tab_button>>)
			create tab_toggle_button.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.tab_toggle_button>>)
			create tab_check_box.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.tab_check_box>>)
			create tab_spinner.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.tab_spinner>>)
			create tab_combo_box.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.tab_combo_box>>)
			create tab_split_button.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.tab_split_button>>)
			create tab_dropdown_gallery.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.tab_dropdown_gallery>>)

			create tabs.make (1)
			tabs.extend (tab_button)
			tabs.extend (tab_toggle_button)
			tabs.extend (tab_check_box)
			tabs.extend (tab_spinner)
			tabs.extend (tab_combo_box)
			tabs.extend (tab_split_button)
			tabs.extend (tab_dropdown_gallery)

		end

feature -- Command

	init_with_window (a_window: EV_WINDOW)
			-- <Precursor>
		do
			Precursor (a_window)
			-- You could call setModes here

		end
		
feature -- Query
	tab_button: TAB_BUTTON
	tab_toggle_button: TAB_TOGGLE_BUTTON
	tab_check_box: TAB_CHECK_BOX
	tab_spinner: TAB_SPINNER
	tab_combo_box: TAB_COMBO_BOX
	tab_split_button: TAB_SPLIT_BUTTON
	tab_dropdown_gallery: TAB_DROPDOWN_GALLERY


end

