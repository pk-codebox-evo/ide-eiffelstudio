note
	description: "[
		Graphical panel for EiffelStudio's testing tool.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_PANEL

inherit
	ES_DOCKABLE_STONABLE_TOOL_PANEL [EV_VERTICAL_BOX]
		redefine
			on_after_initialized,
			create_right_tool_bar_items
		end

	ES_TOOL_ICONS_PROVIDER_I [ES_TESTING_TOOL_ICONS]
		rename
			tool as tool_descriptor
		export
			{NONE} all
		end

	ES_SHARED_TEST_SERVICE
		export
			{NONE} all
		end

	TEST_SUITE_OBSERVER
		redefine
			on_test_added,
			on_test_removed,
			on_test_result_added,
			on_processor_launched,
			on_processor_stopped,
			on_processor_error
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	TAG_UTILITIES
		export
			{NONE} all
		end

	CONF_ACCESS
		export
			{NONE} all
		end

create {ES_TESTING_TOOL}
	make

feature {NONE} -- Initialization: widgets

	build_tool_interface (a_widget: like create_widget)
			-- <Precursor>
		do
			create split_area
			build_test_tree
			build_notebook
			a_widget.extend (split_area)
		end

	build_test_tree
			-- Initialize `test_tree' and show it in `Current'.
		local
			l_tag_tree: ES_TAG_TREE_GRID [TEST_I]
		do
			create test_tree.make (develop_window, Current)
			l_tag_tree := test_tree.tag_tree

			split_area.set_first (test_tree.widget)
			register_action (l_tag_tree.node_selected_actions, agent on_selection_change (?, True))
			register_action (l_tag_tree.node_deselected_actions, agent on_selection_change (?, False))
		end

	build_notebook
			-- Create `notebook' and add permament tabs.
		local
			l_window: like develop_window
		do
			create notebook
			l_window := develop_window
			check l_window /= Void end
			create outcome_tab.make (l_window)
			notebook.extend (outcome_tab.widget)
			notebook.set_item_text (outcome_tab.widget, outcome_tab.title)
			notebook.item_tab (outcome_tab.widget).set_pixmap (outcome_tab.icon_pixmap)
			split_area.set_second (notebook)
		end

feature {NONE} -- Initialization: widget status

	on_after_initialized
			-- <Precursor>
		local
			l_app: EV_APPLICATION
			l_test_suite: TEST_SUITE_S
			l_service_consumer: SERVICE_CONSUMER [OUTPUT_MANAGER_S]
			l_service: OUTPUT_MANAGER_S
			l_key: UUID
			l_output: ES_EDITOR_OUTPUT_PANE
		do
			Precursor
			if test_suite.is_service_available then
				l_test_suite := test_suite.service
				if l_test_suite.is_interface_usable then
					l_test_suite.test_suite_connection.connect_events (Current)
				end
			end
			propagate_drop_actions (Void)

			update_run_labels

				-- Initialize testing output
			create l_service_consumer
			if l_service_consumer.is_service_available then
				l_service := l_service_consumer.service
				l_key := (create {OUTPUT_MANAGER_KINDS}).testing
				if
					l_service.is_interface_usable and then
					l_service.is_valid_registration_key (l_key) and then
					not l_service.is_output_available (l_key)
				then
					create l_output.make (locale.translation (t_testing_output))
					l_service.register (l_output, l_key)
				end
			end

			l_app := (create {EV_SHARED_APPLICATION}).ev_application
			l_app.add_idle_action_kamikaze (agent split_area.set_proportion (0.5))
		end


feature -- Access: help

	help_context_id: STRING
			-- <Precursor>
		once
			Result := "1d8cc843-238e-feaa-cfa6-629f080ffba7"
		end

feature {NONE} -- Access

	outcome_tab: ES_TESTING_TOOL_OUTCOME_WIDGET
			-- Tab showing details of a selected test

	current_window: EV_WINDOW
			-- <Precursor>
		do
			Result := develop_window.window
		end

feature {NONE} -- Access: widgets

	test_tree: ES_TEST_TREE
			-- Tree showing tag tree for tests

	split_area: EV_VERTICAL_SPLIT_AREA
			-- Splitting area for grid and notebook

	notebook: EV_NOTEBOOK
			-- Notebook for detailed information

	runs_label: EV_LABEL
			-- Label showing number of tests which have been executed

	errors_label: EV_LABEL
			-- Label showing number of tests currently failing

	errors_pixmap: EV_PIXMAP

feature {NONE} -- Access: buttons

	wizard_button: SD_TOOL_BAR_BUTTON
			-- Button for launching test wizard

	run_button: SD_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Button for launching the test executor

	debug_button: SD_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Button for debugging tests

	stop_button: SD_TOOL_BAR_BUTTON
			-- Button for stopping any current test execution

feature {NONE} -- Access: menus

	run_all_menu,
	run_failing_menu,
	run_selected_menu,
	run_filtered_menu: EV_MENU_ITEM
			-- Menu items for running tests in background

	debug_all_menu,
	debug_failing_menu,
	debug_selected_menu,
	debug_filtered_menu: EV_MENU_ITEM
			-- Menu items for debugging tests

feature {NONE} -- Status setting: stones

	on_stone_changed (a_old_stone: detachable like stone)
			-- <Precursor>
		local
			l_filter_text: STRING
			l_is_test_class: BOOLEAN
		do
			if not is_in_stone_synchronization then
				if attached {CLASSI_STONE} stone as l_class_stone and then attached {EIFFEL_CLASS_I} l_class_stone.class_i as l_class then
					create l_filter_text.make (40)
					if l_is_test_class then
						l_filter_text.append ("^class")
					else
						l_filter_text.append ("^covers")
					end
					l_filter_text.append (".*")
					l_filter_text.append ({EC_TAG_TREE_CONSTANTS}.class_prefix)
					l_filter_text.append (l_class_stone.class_name)
					if attached {FEATURE_STONE} stone as l_feature_stone then
						l_filter_text.append ("/")
						l_filter_text.append ({EC_TAG_TREE_CONSTANTS}.feature_prefix)
						l_filter_text.append (l_feature_stone.feature_name)
					end
				elseif attached {CLUSTER_STONE} stone as l_cluster then
					create l_filter_text.make (40)
					if l_cluster.group.is_cluster then
						l_filter_text.append ({EC_TAG_TREE_CONSTANTS}.cluster_prefix)
					elseif l_cluster.group.is_library then
						l_filter_text.append ({EC_TAG_TREE_CONSTANTS}.library_prefix)
					elseif l_cluster.group.is_override then
						l_filter_text.append ({EC_TAG_TREE_CONSTANTS}.override_prefix)
					end
					l_filter_text.append (l_cluster.group.name)
				end
				if l_filter_text /= Void then
					test_tree.set_filter (l_filter_text)
				end
			end
		end

feature {NONE} -- Status settings: widgets

	update_run_labels
			-- Update text in `runs_label' and `errors_label'.
		local
			l_text: STRING_32
			l_ts: TEST_SUITE_S
			l_tool_bar: like right_tool_bar_widget
		do
			if test_suite.is_service_available then
				l_ts := test_suite.service
				create l_text.make (10)
				l_text.append ("Run: ")
				l_text.append_natural_32 (l_ts.count_executed)
				l_text.append_character ('/')
				if l_ts.is_project_initialized then
					l_text.append_integer (l_ts.tests.count)
				else
					l_text.append_integer (0)
				end
				runs_label.set_text (l_text)

				create l_text.make (10)
				l_text.append ("Failing: ")
				l_text.append_natural_32 (l_ts.count_failing)
				errors_label.set_text (l_text)

				if l_ts.count_failing > 0 then
					errors_pixmap.enable_sensitive
					errors_label.enable_sensitive
				else
					errors_pixmap.disable_sensitive
					errors_label.disable_sensitive
				end

				l_tool_bar := right_tool_bar_widget
				if l_tool_bar /= Void then
					l_tool_bar.compute_minimum_size
				end
			end
		end

