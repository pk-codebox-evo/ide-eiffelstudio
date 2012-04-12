note
	description: "[
		Objects that represent an EV_TITLED_WINDOW.
		The original version of this class was generated by EiffelBuild.
		This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
		You should not modify this code by hand, as it will be re-generated every time
		 modifications are made to the project.
		 	]"
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EWEASEL_WINDOW_IMP

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects, initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

feature {NONE}-- Initialization

	frozen initialize
			-- Initialize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}
			initialize_constants

			
				-- Build widget structure.
			set_menu_bar (l_ev_menu_bar_1)
			l_ev_menu_bar_1.extend (l_ev_menu_2)
			l_ev_menu_2.extend (configuration_menu_item)
			l_ev_menu_2.extend (save_menu_item)
			l_ev_menu_2.extend (save_as_menu_item)
			l_ev_menu_2.extend (l_ev_menu_separator_1)
			l_ev_menu_2.extend (recent_menu_item)
			l_ev_menu_2.extend (l_ev_menu_separator_2)
			l_ev_menu_2.extend (exit_menu_item)
			extend (l_ev_vertical_split_area_1)
			l_ev_vertical_split_area_1.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_notebook_1)
			l_ev_notebook_1.extend (test_list_box)
			test_list_box.extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (tests_list)
			l_ev_vertical_box_2.extend (test_description_label)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_cell_1)
			l_ev_horizontal_box_1.extend (test_load_button)
			l_ev_horizontal_box_1.extend (tests_save_button)
			l_ev_horizontal_box_1.extend (tests_run_button)
			l_ev_notebook_1.extend (options_box)
			options_box.extend (l_ev_frame_2)
			l_ev_frame_2.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (l_ev_label_1)
			l_ev_horizontal_box_2.extend (platform_combo_box)
			platform_combo_box.extend (win64_combo_item)
			platform_combo_box.extend (windows_combo_item)
			platform_combo_box.extend (unix_combo_item)
			platform_combo_box.extend (dotnet_combo_item)
			l_ev_vertical_box_3.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_label_2)
			l_ev_horizontal_box_3.extend (include_directory_text_field)
			l_ev_horizontal_box_3.extend (include_directory_browse_button)
			l_ev_vertical_box_3.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (l_ev_label_3)
			l_ev_horizontal_box_4.extend (control_file_text_field)
			l_ev_horizontal_box_4.extend (control_file_browse_button)
			l_ev_vertical_box_3.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_5.extend (l_ev_label_4)
			l_ev_horizontal_box_5.extend (ise_eiffel_var_text_field)
			l_ev_horizontal_box_5.extend (ise_eiffel_var_browse_button)
			l_ev_vertical_box_3.extend (l_ev_horizontal_box_6)
			l_ev_horizontal_box_6.extend (l_ev_label_5)
			l_ev_horizontal_box_6.extend (eweasel_directory_text_field)
			l_ev_horizontal_box_6.extend (eweasel_directory_browse_button)
			options_box.extend (l_ev_frame_3)
			l_ev_frame_3.extend (l_ev_vertical_box_4)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_7)
			l_ev_horizontal_box_7.extend (l_ev_label_6)
			l_ev_horizontal_box_7.extend (test_output_directory_text_field)
			l_ev_horizontal_box_7.extend (test_output_directory_browse_button)
			l_ev_vertical_box_4.extend (l_ev_vertical_box_5)
			l_ev_vertical_box_5.extend (keep_check_button)
			l_ev_vertical_box_5.extend (keep_options_radio_box)
			keep_options_radio_box.extend (all_test_keep_radio)
			keep_options_radio_box.extend (passed_test_keep_radio)
			keep_options_radio_box.extend (failed_test_keep_radio)
			l_ev_vertical_box_4.extend (l_ev_vertical_box_6)
			l_ev_vertical_box_6.extend (keep_eifgen_check_buttons)
			l_ev_vertical_split_area_1.extend (l_ev_vertical_box_7)
			l_ev_vertical_box_7.extend (l_ev_frame_4)
			l_ev_frame_4.extend (l_ev_vertical_box_8)
			l_ev_vertical_box_8.extend (output_text)
			l_ev_vertical_box_8.extend (l_ev_horizontal_box_8)
			l_ev_horizontal_box_8.extend (l_ev_cell_2)
			l_ev_horizontal_box_8.extend (clear_output_button)
			l_ev_horizontal_box_8.extend (save_output_button)

			l_ev_menu_2.set_text ("File")
			configuration_menu_item.set_text ("Load configuration..")
			save_menu_item.disable_sensitive
			save_menu_item.set_text ("Save configuration")
			save_as_menu_item.set_text ("Save configuration as..")
			recent_menu_item.set_text ("Recent")
			exit_menu_item.set_text ("Exit")
			l_ev_vertical_split_area_1.enable_item_expand (l_ev_vertical_box_7)
			l_ev_vertical_split_area_1.disable_item_expand (l_ev_vertical_box_1)
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_1.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_1.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			l_ev_notebook_1.set_item_text (test_list_box, "Test")
			l_ev_notebook_1.set_item_text (options_box, "Configuration")
			integer_constant_set_procedures.extend (agent test_list_box.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent test_list_box.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			l_ev_frame_1.set_text ("Tests")
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_2.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_2.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			l_ev_vertical_box_2.disable_item_expand (test_description_label)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_1)
			tests_list.set_minimum_height (150)
			test_description_label.align_text_left
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_1.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_1.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			l_ev_horizontal_box_1.disable_item_expand (test_load_button)
			l_ev_horizontal_box_1.disable_item_expand (tests_save_button)
			l_ev_horizontal_box_1.disable_item_expand (tests_run_button)
			test_load_button.set_text ("Load..")
			integer_constant_set_procedures.extend (agent test_load_button.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent button_width)
			tests_save_button.set_text ("Save..")
			integer_constant_set_procedures.extend (agent tests_save_button.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent button_width)
			tests_run_button.set_text ("Run")
			integer_constant_set_procedures.extend (agent tests_run_button.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent button_width)
			options_box.set_minimum_height (0)
			integer_constant_set_procedures.extend (agent options_box.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent options_box.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			options_box.disable_item_expand (l_ev_frame_2)
			options_box.disable_item_expand (l_ev_frame_3)
			l_ev_frame_2.set_text ("Compile options")
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_3.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_3.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			l_ev_vertical_box_3.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_vertical_box_3.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_vertical_box_3.disable_item_expand (l_ev_horizontal_box_4)
			l_ev_vertical_box_3.disable_item_expand (l_ev_horizontal_box_5)
			l_ev_vertical_box_3.disable_item_expand (l_ev_horizontal_box_6)
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_2.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_2.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_1)
			l_ev_horizontal_box_2.disable_item_expand (platform_combo_box)
			l_ev_label_1.set_text ("Platform ")
			platform_combo_box.set_minimum_width (80)
			platform_combo_box.disable_edit
			win64_combo_item.set_text ("win64")
			windows_combo_item.set_text ("windows")
			unix_combo_item.set_text ("unix")
			dotnet_combo_item.set_text ("dotnet")
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_3.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_3.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			l_ev_horizontal_box_3.disable_item_expand (l_ev_label_2)
			l_ev_horizontal_box_3.disable_item_expand (include_directory_browse_button)
			l_ev_label_2.set_text ("Include directory ")
			include_directory_browse_button.set_text ("Browse..")
			integer_constant_set_procedures.extend (agent include_directory_browse_button.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent button_width)
			l_ev_horizontal_box_4.set_padding (2)
			l_ev_horizontal_box_4.set_border_width (5)
			l_ev_horizontal_box_4.disable_item_expand (l_ev_label_3)
			l_ev_horizontal_box_4.disable_item_expand (control_file_browse_button)
			l_ev_label_3.set_text ("Initial control file ")
			control_file_browse_button.set_text ("Browse..")
			control_file_browse_button.set_minimum_width (80)
			l_ev_horizontal_box_5.set_padding (2)
			l_ev_horizontal_box_5.set_border_width (5)
			l_ev_horizontal_box_5.disable_item_expand (l_ev_label_4)
			l_ev_horizontal_box_5.disable_item_expand (ise_eiffel_var_browse_button)
			l_ev_label_4.set_text ("ISE_EIFFEL ")
			ise_eiffel_var_browse_button.set_text ("Browse..")
			ise_eiffel_var_browse_button.set_minimum_width (80)
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_6.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_6.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			l_ev_horizontal_box_6.disable_item_expand (l_ev_label_5)
			l_ev_horizontal_box_6.disable_item_expand (eweasel_directory_browse_button)
			l_ev_label_5.set_text ("EWEASEL ")
			eweasel_directory_browse_button.set_text ("Browse..")
			eweasel_directory_browse_button.set_minimum_width (80)
			l_ev_frame_3.set_text ("Output options")
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_4.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_4.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_7)
			l_ev_vertical_box_4.disable_item_expand (l_ev_vertical_box_5)
			l_ev_vertical_box_4.disable_item_expand (l_ev_vertical_box_6)
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_7.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_7.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			l_ev_horizontal_box_7.disable_item_expand (l_ev_label_6)
			l_ev_horizontal_box_7.disable_item_expand (test_output_directory_browse_button)
			l_ev_label_6.set_text ("Create test directories in ")
			test_output_directory_browse_button.set_text ("Browse..")
			integer_constant_set_procedures.extend (agent test_output_directory_browse_button.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent button_width)
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_5.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_5.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			keep_check_button.set_text ("Keep test directories after execution")
			keep_options_radio_box.disable_sensitive
			integer_constant_set_procedures.extend (agent keep_options_radio_box.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent keep_options_radio_box.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			keep_options_radio_box.disable_item_expand (all_test_keep_radio)
			keep_options_radio_box.disable_item_expand (passed_test_keep_radio)
			keep_options_radio_box.disable_item_expand (failed_test_keep_radio)
			all_test_keep_radio.set_text ("All tests")
			passed_test_keep_radio.set_text ("Passed tests")
			failed_test_keep_radio.set_text ("Failed tests")
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_6.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_6.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			keep_eifgen_check_buttons.set_text ("Keep test EIFGEN directories")
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_7.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_7.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			l_ev_frame_4.set_text ("Output")
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_8.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_8.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			l_ev_vertical_box_8.disable_item_expand (l_ev_horizontal_box_8)
			output_text.disable_edit
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_8.set_padding (?))
			integer_constant_retrieval_functions.extend (agent padding_width)
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_8.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent border_width)
			l_ev_horizontal_box_8.disable_item_expand (clear_output_button)
			l_ev_horizontal_box_8.disable_item_expand (save_output_button)
			clear_output_button.set_text ("Clear")
			integer_constant_set_procedures.extend (agent clear_output_button.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent button_width)
			save_output_button.set_text ("Save")
			integer_constant_set_procedures.extend (agent save_output_button.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent button_width)
			set_minimum_width (700)
			set_minimum_height (600)
			set_title ("Eweasel")

			set_all_attributes_using_constants
			
				-- Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.
			close_request_actions.extend (agent destroy_and_exit_if_last)

				-- Call `user_initialization'.
			user_initialization
		end
		
	frozen create_interface_objects
			-- Create objects
		do
			
				-- Create all widgets.
			create l_ev_menu_bar_1
			create l_ev_menu_2
			create configuration_menu_item
			create save_menu_item
			create save_as_menu_item
			create l_ev_menu_separator_1
			create recent_menu_item
			create l_ev_menu_separator_2
			create exit_menu_item
			create l_ev_vertical_split_area_1
			create l_ev_vertical_box_1
			create l_ev_notebook_1
			create test_list_box
			create l_ev_frame_1
			create l_ev_vertical_box_2
			create tests_list
			create test_description_label
			create l_ev_horizontal_box_1
			create l_ev_cell_1
			create test_load_button
			create tests_save_button
			create tests_run_button
			create options_box
			create l_ev_frame_2
			create l_ev_vertical_box_3
			create l_ev_horizontal_box_2
			create l_ev_label_1
			create platform_combo_box
			create win64_combo_item
			create windows_combo_item
			create unix_combo_item
			create dotnet_combo_item
			create l_ev_horizontal_box_3
			create l_ev_label_2
			create include_directory_text_field
			create include_directory_browse_button
			create l_ev_horizontal_box_4
			create l_ev_label_3
			create control_file_text_field
			create control_file_browse_button
			create l_ev_horizontal_box_5
			create l_ev_label_4
			create ise_eiffel_var_text_field
			create ise_eiffel_var_browse_button
			create l_ev_horizontal_box_6
			create l_ev_label_5
			create eweasel_directory_text_field
			create eweasel_directory_browse_button
			create l_ev_frame_3
			create l_ev_vertical_box_4
			create l_ev_horizontal_box_7
			create l_ev_label_6
			create test_output_directory_text_field
			create test_output_directory_browse_button
			create l_ev_vertical_box_5
			create keep_check_button
			create keep_options_radio_box
			create all_test_keep_radio
			create passed_test_keep_radio
			create failed_test_keep_radio
			create l_ev_vertical_box_6
			create keep_eifgen_check_buttons
			create l_ev_vertical_box_7
			create l_ev_frame_4
			create l_ev_vertical_box_8
			create output_text
			create l_ev_horizontal_box_8
			create l_ev_cell_2
			create clear_output_button
			create save_output_button

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
			user_create_interface_objects
		end


feature -- Access

	configuration_menu_item, save_menu_item, save_as_menu_item, exit_menu_item: EV_MENU_ITEM
	recent_menu_item: EV_MENU
	test_list_box,
	options_box, keep_options_radio_box: EV_VERTICAL_BOX
	tests_list: EV_MULTI_COLUMN_LIST
	test_description_label: EV_LABEL
	test_load_button,
	tests_save_button, tests_run_button, include_directory_browse_button, control_file_browse_button,
	ise_eiffel_var_browse_button, eweasel_directory_browse_button, test_output_directory_browse_button,
	clear_output_button, save_output_button: EV_BUTTON
	platform_combo_box: EV_COMBO_BOX
	win64_combo_item, windows_combo_item,
	unix_combo_item, dotnet_combo_item: EV_LIST_ITEM
	include_directory_text_field, control_file_text_field,
	ise_eiffel_var_text_field, eweasel_directory_text_field, test_output_directory_text_field: EV_TEXT_FIELD
	keep_check_button,
	keep_eifgen_check_buttons: EV_CHECK_BUTTON
	all_test_keep_radio, passed_test_keep_radio, failed_test_keep_radio: EV_RADIO_BUTTON
	output_text: EV_RICH_TEXT

feature {NONE} -- Implementation

	l_ev_menu_bar_1: EV_MENU_BAR
	l_ev_menu_2: EV_MENU
	l_ev_menu_separator_1, l_ev_menu_separator_2: EV_MENU_SEPARATOR
	l_ev_vertical_split_area_1: EV_VERTICAL_SPLIT_AREA
	l_ev_vertical_box_1,
	l_ev_vertical_box_2, l_ev_vertical_box_3, l_ev_vertical_box_4, l_ev_vertical_box_5,
	l_ev_vertical_box_6, l_ev_vertical_box_7, l_ev_vertical_box_8: EV_VERTICAL_BOX
	l_ev_notebook_1: EV_NOTEBOOK
	l_ev_frame_1,
	l_ev_frame_2, l_ev_frame_3, l_ev_frame_4: EV_FRAME
	l_ev_horizontal_box_1, l_ev_horizontal_box_2,
	l_ev_horizontal_box_3, l_ev_horizontal_box_4, l_ev_horizontal_box_5, l_ev_horizontal_box_6,
	l_ev_horizontal_box_7, l_ev_horizontal_box_8: EV_HORIZONTAL_BOX
	l_ev_cell_1, l_ev_cell_2: EV_CELL
	l_ev_label_1,
	l_ev_label_2, l_ev_label_3, l_ev_label_4, l_ev_label_5, l_ev_label_6: EV_LABEL

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := True
		end

	user_create_interface_objects
			-- Feature for custom user interface object creation, called at end of `create_interface_objects'.
		deferred
		end

	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end

