indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NEW_METRIC_PANEL

inherit
	EB_NEW_METRIC_PANEL_IMP

	EB_CONSTANTS
		undefine
			is_equal,
			copy,
			default_create
		end

	QL_SHARED_UNIT
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_METRIC_SHARED
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_METRIC_PANEL
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_SHARED_PREFERENCES
		undefine
			is_equal,
			copy,
			default_create
		end

	EV_SHARED_APPLICATION
		undefine
			is_equal,
			copy,
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make (a_tool: like metric_tool) is
			-- Initialize `metric_tool' with `a_tool'.
		require
			a_tool_attached: a_tool /= Void
		do
			metric_tool := a_tool
			install_agents (metric_tool)
			on_unit_order_change_agent := agent on_unit_order_change
			default_create
			create basic_metric_definition_area.make (metric_tool, Current, new_mode, class_unit)
			create linear_metric_definition_area.make (metric_tool, Current, new_mode, class_unit)
			create ratio_metric_definition_area.make (metric_tool, Current, new_mode, ratio_unit)
			basic_metric_definition_area.change_actions.extend (agent on_metric_changed)
			linear_metric_definition_area.change_actions.extend (agent on_metric_changed)
			ratio_metric_definition_area.change_actions.extend (agent on_metric_changed)
			create metric_editor_table.make (3)
			metric_editor_table.put (basic_metric_definition_area, basic_metric_type)
			metric_editor_table.put (linear_metric_definition_area, linear_metric_type)
			metric_editor_table.put (ratio_metric_definition_area, ratio_metric_type)
			set_is_metric_reloaded (True)
		ensure
			metric_tool_set: metric_tool = a_tool
		end

	metric_editor_table: HASH_TABLE [EB_METRIC_EDITOR, INTEGER]
			-- Table of metric editor
			-- Key is metric type index, value is metric editor

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			create metric_selector.make (False)
			metric_selector.delete_key_pressed_actions.extend (
				agent (a_metric: EB_METRIC)
					do
						if remove_metric_btn.is_sensitive then
							remove_metric
						end
					end
			)
			metric_selector.disable_tooltip_contain_go_to_definition_message
			metric_selector_area.extend (metric_selector)

				-- Initialize toolbar
			new_metric_btn.remove_text
			new_metric_btn.set_pixmap (pixmaps.icon_pixmaps.new_metric_icon)
			new_metric_btn.set_tooltip (metric_names.f_new)

			remove_metric_btn.remove_text
			remove_metric_btn.set_pixmap (pixmaps.icon_pixmaps.general_remove_icon)
			remove_metric_btn.set_tooltip (metric_names.f_remove)

			save_metric_btn.remove_text
			save_metric_btn.set_pixmap (pixmaps.icon_pixmaps.general_save_icon)
			save_metric_btn.set_tooltip (metric_names.f_save)

				-- Setup actions
			new_metric_btn.select_actions.extend (agent on_new_metric_button_pressed)
			metric_selector.metric_selected_actions.extend (agent on_metric_selected)
			save_metric_btn.select_actions.extend (agent on_save_metric)
			remove_metric_btn.select_actions.extend (agent on_remove_metric)

			metric_selector.group_selected_actions.extend (agent on_group_selected)
			save_metric_btn.disable_sensitive
			remove_metric_btn.disable_sensitive

			no_metric_lbl.set_text (metric_names.e_no_metric_is_selected)

			reload_btn.set_pixmap (pixmaps.icon_pixmaps.general_open_icon)
			reload_btn.set_tooltip (metric_names.f_reload_metrics)
			reload_btn.select_actions.extend (agent on_reload_metrics)

			open_metric_file_btn.set_pixmap (pixmaps.icon_pixmaps.command_send_to_external_editor_icon)
			open_metric_file_btn.select_actions.extend (agent on_open_user_defined_metric_file)
			open_metric_file_btn.set_tooltip (metric_names.f_open_metric_file_in_external_editor)

			send_current_to_new_btn.set_pixmap (pixmaps.icon_pixmaps.new_document_icon)
			send_current_to_new_btn.select_actions.extend (agent on_copy_current_metric_to_a_new_metric)
			send_current_to_new_btn.set_tooltip (metric_names.f_create_new_metric_using_current_data)

			import_btn.set_pixmap (pixmaps.icon_pixmaps.metric_export_to_file_icon)
			import_btn.set_tooltip (metric_names.f_import_metrics)
			import_btn.select_actions.extend (agent on_import_metrics)

				-- Delete following in docking EiffelStudio.
			no_metric_area.drop_actions.extend (agent drop_cluster)
			no_metric_area.drop_actions.extend (agent drop_class)
			no_metric_area.drop_actions.extend (agent drop_feature)
			toolbar_area.drop_actions.extend (agent drop_cluster)
			toolbar_area.drop_actions.extend (agent drop_class)
			toolbar_area.drop_actions.extend (agent drop_feature)
			metric_definition_area.drop_actions.extend (agent drop_cluster)
			metric_definition_area.drop_actions.extend (agent drop_class)
			metric_definition_area.drop_actions.extend (agent drop_feature)

			select_metric_lbl.set_text (metric_names.t_select_metric)
			preferences.metric_tool_data.unit_order_preference.change_actions.extend (on_unit_order_change_agent)
		end