feature {NONE} -- Events: wizard

	on_launch_wizard
			-- Called when user_widget click on `wizard_button'.
		local
			l_wizard: ES_TEST_WIZARD_MANAGER
		do
			create l_wizard.make (develop_window)
		end

feature {NONE} -- Events: test execution

	on_run_current (a_type: TYPE [TEST_EXECUTOR_I])
			-- Called when user presses `run_button' or `debug_button' directly.
		do
			if test_tree.tag_tree.selected_nodes.is_empty then
				on_run_filtered (a_type)
			else
				on_run_selected (a_type)
			end
		end

	on_run_all (a_type: TYPE [TEST_EXECUTOR_I])
			-- Called when user selects "run all" item of `run_button'.
		do
			launch_executor (Void, a_type)
		end

	on_run_failing (a_type: TYPE [TEST_EXECUTOR_I])
			-- Called when user selectes "run failing" item of `run_button'.
		local
			l_item: TEST_I
			l_list: DS_ARRAYED_LIST [TEST_I]
			l_cursor: DS_LINEAR_CURSOR [TEST_I]
		do
			if test_suite.is_service_available then
				create l_list.make (test_suite.service.tests.count)
				l_cursor := test_suite.service.tests.new_cursor
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					l_item := l_cursor.item
					if l_item.is_outcome_available then
						if l_item.last_outcome.is_fail then
							l_list.force_last (l_item)
						end
					end
					l_cursor.forth
				end
				launch_executor (l_list, a_type)
			end
		end

	on_run_filtered (a_type: TYPE [TEST_EXECUTOR_I])
			-- Called when user selects "run filteres" item of `run_button'.
		local
			l_set: DS_HASH_SET [TEST_I]
		do
			create l_set.make_default
			test_tree.tag_tree.append_items_recursive (l_set)
			launch_executor (l_set, a_type)
		end

	on_run_selected (a_type: TYPE [TEST_EXECUTOR_I])
			-- Called when user selects "run selected" item of `run_button'.
		local
			l_set: DS_HASH_SET [TEST_I]
		do
			create l_set.make_default
			test_tree.tag_tree.selected_nodes.do_all (agent {TAG_TREE_NODE [TEST_I]}.append_items_recursive (l_set))
			launch_executor (l_set, a_type)
		end

	launch_executor (a_list: detachable DS_LINEAR [TEST_I]; a_type: TYPE [TEST_EXECUTOR_I])
			-- Try to run all tests in a given list through the background executor. If of some reason
			-- the tests can not be executed, show an error message.
		local
			l_conf: TEST_EXECUTOR_CONF
		do
			if a_list /= Void then
				create l_conf.make_with_tests (a_list, a_type ~ debug_executor_type)
			else
				create l_conf.make (a_type ~ debug_executor_type)
			end
			launch_processor (a_type, l_conf)
		end

	on_stop
			-- Stop any running test processor
		local
			l_cursor: DS_LINEAR_CURSOR [TEST_PROCESSOR_I]
		do
			if test_suite.is_service_available then
				from
					l_cursor := test_suite.service.processor_registrar.processor_instances (test_suite.service).new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					if l_cursor.item.is_interface_usable and l_cursor.item.is_running then
						l_cursor.item.request_stop
					end
					l_cursor.forth
				end
			end
		end