feature {NONE} -- Constant setting

	frozen set_attributes_using_string_constants
			-- Set all attributes relying on string constants to the current
			-- value of the associated constant.
		local
			s: detachable STRING_32
		do
			from
				string_constant_set_procedures.start
			until
				string_constant_set_procedures.off
			loop
				string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).call (Void)
				s := string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).last_result
				if s /= Void then
					string_constant_set_procedures.item.call ([s])
				end
				string_constant_set_procedures.forth
			end
		end

	frozen set_attributes_using_integer_constants
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

	frozen set_attributes_using_pixmap_constants
			-- Set all attributes relying on pixmap constants to the current
			-- value of the associated constant.
		local
			p: detachable EV_PIXMAP
		do
			from
				pixmap_constant_set_procedures.start
			until
				pixmap_constant_set_procedures.off
			loop
				pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).call (Void)
				p := pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).last_result
				if p /= Void then
					pixmap_constant_set_procedures.item.call ([p])
				end
				pixmap_constant_set_procedures.forth
			end
		end

	frozen set_attributes_using_font_constants
			-- Set all attributes relying on font constants to the current
			-- value of the associated constant.
		local
			f: detachable EV_FONT
		do
			from
				font_constant_set_procedures.start
			until
				font_constant_set_procedures.off
			loop
				font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).call (Void)
				f := font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).last_result
				if f /= Void then
					font_constant_set_procedures.item.call ([f])
				end
				font_constant_set_procedures.forth
			end	
		end

	frozen set_attributes_using_color_constants
			-- Set all attributes relying on color constants to the current
			-- value of the associated constant.
		local
			c: detachable EV_COLOR
		do
			from
				color_constant_set_procedures.start
			until
				color_constant_set_procedures.off
			loop
				color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).call (Void)
				c := color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).last_result
				if c /= Void then
					color_constant_set_procedures.item.call ([c])
				end
				color_constant_set_procedures.forth
			end
		end

	frozen set_all_attributes_using_constants
			-- Set all attributes relying on constants to the current
			-- calue of the associated constant.
		do
			set_attributes_using_string_constants
			set_attributes_using_integer_constants
			set_attributes_using_pixmap_constants
			set_attributes_using_font_constants
			set_attributes_using_color_constants
		end
	
	string_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [READABLE_STRING_GENERAL]]]
	string_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], STRING_32]]
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

	frozen integer_from_integer (an_integer: INTEGER): INTEGER
			-- Return `an_integer', used for creation of
			-- an agent that returns a fixed integer value.
		do
			Result := an_integer
		end

end
