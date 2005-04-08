indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROW_TAB_IMP

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
			create row_finder
			create row_properties_frame
			create l_ev_vertical_box_1
			create l_ev_table_1
			create l_ev_label_1
			create row_index_entry
			create l_ev_label_2
			create row_height_entry
			create l_ev_horizontal_box_2
			create row_selected_button
			create swap_row_button
			
				-- Build_widget_structure.
			extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (row_finder)
			extend (row_properties_frame)
			row_properties_frame.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_table_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (row_selected_button)
			extend (swap_row_button)
			
			row_properties_frame.set_text ("Row Properties")
			l_ev_vertical_box_1.set_padding_width (box_padding)
			l_ev_vertical_box_1.set_border_width (box_padding)
			l_ev_vertical_box_1.disable_item_expand (l_ev_table_1)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_table_1.resize (2, 3)
			l_ev_table_1.set_row_spacing (box_padding)
				-- Insert and position all children of `l_ev_table_1'.
			l_ev_table_1.put_at_position (l_ev_label_1, 1, 1, 1, 1)
			l_ev_table_1.put_at_position (row_index_entry, 2, 1, 1, 1)
			l_ev_table_1.put_at_position (l_ev_label_2, 1, 2, 1, 1)
			l_ev_table_1.put_at_position (row_height_entry, 2, 2, 1, 1)
			l_ev_label_1.set_text ("Row Index")
			row_index_entry.set_text ("10")
			row_index_entry.value_range.adapt (create {INTEGER_INTERVAL}.make (1, 1000000))
			row_index_entry.set_value (10)
			l_ev_label_2.set_text ("Row Height")
			row_height_entry.set_text ("100")
			row_height_entry.value_range.adapt (create {INTEGER_INTERVAL}.make (1, 10000))
			row_height_entry.set_value (100)
			row_selected_button.set_text ("Is Row Selected?")
			swap_row_button.set_text ("Move first selected row past second")
			disable_item_expand (l_ev_horizontal_box_1)
			disable_item_expand (row_properties_frame)
			disable_item_expand (swap_row_button)
			
				--Connect events.
			row_index_entry.change_actions.extend (agent row_index_entry_changed (?))
			row_height_entry.change_actions.extend (agent row_height_entry_changed (?))
			row_selected_button.select_actions.extend (agent row_selected_button_selected)
			swap_row_button.select_actions.extend (agent swap_row_button_selected)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	row_index_entry, row_height_entry: EV_SPIN_BUTTON
	row_selected_button: EV_CHECK_BUTTON
	row_finder: GRID_ITEM_FINDER
	swap_row_button: EV_BUTTON
	row_properties_frame: EV_FRAME

feature {NONE} -- Implementation

	l_ev_vertical_box_1: EV_VERTICAL_BOX
	l_ev_horizontal_box_1, l_ev_horizontal_box_2: EV_HORIZONTAL_BOX
	l_ev_label_1,
	l_ev_label_2: EV_LABEL
	l_ev_table_1: EV_TABLE

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
	
	row_index_entry_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `row_index_entry'.
		deferred
		end
	
	row_height_entry_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `row_height_entry'.
		deferred
		end
	
	row_selected_button_selected is
			-- Called by `select_actions' of `row_selected_button'.
		deferred
		end
	
	swap_row_button_selected is
			-- Called by `select_actions' of `swap_row_button'.
		deferred
		end
	

end -- class ROW_TAB_IMP