feature {NONE} -- Events: labels

	on_run_label_select (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tile, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER)
			-- Called when user clicks on `runs_label'.
		do
			test_tree.set_filter (l_outcome_view)
		end

	on_error_label_select (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tile, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER)
			-- Called when user clicks on `errors_label'.
		do
			test_tree.set_filter (l_filter_not_passing)
		end

feature {TEST_SUITE_S} -- Events: test suite

	on_test_added (a_collection: TEST_SUITE_S; a_item: TEST_I)
			-- <Precursor>
		do
			update_run_labels
		end

	on_test_result_added (a_test_suite: TEST_SUITE_S; a_test: TEST_I; a_result: EQA_TEST_RESULT)
			-- <Precursor>
		do
			if outcome_tab.is_active and then outcome_tab.test = a_test then
				outcome_tab.show_test (a_test)
			end
			update_run_labels
		end

	on_test_removed (a_collection: TEST_SUITE_S; a_item: TEST_I)
			-- <Precursor>
		do
			if outcome_tab.is_active and then outcome_tab.test = a_item then
				outcome_tab.remove_test
			end
			update_run_labels
		end

	on_processor_launched (a_test_suite: TEST_SUITE_S; a_processor: TEST_PROCESSOR_I)
			-- <Precursor>
		local
			l_new_tab: ES_TESTING_TOOL_PROCESSOR_WIDGET
			l_found: BOOLEAN
			l_window: like develop_window
		do
			from
				notebook.start
			until
				notebook.after or l_found
			loop
				if attached {ES_TESTING_TOOL_PROCESSOR_WIDGET} notebook.item_for_iteration.data as l_tab then
					if l_tab.processor = a_processor then
						l_found := True
						notebook.item_tab (l_tab.widget).enable_select
					end
				end
				notebook.forth
			end

			if not l_found then
				l_window := develop_window
				check l_window /= Void end
				if attached {TEST_EXECUTOR_I} a_processor as l_executor then
					create {ES_TESTING_TOOL_EXECUTOR_WIDGET} l_new_tab.make (l_executor, l_window)
				elseif attached {TEST_GENERATOR_I} a_processor as l_generator then
					create {ES_TESTING_TOOL_GENERATOR_WIDGET} l_new_tab.make (l_generator, l_window)
				elseif attached {TEST_CREATOR_I} a_processor as l_creator then
					create {ES_TESTING_TOOL_CREATOR_WIDGET} l_new_tab.make (l_creator, l_window)
				end
				if l_new_tab /= Void then
					l_new_tab.widget.set_data (l_new_tab)
					register_kamikaze_action (l_new_tab.close_button.select_actions, agent on_notebook_tab_close (l_new_tab))
					notebook.go_i_th (notebook.count)
					notebook.put_right (l_new_tab.widget)
					notebook.set_item_text (l_new_tab.widget, l_new_tab.title)
					notebook.item_tab (l_new_tab.widget).set_pixmap (l_new_tab.icon_pixmap)
					notebook.item_tab (l_new_tab.widget).enable_select
				end
			end

			if background_executor_type.attempt (a_processor) /= Void then
				run_button.disable_sensitive
			elseif debug_executor_type.attempt (a_processor) /= Void then
				debug_button.disable_sensitive
			end
		end

 	on_processor_stopped (a_test_suite: TEST_SUITE_S; a_processor: TEST_PROCESSOR_I)
 			-- <Precursor>
 		do
 			if background_executor_type.attempt (a_processor) /= Void then
				run_button.enable_sensitive
			elseif debug_executor_type.attempt (a_processor) /= Void then
				debug_button.enable_sensitive
			end
 		end

 	on_processor_error (a_test_suite: TEST_SUITE_S; a_processor: TEST_PROCESSOR_I; a_error: STRING_8; a_token_values: TUPLE)
 			-- <Precursor>
 		do
 			if window_manager.last_focused_window = develop_window then
 					-- Note: remove `as_attached' compiler treats Current as attached
 				prompts.show_error_prompt (locale_formatter.formatted_translation (a_error, a_token_values.as_attached), develop_window.window, Void)
 			end
 		end

feature {NONE} -- Events: tree view

	on_selection_change (a_node: TAG_TREE_NODE [TEST_I]; a_is_selected: BOOLEAN)
			-- Called when item is selected or deselected.
		do
			if test_tree.tag_tree.selected_nodes.is_empty then
				run_selected_menu.disable_sensitive
				debug_selected_menu.disable_sensitive
			else
				run_selected_menu.enable_sensitive
				debug_selected_menu.enable_sensitive
			end
			if a_is_selected and a_node.is_leaf then
				if not outcome_tab.is_active or else outcome_tab.test /= a_node.item then
					outcome_tab.show_test (a_node.item)
				end
				notebook.item_tab (outcome_tab.widget).enable_select
			end
		end

feature {NONE} -- Events: notebook

	on_notebook_tab_close (a_tab: ES_TESTING_TOOL_PROCESSOR_WIDGET)
			-- Called when `close_button' on `a_tab' was pressed.
		local
			l_found: BOOLEAN
		do
			from
				notebook.start
			until
				notebook.after or l_found
			loop
				if notebook.item_for_iteration.data = a_tab then
					notebook.remove
					a_tab.recycle
					l_found := True
				else
					notebook.forth
				end
			end
		end

