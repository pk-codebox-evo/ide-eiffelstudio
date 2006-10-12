indexing
	description: "[
		Objects that represent an EV_TITLED_WINDOW.
		The original version of this class was generated by EiffelBuild.
		This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
		You should not modify this code by hand, as it will be re-generated every time
		 modifications are made to the project.
		 	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_EVALUATION_PANEL_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			initialize, is_in_default_state
		end

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_BOX}
			
				-- Create all widgets.
			create l_ev_vertical_box_1
			create toolbar_area
			create quick_metric_toolbar
			create quick_metric_btn
			create l_ev_tool_bar_1
			create l_ev_tool_bar_separator_1
			create control_toolbar
			create filter_result_btn
			create run_metric_btn
			create run_with_detail_metric_btn
			create stop_metric_btn
			create l_ev_tool_bar_separator_2
			create value_area
			create metric_value_lbl
			create metric_value_text
			create l_ev_tool_bar_4
			create l_ev_tool_bar_separator_3
			create l_ev_tool_bar_6
			create show_percent_btn
			create l_ev_tool_bar_7
			create auto_go_to_result_btn
			create toolbar_empty_area
			create l_ev_horizontal_split_area_1
			create metric_source_domain_area
			create choose_input_domain_lbl
			create metric_domain_selector_area
			create main_area
			create l_ev_cell_1
			create metric_selection_area
			create l_ev_horizontal_box_1
			create choose_metric_lbl
			create l_ev_cell_2
			create l_ev_horizontal_split_area_2
			create grid_wrapper
			create grid_wrapper_empty_area
			create metric_definition_area
			create quick_metric_empty_area
			create unit_area
			create unit_lbl
			create unit_combo
			create l_ev_tool_bar_8
			create go_to_definition_btn
			create metric_definition_empty_area
			create criterion_area
			create l_ev_horizontal_box_2
			
				-- Build widget structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (toolbar_area)
			toolbar_area.extend (quick_metric_toolbar)
			quick_metric_toolbar.extend (quick_metric_btn)
			toolbar_area.extend (l_ev_tool_bar_1)
			l_ev_tool_bar_1.extend (l_ev_tool_bar_separator_1)
			toolbar_area.extend (control_toolbar)
			control_toolbar.extend (filter_result_btn)
			control_toolbar.extend (run_metric_btn)
			control_toolbar.extend (run_with_detail_metric_btn)
			control_toolbar.extend (stop_metric_btn)
			control_toolbar.extend (l_ev_tool_bar_separator_2)
			toolbar_area.extend (value_area)
			value_area.extend (metric_value_lbl)
			value_area.extend (metric_value_text)
			toolbar_area.extend (l_ev_tool_bar_4)
			l_ev_tool_bar_4.extend (l_ev_tool_bar_separator_3)
			toolbar_area.extend (l_ev_tool_bar_6)
			l_ev_tool_bar_6.extend (show_percent_btn)
			toolbar_area.extend (l_ev_tool_bar_7)
			l_ev_tool_bar_7.extend (auto_go_to_result_btn)
			toolbar_area.extend (toolbar_empty_area)
			l_ev_vertical_box_1.extend (l_ev_horizontal_split_area_1)
			l_ev_horizontal_split_area_1.extend (metric_source_domain_area)
			metric_source_domain_area.extend (choose_input_domain_lbl)
			metric_source_domain_area.extend (metric_domain_selector_area)
			l_ev_horizontal_split_area_1.extend (main_area)
			main_area.extend (l_ev_cell_1)
			main_area.extend (metric_selection_area)
			metric_selection_area.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (choose_metric_lbl)
			l_ev_horizontal_box_1.extend (l_ev_cell_2)
			metric_selection_area.extend (l_ev_horizontal_split_area_2)
			l_ev_horizontal_split_area_2.extend (grid_wrapper)
			l_ev_horizontal_split_area_2.extend (grid_wrapper_empty_area)
			main_area.extend (metric_definition_area)
			metric_definition_area.extend (quick_metric_empty_area)
			metric_definition_area.extend (unit_area)
			unit_area.extend (unit_lbl)
			unit_area.extend (unit_combo)
			unit_area.extend (l_ev_tool_bar_8)
			l_ev_tool_bar_8.extend (go_to_definition_btn)
			unit_area.extend (metric_definition_empty_area)
			metric_definition_area.extend (criterion_area)
			metric_definition_area.extend (l_ev_horizontal_box_2)
			
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
			l_ev_vertical_box_1.set_padding (3)
			l_ev_vertical_box_1.disable_item_expand (toolbar_area)
			toolbar_area.disable_item_expand (quick_metric_toolbar)
			toolbar_area.disable_item_expand (l_ev_tool_bar_1)
			toolbar_area.disable_item_expand (control_toolbar)
			toolbar_area.disable_item_expand (value_area)
			toolbar_area.disable_item_expand (l_ev_tool_bar_4)
			toolbar_area.disable_item_expand (l_ev_tool_bar_6)
			toolbar_area.disable_item_expand (l_ev_tool_bar_7)
			l_ev_tool_bar_1.disable_vertical_button_style
			control_toolbar.disable_vertical_button_style
			value_area.set_padding (3)
			metric_value_lbl.set_text ("Value:")
			metric_value_lbl.align_text_left
			metric_value_text.set_minimum_width (100)
			metric_value_text.set_minimum_height (18)
			l_ev_tool_bar_6.disable_vertical_button_style
			l_ev_tool_bar_7.disable_vertical_button_style
			l_ev_horizontal_split_area_1.disable_item_expand (metric_source_domain_area)
			l_ev_horizontal_split_area_1.enable_item_expand (main_area)
			metric_source_domain_area.set_minimum_width (250)
			metric_source_domain_area.set_minimum_height (0)
			metric_source_domain_area.set_padding (3)
			metric_source_domain_area.disable_item_expand (choose_input_domain_lbl)
			choose_input_domain_lbl.set_text ("Source domain:")
			choose_input_domain_lbl.align_text_left
			metric_domain_selector_area.set_minimum_height (0)
			main_area.set_minimum_width (230)
			main_area.set_minimum_height (0)
			main_area.disable_item_expand (l_ev_cell_1)
			l_ev_cell_1.set_minimum_width (10)
			metric_selection_area.set_minimum_width (250)
			metric_selection_area.set_padding (3)
			metric_selection_area.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.disable_item_expand (choose_metric_lbl)
			choose_metric_lbl.set_text ("Choose metric:")
			l_ev_horizontal_split_area_2.disable_item_expand (grid_wrapper)
			l_ev_horizontal_split_area_2.enable_item_expand (grid_wrapper_empty_area)
			grid_wrapper.set_minimum_width (0)
			grid_wrapper_empty_area.set_minimum_width (20)
			metric_definition_area.set_padding (3)
			metric_definition_area.disable_item_expand (quick_metric_empty_area)
			metric_definition_area.disable_item_expand (unit_area)
			metric_definition_area.disable_item_expand (l_ev_horizontal_box_2)
			quick_metric_empty_area.set_minimum_height (0)
			unit_area.set_padding (3)
			unit_area.disable_item_expand (unit_lbl)
			unit_area.disable_item_expand (unit_combo)
			unit_area.disable_item_expand (l_ev_tool_bar_8)
			unit_lbl.set_text ("Unit:")
			unit_lbl.align_text_left
			unit_combo.set_minimum_width (120)
			unit_combo.disable_edit
			metric_definition_empty_area.set_minimum_width (10)
			criterion_area.set_padding (5)
			l_ev_horizontal_box_2.set_minimum_height (21)
			set_padding (5)
			set_border_width (5)
			
			set_all_attributes_using_constants
			
				-- Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end


