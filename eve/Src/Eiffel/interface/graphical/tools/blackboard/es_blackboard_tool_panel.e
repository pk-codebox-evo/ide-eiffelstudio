note
	description:
		"Graphical panel for blackboard."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_BLACKBOARD_TOOL_PANEL

inherit
	ES_DOCKABLE_STONABLE_TOOL_PANEL [EV_NOTEBOOK]
		redefine
			on_before_initialize,
			on_after_initialized,
			internal_recycle,
			create_mini_tool_bar_items
		end

	EBB_SHARED_BLACKBOARD

	EBB_SHARED_LOG

	EB_CLUSTER_MANAGER_OBSERVER
		export {NONE} all end

	EV_SHARED_APPLICATION
		export {NONE} all end

create {ES_BLACKBOARD_TOOL}
	make

feature {NONE} -- Initialization

	on_before_initialize
			-- <Precursor>
		do
			manager.extend (Current)

			log_cell.put (create {ES_BLACKBOARD_LOG})
		end

	on_after_initialized
			-- <Precursor>
		do
			propagate_drop_actions (Void)

				-- Register events
			if blackboard.is_initialized then
				blackboard.data.update_from_universe
				overview_panel.update_blackboard_data
			else
				blackboard.data_initialized_event.subscribe (agent overview_panel.update_blackboard_data)
			end

			blackboard.data_changed_event.subscribe (agent overview_panel.update_blackboard_data)
			blackboard.tool_execution_changed_event.subscribe (agent progress_panel.update_display)

			create update_task.make (agent overview_panel.update_blackboard_data, 5000)
			update_task.start
			rota.run_task (update_task)
			create update_progress_panel_task.make (agent progress_panel.update_display, 200)
		end

	create_widget: EV_NOTEBOOK
			-- <Precursor>
		do
			create Result
		end

	create_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_button: SD_TOOL_BAR_BUTTON
		do
		end

	create_mini_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display on the window title
		local
			l_button: SD_TOOL_BAR_BUTTON
			l_toggle_button: SD_TOOL_BAR_TOGGLE_BUTTON
			l_menu: EV_MENU
			l_menu_item: EV_MENU_ITEM
		do
			create Result.make (10)

			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.debug_run_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.debug_run_icon)
			l_button.set_tooltip ("Start verification assistant")
			register_action (l_button.select_actions, agent on_start_control_clicked)
			Result.extend (l_button)
			start_control_button := l_button

			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.debug_stop_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.debug_stop_icon)
			l_button.set_tooltip ("Stop verification assistant")
			l_button.disable_sensitive
			register_action (l_button.select_actions, agent on_stop_control_clicked)
			Result.extend (l_button)
			stop_control_button := l_button

			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

			create l_menu.make_with_text ("a")
			create l_menu_item.make_with_text ("b")
			l_menu.extend (l_menu_item)
			create l_menu_item.make_with_text ("c")
			l_menu.extend (l_menu_item)

			create filter_button.make
			filter_button.set_pixmap (stock_pixmaps.metric_filter_icon)
			filter_button.set_pixel_buffer (stock_pixmaps.metric_filter_icon_buffer)
			filter_button.set_tooltip (interface_names.f_filter_warnings)
			filter_button.set_popup_widget (create {ES_WARNINGS_FILTER_WIDGET}.make)
