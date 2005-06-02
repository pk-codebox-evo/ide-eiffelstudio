indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COLUMN_TAB_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_BOX}
			initialize_constants
			
				-- Create all widgets.
			create l_ev_horizontal_box_1
			create column_finder
			create column_properties_frame
			create l_ev_vertical_box_1
			create l_ev_horizontal_box_2
			create l_ev_table_1
			create l_ev_label_1
			create column_index
			create l_ev_label_2
			create column_width
			create l_ev_label_3
			create column_title_entry
			create l_ev_label_4
			create column_pixmap_combo
			create l_ev_horizontal_box_3
			create l_ev_label_5
			create foreground_color_combo
			create l_ev_horizontal_box_4
			create l_ev_label_6
			create background_color_combo
			create column_selected_button
			create column_visible_button
			create column_operations_frame
			create l_ev_vertical_box_2
			create l_ev_horizontal_box_5
			create l_ev_vertical_box_3
			create l_ev_cell_1
			create swap_column_button
			create l_ev_cell_2
			create move_to_column_finder
			create l_ev_table_2
			create clear_column_button
			create remove_column_button
			create l_ev_cell_3
			
				-- Build_widget_structure.
			extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (column_finder)
			extend (column_properties_frame)
			column_properties_frame.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (l_ev_table_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_label_5)
			l_ev_horizontal_box_3.extend (foreground_color_combo)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (l_ev_label_6)
			l_ev_horizontal_box_4.extend (background_color_combo)
			l_ev_vertical_box_1.extend (column_selected_button)
			l_ev_vertical_box_1.extend (column_visible_button)
			extend (column_operations_frame)
			column_operations_frame.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_5.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (l_ev_cell_1)
			l_ev_vertical_box_3.extend (swap_column_button)
			l_ev_vertical_box_3.extend (l_ev_cell_2)
			l_ev_horizontal_box_5.extend (move_to_column_finder)
			l_ev_vertical_box_2.extend (l_ev_table_2)
			
			column_properties_frame.disable_sensitive
			column_properties_frame.set_text ("Column Properties")
			l_ev_vertical_box_1.set_border_width (box_padding)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_table_1)
			l_ev_table_1.resize (2, 4)
			l_ev_table_1.set_row_spacing (box_padding)
			l_ev_table_1.set_column_spacing (box_padding)
				-- Insert and position all children of `l_ev_table_1'.
			l_ev_table_1.put_at_position (l_ev_label_1, 1, 1, 1, 1)
			l_ev_table_1.put_at_position (column_index, 2, 1, 1, 1)
			l_ev_table_1.put_at_position (l_ev_label_2, 1, 2, 1, 1)
			l_ev_table_1.put_at_position (column_width, 2, 2, 1, 1)
			l_ev_table_1.put_at_position (l_ev_label_3, 1, 3, 1, 1)
			l_ev_table_1.put_at_position (column_title_entry, 2, 3, 1, 1)
			l_ev_table_1.put_at_position (l_ev_label_4, 1, 4, 1, 1)
			l_ev_table_1.put_at_position (column_pixmap_combo, 2, 4, 1, 1)
			l_ev_label_1.set_text ("Index")
			column_index.set_text ("1")
			column_index.value_range.adapt (create {INTEGER_INTERVAL}.make (1, 100))
			column_index.set_value (1)
			l_ev_label_2.set_text ("Width ")
			column_width.set_text ("100")
			column_width.value_range.adapt (create {INTEGER_INTERVAL}.make (1, 10000))
			column_width.set_value (100)
			l_ev_label_3.set_text ("Title")
			column_title_entry.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (212, 208, 200))
			l_ev_label_4.set_text ("Pixmap")
			l_ev_horizontal_box_3.disable_item_expand (l_ev_label_5)
			l_ev_label_5.set_text ("Foreground Color : ")
			l_ev_horizontal_box_4.disable_item_expand (l_ev_label_6)
			l_ev_label_6.set_text ("Background Color : ")
			column_selected_button.set_text ("Is Column Selected?")
			column_visible_button.set_text ("Is Column Visible?")
			column_operations_frame.disable_sensitive
			column_operations_frame.set_text ("Column Operations")
			l_ev_vertical_box_2.set_padding_width (box_padding)
			l_ev_vertical_box_2.set_border_width (box_padding)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_5)
			l_ev_vertical_box_2.disable_item_expand (l_ev_table_2)
			l_ev_horizontal_box_5.set_padding_width (box_padding)
			l_ev_horizontal_box_5.disable_item_expand (l_ev_vertical_box_3)
			l_ev_horizontal_box_5.disable_item_expand (move_to_column_finder)
			l_ev_vertical_box_3.disable_item_expand (swap_column_button)
			swap_column_button.set_text ("Move Column ? past Column ?")
			l_ev_table_2.resize (3, 1)
			l_ev_table_2.set_row_spacing (box_padding)
			l_ev_table_2.set_column_spacing (box_padding)
			l_ev_table_2.set_border_width (box_padding)
				-- Insert and position all children of `l_ev_table_2'.
			l_ev_table_2.put_at_position (clear_column_button, 1, 1, 1, 1)
			l_ev_table_2.put_at_position (remove_column_button, 2, 1, 1, 1)
			l_ev_table_2.put_at_position (l_ev_cell_3, 3, 1, 1, 1)
			clear_column_button.set_text ("Clear Column")
			remove_column_button.set_text ("Remove Column")
			set_padding_width (box_padding)
			set_border_width (box_padding)
			disable_item_expand (l_ev_horizontal_box_1)
			disable_item_expand (column_properties_frame)
			disable_item_expand (column_operations_frame)
			
				--Connect events.
			column_index.change_actions.extend (agent column_index_changed (?))
			column_width.change_actions.extend (agent column_width_changed (?))
			column_title_entry.change_actions.extend (agent column_title_entry_changed)
			column_pixmap_combo.select_actions.extend (agent column_pixmap_combo_selected)
			foreground_color_combo.select_actions.extend (agent foreground_color_combo_selected)
			background_color_combo.select_actions.extend (agent background_color_combo_selected)
			column_selected_button.select_actions.extend (agent column_selected_button_selected)
			column_visible_button.select_actions.extend (agent column_visible_button_selected)
			swap_column_button.select_actions.extend (agent swap_column_button_selected)
			clear_column_button.select_actions.extend (agent clear_column_button_selected)
			remove_column_button.select_actions.extend (agent remove_column_button_selected)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	column_pixmap_combo, foreground_color_combo, background_color_combo: EV_COMBO_BOX
	column_finder,
	move_to_column_finder: GRID_ITEM_FINDER
	column_index, column_width: EV_SPIN_BUTTON
	swap_column_button, clear_column_button,
	remove_column_button: EV_BUTTON
	column_selected_button, column_visible_button: EV_CHECK_BUTTON
	column_title_entry: EV_TEXT_FIELD
	column_properties_frame,
	column_operations_frame: EV_FRAME

