indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERROR_DIALOG_IMP

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
			
				-- Create all widgets.
			create l_ev_vertical_box_1
			create l_ev_horizontal_box_1
			create l_ev_label_1
			create l_ev_tool_bar_1
			create back
			create forth
			create errors
			create l_ev_cell_1
			create l_ev_horizontal_box_2
			create error_count
			create l_ev_cell_2
			create ok
			
				-- Build_widget_structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_label_1)
			l_ev_horizontal_box_1.extend (l_ev_tool_bar_1)
			l_ev_tool_bar_1.extend (back)
			l_ev_tool_bar_1.extend (forth)
			l_ev_vertical_box_1.extend (errors)
			l_ev_vertical_box_1.extend (l_ev_cell_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (error_count)
			l_ev_horizontal_box_2.extend (l_ev_cell_2)
			l_ev_horizontal_box_2.extend (ok)
			
			set_minimum_width (dialog_width)
			set_minimum_height (dialog_height)
			set_title ("Error Report")
			l_ev_vertical_box_1.set_padding_width (padding_width)
			l_ev_vertical_box_1.set_border_width (border_width)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_vertical_box_1.disable_item_expand (l_ev_cell_1)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_horizontal_box_1.set_padding_width (padding_width)
			l_ev_horizontal_box_1.set_border_width (border_width)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_tool_bar_1)
			l_ev_label_1.set_text ("The following listed errors occured:")
			l_ev_label_1.set_minimum_height (25)
			l_ev_label_1.align_text_left
			back.set_tooltip ("Back")
			forth.set_tooltip ("Forth")
			l_ev_cell_1.set_minimum_height (4)
			l_ev_horizontal_box_2.set_padding_width (padding_width)
			l_ev_horizontal_box_2.set_border_width (border_width)
			l_ev_horizontal_box_2.disable_item_expand (error_count)
			l_ev_horizontal_box_2.disable_item_expand (ok)
			error_count.align_text_left
			ok.set_text (button_ok_text)
			ok.set_minimum_width (button_width)
			
				--Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	l_ev_vertical_box_1: EV_VERTICAL_BOX
	l_ev_horizontal_box_1, l_ev_horizontal_box_2: EV_HORIZONTAL_BOX
	l_ev_label_1, error_count: EV_LABEL
	l_ev_tool_bar_1: EV_TOOL_BAR
	back, forth: EV_TOOL_BAR_BUTTON
	errors: EV_LIST
	l_ev_cell_1, l_ev_cell_2: EV_CELL
	ok: EV_BUTTON

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
	
end -- class ERROR_DIALOG_IMP