--			filter_button.set_popup_widget (filter_widget)
			Result.extend (filter_button)

			create class_name_text
			class_name_text.set_minimum_width_in_characters (7)
			class_name_text.key_release_actions.force_extend (agent do overview_panel.set_class_name_filter (class_name_text.text) end)
			Result.extend (create {SD_TOOL_BAR_RESIZABLE_ITEM}.make (class_name_text))

			create feature_name_text
			feature_name_text.set_minimum_width_in_characters (7)
			feature_name_text.key_release_actions.force_extend (agent do overview_panel.set_feature_name_filter (feature_name_text.text) end)
			Result.extend (create {SD_TOOL_BAR_RESIZABLE_ITEM}.make (feature_name_text))

				-- clear button
			create l_button.make
			l_button.set_pixmap (stock_mini_pixmaps.general_delete_icon)
			l_button.pointer_button_press_actions.force_extend (
				agent
					do
						class_name_text.set_text ("")
						overview_panel.set_class_name_filter ("")
						feature_name_text.set_text ("")
						overview_panel.set_feature_name_filter ("")
					end
				)
			Result.extend (l_button)

			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
		end

	build_tool_interface (root_widget: EV_NOTEBOOK)
			-- <Precursor>
		do
			create overview_panel.make (develop_window)
			create progress_panel.make
			create configuration_panel.make

			user_widget.selection_actions.extend (agent on_panel_selected)

			user_widget.extend (overview_panel.grid)
			user_widget.extend (progress_panel.grid)
			user_widget.extend (configuration_panel.panel)

			user_widget.item_tab (overview_panel.grid).set_text ("Overview")
			user_widget.item_tab (overview_panel.grid).set_pixmap (stock_pixmaps.general_information_icon)

			user_widget.item_tab (progress_panel.grid).set_text ("Progress")
			user_widget.item_tab (progress_panel.grid).set_pixmap (stock_pixmaps.debug_run_icon)

			user_widget.item_tab (configuration_panel.panel).set_text ("Configuration")
			user_widget.item_tab (configuration_panel.panel).set_pixmap (stock_pixmaps.tool_preferences_icon)
		end

feature -- Access

	overview_panel: ES_BLACKBOARD_OVERVIEW_PANEL
			-- Panel for system overview.

	progress_panel: ES_BLACKBOARD_PROGRESS_PANEL
			-- Panel displaying current progress.

	configuration_panel: ES_BLACKBOARD_CONFIGURATION_PANEL
			-- Panel for configuring blackboard.

	start_control_button: SD_TOOL_BAR_BUTTON
			-- Button to start control.

	stop_control_button: SD_TOOL_BAR_BUTTON
			-- Button to stop control.

	filter_button: SD_TOOL_BAR_POPUP_BUTTON
			-- Button to open filter settings.

	class_name_text: EV_TEXT_FIELD
			-- Text field to enter class name filter.

	feature_name_text: EV_TEXT_FIELD
			-- Text field to enter feature name filter.

feature -- Status report

feature {NONE} -- Event handlers

	on_panel_selected
		do
			update_task.cancel
			update_progress_panel_task.cancel
			if user_widget.selected_item = overview_panel.grid then
				overview_panel.update_blackboard_data
				update_task.start
				rota.run_task (update_task)
			elseif user_widget.selected_item = progress_panel.grid then
				progress_panel.update_display
				update_progress_panel_task.start
				rota.run_task (update_progress_panel_task)
			end
		end

	on_start_control_clicked
			--
		do
			blackboard.control.start

			start_control_button.disable_sensitive
			stop_control_button.enable_sensitive
		end

	on_stop_control_clicked
			--
		do
			blackboard.control.stop

			start_control_button.enable_sensitive
			stop_control_button.disable_sensitive
		end

feature {NONE} -- Implementation

	frozen rota: ROTA_S
			-- Access to rota service.
		local
			l_service_consumer: SERVICE_CONSUMER [ROTA_S]
		once
			create l_service_consumer
			if l_service_consumer.is_service_available then
				Result := l_service_consumer.service
			else
				check False end
			end
		ensure
			result_attached: Result /= Void
		end

	update_task: ROTA_TIMED_AGENT_TASK
			-- Task to update display periodically.

	update_progress_panel_task: ROTA_TIMED_AGENT_TASK
			-- Task to update progress panel periodically.

	show_attributes_session_id: STRING_8 = "com.eiffel.eve.blackboard.show_attributes"
	control_session_id: STRING_8 = "com.eiffel.eve.blackboard.control"
			-- Session IDs

feature {NONE} -- Events

	on_stone_changed (a_old_stone: detachable like stone)
			-- <Precursor>
		do
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			manager.prune (Current)
			update_task.cancel
			Precursor
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
