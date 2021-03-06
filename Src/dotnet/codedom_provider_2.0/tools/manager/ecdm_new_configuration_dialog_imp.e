note
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECDM_NEW_CONFIGURATION_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end
			
	ECDM_CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'.
		local
			internal_font: EV_FONT
		do
			Precursor {EV_DIALOG}
			initialize_constants
			
				-- Create all widgets.
			create main_box
			create top_box
			create title_box
			create title_label
			create subtitle_box
			create subtitle_padding_cell
			create subtitle_label
			create top_padding_cell
			create new_configuration_pixmap
			create l_ev_horizontal_separator_1
			create bottom_box
			create config_info_frame
			create config_info_box
			create config_name_label
			create config_name_edit_box
			create config_name_text_field
			create config_name_padding_cell
			create config_info_padding_cell
			create configuration_folder_label
			create configuration_folder_box
			create configuration_folder_text_field
			create browse_button
			create applications_frame
			create applications_box
			create applications_label
			create applications_list
			create applications_buttons_box
			create add_button
			create remove_button
			create buttons_padding_cell
			create l_ev_horizontal_separator_2
			create buttons_box
			create bottom_buttons_padding_cell
			create ok_button
			create cancel_button
			
				-- Build_widget_structure.
			extend (main_box)
			main_box.extend (top_box)
			top_box.extend (title_box)
			title_box.extend (title_label)
			title_box.extend (subtitle_box)
			subtitle_box.extend (subtitle_padding_cell)
			subtitle_box.extend (subtitle_label)
			top_box.extend (top_padding_cell)
			top_box.extend (new_configuration_pixmap)
			main_box.extend (l_ev_horizontal_separator_1)
			main_box.extend (bottom_box)
			bottom_box.extend (config_info_frame)
			config_info_frame.extend (config_info_box)
			config_info_box.extend (config_name_label)
			config_info_box.extend (config_name_edit_box)
			config_name_edit_box.extend (config_name_text_field)
			config_name_edit_box.extend (config_name_padding_cell)
			config_info_box.extend (config_info_padding_cell)
			config_info_box.extend (configuration_folder_label)
			config_info_box.extend (configuration_folder_box)
			configuration_folder_box.extend (configuration_folder_text_field)
			configuration_folder_box.extend (browse_button)
			bottom_box.extend (applications_frame)
			applications_frame.extend (applications_box)
			applications_box.extend (applications_label)
			applications_box.extend (applications_list)
			applications_box.extend (applications_buttons_box)
			applications_buttons_box.extend (add_button)
			applications_buttons_box.extend (remove_button)
			applications_buttons_box.extend (buttons_padding_cell)
			main_box.extend (l_ev_horizontal_separator_2)
			main_box.extend (buttons_box)
			buttons_box.extend (bottom_buttons_padding_cell)
			buttons_box.extend (ok_button)
			buttons_box.extend (cancel_button)
			
			main_box.disable_item_expand (top_box)
			main_box.disable_item_expand (l_ev_horizontal_separator_1)
			main_box.disable_item_expand (l_ev_horizontal_separator_2)
			main_box.disable_item_expand (buttons_box)
			top_box.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			top_box.set_minimum_height (50)
			top_box.set_padding_width (5)
			top_box.set_border_width (8)
			top_box.disable_item_expand (new_configuration_pixmap)
			title_box.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			title_box.set_padding_width (5)
			title_box.disable_item_expand (title_label)
			title_box.disable_item_expand (subtitle_box)
			title_label.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			create internal_font
			internal_font.set_family ({EV_FONT_CONSTANTS}.Family_sans)
			internal_font.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)
			internal_font.set_shape ({EV_FONT_CONSTANTS}.Shape_regular)
			internal_font.set_height_in_points (8)
			internal_font.preferred_families.extend ("Microsoft Sans Serif")
			title_label.set_font (internal_font)
			title_label.set_text ("New Configuration")
			title_label.align_text_left
			subtitle_box.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			subtitle_box.disable_item_expand (subtitle_padding_cell)
			subtitle_padding_cell.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			subtitle_padding_cell.set_minimum_width (20)
			subtitle_label.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			subtitle_label.set_text ("Fill in the following information to create a new Eiffel Codedom Provider configuration")
			subtitle_label.align_text_left
			top_padding_cell.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			new_configuration_pixmap.set_minimum_width (40)
			new_configuration_pixmap.copy (new_wizard_png)
			bottom_box.set_padding_width (10)
			bottom_box.set_border_width (10)
			bottom_box.disable_item_expand (config_info_frame)
			config_info_frame.set_text ("Configuration Information")
			config_info_box.set_padding_width (5)
			config_info_box.set_border_width (10)
			config_name_label.set_text ("Type the name for the new configuration:")
			config_name_label.align_text_left
			config_name_edit_box.disable_item_expand (config_name_text_field)
			config_name_text_field.set_text ("new_config")
			config_name_text_field.set_minimum_width (150)
			config_info_padding_cell.set_minimum_height (5)
			configuration_folder_label.set_text ("Type the location of the folder where the configuration file will be created:")
			configuration_folder_label.align_text_left
			configuration_folder_box.set_padding_width (5)
			configuration_folder_box.disable_item_expand (browse_button)
			browse_button.set_text ("Browse")
			browse_button.set_minimum_width (100)
			applications_frame.set_text ("Configured Applications")
			applications_box.set_padding_width (5)
			applications_box.set_border_width (10)
			applications_box.disable_item_expand (applications_label)
			applications_box.disable_item_expand (applications_buttons_box)
			applications_label.set_text ("List applications that will use this configuration:")
			applications_label.align_text_left
			applications_buttons_box.set_padding_width (5)
			applications_buttons_box.disable_item_expand (add_button)
			applications_buttons_box.disable_item_expand (remove_button)
			add_button.set_text ("Add")
			add_button.set_minimum_width (100)
			remove_button.disable_sensitive
			remove_button.set_text ("Remove")
			remove_button.set_minimum_width (100)
			buttons_box.set_padding_width (5)
			buttons_box.set_border_width (10)
			buttons_box.disable_item_expand (ok_button)
			buttons_box.disable_item_expand (cancel_button)
			ok_button.disable_sensitive
			ok_button.set_text ("OK")
			ok_button.set_minimum_width (100)
			cancel_button.set_text ("Cancel")
			cancel_button.set_minimum_width (100)
			set_minimum_width (520)
			set_minimum_height (440)
			disable_user_resize
			set_title ("New Configuration")
			
				--Connect events.
			config_name_text_field.change_actions.extend (agent on_name_change)
			browse_button.select_actions.extend (agent on_browse_for_folder)
			applications_list.select_actions.extend (agent on_application_select)
			applications_list.deselect_actions.extend (agent on_application_deselect)
			add_button.select_actions.extend (agent on_add)
			remove_button.select_actions.extend (agent on_remove)
			ok_button.select_actions.extend (agent on_ok)
			cancel_button.select_actions.extend (agent on_cancel)
				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	applications_list: EV_LIST
	subtitle_padding_cell, top_padding_cell, config_name_padding_cell,
	config_info_padding_cell, buttons_padding_cell, bottom_buttons_padding_cell: EV_CELL
	browse_button,
	add_button, remove_button, ok_button, cancel_button: EV_BUTTON
	new_configuration_pixmap: EV_PIXMAP
	top_box,
	subtitle_box, config_name_edit_box, configuration_folder_box, applications_buttons_box,
	buttons_box: EV_HORIZONTAL_BOX
	main_box, title_box, bottom_box, config_info_box, applications_box: EV_VERTICAL_BOX
	title_label,
	subtitle_label, config_name_label, configuration_folder_label, applications_label: EV_LABEL
	config_name_text_field,
	configuration_folder_text_field: EV_TEXT_FIELD
	config_info_frame, applications_frame: EV_FRAME

feature {NONE} -- Implementation

	l_ev_horizontal_separator_1, l_ev_horizontal_separator_2: EV_HORIZONTAL_SEPARATOR

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	on_name_change
			-- Called by `change_actions' of `config_name_text_field'.
		deferred
		end
	
	on_browse_for_folder
			-- Called by `select_actions' of `browse_button'.
		deferred
		end
	
	on_application_select
			-- Called by `select_actions' of `applications_list'.
		deferred
		end
	
	on_application_deselect
			-- Called by `deselect_actions' of `applications_list'.
		deferred
		end
	
	on_add
			-- Called by `select_actions' of `add_button'.
		deferred
		end
	
	on_remove
			-- Called by `select_actions' of `remove_button'.
		deferred
		end
	
	on_ok
			-- Called by `select_actions' of `ok_button'.
		deferred
		end
	
	on_cancel
			-- Called by `select_actions' of `cancel_button'.
		deferred
		end
	

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class ECDM_NEW_CONFIGURATION_DIALOG_IMP