feature {NONE} -- Implementation

	l_ev_cell_1, l_ev_cell_2, l_ev_cell_3: EV_CELL
	l_ev_table_1, l_ev_table_2: EV_TABLE
	l_ev_horizontal_box_1,
	l_ev_horizontal_box_2, l_ev_horizontal_box_3, l_ev_horizontal_box_4, l_ev_horizontal_box_5: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1,
	l_ev_vertical_box_2, l_ev_vertical_box_3: EV_VERTICAL_BOX
	l_ev_label_1, l_ev_label_2, l_ev_label_3,
	l_ev_label_4, l_ev_label_5, l_ev_label_6: EV_LABEL

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
	
	column_index_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `column_index'.
		deferred
		end
	
	column_width_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `column_width'.
		deferred
		end
	
	column_title_entry_changed is
			-- Called by `change_actions' of `column_title_entry'.
		deferred
		end
	
	column_pixmap_combo_selected is
			-- Called by `select_actions' of `column_pixmap_combo'.
		deferred
		end
	
	foreground_color_combo_selected is
			-- Called by `select_actions' of `foreground_color_combo'.
		deferred
		end
	
	background_color_combo_selected is
			-- Called by `select_actions' of `background_color_combo'.
		deferred
		end
	
	column_selected_button_selected is
			-- Called by `select_actions' of `column_selected_button'.
		deferred
		end
	
	column_visible_button_selected is
			-- Called by `select_actions' of `column_visible_button'.
		deferred
		end
	
	swap_column_button_selected is
			-- Called by `select_actions' of `swap_column_button'.
		deferred
		end
	
	clear_column_button_selected is
			-- Called by `select_actions' of `clear_column_button'.
		deferred
		end
	
	remove_column_button_selected is
			-- Called by `select_actions' of `remove_column_button'.
		deferred
		end
	

end -- class COLUMN_TAB_IMP
