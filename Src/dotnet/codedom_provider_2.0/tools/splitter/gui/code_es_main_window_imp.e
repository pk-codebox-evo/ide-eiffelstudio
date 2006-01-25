indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CODE_ES_MAIN_WINDOW_IMP

inherit
	EV_TITLED_WINDOW
		redefine
			initialize, is_in_default_state
		end
			
	CODE_ES_CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		local 
			l_ev_menu_separator_1: EV_MENU_SEPARATOR
			l_ev_cell_1, l_ev_cell_2, l_ev_cell_3: EV_CELL
			l_ev_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR
		do
			Precursor {EV_TITLED_WINDOW}
			initialize_constants
			
				-- Create all widgets.
			create menu
			create file_menu
			create exit_menu_item
			create help_menu
			create help_menu_item
			create l_ev_menu_separator_1
			create about_menu_item
			create notebook
			create settings_box
			create path_frame
			create path_box
			create folders_box
			create folders_label
			create inner_folders_box
			create folders_combo_box
			create browse_folder_button
			create regexp_box
			create regexp_label
			create regexp_combo_box
			create subfolders_box
			create subfolders_check_button
			create subfolders_label
			create destination_frame
			create destination_box
			create no_destination_radio_button
			create destination_radio_button
			create destination_folder_box
			create l_ev_cell_1
			create destination_folders_combo
			create destination_folder_browse_button
			create buttons_box
			create l_ev_cell_2
			create generate_button
			create output_box
			create output_text
			create l_ev_horizontal_separator_1
			create output_buttons_box
			create open_folder_button
			create l_ev_cell_3
			create exit_button
			
				-- Build_widget_structure.
			set_menu_bar (menu)
			menu.extend (file_menu)
			file_menu.extend (exit_menu_item)
			menu.extend (help_menu)
			help_menu.extend (help_menu_item)
			help_menu.extend (l_ev_menu_separator_1)
			help_menu.extend (about_menu_item)
			extend (notebook)
			notebook.extend (settings_box)
			settings_box.extend (path_frame)
			path_frame.extend (path_box)
			path_box.extend (folders_box)
			folders_box.extend (folders_label)
			folders_box.extend (inner_folders_box)
			inner_folders_box.extend (folders_combo_box)
			inner_folders_box.extend (browse_folder_button)
			path_box.extend (regexp_box)
			regexp_box.extend (regexp_label)
			regexp_box.extend (regexp_combo_box)
			path_box.extend (subfolders_box)
			subfolders_box.extend (subfolders_check_button)
			subfolders_box.extend (subfolders_label)
			settings_box.extend (destination_frame)
			destination_frame.extend (destination_box)
			destination_box.extend (no_destination_radio_button)
			destination_box.extend (destination_radio_button)
			destination_box.extend (destination_folder_box)
			destination_folder_box.extend (l_ev_cell_1)
			destination_folder_box.extend (destination_folders_combo)
			destination_folder_box.extend (destination_folder_browse_button)
			settings_box.extend (buttons_box)
			buttons_box.extend (l_ev_cell_2)
			buttons_box.extend (generate_button)
			notebook.extend (output_box)
			output_box.extend (output_text)
			output_box.extend (l_ev_horizontal_separator_1)
			output_box.extend (output_buttons_box)
			output_buttons_box.extend (open_folder_button)
			output_buttons_box.extend (l_ev_cell_3)
			output_buttons_box.extend (exit_button)
			
			set_minimum_width (450)
			disable_user_resize
			set_title ("eSplitter")
			file_menu.set_text ("File")
			exit_menu_item.set_text ("Exit")
			help_menu.set_text ("Help")
			help_menu_item.set_text ("eSplitter Help")
			help_menu_item.set_pixmap (help_png)
			about_menu_item.set_text ("About")
			notebook.set_item_text (settings_box, "Settings")
			notebook.set_item_text (output_box, "Output")
			settings_box.set_padding_width (5)
			settings_box.set_border_width (5)
			settings_box.disable_item_expand (path_frame)
			settings_box.disable_item_expand (destination_frame)
			settings_box.disable_item_expand (buttons_box)
			path_frame.set_text ("Files Paths")
			path_box.set_padding_width (10)
			path_box.set_border_width (5)
			folders_box.set_padding_width (5)
			folders_box.disable_item_expand (folders_label)
			folders_box.disable_item_expand (inner_folders_box)
			folders_label.set_text ("Folder containing Eiffel multi-class file(s):")
			folders_label.align_text_left
			inner_folders_box.set_padding_width (7)
			inner_folders_box.disable_item_expand (browse_folder_button)
			browse_folder_button.set_text ("...")
			browse_folder_button.set_minimum_width (35)
			regexp_box.set_padding_width (5)
			regexp_box.disable_item_expand (regexp_label)
			regexp_label.set_text ("Only process files whose filename matches the following regular expression:")
			regexp_label.align_text_left
			regexp_combo_box.set_text (".*\.es")
			subfolders_box.disable_item_expand (subfolders_check_button)
			subfolders_box.disable_item_expand (subfolders_label)
			subfolders_label.set_text ("Also process files in subfolders")
			subfolders_label.align_text_left
			destination_frame.set_text ("Destination")
			destination_box.set_border_width (5)
			destination_box.disable_item_expand (no_destination_radio_button)
			destination_box.disable_item_expand (destination_radio_button)
			destination_box.disable_item_expand (destination_folder_box)
			no_destination_radio_button.set_text ("Generate Eiffel class files in the same folder as the Eiffel multi-class files")
			destination_radio_button.set_text ("Generate Eiffel class files in the following folder:")
			destination_folder_box.disable_sensitive
			destination_folder_box.set_padding_width (7)
			destination_folder_box.disable_item_expand (l_ev_cell_1)
			destination_folder_box.disable_item_expand (destination_folder_browse_button)
			l_ev_cell_1.set_minimum_width (10)
			destination_folder_browse_button.set_text ("...")
			destination_folder_browse_button.set_minimum_width (35)
			buttons_box.set_padding_width (5)
			buttons_box.set_border_width (5)
			buttons_box.disable_item_expand (generate_button)
			generate_button.set_text ("Generate")
			generate_button.set_minimum_width (100)
			output_box.set_padding_width (5)
			output_box.set_border_width (5)
			output_box.disable_item_expand (l_ev_horizontal_separator_1)
			output_box.disable_item_expand (output_buttons_box)
			output_buttons_box.set_padding_width (7)
			output_buttons_box.disable_item_expand (open_folder_button)
			output_buttons_box.disable_item_expand (exit_button)
			open_folder_button.set_text ("Open Folder")
			open_folder_button.set_minimum_width (100)
			exit_button.set_text ("Exit")
			exit_button.set_minimum_width (100)
			
				--Connect events.
			exit_menu_item.select_actions.extend (agent on_exit)
			help_menu_item.select_actions.extend (agent on_help)
			about_menu_item.select_actions.extend (agent on_about)
			folders_combo_box.change_actions.extend (agent on_folder_change)
			folders_combo_box.return_actions.extend (agent on_generate)
			browse_folder_button.select_actions.extend (agent on_browse_folder)
			regexp_combo_box.change_actions.extend (agent on_regexp_change)
			no_destination_radio_button.select_actions.extend (agent on_select_no_destination)
			destination_radio_button.select_actions.extend (agent on_select_destination)
			destination_folders_combo.change_actions.extend (agent on_destination_folder_change)
			destination_folders_combo.return_actions.extend (agent on_generate)
			destination_folder_browse_button.select_actions.extend (agent on_browse_destination_folder)
			generate_button.select_actions.extend (agent on_generate)
			open_folder_button.select_actions.extend (agent on_open_folder)
			exit_button.select_actions.extend (agent on_exit)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	menu: EV_MENU_BAR
	file_menu, help_menu: EV_MENU
	exit_menu_item, help_menu_item, about_menu_item: EV_MENU_ITEM
	notebook: EV_NOTEBOOK
	settings_box, path_box, folders_box, regexp_box, destination_box, output_box: EV_VERTICAL_BOX
	path_frame, destination_frame: EV_FRAME
	folders_label, regexp_label, subfolders_label: EV_LABEL
	inner_folders_box, subfolders_box, destination_folder_box, buttons_box, output_buttons_box: EV_HORIZONTAL_BOX
	folders_combo_box, regexp_combo_box, destination_folders_combo: EV_COMBO_BOX
	browse_folder_button, destination_folder_browse_button, generate_button, open_folder_button, 
	exit_button: EV_BUTTON
	subfolders_check_button: EV_CHECK_BUTTON
	no_destination_radio_button, destination_radio_button: EV_RADIO_BUTTON
	output_text: EV_RICH_TEXT

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	on_exit is
			-- Called by `select_actions' of `exit_menu_item'.
		deferred
		end
	
	on_help is
			-- Called by `select_actions' of `help_menu_item'.
		deferred
		end
	
	on_about is
			-- Called by `select_actions' of `about_menu_item'.
		deferred
		end
	
	on_folder_change is
			-- Called by `change_actions' of `folders_combo_box'.
		deferred
		end
	
	on_generate is
			-- Called by `return_actions' of `folders_combo_box'.
		deferred
		end
	
	on_browse_folder is
			-- Called by `select_actions' of `browse_folder_button'.
		deferred
		end
	
	on_regexp_change is
			-- Called by `change_actions' of `regexp_combo_box'.
		deferred
		end
	
	on_select_no_destination is
			-- Called by `select_actions' of `no_destination_radio_button'.
		deferred
		end
	
	on_select_destination is
			-- Called by `select_actions' of `destination_radio_button'.
		deferred
		end
	
	on_destination_folder_change is
			-- Called by `change_actions' of `destination_folders_combo'.
		deferred
		end
	
	on_browse_destination_folder is
			-- Called by `select_actions' of `destination_folder_browse_button'.
		deferred
		end
	
	on_open_folder is
			-- Called by `select_actions' of `open_folder_button'.
		deferred
		end
	

end -- class CODE_ES_MAIN_WINDOW_IMP