feature -- Access

	metric_selector: EB_METRIC_SELECTOR
			-- Metric selector

feature -- Status report

	is_metric_changed: BOOLEAN
			-- Is definition of current metric changed?

feature -- Basic operations

	set_is_metric_changed (b: BOOLEAN) is
			-- Set `is_metric_changed' with `b'.
		do
			is_metric_changed := b
		ensure
			is_metric_changed_set: is_metric_changed = b
		end

	load_metric_definition (a_metric: EB_METRIC; a_type: INTEGER; a_unit: QL_METRIC_UNIT; a_new: BOOLEAN) is
			-- Load `a_metric' definition whose type is `a_type' and unit is `a_unit'.
			-- `a_new' is True indicates that we are creating a new metric.
		require
			a_type_valid: is_metric_type_valid (a_type)
			a_new_valid: not a_new implies a_metric /= Void
			a_unit_attached: a_unit /= Void
		local
			l_mode: INTEGER
			l_uuid_generator: UUID_GENERATOR
			l_editor: EB_METRIC_EDITOR
		do
				-- Decide editor mode: read-only, edit or new.
			if a_new then
				l_mode := new_mode
				set_is_metric_changed (True)
			else
				if a_metric.is_predefined then
					l_mode := readonly_mode
				else
					l_mode := edit_mode
				end
			end
			original_metric := a_metric

				-- Refresh metric definition area.
			l_editor := current_metric_editor
			current_metric_editor := metric_editor_table.item (a_type)
			if l_editor /= current_metric_editor then
				metric_definition_area.wipe_out
				metric_definition_area.extend (current_metric_editor.widget)
			end
			if original_metric /= Void then
				current_metric_editor.initialize_editor (a_metric, l_mode, a_unit, original_metric.uuid)
			else
				create l_uuid_generator
				current_metric_editor.initialize_editor (a_metric, l_mode, a_unit, l_uuid_generator.generate_uuid)
			end
			set_is_up_to_date (False)
			update_ui
		end

	force_drop_stone (a_stone: STONE) is
			-- Force to drop `a_stone' in `domain_selector'.
		do
		end