feature {NONE} -- Factory

	create_widget: EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_menu: EV_MENU
		do
			create Result.make (5)

			create wizard_button.make
			wizard_button.set_tooltip (locale_formatter.translation (tt_wizard))
			wizard_button.set_pixmap (stock_pixmaps.icon_buffer_with_overlay (icons.general_test_icon_buffer, stock_pixmaps.overlay_new_icon_buffer, 0, 0).to_pixmap)
			wizard_button.set_pixel_buffer (stock_pixmaps.icon_buffer_with_overlay (icons.general_test_icon_buffer, stock_pixmaps.overlay_new_icon_buffer, 0, 0))
			register_action (wizard_button.select_actions, agent on_launch_wizard)
--				local
--					l_wizard: ES_TEST_WIZARD_MANAGER
--				do
--					create l_wizard.make (develop_window)
--				end)
			Result.force_last (wizard_button)

			Result.force_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Create run button
			create run_button.make
			run_button.set_tooltip (locale_formatter.translation (f_run_button))
			run_button.set_pixel_buffer (stock_pixmaps.debug_run_icon_buffer)
			run_button.set_pixmap (stock_pixmaps.debug_run_icon)
			register_action (run_button.select_actions, agent on_run_current (background_executor_type))

			create l_menu
			create run_all_menu.make_with_text (locale_formatter.translation (m_run_all))
			register_action (run_all_menu.select_actions, agent on_run_all (background_executor_type))
			l_menu.extend (run_all_menu)
			create run_failing_menu.make_with_text (locale_formatter.translation (m_run_failing))
			register_action (run_failing_menu.select_actions, agent on_run_failing (background_executor_type))
			l_menu.extend (run_failing_menu)
			create run_filtered_menu.make_with_text (locale_formatter.translation (m_run_filtered))
			register_action (run_filtered_menu.select_actions, agent on_run_filtered (background_executor_type))
			l_menu.extend (run_filtered_menu)
			create run_selected_menu.make_with_text (locale_formatter.translation (m_run_selected))
			register_action (run_selected_menu.select_actions, agent on_run_selected (background_executor_type))
			l_menu.extend (run_selected_menu)
			run_button.set_menu (l_menu)

			Result.force_last (run_button)

				-- Create debug button
			create debug_button.make
			debug_button.set_tooltip (locale_formatter.translation (f_debug_button))
			debug_button.set_pixel_buffer (stock_pixmaps.debugger_environment_force_execution_mode_icon_buffer)
			debug_button.set_pixmap (stock_pixmaps.debugger_environment_force_execution_mode_icon)
			register_action (debug_button.select_actions, agent on_run_current (debug_executor_type))

			create l_menu
			create debug_all_menu.make_with_text (locale_formatter.translation (m_debug_all))
			register_action (debug_all_menu.select_actions, agent on_run_all (debug_executor_type))
			l_menu.extend (debug_all_menu)
			create debug_failing_menu.make_with_text (locale_formatter.translation (m_debug_failing))
			register_action (debug_failing_menu.select_actions, agent on_run_failing (debug_executor_type))
			l_menu.extend (debug_failing_menu)
			create debug_filtered_menu.make_with_text (locale_formatter.translation (m_debug_filtered))
			register_action (debug_filtered_menu.select_actions, agent on_run_filtered (debug_executor_type))
			l_menu.extend (debug_filtered_menu)
			create debug_selected_menu.make_with_text (locale_formatter.translation (m_debug_selected))
			register_action (debug_selected_menu.select_actions, agent on_run_selected (debug_executor_type))
			l_menu.extend (debug_selected_menu)
			debug_button.set_menu (l_menu)

			Result.force_last (debug_button)

				-- Create stop button
			create stop_button.make
			stop_button.set_tooltip (locale_formatter.translation (f_stop_button))
			stop_button.set_pixel_buffer (stock_pixmaps.debug_stop_icon_buffer)
			stop_button.set_pixmap (stock_pixmaps.debug_stop_icon)
			register_action (stop_button.select_actions, agent on_stop)
			Result.force_last (stop_button)
		end

	create_right_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_vbox: EV_VERTICAL_BOX
			l_box: EV_HORIZONTAL_BOX
			l_pixmap: EV_PIXMAP
		do
			create Result.make (4)

				-- Runs
			create l_vbox
			l_vbox.extend (create {EV_CELL})

			create l_box
			l_box.set_border_width ({ES_UI_CONSTANTS}.notebook_border)
			l_box.set_padding ({ES_UI_CONSTANTS}.label_horizontal_padding)

			l_pixmap := stock_pixmaps.run_animation_5_icon.twin
			register_action (l_pixmap.pointer_double_press_actions, agent on_run_label_select)

			l_pixmap.set_minimum_size (l_pixmap.width, l_pixmap.height)
			l_box.extend (l_pixmap)

			create runs_label
			runs_label.align_text_left
			register_action (runs_label.pointer_double_press_actions, agent on_run_label_select)
			l_box.extend (runs_label)

			l_vbox.extend (l_box)
			l_vbox.disable_item_expand (l_box)
			l_vbox.extend (create {EV_CELL})
			Result.force_last (create {SD_TOOL_BAR_WIDGET_ITEM}.make (l_vbox))

			Result.force_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Errors
			create l_vbox
			l_vbox.extend (create {EV_CELL})

			create l_box
			l_box.set_border_width ({ES_UI_CONSTANTS}.notebook_border)
			l_box.set_padding ({ES_UI_CONSTANTS}.label_horizontal_padding)

			create errors_pixmap.make_with_pixel_buffer (stock_pixmaps.general_error_icon_buffer)
			errors_pixmap.set_minimum_size (errors_pixmap.width, errors_pixmap.height)
			register_action (errors_pixmap.pointer_double_press_actions, agent on_error_label_select)
			l_box.extend (errors_pixmap)

			create errors_label
			errors_label.align_text_left
			register_action (errors_label.pointer_double_press_actions, agent on_error_label_select)
			l_box.extend (errors_label)

			l_vbox.extend (l_box)
			l_vbox.disable_item_expand (l_box)
			l_vbox.extend (create {EV_CELL})
			Result.force_last (create {SD_TOOL_BAR_WIDGET_ITEM}.make (l_vbox))
		end

feature {NONE} -- Internationalization

	t_testing_output: STRING = "Testing"

	tt_wizard: STRING = "Create new tests"
	f_run_button: STRING = "Run all tests in background"
	f_debug_button: STRING = "Debug all tests in EiffelStudio"
	f_stop_button: STRING = "Stop all execution"

	m_run_all: STRING = "Run all"
	m_run_failing: STRING = "Run failing"
	m_run_filtered: STRING = "Run filtered"
	m_run_selected: STRING = "Run selected"
	m_debug_all: STRING = "Debug all"
	m_debug_failing: STRING = "Debug failing"
	m_debug_filtered: STRING = "Debug filtered"
	m_debug_selected: STRING = "Debug selected"

feature {NONE} -- Constants

	l_outcome_view: STRING = "^outcome/"
	l_filter_not_passing: STRING = "^outcome/ -^outcome/passes/"

invariant
	details_tab_valid: is_initialized implies notebook.has (outcome_tab.widget)

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
