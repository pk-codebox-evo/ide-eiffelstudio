indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_PIXMAP_SETTINGS_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_DIALOG}
			initialize_constants
			
			create l_horizontal_box_9
			create l_vertical_box_12
			create l_horizontal_box_10
			create l_vertical_box_13
			create l_horizontal_box_11
			create select_pixmap_button
			create l_horizontal_box_12
			create select_directory_button
			create l_horizontal_box_13
			create l_frame_6
			create l_vertical_box_14
			create pixmap_list
			create check_buttons_box
			create check_all_button
			create uncheck_all_button
			create l_horizontal_box_14
			create pixmap_location_label
			create pixmap_path_label
			create built_from_frame
			create l_vertical_box_15
			create l_horizontal_box_15
			create l_vertical_box_16
			create absolute_constant_radio_button
			create absolute_constant_box1
			create absolute_text
			create l_horizontal_separator_1
			create l_horizontal_box_16
			create relative_constant_radio_button
			create relative_constant_box
			create l_horizontal_box_17
			create l_label_4
			create relative_text
			create l_horizontal_box_18
			create l_label_5
			create relative_directory_combo
			create l_vertical_box_17
			create ok_button
			create cancel_button
			create l_cell_5
			
			extend (l_horizontal_box_9)
			l_horizontal_box_9.extend (l_vertical_box_12)
			l_vertical_box_12.extend (l_horizontal_box_10)
			l_horizontal_box_10.extend (l_vertical_box_13)
			l_vertical_box_13.extend (l_horizontal_box_11)
			l_horizontal_box_11.extend (select_pixmap_button)
			l_vertical_box_13.extend (l_horizontal_box_12)
			l_horizontal_box_12.extend (select_directory_button)
			l_vertical_box_12.extend (l_horizontal_box_13)
			l_horizontal_box_13.extend (l_frame_6)
			l_frame_6.extend (l_vertical_box_14)
			l_vertical_box_14.extend (pixmap_list)
			l_vertical_box_14.extend (check_buttons_box)
			check_buttons_box.extend (check_all_button)
			check_buttons_box.extend (uncheck_all_button)
			l_vertical_box_12.extend (l_horizontal_box_14)
			l_horizontal_box_14.extend (pixmap_location_label)
			l_horizontal_box_14.extend (pixmap_path_label)
			l_vertical_box_12.extend (built_from_frame)
			built_from_frame.extend (l_vertical_box_15)
			l_vertical_box_15.extend (l_horizontal_box_15)
			l_horizontal_box_15.extend (l_vertical_box_16)
			l_vertical_box_16.extend (absolute_constant_radio_button)
			l_horizontal_box_15.extend (absolute_constant_box1)
			absolute_constant_box1.extend (absolute_text)
			l_vertical_box_15.extend (l_horizontal_separator_1)
			l_vertical_box_15.extend (l_horizontal_box_16)
			l_horizontal_box_16.extend (relative_constant_radio_button)
			l_horizontal_box_16.extend (relative_constant_box)
			relative_constant_box.extend (l_horizontal_box_17)
			l_horizontal_box_17.extend (l_label_4)
			l_horizontal_box_17.extend (relative_text)
			relative_constant_box.extend (l_horizontal_box_18)
			l_horizontal_box_18.extend (l_label_5)
			l_horizontal_box_18.extend (relative_directory_combo)
			l_horizontal_box_9.extend (l_vertical_box_17)
			l_vertical_box_17.extend (ok_button)
			l_vertical_box_17.extend (cancel_button)
			l_vertical_box_17.extend (l_cell_5)
			
			set_title ("Display window")
			l_horizontal_box_9.set_padding_width (10)
			l_horizontal_box_9.set_border_width (10)
			l_horizontal_box_9.disable_item_expand (l_vertical_box_17)
			l_vertical_box_12.set_padding_width (5)
			l_vertical_box_12.disable_item_expand (l_horizontal_box_10)
			l_vertical_box_12.disable_item_expand (l_horizontal_box_14)
			l_vertical_box_12.disable_item_expand (built_from_frame)
			l_horizontal_box_10.disable_item_expand (l_vertical_box_13)
			l_vertical_box_13.set_padding_width (10)
			l_vertical_box_13.disable_item_expand (l_horizontal_box_11)
			l_vertical_box_13.disable_item_expand (l_horizontal_box_12)
			select_pixmap_button.set_text ("Select Individual ...")
			select_directory_button.set_text ("Select Directory...")
			l_frame_6.set_minimum_width (150)
			l_frame_6.set_minimum_height (150)
			l_vertical_box_14.disable_item_expand (check_buttons_box)
			check_buttons_box.disable_sensitive
			check_buttons_box.set_padding_width (5)
			check_buttons_box.set_border_width (5)
			check_all_button.set_text ("Check all")
			check_all_button.set_tooltip ("Check all items, for inclusion as new pixmap constants")
			uncheck_all_button.set_text ("Uncheck all")
			uncheck_all_button.set_tooltip ("Uncheck all items")
			l_horizontal_box_14.disable_item_expand (pixmap_location_label)
			pixmap_location_label.disable_sensitive
			pixmap_location_label.set_text ("Pixmap location")
			pixmap_location_label.align_text_left
			built_from_frame.disable_sensitive
			built_from_frame.set_text ("Built from")
			l_vertical_box_15.set_padding_width (5)
			l_horizontal_box_15.disable_item_expand (l_vertical_box_16)
			l_vertical_box_16.disable_item_expand (absolute_constant_radio_button)
			l_horizontal_box_16.merge_radio_button_groups (l_vertical_box_16)
			absolute_constant_radio_button.set_text ("Absolute PIXMAP constant named")
			absolute_text.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (212, 208, 200))
			l_horizontal_box_16.disable_item_expand (relative_constant_radio_button)
			l_vertical_box_16.merge_radio_button_groups (l_horizontal_box_16)
			relative_constant_box.set_padding_width (5)
			l_horizontal_box_17.disable_item_expand (l_label_4)
			l_label_4.set_text ("Relative PIXMAP constant named:")
			relative_text.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (212, 208, 200))
			l_horizontal_box_18.set_padding_width (5)
			l_horizontal_box_18.disable_item_expand (l_label_5)
			l_label_5.set_text ("Comprised of DIRECTORY: ")
			l_vertical_box_17.set_padding_width (10)
			l_vertical_box_17.disable_item_expand (ok_button)
			l_vertical_box_17.disable_item_expand (cancel_button)
			ok_button.disable_sensitive
			ok_button.set_text (ok_button_text)
			ok_button.set_minimum_width (default_button_width)
			cancel_button.set_text (cancel_button_text)
			cancel_button.set_minimum_width (default_button_width)
			
			select_pixmap_button.select_actions.extend (agent select_pixmap_pressed)
			select_directory_button.select_actions.extend (agent select_directory_pressed)
			pixmap_list.check_actions.extend (agent item_checked (?))
			pixmap_list.uncheck_actions.extend (agent item_unchecked (?))
			check_all_button.select_actions.extend (agent check_all_button_selected)
			uncheck_all_button.select_actions.extend (agent uncheck_all_button_selected)
			absolute_constant_radio_button.select_actions.extend (agent absolute_radio_button_selected)
			absolute_text.change_actions.extend (agent absolute_text_changed)
			relative_constant_radio_button.select_actions.extend (agent relative_radio_button_selected)
			relative_text.change_actions.extend (agent relative_text_changed)
			relative_directory_combo.change_actions.extend (agent relative_directory_text_changed)
			ok_button.select_actions.extend (agent ok_button_pressed)
			cancel_button.select_actions.extend (agent cancel_button_pressed)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end
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
	
	l_horizontal_box_9, l_horizontal_box_10, l_horizontal_box_11, l_horizontal_box_12, 
	l_horizontal_box_13, check_buttons_box, l_horizontal_box_14, l_horizontal_box_15, 
	absolute_constant_box1, l_horizontal_box_16, l_horizontal_box_17, l_horizontal_box_18: EV_HORIZONTAL_BOX
	l_vertical_box_12, l_vertical_box_13, l_vertical_box_14, l_vertical_box_15, l_vertical_box_16, 
	relative_constant_box, l_vertical_box_17: EV_VERTICAL_BOX
	select_pixmap_button, select_directory_button, check_all_button, uncheck_all_button, 
	ok_button, cancel_button: EV_BUTTON
	l_frame_6, built_from_frame: EV_FRAME
	pixmap_list: EV_CHECKABLE_LIST
	pixmap_location_label, pixmap_path_label, l_label_4, l_label_5: EV_LABEL
	absolute_constant_radio_button, relative_constant_radio_button: EV_RADIO_BUTTON
	absolute_text, relative_text: EV_TEXT_FIELD
	l_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR
	relative_directory_combo: EV_COMBO_BOX
	l_cell_5: EV_CELL
	
	select_pixmap_pressed is
			-- Called by `select_actions' of `select_pixmap_button'.
		deferred
		end
	
	select_directory_pressed is
			-- Called by `select_actions' of `select_directory_button'.
		deferred
		end
	
	item_checked (a_list_item: EV_LIST_ITEM) is
			-- Called by `check_actions' of `pixmap_list'.
		deferred
		end
	
	item_unchecked (a_list_item: EV_LIST_ITEM) is
			-- Called by `uncheck_actions' of `pixmap_list'.
		deferred
		end
	
	check_all_button_selected is
			-- Called by `select_actions' of `check_all_button'.
		deferred
		end
	
	uncheck_all_button_selected is
			-- Called by `select_actions' of `uncheck_all_button'.
		deferred
		end
	
	absolute_radio_button_selected is
			-- Called by `select_actions' of `absolute_constant_radio_button'.
		deferred
		end
	
	absolute_text_changed is
			-- Called by `change_actions' of `absolute_text'.
		deferred
		end
	
	relative_radio_button_selected is
			-- Called by `select_actions' of `relative_constant_radio_button'.
		deferred
		end
	
	relative_text_changed is
			-- Called by `change_actions' of `relative_text'.
		deferred
		end
	
	relative_directory_text_changed is
			-- Called by `change_actions' of `relative_directory_combo'.
		deferred
		end
	
	ok_button_pressed is
			-- Called by `select_actions' of `ok_button'.
		deferred
		end
	
	cancel_button_pressed is
			-- Called by `select_actions' of `cancel_button'.
		deferred
		end
	

end -- class GB_PIXMAP_SETTINGS_DIALOG_IMP