feature -- Actions

	on_copy_current_metric_to_a_new_metric is
			-- Action to be performed when user wants to copy current edited metric into a new metric
		local
			l_editor: like current_metric_editor
			l_metric: EB_METRIC
		do
			l_editor := current_metric_editor
			if l_editor /= Void then
				l_metric := l_editor.metric
				l_metric.set_name (metric_manager.next_metric_name_with_unit (l_metric.unit))
				metric_selector.remove_selection
				load_metric_definition (l_metric, metric_type_id (l_metric), l_metric.unit, True)
			end
		end

	on_new_metric_button_pressed is
			-- Action to be performed when new metric button is pressed
		local
			l_menu: EV_MENU
		do
			l_menu := new_metric_menu
			l_menu.show_at (new_metric_toolbar, 0, new_metric_toolbar.height - 3)
		end

	on_metric_selected (a_metric: EB_METRIC) is
			-- Action to be performed when a metric is selected
		require
			a_metric_attached: a_metric /= Void
		do
			set_is_metric_changed (False)
			load_metric_definition (a_metric, metric_type_id (a_metric), a_metric.unit, False)
			set_is_up_to_date (False)
			update_ui
		end

	on_save_metric is
			-- Action to be performed when save a metric.
		local
			l_old_metric: EB_METRIC
			l_new_metric: EB_METRIC
			l_dlg: EV_ERROR_DIALOG
			l_ok: BOOLEAN
			l_message: STRING_32
		do
			check current_metric_editor /= Void end
			l_old_metric := original_metric
			l_new_metric := current_metric_editor.metric
			l_ok := True
			if l_new_metric.name.is_empty then
				l_ok := False
				l_message := metric_names.t_metric_name_can_not_be_empty
			elseif
				current_metric_editor.mode = {EB_METRIC_EDITOR}.new_mode and then
				metric_manager.has_metric (l_new_metric.name)
			then
				l_ok := False
				l_message := metric_names.t_metric_with_name.as_string_32 + " %"" + l_new_metric.name + "%" " + metric_names.t_metric_exists
			elseif
				current_metric_editor.mode = {EB_METRIC_EDITOR}.edit_mode and then
				l_old_metric /= Void and then
				not l_old_metric.name.is_case_insensitive_equal (l_new_metric.name) and then
				metric_manager.has_metric (l_new_metric.name)
			then
				l_ok := False
				l_message := metric_names.t_metric_with_name.as_string_32 + " %"" + l_new_metric.name + "%" " + metric_names.t_metric_exists
			end
			if l_ok then
				metric_manager.save_metric (l_new_metric, current_metric_editor.mode = {EB_METRIC_EDITOR}.new_mode, l_old_metric)
				metric_tool.store_metrics
				set_is_metric_changed (False)
				original_metric := l_new_metric
				current_metric_editor.initialize_editor (l_new_metric, {EB_METRIC_EDITOR}.edit_mode, l_new_metric.unit, l_new_metric.uuid)
				set_is_up_to_date (False)
				update_ui
			else
				create l_dlg.make_with_text (l_message + "%N" + metric_names.t_metric_not_saved)
				l_dlg.set_buttons (<<metric_names.t_ok>>)
				l_dlg.show_modal_to_window (metric_tool_window)
			end
		end

	on_create_new_metric (a_type: INTEGER; a_unit: QL_METRIC_UNIT) is
			-- Action to be performed when create a new metric of type `a_type' and unit `a_unit'.
			-- For metric type information, see `basic_metric_type', `linear_metric_type' and `ratio_metric_type'.
		require
			a_type_valid: is_metric_type_valid (a_type)
			a_unit_attached: a_unit /= Void
		do
			metric_selector.remove_selection
			load_metric_definition (Void, a_type, a_unit, True)
		end

	on_remove_metric is
			-- Action to be performed when user wants to remove selected metric
		local
			l_dlg: EB_DISCARDABLE_CONFIRMATION_DIALOG
		do
			check
				original_metric /= Void
				current_metric_editor /= Void
			end
			create l_dlg.make_initialized (
				2, preferences.dialog_data.confirm_remove_metric_string,
				metric_names.t_remove_metric.as_string_32 +  "%"" + current_metric_editor.name_area.name.twin + "%"?",
				metric_names.t_discard_remove_prompt,
				preferences.preferences
			)
			l_dlg.set_ok_action (agent remove_metric)
			l_dlg.show_modal_to_window (metric_tool_window)
		end

	on_group_selected is
			-- Action to be performed when a group in `metric_selector' is selected
		do
		end

	on_metric_changed is
			-- Action to be performed when definition or description of current metric changes
		do
			set_is_metric_changed (True)
			set_is_up_to_date (False)
			update_ui
		ensure
			definition_changed: is_metric_changed
		end

	on_reload_metrics is
			-- Action to be performed when reload metrics
		do
			metric_tool.load_metrics (True, metric_names.t_loading_metrics)
		end

	on_open_user_defined_metric_file is
			-- Action to be performed to open user defined metric file in specified external editor
		local
			l_cmd_exec: COMMAND_EXECUTOR
			l_cmd_string: STRING
		do
			if metric_manager.is_userdefined_metric_file_exist then
				l_cmd_string := preferences.misc_data.external_editor_command.twin
				if not l_cmd_string.is_empty then
					l_cmd_string.replace_substring_all ("$target", metric_manager.userdefined_metrics_file)
					l_cmd_string.replace_substring_all ("$line", "0")
					create l_cmd_exec
					l_cmd_exec.execute (l_cmd_string)
				end
			end
		end

	on_import_metrics is
			-- Action to be performed to import metric definitions from file.
		local
			l_import_dlg: EB_METRIC_IMPORT_DIALOG
		do
			create l_import_dlg.make (metric_tool)
			l_import_dlg.show_modal_to_window (metric_tool_window)
			if l_import_dlg.should_metric_be_refreshed then
				on_reload_metrics
			end
		end

	on_metric_sent_to_history (a_archive: EB_METRIC_ARCHIVE_NODE; a_panel: ANY) is
			-- Action to be performed when metric calculation information contained in `a_archive' has been sent to history
		do
		end

