indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MAIN_WINDOW_IMP

inherit
	EV_TITLED_WINDOW
		redefine
			initialize, is_in_default_state
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}
			
				-- Create all widgets.
			create l_menu_bar_1
			create file_menu
			create file_generate
			create l_menu_separator_1
			create file_exit
			create help_menu
			create help_about
			create l_vertical_box_1
			create l_horizontal_separator_1
			create l_horizontal_box_1
			create l_tool_bar_1
			create generate_button
			create l_vertical_box_2
			create l_cell_1
			create l_vertical_separator_1
			create l_cell_2
			create l_tool_bar_2
			create properties_button
			create l_tool_bar_3
			create tests_button
			create l_tool_bar_4
			create documentation_button
			create l_horizontal_separator_2
			create main_split_area
			create widget_selector_parent
			create main_box
			create l_label_1
			create main_notebook
			create main_notebook_properties_item
			create l_vertical_box_3
			create scrollable_parent
			create scrollable_widget_area
			create horizontal_spacing_box
			create left_spacing_cell
			create vertical_spacing_box
			create top_spacing_cell
			create widget_holder
			create bottom_spacing_cell
			create right_spacing_cell
			create l_horizontal_box_2
			create l_notebook_1
			create event_output
			create l_horizontal_box_3
			create event_selector_list
			create l_vertical_box_4
			create select_all
			create clear_all
			create l_vertical_box_5
			create object_editor
			create padding_cell
			create main_notebook_tests
			create l_vertical_split_area_1
			create l_horizontal_box_4
			create controller_parent
			create l_horizontal_box_5
			create test_class_display
			create flat_short_display_parent
			create flat_short_display
			create l_horizontal_box_6
			create l_frame_1
			create l_horizontal_box_7
			create search_field
			create search_button
			create match_case_button
			create l_frame_2
			create l_cell_3
			create modify_text_size
			
				-- Build_widget_structure.
			set_menu_bar (l_menu_bar_1)
			l_menu_bar_1.extend (file_menu)
			file_menu.extend (file_generate)
			file_menu.extend (l_menu_separator_1)
			file_menu.extend (file_exit)
			l_menu_bar_1.extend (help_menu)
			help_menu.extend (help_about)
			extend (l_vertical_box_1)
			l_vertical_box_1.extend (l_horizontal_separator_1)
			l_vertical_box_1.extend (l_horizontal_box_1)
			l_horizontal_box_1.extend (l_tool_bar_1)
			l_tool_bar_1.extend (generate_button)
			l_horizontal_box_1.extend (l_vertical_box_2)
			l_vertical_box_2.extend (l_cell_1)
			l_vertical_box_2.extend (l_vertical_separator_1)
			l_vertical_box_2.extend (l_cell_2)
			l_horizontal_box_1.extend (l_tool_bar_2)
			l_tool_bar_2.extend (properties_button)
			l_horizontal_box_1.extend (l_tool_bar_3)
			l_tool_bar_3.extend (tests_button)
			l_horizontal_box_1.extend (l_tool_bar_4)
			l_tool_bar_4.extend (documentation_button)
			l_vertical_box_1.extend (l_horizontal_separator_2)
			l_vertical_box_1.extend (main_split_area)
			main_split_area.extend (widget_selector_parent)
			main_split_area.extend (main_box)
			main_box.extend (l_label_1)
			main_box.extend (main_notebook)
			main_notebook.extend (main_notebook_properties_item)
			main_notebook_properties_item.extend (l_vertical_box_3)
			l_vertical_box_3.extend (scrollable_parent)
			scrollable_parent.extend (scrollable_widget_area)
			scrollable_widget_area.extend (horizontal_spacing_box)
			horizontal_spacing_box.extend (left_spacing_cell)
			horizontal_spacing_box.extend (vertical_spacing_box)
			vertical_spacing_box.extend (top_spacing_cell)
			vertical_spacing_box.extend (widget_holder)
			vertical_spacing_box.extend (bottom_spacing_cell)
			horizontal_spacing_box.extend (right_spacing_cell)
			l_vertical_box_3.extend (l_horizontal_box_2)
			l_horizontal_box_2.extend (l_notebook_1)
			l_notebook_1.extend (event_output)
			l_notebook_1.extend (l_horizontal_box_3)
			l_horizontal_box_3.extend (event_selector_list)
			l_horizontal_box_3.extend (l_vertical_box_4)
			l_vertical_box_4.extend (select_all)
			l_vertical_box_4.extend (clear_all)
			main_notebook_properties_item.extend (l_vertical_box_5)
			l_vertical_box_5.extend (object_editor)
			l_vertical_box_5.extend (padding_cell)
			main_notebook.extend (main_notebook_tests)
			main_notebook_tests.extend (l_vertical_split_area_1)
			l_vertical_split_area_1.extend (l_horizontal_box_4)
			l_horizontal_box_4.extend (controller_parent)
			l_vertical_split_area_1.extend (l_horizontal_box_5)
			l_horizontal_box_5.extend (test_class_display)
			main_notebook.extend (flat_short_display_parent)
			flat_short_display_parent.extend (flat_short_display)
			flat_short_display_parent.extend (l_horizontal_box_6)
			l_horizontal_box_6.extend (l_frame_1)
			l_frame_1.extend (l_horizontal_box_7)
			l_horizontal_box_7.extend (search_field)
			l_horizontal_box_7.extend (search_button)
			l_horizontal_box_7.extend (match_case_button)
			l_horizontal_box_6.extend (l_frame_2)
			l_frame_2.extend (l_cell_3)
			l_cell_3.extend (modify_text_size)
			
				-- Initialize properties of all widgets.
			
			set_minimum_width (800)
			set_minimum_height (600)
			set_title ("Vision2 Tour")
			file_menu.set_text ("File")
			file_generate.set_text ("Generate")
			file_exit.set_text ("Exit")
			help_menu.set_text ("Help")
			help_about.set_text ("About...")
			l_vertical_box_1.disable_item_expand (l_horizontal_separator_1)
			l_vertical_box_1.disable_item_expand (l_horizontal_box_1)
			l_vertical_box_1.disable_item_expand (l_horizontal_separator_2)
			l_horizontal_box_1.disable_item_expand (l_tool_bar_1)
			l_horizontal_box_1.disable_item_expand (l_vertical_box_2)
			l_horizontal_box_1.disable_item_expand (l_tool_bar_2)
			l_horizontal_box_1.disable_item_expand (l_tool_bar_3)
			l_horizontal_box_1.disable_item_expand (l_tool_bar_4)
			generate_button.disable_sensitive
			generate_button.set_text ("Generate")
			generate_button.set_tooltip ("Generate the currently selected test into a stand alone project")
			l_vertical_box_2.disable_item_expand (l_cell_1)
			l_vertical_box_2.disable_item_expand (l_cell_2)
			l_cell_1.set_minimum_height (4)
			l_vertical_separator_1.set_minimum_width (8)
			l_cell_2.set_minimum_height (4)
			properties_button.disable_sensitive
			properties_button.set_text ("properties")
			properties_button.set_tooltip ("Display properties editor for currently selected widget type")
			tests_button.disable_sensitive
			tests_button.set_text ("Tests")
			tests_button.set_tooltip ("Display tests for currently selected widget type")
			documentation_button.disable_sensitive
			documentation_button.set_text ("Documentation")
			documentation_button.set_tooltip ("Display flatshort of currently selected widget class")
			widget_selector_parent.set_minimum_width (150)
			main_box.disable_item_expand (l_label_1)
			l_label_1.align_text_left
			main_notebook.set_item_text (main_notebook_properties_item, "Properties")
			main_notebook.set_item_text (main_notebook_tests, "Tests")
			main_notebook.set_item_text (flat_short_display_parent, "Documentation")
			main_notebook_properties_item.disable_item_expand (l_vertical_box_5)
			l_vertical_box_3.disable_item_expand (scrollable_parent)
			scrollable_widget_area.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (216, 213, 255))
			scrollable_widget_area.set_minimum_width (330)
			scrollable_widget_area.set_minimum_height (330)
			
			scrollable_widget_area.set_item_width (310)
			scrollable_widget_area.set_item_height (310)
			horizontal_spacing_box.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (216, 213, 255))
			horizontal_spacing_box.disable_item_expand (left_spacing_cell)
			horizontal_spacing_box.disable_item_expand (right_spacing_cell)
			left_spacing_cell.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (216, 213, 255))
			left_spacing_cell.set_minimum_width (5)
			left_spacing_cell.set_minimum_height (0)
			vertical_spacing_box.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (216, 213, 255))
			vertical_spacing_box.disable_item_expand (top_spacing_cell)
			vertical_spacing_box.disable_item_expand (bottom_spacing_cell)
			top_spacing_cell.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (216, 213, 255))
			top_spacing_cell.set_minimum_height (5)
			bottom_spacing_cell.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (216, 213, 255))
			bottom_spacing_cell.set_minimum_width (300)
			bottom_spacing_cell.set_minimum_height (5)
			right_spacing_cell.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (216, 213, 255))
			right_spacing_cell.set_minimum_width (5)
			right_spacing_cell.set_minimum_height (310)
			l_notebook_1.set_item_text (event_output, "Output")
			l_notebook_1.set_item_text (l_horizontal_box_3, "Events")
			l_horizontal_box_3.disable_item_expand (l_vertical_box_4)
			event_selector_list.set_minimum_width (150)
			l_vertical_box_4.set_padding_width (10)
			l_vertical_box_4.set_border_width (10)
			l_vertical_box_4.disable_item_expand (select_all)
			l_vertical_box_4.disable_item_expand (clear_all)
			select_all.set_text ("Select All")
			select_all.set_tooltip ("Select all events")
			clear_all.set_text ("Clear All")
			clear_all.set_tooltip ("Clear all events")
			l_vertical_box_5.disable_item_expand (object_editor)
			object_editor.set_border_width (3)
			padding_cell.set_minimum_width (180)
			test_class_display.disable_edit
			flat_short_display_parent.disable_item_expand (l_horizontal_box_6)
			flat_short_display.disable_edit
			l_horizontal_box_6.disable_item_expand (l_frame_2)
			l_frame_1.set_text ("Search")
			l_horizontal_box_7.set_padding_width (10)
			l_horizontal_box_7.set_border_width (2)
			l_horizontal_box_7.disable_item_expand (search_field)
			l_horizontal_box_7.disable_item_expand (search_button)
			l_horizontal_box_7.disable_item_expand (match_case_button)
			search_field.set_text ("Text to be searched")
			search_field.set_minimum_width (120)
			search_button.set_text ("Search")
			search_button.set_tooltip ("Perform Search")
			match_case_button.set_text ("Match Case")
			match_case_button.set_tooltip ("Should next search be case insensitive?")
			l_frame_2.set_text ("Text Size")
			modify_text_size.set_text ("4")
			modify_text_size.value_range.adapt(create {INTEGER_INTERVAL}.make (4, 75))
			modify_text_size.set_value (4)
			
				--Connect events.
			close_request_actions.extend (agent close_test)
			file_generate.select_actions.extend (agent perform_generation)
			file_exit.select_actions.extend (agent close_test)
			help_about.select_actions.extend (agent display_about_dialog)
			generate_button.select_actions.extend (agent perform_generation)
			l_notebook_1.selection_actions.extend (agent clear_events)
			select_all.select_actions.extend (agent select_all_events)
			clear_all.select_actions.extend (agent clear_all_events)
			search_button.select_actions.extend (agent start_search)
			match_case_button.select_actions.extend (agent update_case_matching)
			modify_text_size.change_actions.extend (agent update_text_size (?))
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.
			close_request_actions.extend (agent ((create {EV_ENVIRONMENT}).application).destroy)

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
	
	l_menu_bar_1: EV_MENU_BAR
	file_menu, help_menu: EV_MENU
	file_generate, file_exit, help_about: EV_MENU_ITEM
	l_menu_separator_1: EV_MENU_SEPARATOR
	l_vertical_box_1, l_vertical_box_2, main_box, l_vertical_box_3, vertical_spacing_box, 
	l_vertical_box_4, l_vertical_box_5, object_editor, flat_short_display_parent: EV_VERTICAL_BOX
	l_horizontal_separator_1, l_horizontal_separator_2: EV_HORIZONTAL_SEPARATOR
	l_horizontal_box_1, main_notebook_properties_item, horizontal_spacing_box, l_horizontal_box_2, 
	l_horizontal_box_3, main_notebook_tests, l_horizontal_box_4, l_horizontal_box_5, 
	l_horizontal_box_6, l_horizontal_box_7: EV_HORIZONTAL_BOX
	l_tool_bar_1, l_tool_bar_2, l_tool_bar_3, l_tool_bar_4: EV_TOOL_BAR
	generate_button: EV_TOOL_BAR_BUTTON
	l_cell_1, l_cell_2, widget_selector_parent, left_spacing_cell, top_spacing_cell, 
	widget_holder, bottom_spacing_cell, right_spacing_cell, padding_cell, controller_parent, 
	l_cell_3: EV_CELL
	l_vertical_separator_1: EV_VERTICAL_SEPARATOR
	properties_button, tests_button, documentation_button: EV_TOOL_BAR_TOGGLE_BUTTON
	main_split_area: EV_HORIZONTAL_SPLIT_AREA
	l_label_1: EV_LABEL
	main_notebook, l_notebook_1: EV_NOTEBOOK
	scrollable_parent, l_frame_1, l_frame_2: EV_FRAME
	scrollable_widget_area: EV_SCROLLABLE_AREA
	event_output: EV_LIST
	event_selector_list: EV_CHECKABLE_LIST
	select_all, clear_all, search_button: EV_BUTTON
	l_vertical_split_area_1: EV_VERTICAL_SPLIT_AREA
	test_class_display, flat_short_display: EV_TEXT
	search_field: EV_TEXT_FIELD
	match_case_button: EV_CHECK_BUTTON
	modify_text_size: EV_SPIN_BUTTON
	
	close_test is
			-- Called by `close_request_actions' of `Current'.
		deferred
		end
	
	perform_generation is
			-- Called by `select_actions' of `file_generate'.
		deferred
		end
	
	display_about_dialog is
			-- Called by `select_actions' of `help_about'.
		deferred
		end
	
	clear_events is
			-- Called by `selection_actions' of `l_notebook_1'.
		deferred
		end
	
	select_all_events is
			-- Called by `select_actions' of `select_all'.
		deferred
		end
	
	clear_all_events is
			-- Called by `select_actions' of `clear_all'.
		deferred
		end
	
	start_search is
			-- Called by `select_actions' of `search_button'.
		deferred
		end
	
	update_case_matching is
			-- Called by `select_actions' of `match_case_button'.
		deferred
		end
	
	update_text_size (a_value: INTEGER) is
			-- Called by `change_actions' of `modify_text_size'.
		deferred
		end
	

end -- class MAIN_WINDOW_IMP
