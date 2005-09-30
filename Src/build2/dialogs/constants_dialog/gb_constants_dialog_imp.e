indexing
	description: "[
		Objects that represent an EV_DIALOG.
		The original version of this class was generated by EiffelBuild.
		This class is the implementation of an EV_DIALOG generated by EiffelBuild.
		You should not modify this code by hand, as it will be re-generated every time
		 modifications are made to the project.
		 	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_CONSTANTS_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_DIALOG}
			initialize_constants
			
				-- Create all widgets.
			create l_ev_vertical_box_1
			create l_ev_horizontal_box_1
			create l_ev_frame_1
			create l_ev_vertical_box_2
			create constants_list
			create l_ev_horizontal_box_2
			create display_all_types
			create l_ev_horizontal_separator_1
			create l_ev_horizontal_box_3
			create l_ev_vertical_box_3
			create l_ev_horizontal_box_4
			create l_ev_cell_1
			create l_ev_label_1
			create type_combo_box
			create string_item
			create integer_item
			create directory_item
			create pixmap_item
			create color_item
			create font_item
			create l_ev_vertical_box_4
			create l_ev_horizontal_box_5
			create l_ev_cell_2
			create l_ev_label_2
			create name_field
			create l_ev_vertical_box_5
			create l_ev_horizontal_box_6
			create l_ev_cell_3
			create l_ev_label_3
			create entry_selection_parent
			create l_ev_cell_4
			create l_ev_horizontal_box_7
			create l_ev_cell_5
			create new_button
			create modify_button
			create remove_button
			create l_ev_vertical_box_6
			create ok_button
			create l_ev_cell_6
			
				-- Build widget structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (constants_list)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (display_all_types)
			l_ev_vertical_box_2.extend (l_ev_horizontal_separator_1)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (l_ev_cell_1)
			l_ev_horizontal_box_4.extend (l_ev_label_1)
			l_ev_vertical_box_3.extend (type_combo_box)
			type_combo_box.extend (string_item)
			type_combo_box.extend (integer_item)
			type_combo_box.extend (directory_item)
			type_combo_box.extend (pixmap_item)
			type_combo_box.extend (color_item)
			type_combo_box.extend (font_item)
			l_ev_horizontal_box_3.extend (l_ev_vertical_box_4)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_5.extend (l_ev_cell_2)
			l_ev_horizontal_box_5.extend (l_ev_label_2)
			l_ev_vertical_box_4.extend (name_field)
			l_ev_horizontal_box_3.extend (l_ev_vertical_box_5)
			l_ev_vertical_box_5.extend (l_ev_horizontal_box_6)
			l_ev_horizontal_box_6.extend (l_ev_cell_3)
			l_ev_horizontal_box_6.extend (l_ev_label_3)
			l_ev_vertical_box_5.extend (entry_selection_parent)
			l_ev_vertical_box_2.extend (l_ev_cell_4)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_7)
			l_ev_horizontal_box_7.extend (l_ev_cell_5)
			l_ev_horizontal_box_7.extend (new_button)
			l_ev_horizontal_box_7.extend (modify_button)
			l_ev_horizontal_box_7.extend (remove_button)
			l_ev_horizontal_box_1.extend (l_ev_vertical_box_6)
			l_ev_vertical_box_6.extend (ok_button)
			l_ev_vertical_box_6.extend (l_ev_cell_6)
			
			create string_constant_set_procedures.make (10)
			create string_constant_retrieval_functions.make (10)
			create integer_constant_set_procedures.make (10)
			create integer_constant_retrieval_functions.make (10)
			create pixmap_constant_set_procedures.make (10)
			create pixmap_constant_retrieval_functions.make (10)
			create integer_interval_constant_retrieval_functions.make (10)
			create integer_interval_constant_set_procedures.make (10)
			create font_constant_set_procedures.make (10)
			create font_constant_retrieval_functions.make (10)
			create pixmap_constant_retrieval_functions.make (10)
			create color_constant_set_procedures.make (10)
			create color_constant_retrieval_functions.make (10)
			l_ev_vertical_box_1.set_padding (10)
			l_ev_vertical_box_1.set_border_width (5)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_vertical_box_6)
			l_ev_frame_1.set_text ("Constants Defined")
			l_ev_vertical_box_2.set_padding (1)
			l_ev_vertical_box_2.set_border_width (2)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_separator_1)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_vertical_box_2.disable_item_expand (l_ev_cell_4)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_7)
			display_all_types.enable_select
			display_all_types.set_text ("Show all types")
			l_ev_horizontal_box_3.enable_homogeneous
			l_ev_horizontal_box_3.set_padding (5)
			l_ev_horizontal_box_3.disable_item_expand (l_ev_vertical_box_3)
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_3.set_padding (?))
			integer_constant_retrieval_functions.extend (agent small_padding)
			l_ev_vertical_box_3.disable_item_expand (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.disable_item_expand (l_ev_cell_1)
			integer_constant_set_procedures.extend (agent l_ev_cell_1.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent small_padding)
			l_ev_label_1.set_text ("Type")
			l_ev_label_1.align_text_left
			type_combo_box.set_text ("DIRECTORY")
			type_combo_box.set_minimum_width (80)
			type_combo_box.disable_edit
			string_item.set_text ("STRING")
			integer_item.set_text ("INTEGER")
			directory_item.enable_select
			directory_item.set_text ("DIRECTORY")
			pixmap_item.set_text ("PIXMAP")
			color_item.set_text ("COLOR")
			font_item.set_text ("FONT")
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_4.set_padding (?))
			integer_constant_retrieval_functions.extend (agent small_padding)
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_5)
			l_ev_horizontal_box_5.disable_item_expand (l_ev_cell_2)
			integer_constant_set_procedures.extend (agent l_ev_cell_2.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent small_padding)
			l_ev_label_2.set_text ("Name")
			l_ev_label_2.align_text_left
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_5.set_padding (?))
			integer_constant_retrieval_functions.extend (agent small_padding)
			l_ev_vertical_box_5.disable_item_expand (l_ev_horizontal_box_6)
			l_ev_horizontal_box_6.disable_item_expand (l_ev_cell_3)
			integer_constant_set_procedures.extend (agent l_ev_cell_3.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent small_padding)
			l_ev_label_3.set_text ("Value")
			l_ev_label_3.align_text_left
			l_ev_cell_4.set_minimum_height (5)
			l_ev_horizontal_box_7.set_padding (5)
			l_ev_horizontal_box_7.disable_item_expand (new_button)
			l_ev_horizontal_box_7.disable_item_expand (modify_button)
			l_ev_horizontal_box_7.disable_item_expand (remove_button)
			string_constant_set_procedures.extend (agent new_button.set_text (?))
			string_constant_retrieval_functions.extend (agent new_button_text)
			integer_constant_set_procedures.extend (agent new_button.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent default_button_width)
			string_constant_set_procedures.extend (agent modify_button.set_text (?))
			string_constant_retrieval_functions.extend (agent modify_button_text)
			integer_constant_set_procedures.extend (agent modify_button.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent default_button_width)
			remove_button.disable_sensitive
			string_constant_set_procedures.extend (agent remove_button.set_text (?))
			string_constant_retrieval_functions.extend (agent remove_button_text)
			integer_constant_set_procedures.extend (agent remove_button.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent default_button_width)
			l_ev_vertical_box_6.set_border_width (10)
			l_ev_vertical_box_6.disable_item_expand (ok_button)
			string_constant_set_procedures.extend (agent ok_button.set_text (?))
			string_constant_retrieval_functions.extend (agent ok_button_text)
			integer_constant_set_procedures.extend (agent ok_button.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent default_button_width)
			set_minimum_width (640)
			set_minimum_height (480)
			string_constant_set_procedures.extend (agent set_title (?))
			string_constant_retrieval_functions.extend (agent constants_dialog_title)
			
			set_all_attributes_using_constants
			
				-- Connect events.
			constants_list.select_actions.extend (agent item_selected_in_list (?))
			constants_list.deselect_actions.extend (agent item_deselected_in_list (?))
			constants_list.column_title_click_actions.extend (agent column_clicked (?))
			constants_list.key_press_actions.extend (agent key_pressed_on_constants_list (?))
			display_all_types.select_actions.extend (agent display_all_types_changed)
			string_item.select_actions.extend (agent string_item_selected)
			integer_item.select_actions.extend (agent integer_item_selected)
			directory_item.select_actions.extend (agent directory_item_selected)
			pixmap_item.select_actions.extend (agent pixmap_item_selected)
			color_item.select_actions.extend (agent color_item_selected)
			font_item.select_actions.extend (agent font_item_selected)
			name_field.change_actions.extend (agent validate_constant_name)
			new_button.select_actions.extend (agent new_button_selected)
			modify_button.select_actions.extend (agent modify_button_selected)
			remove_button.select_actions.extend (agent remove_selected_constant)
			ok_button.select_actions.extend (agent ok_pressed)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end