feature{NONE} -- Implementation

	current_metric_editor: EB_METRIC_EDITOR
			-- Current metric editor

	original_metric: EB_METRIC
			-- Current metric

	new_metric_menu: EV_MENU is
			-- Menu for creating new metrics
		local
			l_submenu: EV_MENU
			l_menu_item: EV_MENU_ITEM
			l_unit_list: LIST [TUPLE [l_unit: QL_METRIC_UNIT; l_pixmap: EV_PIXMAP]]
			l_type: INTEGER_REF
			l_new_menu: like new_metric_menu
		do
			if new_metric_menu_internal = Void then
				l_unit_list := unit_list (False)

				create l_new_menu
				create l_submenu.make_with_text (displayed_name (metric_names.l_basic_metric))
				l_submenu.set_data (basic_metric_type)
				l_submenu.set_pixmap (pixmaps.icon_pixmaps.metric_basic_icon)
				l_new_menu.extend (l_submenu)

				create l_submenu.make_with_text (displayed_name (metric_names.l_linear_metric))
				l_submenu.set_data (linear_metric_type)
				l_submenu.set_pixmap (pixmaps.icon_pixmaps.metric_linear_icon)
				l_new_menu.extend (l_submenu)

				from
					l_new_menu.start
				until
					l_new_menu.index > 2
				loop
					l_type ?= l_new_menu.item.data
					from
						l_unit_list.start
					until
						l_unit_list.after
					loop
						l_submenu ?= l_new_menu.item
						create l_menu_item.make_with_text_and_action (unit_name_table.item (l_unit_list.item.l_unit), agent on_create_new_metric (l_type.item, l_unit_list.item.l_unit))
						l_menu_item.set_pixmap (l_unit_list.item.l_pixmap)
						l_submenu.extend (l_menu_item)
						l_unit_list.forth
					end
					l_new_menu.forth
				end
				create l_menu_item.make_with_text_and_action (displayed_name (metric_names.l_ratio_metric), agent on_create_new_metric (ratio_metric_type, ratio_unit))
				l_menu_item.set_pixmap (pixmaps.icon_pixmaps.metric_ratio_icon)
				l_new_menu.extend (l_menu_item)
				new_metric_menu_internal := l_new_menu
			end
			Result := new_metric_menu_internal
		ensure
			result_attached: Result /= Void
		end

	new_metric_menu_internal: like new_metric_menu
			-- Implementation of `new_metric_menu_internal'

	basic_metric_definition_area: EB_BASIC_METRIC_DEFINITION_AREA
			-- Internal basic metric definition area

	linear_metric_definition_area: EB_LINEAR_METRIC_DEFINITION_AREA
			-- Internal linear metric definition area

	ratio_metric_definition_area: EB_RATIO_METRIC_DEFINITION_AREA
			-- Internal ratio metric definition area

	remove_metric is
			-- Remove current editing metric.
		do
			check
				original_metric /= Void
				current_metric_editor /= Void
			end
			metric_manager.remove_metric (original_metric.name)
			current_metric_editor := Void
			original_metric := Void
			metric_tool.store_metrics
--			metric_tool.load_metrics (True, metric_names.t_removing_metrics)
			metric_selector.select_first_metric
		end

feature {NONE} -- Recycle

	internal_recycle is
			-- To be called when the button has became useless.
		do
			preferences.metric_tool_data.unit_order_preference.change_actions.prune_all (on_unit_order_change_agent)
			uninstall_agents (metric_tool)
		end

feature{NONE} -- Actions

	on_project_loaded is
			-- Action to be performed when project loaded
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_project_unloaded is
			-- Action to be performed when project unloaded
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_compile_start is
			-- Action to be performed when Eiffel compilation starts
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_compile_stop is
			-- Action to be performed when Eiffel compilation stops
		do
			set_is_up_to_date (False)
			set_is_metric_reloaded (True)
			update_ui
		end

	on_metric_evaluation_start (a_data: ANY) is
			-- Action to be performed when metric evaluation starts
			-- `a_data' can be the metric tool panel from which metric evaluation starts.
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_metric_evaluation_stop (a_data: ANY) is
			-- Action to be performed when metric evaluation stops
			-- `a_data' can be the metric tool panel from which metric evaluation stops.
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_archive_calculation_start (a_data: ANY) is
			-- Action to be performed when metric archive calculation starts
			-- `a_data' can be the metric tool panel from which metric archive calculation starts.
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_archive_calculation_stop (a_data: ANY) is
			-- Action to be performed when metric archive calculation stops
			-- `a_data' can be the metric tool panel from which metric archive calculation stops.
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_metric_loaded is
			-- Action to be performed when metrics loaded in `metric_manager'
		do
			set_is_metric_reloaded (True)
			set_is_up_to_date (False)
			update_ui
		end

	on_history_recalculation_start (a_data: ANY) is
			-- Action to be performed when archive history recalculation starts
			-- `a_data' can be the metric tool panel from which metric history recalculation starts.
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_history_recalculation_stop (a_data: ANY) is
			-- Action to be performed when archive history recalculation stops
			-- `a_data' can be the metric tool panel from which metric history recalculation stops.
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_metric_renamed (a_old_name, a_new_name: STRING) is
			-- Action to be performed when a metric with `a_old_name' has been renamed to `a_new_name'.
		do
		end

