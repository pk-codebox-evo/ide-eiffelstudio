indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CHARACTER_DIALOG_IMP

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
			create l_ev_notebook_1
			create l_ev_vertical_box_1
			create xml_character_list
			create l_ev_vertical_box_2
			create html_character_list
			create dummy_cancel_button
			
				-- Build_widget_structure.
			extend (l_ev_notebook_1)
			l_ev_notebook_1.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (xml_character_list)
			l_ev_notebook_1.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (html_character_list)
			l_ev_vertical_box_2.extend (dummy_cancel_button)
			
			set_minimum_width (300)
			set_minimum_height (dialog_medium_height)
			set_title ("Special Characters")
			l_ev_notebook_1.set_item_text (l_ev_vertical_box_1, "XML Characters")
			l_ev_notebook_1.set_item_text (l_ev_vertical_box_2, "HTML Characters")
			l_ev_vertical_box_1.set_padding_width (padding_width)
			l_ev_vertical_box_1.set_border_width (border_width)
			l_ev_vertical_box_2.disable_item_expand (dummy_cancel_button)
			dummy_cancel_button.set_text ("Cancel")
			dummy_cancel_button.set_minimum_width (0)
			dummy_cancel_button.set_minimum_height (0)
			
				--Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	l_ev_notebook_1: EV_NOTEBOOK
	l_ev_vertical_box_1, l_ev_vertical_box_2: EV_VERTICAL_BOX
	xml_character_list, html_character_list: EV_MULTI_COLUMN_LIST
	dummy_cancel_button: EV_BUTTON

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
	
end -- class CHARACTER_DIALOG_IMP
