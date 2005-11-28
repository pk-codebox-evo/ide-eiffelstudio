indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_MAIN_CONTAINER_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			initialize, is_in_default_state
		end

	SD_CONSTANTS
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
			create l_ev_cell_1
			create top_bar
			create l_ev_cell_2
			create l_ev_horizontal_box_2
			create left_bar
			create center_area
			create right_bar
			create l_ev_horizontal_box_3
			create l_ev_cell_3
			create bottom_bar
			create l_ev_cell_4

				-- Build_widget_structure.
			extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_cell_1)
			l_ev_horizontal_box_1.extend (top_bar)
			l_ev_horizontal_box_1.extend (l_ev_cell_2)
			extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (left_bar)
			l_ev_horizontal_box_2.extend (center_area)
			l_ev_horizontal_box_2.extend (right_bar)
			extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_cell_3)
			l_ev_horizontal_box_3.extend (bottom_bar)
			l_ev_horizontal_box_3.extend (l_ev_cell_4)

			l_ev_horizontal_box_1.disable_item_expand (l_ev_cell_1)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_cell_2)
			l_ev_cell_1.set_minimum_width (auto_hide_bar_width)
			l_ev_cell_2.set_minimum_width (auto_hide_bar_width)
			l_ev_horizontal_box_2.disable_item_expand (left_bar)
			l_ev_horizontal_box_2.disable_item_expand (right_bar)
			l_ev_horizontal_box_3.disable_item_expand (l_ev_cell_3)
			l_ev_horizontal_box_3.disable_item_expand (l_ev_cell_4)
			l_ev_cell_3.set_minimum_width (auto_hide_bar_width)
			l_ev_cell_4.set_minimum_width (auto_hide_bar_width)
			disable_item_expand (l_ev_horizontal_box_1)
			disable_item_expand (l_ev_horizontal_box_3)

				--Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	top_bar, left_bar, center_area, right_bar, bottom_bar: EV_CELL

feature {NONE} -- Implementation

	l_ev_cell_1, l_ev_cell_2, l_ev_cell_3, l_ev_cell_4: EV_CELL
	l_ev_horizontal_box_1, l_ev_horizontal_box_2,
	l_ev_horizontal_box_3: EV_HORIZONTAL_BOX

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

end -- class SD_MAIN_CONTAINER_IMP