feature{NONE} -- UI Update

	update_ui is
			-- Update interface
		local
			l_metric: EB_METRIC
			l_mode: INTEGER
		do
			if is_selected and then not is_up_to_date then
				if (not is_project_loaded) or is_eiffel_compiling or is_archive_calculating or is_history_recalculationg_running or is_metric_evaluating then
					disable_sensitive
				else
					enable_sensitive
					metric_tool.load_metrics (False, metric_names.t_loading_metrics)
					if not metric_tool.is_metric_validation_checked.item then
						metric_tool.check_metric_validation
					end
					if is_metric_reloaded then
						set_is_metric_reloaded (False)
						metric_selector.load_metrics (False)
						if current_metric_editor /= Void then
							l_mode := current_metric_editor.mode
							inspect
								l_mode
							when {EB_METRIC_EDITOR}.new_mode then
								l_metric := current_metric_editor.metric
								metric_selector.remove_selection
								current_metric_editor.initialize_editor (l_metric, l_mode, l_metric.unit, l_metric.uuid)
							when {EB_METRIC_EDITOR}.readonly_mode then
								if metric_manager.has_metric (original_metric.name) then
									metric_selector.select_metric (original_metric.name)
								else
									metric_definition_area.wipe_out
									metric_definition_area.extend (no_metric_frame)
									current_metric_editor := Void
									original_metric := Void
								end
							when {EB_METRIC_EDITOR}.edit_mode then
								if metric_manager.has_metric (original_metric.name) then
									if is_metric_changed then
										metric_selector.metric_selected_actions.block
										metric_selector.select_metric (original_metric.name)
										metric_selector.metric_selected_actions.resume
										l_metric := current_metric_editor.metric
										original_metric := metric_selector.selected_metric
										current_metric_editor.initialize_editor (l_metric, l_mode, l_metric.unit, l_metric.uuid)
									else
										metric_selector.select_metric (original_metric.name)
									end
								else
									metric_definition_area.wipe_out
									metric_definition_area.extend (no_metric_frame)
									current_metric_editor := Void
									original_metric := Void
									set_is_metric_changed (False)
								end
							end
						end
					end
					if current_metric_editor /= Void then
						if is_metric_changed then
							save_metric_btn.enable_sensitive
							send_current_to_new_btn.disable_sensitive
						else
							save_metric_btn.disable_sensitive
							send_current_to_new_btn.enable_sensitive
						end
						if current_metric_editor.mode = {EB_METRIC_EDITOR}.edit_mode then
							remove_metric_btn.enable_sensitive
						else
							remove_metric_btn.disable_sensitive
						end
					else
						save_metric_btn.disable_sensitive
						remove_metric_btn.disable_dockable
						send_current_to_new_btn.disable_sensitive
					end
				end
				set_is_up_to_date (True)
			end
		end