feature -- Access

	unit_combo: EV_COMBO_BOX
	toolbar_empty_area, grid_wrapper_empty_area, metric_definition_empty_area: EV_CELL
	quick_metric_toolbar,
	control_toolbar: EV_TOOL_BAR
	quick_metric_btn, filter_result_btn, show_percent_btn, auto_go_to_result_btn: EV_TOOL_BAR_TOGGLE_BUTTON
	run_metric_btn,
	run_with_detail_metric_btn, stop_metric_btn, go_to_definition_btn: EV_TOOL_BAR_BUTTON
	toolbar_area,
	value_area, main_area, grid_wrapper, quick_metric_empty_area, unit_area: EV_HORIZONTAL_BOX
	metric_source_domain_area,
	metric_domain_selector_area, metric_selection_area, metric_definition_area, criterion_area: EV_VERTICAL_BOX
	metric_value_lbl,
	choose_input_domain_lbl, choose_metric_lbl, unit_lbl: EV_LABEL
	metric_value_text: EV_TEXT_FIELD

feature {NONE} -- Implementation

	l_ev_tool_bar_separator_1, l_ev_tool_bar_separator_2, l_ev_tool_bar_separator_3: EV_TOOL_BAR_SEPARATOR
	l_ev_cell_1,
	l_ev_cell_2: EV_CELL
	l_ev_tool_bar_1, l_ev_tool_bar_4, l_ev_tool_bar_6, l_ev_tool_bar_7,
	l_ev_tool_bar_8: EV_TOOL_BAR
	l_ev_horizontal_split_area_1, l_ev_horizontal_split_area_2: EV_HORIZONTAL_SPLIT_AREA
	l_ev_horizontal_box_1,
	l_ev_horizontal_box_2: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1: EV_VERTICAL_BOX

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
	
feature {NONE} -- Constant setting

	set_attributes_using_string_constants is
			-- Set all attributes relying on string constants to the current
			-- value of the associated constant.
		local
			s: STRING_GENERAL
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
					
	string_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [STRING_GENERAL]]]
	string_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], STRING_GENERAL]]
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

end
