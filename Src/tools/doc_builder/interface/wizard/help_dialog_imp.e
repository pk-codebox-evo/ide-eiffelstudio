indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HELP_DIALOG_IMP

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
			create l_ev_horizontal_box_1
			create l_ev_label_1
			create l_ev_horizontal_box_2
			create l_ev_label_2
			create l_ev_horizontal_separator_1
			create l_ev_horizontal_box_3
			create l_ev_vertical_box_3
			create html_radio
			create vs_radio
			create web_radio
			create l_ev_horizontal_box_4
			create l_ev_label_3
			create l_ev_horizontal_separator_2
			create l_ev_horizontal_box_5
			create l_ev_label_4
			create title_text1
			create l_ev_horizontal_box_6
			create l_ev_label_5
			create location_text
			create browse_proj1
			create l_ev_horizontal_box_7
			create l_ev_label_6
			create l_ev_horizontal_separator_3
			create l_ev_vertical_box_4
			create toc_view_check
			create l_ev_cell_1
			create l_ev_horizontal_box_8
			create l_ev_cell_2
			create back_but
			create next
			create cancel_but
			
				-- Build_widget_structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_label_1)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (l_ev_label_2)
			l_ev_horizontal_box_2.extend (l_ev_horizontal_separator_1)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (html_radio)
			l_ev_vertical_box_3.extend (vs_radio)
			l_ev_vertical_box_3.extend (web_radio)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (l_ev_label_3)
			l_ev_horizontal_box_4.extend (l_ev_horizontal_separator_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_5.extend (l_ev_label_4)
			l_ev_horizontal_box_5.extend (title_text1)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_6)
			l_ev_horizontal_box_6.extend (l_ev_label_5)
			l_ev_horizontal_box_6.extend (location_text)
			l_ev_horizontal_box_6.extend (browse_proj1)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_7)
			l_ev_horizontal_box_7.extend (l_ev_label_6)
			l_ev_horizontal_box_7.extend (l_ev_horizontal_separator_3)
			l_ev_vertical_box_2.extend (l_ev_vertical_box_4)
			l_ev_vertical_box_4.extend (toc_view_check)
			l_ev_vertical_box_2.extend (l_ev_cell_1)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_8)
			l_ev_horizontal_box_8.extend (l_ev_cell_2)
			l_ev_horizontal_box_8.extend (back_but)
			l_ev_horizontal_box_8.extend (next)
			l_ev_horizontal_box_8.extend (cancel_but)
			
			set_minimum_width (dialog_width)
			set_minimum_height (dialog_height)
			set_title ("Help Generation Wizard")
			l_ev_vertical_box_1.set_padding_width (padding_width)
			l_ev_vertical_box_1.set_border_width (border_width)
			l_ev_frame_1.set_text ("Help Type")
			l_ev_vertical_box_2.set_padding_width (padding_width)
			l_ev_vertical_box_2.set_border_width (border_width)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_4)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_5)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_6)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_7)
			l_ev_vertical_box_2.disable_item_expand (l_ev_vertical_box_4)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_8)
			l_ev_horizontal_box_1.set_border_width (10)
			l_ev_label_1.set_text ("To create a help system please select from the options below")
			l_ev_label_1.align_text_left
			l_ev_horizontal_box_2.set_padding_width (padding_width)
			l_ev_horizontal_box_2.set_border_width (border_width)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_2)
			l_ev_label_2.set_text ("Help Type")
			l_ev_vertical_box_3.set_padding_width (padding_width)
			l_ev_vertical_box_3.set_border_width (inner_border_width)
			l_ev_vertical_box_3.disable_item_expand (html_radio)
			l_ev_vertical_box_3.disable_item_expand (vs_radio)
			l_ev_vertical_box_3.disable_item_expand (web_radio)
			html_radio.set_text ("Microsoft HTML Help 1.x")
			vs_radio.set_text ("Visual Studio Integrated Help (MS Help 2.0)")
			web_radio.set_text ("Web Help")
			l_ev_horizontal_box_4.set_padding_width (padding_width)
			l_ev_horizontal_box_4.set_border_width (border_width)
			l_ev_horizontal_box_4.disable_item_expand (l_ev_label_3)
			l_ev_label_3.set_text ("Generated Help Project")
			l_ev_horizontal_box_5.set_padding_width (padding_width)
			l_ev_horizontal_box_5.set_border_width (border_width)
			l_ev_horizontal_box_5.disable_item_expand (l_ev_label_4)
			l_ev_label_4.set_text ("Title:")
			l_ev_horizontal_box_6.set_padding_width (padding_width)
			l_ev_horizontal_box_6.set_border_width (border_width)
			l_ev_horizontal_box_6.disable_item_expand (l_ev_label_5)
			l_ev_horizontal_box_6.disable_item_expand (browse_proj1)
			l_ev_label_5.set_text ("Location:")
			browse_proj1.set_text (button_browse_text)
			browse_proj1.set_minimum_width (button_width)
			l_ev_horizontal_box_7.set_padding_width (padding_width)
			l_ev_horizontal_box_7.set_border_width (border_width)
			l_ev_horizontal_box_7.disable_item_expand (l_ev_label_6)
			l_ev_label_6.set_text ("Table of Contents%N")
			l_ev_vertical_box_4.set_padding_width (padding_width)
			l_ev_vertical_box_4.set_border_width (inner_border_width)
			toc_view_check.set_text ("Generate from TOC View")
			l_ev_horizontal_box_8.set_padding_width (padding_width)
			l_ev_horizontal_box_8.set_border_width (border_width)
			l_ev_horizontal_box_8.disable_item_expand (back_but)
			l_ev_horizontal_box_8.disable_item_expand (next)
			l_ev_horizontal_box_8.disable_item_expand (cancel_but)
			back_but.set_text (button_back_text)
			back_but.set_minimum_width (button_width)
			next.set_text (button_next_text)
			next.set_minimum_width (button_width)
			cancel_but.set_text (button_cancel_text)
			cancel_but.set_minimum_width (button_width)
			
				--Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	l_ev_vertical_box_1, l_ev_vertical_box_2, l_ev_vertical_box_3, l_ev_vertical_box_4: EV_VERTICAL_BOX
	l_ev_frame_1: EV_FRAME
	l_ev_horizontal_box_1, l_ev_horizontal_box_2, l_ev_horizontal_box_3, l_ev_horizontal_box_4, 
	l_ev_horizontal_box_5, l_ev_horizontal_box_6, l_ev_horizontal_box_7, l_ev_horizontal_box_8: EV_HORIZONTAL_BOX
	l_ev_label_1, l_ev_label_2, l_ev_label_3, l_ev_label_4, l_ev_label_5, l_ev_label_6: EV_LABEL
	l_ev_horizontal_separator_1, l_ev_horizontal_separator_2, l_ev_horizontal_separator_3: EV_HORIZONTAL_SEPARATOR
	html_radio, vs_radio, web_radio: EV_RADIO_BUTTON
	title_text1, location_text: EV_TEXT_FIELD
	browse_proj1, back_but, next, cancel_but: EV_BUTTON
	toc_view_check: EV_CHECK_BUTTON
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
	
end -- class HELP_DIALOG_IMP
