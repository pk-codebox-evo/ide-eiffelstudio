indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_TIP_OF_THE_DAY_DIALOG_IMP

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
		local
			internal_font: EV_FONT
		do
			Precursor {EV_DIALOG}
			initialize_constants
			
			create l_vertical_box_23
			create l_horizontal_box_25
			create l_vertical_box_24
			create l_frame_7
			create l_vertical_box_25
			create l_horizontal_box_26
			create l_pixmap_1
			create l_cell_14
			create l_vertical_box_26
			create l_cell_15
			create l_label_11
			create l_cell_16
			create l_horizontal_box_27
			create l_cell_17
			create tip_label
			create l_cell_18
			create l_cell_19
			create l_horizontal_box_28
			create show_tips_button
			create l_cell_20
			create next_tip_button
			create close_button
			
			extend (l_vertical_box_23)
			l_vertical_box_23.extend (l_horizontal_box_25)
			l_horizontal_box_25.extend (l_vertical_box_24)
			l_vertical_box_24.extend (l_frame_7)
			l_frame_7.extend (l_vertical_box_25)
			l_vertical_box_25.extend (l_horizontal_box_26)
			l_horizontal_box_26.extend (l_pixmap_1)
			l_horizontal_box_26.extend (l_cell_14)
			l_horizontal_box_26.extend (l_vertical_box_26)
			l_vertical_box_26.extend (l_cell_15)
			l_vertical_box_26.extend (l_label_11)
			l_vertical_box_26.extend (l_cell_16)
			l_vertical_box_25.extend (l_horizontal_box_27)
			l_horizontal_box_27.extend (l_cell_17)
			l_horizontal_box_27.extend (tip_label)
			l_horizontal_box_27.extend (l_cell_18)
			l_vertical_box_25.extend (l_cell_19)
			l_vertical_box_23.extend (l_horizontal_box_28)
			l_horizontal_box_28.extend (show_tips_button)
			l_horizontal_box_28.extend (l_cell_20)
			l_horizontal_box_28.extend (next_tip_button)
			l_horizontal_box_28.extend (close_button)
			
			set_title (tip_of_day_dialog_title)
			l_vertical_box_23.set_padding_width (large_spacing_width)
			l_vertical_box_23.set_border_width (large_spacing_width)
			l_vertical_box_23.disable_item_expand (l_horizontal_box_28)
			l_frame_7.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_vertical_box_25.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_vertical_box_25.set_padding_width (5)
			l_vertical_box_25.disable_item_expand (l_horizontal_box_26)
			l_vertical_box_25.disable_item_expand (l_horizontal_box_27)
			l_horizontal_box_26.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_horizontal_box_26.disable_item_expand (l_pixmap_1)
			l_horizontal_box_26.disable_item_expand (l_cell_14)
			l_pixmap_1.set_minimum_width (39)
			l_pixmap_1.set_minimum_height (33)
			l_pixmap_1.copy (lightbulb_png)
			l_cell_14.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_cell_14.set_minimum_width (5)
			l_vertical_box_26.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_vertical_box_26.disable_item_expand (l_label_11)
			l_cell_15.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_label_11.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			create internal_font
			internal_font.set_family (3)
			internal_font.set_weight (7)
			internal_font.set_shape (10)
			internal_font.set_height (19)
			internal_font.preferred_families.extend ("Microsoft Sans Serif")
			l_label_11.set_font (internal_font)
			l_label_11.set_text ("Did you know...")
			l_label_11.align_text_left
			l_cell_16.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_horizontal_box_27.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_horizontal_box_27.disable_item_expand (l_cell_17)
			l_cell_17.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_cell_17.set_minimum_width (20)
			tip_label.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			create internal_font
			internal_font.set_family (3)
			internal_font.set_weight (7)
			internal_font.set_shape (10)
			internal_font.set_height (13)
			internal_font.preferred_families.extend ("Microsoft Sans Serif")
			tip_label.set_font (internal_font)
			tip_label.align_text_left
			l_cell_18.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_cell_18.set_minimum_width (20)
			l_cell_19.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_cell_19.set_minimum_height (10)
			l_horizontal_box_28.set_padding_width (large_spacing_width)
			l_horizontal_box_28.disable_item_expand (show_tips_button)
			l_horizontal_box_28.disable_item_expand (next_tip_button)
			l_horizontal_box_28.disable_item_expand (close_button)
			show_tips_button.set_text ("Show tips at startup")
			next_tip_button.set_text (next_tip_text)
			next_tip_button.set_minimum_width (default_button_width)
			close_button.set_text (close_text)
			close_button.set_minimum_width (default_button_width)
			
			show_actions.extend (agent window_shown)
			next_tip_button.select_actions.extend (agent next_tip_selected)
			close_button.select_actions.extend (agent close_button_selected)
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
	
	l_vertical_box_23, l_vertical_box_24, l_vertical_box_25, l_vertical_box_26: EV_VERTICAL_BOX
	l_horizontal_box_25, l_horizontal_box_26, l_horizontal_box_27, l_horizontal_box_28: EV_HORIZONTAL_BOX
	l_frame_7: EV_FRAME
	l_pixmap_1: EV_PIXMAP
	l_cell_14, l_cell_15, l_cell_16, l_cell_17, l_cell_18, l_cell_19, l_cell_20: EV_CELL
	l_label_11, tip_label: EV_LABEL
	show_tips_button: EV_CHECK_BUTTON
	next_tip_button, close_button: EV_BUTTON
	
	window_shown is
			-- Called by `show_actions' of `gb_tip_of_the_day_dialog'.
		deferred
		end
	
	next_tip_selected is
			-- Called by `select_actions' of `next_tip_button'.
		deferred
		end
	
	close_button_selected is
			-- Called by `select_actions' of `close_button'.
		deferred
		end
	

end -- class GB_TIP_OF_THE_DAY_DIALOG_IMP