feature -- Access

	type_combo_box: EV_COMBO_BOX
	string_item, integer_item, directory_item, pixmap_item, color_item,
	font_item: EV_LIST_ITEM
	constants_list: EV_MULTI_COLUMN_LIST
	entry_selection_parent: EV_CELL
	new_button, modify_button, remove_button,
	ok_button: EV_BUTTON
	display_all_types: EV_CHECK_BUTTON
	name_field: EV_TEXT_FIELD

feature {NONE} -- Implementation

	l_ev_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR
	l_ev_cell_1, l_ev_cell_2, l_ev_cell_3, l_ev_cell_4,
	l_ev_cell_5, l_ev_cell_6: EV_CELL
	l_ev_horizontal_box_1, l_ev_horizontal_box_2, l_ev_horizontal_box_3,
	l_ev_horizontal_box_4, l_ev_horizontal_box_5, l_ev_horizontal_box_6, l_ev_horizontal_box_7: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1,
	l_ev_vertical_box_2, l_ev_vertical_box_3, l_ev_vertical_box_4, l_ev_vertical_box_5,
	l_ev_vertical_box_6: EV_VERTICAL_BOX
	l_ev_label_1, l_ev_label_2, l_ev_label_3: EV_LABEL
	l_ev_frame_1: EV_FRAME

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
	
	item_selected_in_list (an_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Called by `select_actions' of `constants_list'.
		deferred
		end
	
	item_deselected_in_list (an_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Called by `deselect_actions' of `constants_list'.
		deferred
		end
	
	column_clicked (a_column: INTEGER) is
			-- Called by `column_title_click_actions' of `constants_list'.
		deferred
		end
	
	key_pressed_on_constants_list (a_key: EV_KEY) is
			-- Called by `key_press_actions' of `constants_list'.
		deferred
		end
	
	display_all_types_changed is
			-- Called by `select_actions' of `display_all_types'.
		deferred
		end
	
	string_item_selected is
			-- Called by `select_actions' of `string_item'.
		deferred
		end
	
	integer_item_selected is
			-- Called by `select_actions' of `integer_item'.
		deferred
		end
	
	directory_item_selected is
			-- Called by `select_actions' of `directory_item'.
		deferred
		end
	
	pixmap_item_selected is
			-- Called by `select_actions' of `pixmap_item'.
		deferred
		end
	
	color_item_selected is
			-- Called by `select_actions' of `color_item'.
		deferred
		end
	
	font_item_selected is
			-- Called by `select_actions' of `font_item'.
		deferred
		end
	
	validate_constant_name is
			-- Called by `change_actions' of `name_field'.
		deferred
		end
	
	new_button_selected is
			-- Called by `select_actions' of `new_button'.
		deferred
		end
	
	modify_button_selected is
			-- Called by `select_actions' of `modify_button'.
		deferred
		end
	
	remove_selected_constant is
			-- Called by `select_actions' of `remove_button'.
		deferred
		end
	
	ok_pressed is
			-- Called by `select_actions' of `ok_button'.
		deferred
		end
	
	
feature {NONE} -- Constant setting

	set_attributes_using_string_constants is
			-- Set all attributes relying on string constants to the current
			-- value of the associated constant.
		local
			s: STRING
		do
			from
				string_constant_set_procedures.start
			until
				string_constant_set_procedures.off
			loop
				string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).call (Void)
				s := string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).last_result
				string_constant_set_procedures.item.call ([s])
				string_constant_set_procedures.forth
			end
		end
		
	set_attributes_using_integer_constants is
			-- Set all attributes relying on integer constants to the current
			-- value of the associated constant.
		local
			i: INTEGER
			arg1, arg2: INTEGER
			int: INTEGER_INTERVAL
		do
			from
				integer_constant_set_procedures.start
			until
				integer_constant_set_procedures.off
			loop
				integer_constant_retrieval_functions.i_th (integer_constant_set_procedures.index).call (Void)
				i := integer_constant_retrieval_functions.i_th (integer_constant_set_procedures.index).last_result
				integer_constant_set_procedures.item.call ([i])
				integer_constant_set_procedures.forth
			end
			from
				integer_interval_constant_retrieval_functions.start
				integer_interval_constant_set_procedures.start
			until
				integer_interval_constant_retrieval_functions.off
			loop
				integer_interval_constant_retrieval_functions.item.call (Void)
				arg1 := integer_interval_constant_retrieval_functions.item.last_result
				integer_interval_constant_retrieval_functions.forth
				integer_interval_constant_retrieval_functions.item.call (Void)
				arg2 := integer_interval_constant_retrieval_functions.item.last_result
				create int.make (arg1, arg2)
				integer_interval_constant_set_procedures.item.call ([int])
				integer_interval_constant_retrieval_functions.forth
				integer_interval_constant_set_procedures.forth
			end
		end
		
	set_attributes_using_pixmap_constants is
			-- Set all attributes relying on pixmap constants to the current
			-- value of the associated constant.
		local
			p: EV_PIXMAP
		do
			from
				pixmap_constant_set_procedures.start
			until
				pixmap_constant_set_procedures.off
			loop
				pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).call (Void)
				p := pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).last_result
				pixmap_constant_set_procedures.item.call ([p])
				pixmap_constant_set_procedures.forth
			end
		end
		
	set_attributes_using_font_constants is
			-- Set all attributes relying on font constants to the current
			-- value of the associated constant.
		local
			f: EV_FONT
		do
			from
				font_constant_set_procedures.start
			until
				font_constant_set_procedures.off
			loop
				font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).call (Void)
				f := font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).last_result
				font_constant_set_procedures.item.call ([f])
				font_constant_set_procedures.forth
			end	
		end
		
	set_attributes_using_color_constants is
			-- Set all attributes relying on color constants to the current
			-- value of the associated constant.
		local
			c: EV_COLOR
		do
			from
				color_constant_set_procedures.start
			until
				color_constant_set_procedures.off
			loop
				color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).call (Void)
				c := color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).last_result
				color_constant_set_procedures.item.call ([c])
				color_constant_set_procedures.forth
			end
		end
		
	set_all_attributes_using_constants is
			-- Set all attributes relying on constants to the current
			-- calue of the associated constant.
		do
			set_attributes_using_string_constants
			set_attributes_using_integer_constants
			set_attributes_using_pixmap_constants
			set_attributes_using_font_constants
			set_attributes_using_color_constants
		end
					
	string_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [STRING]]]
	string_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], STRING]]
	integer_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [INTEGER]]]
	integer_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], INTEGER]]
	pixmap_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_PIXMAP]]]
	pixmap_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], EV_PIXMAP]]
	integer_interval_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], INTEGER]]
	integer_interval_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [INTEGER_INTERVAL]]]
	font_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_FONT]]]
	font_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], EV_FONT]]
	color_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_COLOR]]]
	color_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], EV_COLOR]]
	
	integer_from_integer (an_integer: INTEGER): INTEGER is
			-- Return `an_integer', used for creation of
			-- an agent that returns a fixed integer value.
		do
			Result := an_integer
		end

end -- class GB_CONSTANTS_DIALOG_IMP
