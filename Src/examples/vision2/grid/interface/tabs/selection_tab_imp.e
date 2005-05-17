indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SELECTION_TAB_IMP

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
			create l_ev_frame_1
			create l_ev_vertical_box_1
			create l_ev_table_1
			create single_item_selection_button
			create single_row_selection_button
			create multiple_item_selection_button
			create multiple_row_selection_button
			create selection_on_click
			create always_selected_button
			create l_ev_frame_2
			create l_ev_vertical_box_2
			create l_ev_horizontal_box_1
			create item_finder
			create l_ev_vertical_box_3
			create l_ev_cell_1
			create l_ev_horizontal_box_2
			create select_item_x_spin_button
			create select_item_y_spin_button
			create l_ev_cell_2
			create l_ev_horizontal_box_3
			create select_row_button
			create select_column_button
			create select_item_button
			create clear_selection_button
			create l_ev_frame_3
			create l_ev_vertical_box_4
			create l_ev_horizontal_box_4
			create selected_items_button
			create selected_rows_button
			
				-- Build_widget_structure.
			extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_table_1)
			extend (l_ev_frame_2)
			l_ev_frame_2.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (item_finder)
			l_ev_horizontal_box_1.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (l_ev_cell_1)
			l_ev_vertical_box_3.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (select_item_x_spin_button)
			l_ev_horizontal_box_2.extend (select_item_y_spin_button)
			l_ev_vertical_box_3.extend (l_ev_cell_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (select_row_button)
			l_ev_horizontal_box_3.extend (select_column_button)
			l_ev_horizontal_box_3.extend (select_item_button)
			l_ev_horizontal_box_3.extend (clear_selection_button)
			extend (l_ev_frame_3)
			l_ev_frame_3.extend (l_ev_vertical_box_4)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (selected_items_button)
			l_ev_horizontal_box_4.extend (selected_rows_button)
			
			l_ev_frame_1.set_text ("Selection Type")
			l_ev_vertical_box_1.disable_item_expand (l_ev_table_1)
			l_ev_table_1.resize (2, 3)
			l_ev_table_1.set_row_spacing (box_padding)
			l_ev_table_1.set_column_spacing (box_padding)
				-- Insert and position all children of `l_ev_table_1'.
			l_ev_table_1.put_at_position (single_item_selection_button, 1, 1, 1, 1)
			l_ev_table_1.put_at_position (single_row_selection_button, 2, 1, 1, 1)
			l_ev_table_1.put_at_position (multiple_item_selection_button, 1, 2, 1, 1)
			l_ev_table_1.put_at_position (multiple_row_selection_button, 2, 2, 1, 1)
			l_ev_table_1.put_at_position (selection_on_click, 1, 3, 1, 1)
			l_ev_table_1.put_at_position (always_selected_button, 2, 3, 1, 1)
			single_item_selection_button.set_text ("Single Item")
			single_row_selection_button.set_text ("Single Row")
			multiple_item_selection_button.set_text ("Multiple Item")
			multiple_row_selection_button.set_text ("Multiple Row")
			selection_on_click.enable_select
			selection_on_click.set_text ("Selection On Click Enabled")
			always_selected_button.set_text ("Always Selected")
			l_ev_frame_2.set_text ("Selection Change")
			l_ev_vertical_box_2.set_padding_width (box_padding)
			l_ev_vertical_box_2.set_border_width (box_padding)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_horizontal_box_1.set_padding_width (box_padding)
			l_ev_horizontal_box_1.disable_item_expand (item_finder)
			l_ev_vertical_box_3.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.set_padding_width (box_padding)
			l_ev_horizontal_box_2.disable_item_expand (select_item_x_spin_button)
			l_ev_horizontal_box_2.disable_item_expand (select_item_y_spin_button)
			select_item_x_spin_button.set_text ("1")
			select_item_x_spin_button.value_range.adapt (create {INTEGER_INTERVAL}.make (1, 1000000))
			select_item_x_spin_button.set_value (1)
			select_item_y_spin_button.set_text ("1")
			select_item_y_spin_button.value_range.adapt (create {INTEGER_INTERVAL}.make (1, 1000000))
			select_item_y_spin_button.set_value (1)
			l_ev_horizontal_box_3.set_padding_width (box_padding)
			l_ev_horizontal_box_3.disable_item_expand (clear_selection_button)
			select_row_button.disable_sensitive
			select_row_button.set_text ("Select Row")
			select_column_button.disable_sensitive
			select_column_button.set_text ("Select Column")
			select_item_button.disable_sensitive
			select_item_button.set_text ("Select Item")
			clear_selection_button.set_text ("Clear Selection")
			l_ev_frame_3.set_text ("Selection Queries")
			l_ev_vertical_box_4.set_border_width (box_padding)
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.set_padding_width (box_padding)
			l_ev_horizontal_box_4.disable_item_expand (selected_items_button)
			l_ev_horizontal_box_4.disable_item_expand (selected_rows_button)
			selected_items_button.set_text ("Selected Items")
			selected_rows_button.set_text ("Selected Rows")
			set_padding_width (box_padding)
			set_border_width (box_padding)
			disable_item_expand (l_ev_frame_1)
			disable_item_expand (l_ev_frame_2)
			disable_item_expand (l_ev_frame_3)
			
				--Connect events.
			single_item_selection_button.select_actions.extend (agent single_item_selection_button_selected)
			single_row_selection_button.select_actions.extend (agent single_row_selection_button_selected)
			multiple_item_selection_button.select_actions.extend (agent multiple_item_selection_button_selected)
			multiple_row_selection_button.select_actions.extend (agent multiple_row_selection_button_selected)
			selection_on_click.select_actions.extend (agent selection_on_click_selected)
			always_selected_button.select_actions.extend (agent always_selected_button_selected)
			select_item_x_spin_button.change_actions.extend (agent item_x_position_changed (?))
			select_item_y_spin_button.change_actions.extend (agent item_y_position_changed (?))
			select_row_button.select_actions.extend (agent select_row_button_selected)
			select_column_button.select_actions.extend (agent select_column_button_selected)
			select_item_button.select_actions.extend (agent select_item_button_selected)
			clear_selection_button.select_actions.extend (agent clear_selection_button_selected)
			selected_items_button.select_actions.extend (agent selected_items_button_selected)
			selected_rows_button.select_actions.extend (agent selected_rows_button_selected)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	select_item_x_spin_button, select_item_y_spin_button: EV_SPIN_BUTTON
	selection_on_click, always_selected_button: EV_CHECK_BUTTON
	single_item_selection_button,
	single_row_selection_button, multiple_item_selection_button, multiple_row_selection_button: EV_RADIO_BUTTON
	item_finder: GRID_ITEM_FINDER
	select_row_button,
	select_column_button, select_item_button, clear_selection_button, selected_items_button,
	selected_rows_button: EV_BUTTON

feature {NONE} -- Implementation

	l_ev_table_1: EV_TABLE
	l_ev_vertical_box_1, l_ev_vertical_box_2, l_ev_vertical_box_3, l_ev_vertical_box_4: EV_VERTICAL_BOX
	l_ev_horizontal_box_1,
	l_ev_horizontal_box_2, l_ev_horizontal_box_3, l_ev_horizontal_box_4: EV_HORIZONTAL_BOX
	l_ev_frame_1,
	l_ev_frame_2, l_ev_frame_3: EV_FRAME
	l_ev_cell_1, l_ev_cell_2: EV_CELL

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
	
	single_item_selection_button_selected is
			-- Called by `select_actions' of `single_item_selection_button'.
		deferred
		end
	
	single_row_selection_button_selected is
			-- Called by `select_actions' of `single_row_selection_button'.
		deferred
		end
	
	multiple_item_selection_button_selected is
			-- Called by `select_actions' of `multiple_item_selection_button'.
		deferred
		end
	
	multiple_row_selection_button_selected is
			-- Called by `select_actions' of `multiple_row_selection_button'.
		deferred
		end
	
	selection_on_click_selected is
			-- Called by `select_actions' of `selection_on_click'.
		deferred
		end
	
	always_selected_button_selected is
			-- Called by `select_actions' of `always_selected_button'.
		deferred
		end
	
	item_x_position_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `select_item_x_spin_button'.
		deferred
		end
	
	item_y_position_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `select_item_y_spin_button'.
		deferred
		end
	
	select_row_button_selected is
			-- Called by `select_actions' of `select_row_button'.
		deferred
		end
	
	select_column_button_selected is
			-- Called by `select_actions' of `select_column_button'.
		deferred
		end
	
	select_item_button_selected is
			-- Called by `select_actions' of `select_item_button'.
		deferred
		end
	
	clear_selection_button_selected is
			-- Called by `select_actions' of `clear_selection_button'.
		deferred
		end
	
	selected_items_button_selected is
			-- Called by `select_actions' of `selected_items_button'.
		deferred
		end
	
	selected_rows_button_selected is
			-- Called by `select_actions' of `selected_rows_button'.
		deferred
		end
	

end -- class SELECTION_TAB_IMP