invariant
	metric_tool_attached: metric_tool /= Void
	basic_metric_definition_area_attached: basic_metric_definition_area /= Void
	linear_metric_defintion_area_attached: linear_metric_definition_area /= Void
	ratio_metric_definition_area_attached: ratio_metric_definition_area /= Void
	metric_editor_table_attached: metric_editor_table /= Void

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
        license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
        licensing_options:	"http://www.eiffel.com/licensing"
        copying: "[
                        This file is part of Eiffel Software's Eiffel Development Environment.
                        
                        Eiffel Software's Eiffel Development Environment is free
                        software; you can redistribute it and/or modify it under
                        the terms of the GNU General Public License as published
                        by the Free Software Foundation, version 2 of the License
                        (available at the URL listed under "license" above).
                        
                        Eiffel Software's Eiffel Development Environment is
                        distributed in the hope that it will be useful,	but
                        WITHOUT ANY WARRANTY; without even the implied warranty
                        of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
                        See the	GNU General Public License for more details.
                        
                        You should have received a copy of the GNU General Public
                        License along with Eiffel Software's Eiffel Development
                        Environment; if not, write to the Free Software Foundation,
                        Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
                ]"
        source: "[
                         Eiffel Software
                         356 Storke Road, Goleta, CA 93117 USA
                         Telephone 805-685-1006, Fax 805-685-6869
                         Website http://www.eiffel.com
                         Customer support http://support.eiffel.com
                ]"


end -- class EB_NEW_METRIC_PANEL

