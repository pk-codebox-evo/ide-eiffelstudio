indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PREFERENCES_DIALOG_IMP

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
			create l_ev_frame_1
			create l_ev_vertical_box_2
			create l_ev_notebook_1
			create l_ev_vertical_box_3
			create l_ev_horizontal_box_1
			create l_ev_label_1
			create l_ev_horizontal_separator_1
			create l_ev_horizontal_box_2
			create name_text
			create l_ev_vertical_box_4
			create l_ev_horizontal_box_3
			create l_ev_label_2
			create l_ev_horizontal_separator_2
			create l_ev_horizontal_box_4
			create schema_loc_text
			create browse_schema_bt
			create l_ev_horizontal_box_5
			create l_ev_label_3
			create l_ev_horizontal_separator_3
			create l_ev_horizontal_box_6
			create auto_validate_check
			create l_ev_horizontal_box_7
			create invalid_file_flag_check
			create l_ev_vertical_box_5
			create l_ev_horizontal_box_8
			create l_ev_label_4
			create l_ev_horizontal_separator_4
			create l_ev_horizontal_box_9
			create xsl_loc_text
			create browse_xsl_bt
			create l_ev_horizontal_box_10
			create l_ev_label_5
			create l_ev_horizontal_separator_5
			create l_ev_horizontal_box_11
			create css_loc_text
			create browse_css_bt
			create l_ev_horizontal_box_12
			create l_ev_cell_1
			create apply_bt
			create okay_bt
			create cancel_bt
			
				-- Build_widget_structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (l_ev_notebook_1)
			l_ev_notebook_1.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_label_1)
			l_ev_horizontal_box_1.extend (l_ev_horizontal_separator_1)
			l_ev_vertical_box_3.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (name_text)
			l_ev_notebook_1.extend (l_ev_vertical_box_4)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_label_2)
			l_ev_horizontal_box_3.extend (l_ev_horizontal_separator_2)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (schema_loc_text)
			l_ev_horizontal_box_4.extend (browse_schema_bt)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_5.extend (l_ev_label_3)
			l_ev_horizontal_box_5.extend (l_ev_horizontal_separator_3)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_6)
			l_ev_horizontal_box_6.extend (auto_validate_check)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_7)
			l_ev_horizontal_box_7.extend (invalid_file_flag_check)
			l_ev_notebook_1.extend (l_ev_vertical_box_5)
			l_ev_vertical_box_5.extend (l_ev_horizontal_box_8)
			l_ev_horizontal_box_8.extend (l_ev_label_4)
			l_ev_horizontal_box_8.extend (l_ev_horizontal_separator_4)
			l_ev_vertical_box_5.extend (l_ev_horizontal_box_9)
			l_ev_horizontal_box_9.extend (xsl_loc_text)
			l_ev_horizontal_box_9.extend (browse_xsl_bt)
			l_ev_vertical_box_5.extend (l_ev_horizontal_box_10)
			l_ev_horizontal_box_10.extend (l_ev_label_5)
			l_ev_horizontal_box_10.extend (l_ev_horizontal_separator_5)
			l_ev_vertical_box_5.extend (l_ev_horizontal_box_11)
			l_ev_horizontal_box_11.extend (css_loc_text)
			l_ev_horizontal_box_11.extend (browse_css_bt)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_12)
			l_ev_horizontal_box_12.extend (l_ev_cell_1)
			l_ev_horizontal_box_12.extend (apply_bt)
			l_ev_horizontal_box_12.extend (okay_bt)
			l_ev_horizontal_box_12.extend (cancel_bt)
			
			set_minimum_width (dialog_width)
			set_minimum_height (dialog_height)
			set_title ("Project Settings")
			l_ev_vertical_box_1.set_padding_width (padding_width)
			l_ev_vertical_box_1.set_border_width (border_width)
			l_ev_frame_1.set_text ("Project Settings")
			l_ev_vertical_box_2.set_padding_width (padding_width)
			l_ev_vertical_box_2.set_border_width (border_width)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_12)
			l_ev_notebook_1.set_item_text (l_ev_vertical_box_3, "General")
			l_ev_notebook_1.set_item_text (l_ev_vertical_box_4, "Schema")
			l_ev_notebook_1.set_item_text (l_ev_vertical_box_5, "XSL")
			l_ev_vertical_box_3.set_padding_width (padding_width)
			l_ev_vertical_box_3.set_border_width (border_width)
			l_ev_vertical_box_3.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_vertical_box_3.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_horizontal_box_1.set_padding_width (padding_width)
			l_ev_horizontal_box_1.set_border_width (border_width)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_label_1)
			l_ev_label_1.set_text ("Project Name")
			l_ev_horizontal_box_2.set_padding_width (padding_width)
			l_ev_horizontal_box_2.set_border_width (border_width)
			l_ev_vertical_box_4.set_padding_width (padding_width)
			l_ev_vertical_box_4.set_border_width (border_width)
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_4)
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_5)
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_6)
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_7)
			l_ev_horizontal_box_3.set_padding_width (padding_width)
			l_ev_horizontal_box_3.set_border_width (border_width)
			l_ev_horizontal_box_3.disable_item_expand (l_ev_label_2)
			l_ev_label_2.set_text ("Schema File")
			l_ev_horizontal_box_4.set_padding_width (padding_width)
			l_ev_horizontal_box_4.set_border_width (border_width)
			l_ev_horizontal_box_4.disable_item_expand (browse_schema_bt)
			browse_schema_bt.set_text (button_browse_text)
			browse_schema_bt.set_minimum_width (button_width)
			l_ev_horizontal_box_5.set_padding_width (padding_width)
			l_ev_horizontal_box_5.set_border_width (border_width)
			l_ev_horizontal_box_5.disable_item_expand (l_ev_label_3)
			l_ev_label_3.set_text ("Validation")
			l_ev_horizontal_box_6.set_padding_width (padding_width)
			l_ev_horizontal_box_6.set_border_width (border_width)
			auto_validate_check.set_text ("Auto validate open documents during editing")
			l_ev_horizontal_box_7.set_padding_width (padding_width)
			l_ev_horizontal_box_7.set_border_width (border_width)
			invalid_file_flag_check.set_text ("Flag invalid files in document directory hierarchy")
			l_ev_vertical_box_5.set_padding_width (padding_width)
			l_ev_vertical_box_5.set_border_width (border_width)
			l_ev_vertical_box_5.disable_item_expand (l_ev_horizontal_box_8)
			l_ev_vertical_box_5.disable_item_expand (l_ev_horizontal_box_9)
			l_ev_vertical_box_5.disable_item_expand (l_ev_horizontal_box_10)
			l_ev_vertical_box_5.disable_item_expand (l_ev_horizontal_box_11)
			l_ev_horizontal_box_8.set_padding_width (padding_width)
			l_ev_horizontal_box_8.set_border_width (border_width)
			l_ev_horizontal_box_8.disable_item_expand (l_ev_label_4)
			l_ev_label_4.set_text ("Transform File")
			l_ev_horizontal_box_9.set_padding_width (padding_width)
			l_ev_horizontal_box_9.set_border_width (border_width)
			l_ev_horizontal_box_9.disable_item_expand (browse_xsl_bt)
			browse_xsl_bt.set_text (button_browse_text)
			browse_xsl_bt.set_minimum_width (button_width)
			l_ev_horizontal_box_10.set_padding_width (padding_width)
			l_ev_horizontal_box_10.set_border_width (border_width)
			l_ev_horizontal_box_10.disable_item_expand (l_ev_label_5)
			l_ev_label_5.set_text ("HTML Stylesheet File")
			l_ev_horizontal_box_11.set_padding_width (padding_width)
			l_ev_horizontal_box_11.set_border_width (border_width)
			l_ev_horizontal_box_11.disable_item_expand (browse_css_bt)
			browse_css_bt.set_text (button_browse_text)
			browse_css_bt.set_minimum_width (button_width)
			l_ev_horizontal_box_12.set_padding_width (padding_width)
			l_ev_horizontal_box_12.set_border_width (border_width)
			l_ev_horizontal_box_12.disable_item_expand (apply_bt)
			l_ev_horizontal_box_12.disable_item_expand (okay_bt)
			l_ev_horizontal_box_12.disable_item_expand (cancel_bt)
			apply_bt.set_text (button_apply_text)
			apply_bt.set_minimum_width (button_width)
			okay_bt.set_text (button_ok_text)
			okay_bt.set_minimum_width (button_width)
			cancel_bt.set_text (button_cancel_text)
			cancel_bt.set_minimum_width (button_width)
			
				--Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	l_ev_vertical_box_1, l_ev_vertical_box_2, l_ev_vertical_box_3, l_ev_vertical_box_4, 
	l_ev_vertical_box_5: EV_VERTICAL_BOX
	l_ev_frame_1: EV_FRAME
	l_ev_notebook_1: EV_NOTEBOOK
	l_ev_horizontal_box_1, l_ev_horizontal_box_2, l_ev_horizontal_box_3, l_ev_horizontal_box_4, 
	l_ev_horizontal_box_5, l_ev_horizontal_box_6, l_ev_horizontal_box_7, l_ev_horizontal_box_8, 
	l_ev_horizontal_box_9, l_ev_horizontal_box_10, l_ev_horizontal_box_11, l_ev_horizontal_box_12: EV_HORIZONTAL_BOX
	l_ev_label_1, l_ev_label_2, l_ev_label_3, l_ev_label_4, l_ev_label_5: EV_LABEL
	l_ev_horizontal_separator_1, l_ev_horizontal_separator_2, l_ev_horizontal_separator_3, 
	l_ev_horizontal_separator_4, l_ev_horizontal_separator_5: EV_HORIZONTAL_SEPARATOR
	name_text, schema_loc_text, xsl_loc_text, css_loc_text: EV_TEXT_FIELD
	browse_schema_bt, browse_xsl_bt, browse_css_bt, apply_bt, okay_bt, cancel_bt: EV_BUTTON
	auto_validate_check, invalid_file_flag_check: EV_CHECK_BUTTON
	l_ev_cell_1: EV_CELL

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
	
end -- class PREFERENCES_DIALOG_IMP
