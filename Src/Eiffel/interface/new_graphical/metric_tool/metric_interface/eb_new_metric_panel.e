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

	QL_OBSERVER
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

	EB_RECYCLABLE
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
			default_create
		ensure
			metric_tool_set: metric_tool = a_tool
		end

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

			no_metric_area.drop_actions.extend (agent drop_cluster)
			no_metric_area.drop_actions.extend (agent drop_class)
			no_metric_area.drop_actions.extend (agent drop_feature)

			toolbar_area.drop_actions.extend (agent drop_cluster)
			toolbar_area.drop_actions.extend (agent drop_class)
			toolbar_area.drop_actions.extend (agent drop_feature)

			select_metric_lbl.set_text (metric_names.t_select_metric)
			empty_lbl.set_text ("   ")
		end

feature -- Status report

	is_valid_metric_type (a_type: INTEGER): BOOLEAN is
			-- Is `a_type' a valid metric type?
		do
			Result := a_type = basic_metric_type or a_type = linear_metric_type or a_type = ratio_metric_type
		end

	is_metric_changed: BOOLEAN
			-- Is definition of current metric changed?

	is_current_metric_editor_reusable (a_type: INTEGER): BOOLEAN is
			-- Is `current_metric_editor' reusable for metric of type `a_type'?
		require
			a_type_valid: is_valid_metric_type (a_type)
		do
			if current_metric_editor /= Void then
				Result :=
					(current_metric_editor.is_basic_metric_editor and then a_type = basic_metric_type) or
					(current_metric_editor.is_linear_metric_editor and then a_type = linear_metric_type) or
					(current_metric_editor.is_ratio_metric_editor and then a_type = ratio_metric_type)
			end
		end

feature -- Basic operations

	synchronize_when_compile_start is
			-- Synchronize when Eiffel compilation starts.
		do
			disable_sensitive
		end

	synchronize_when_compile_stop is
			-- Synchronize when Eiffel compilation stops.
		do
			enable_sensitive
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
			load_metric_definition (a_metric, metric_type (a_metric), a_metric.unit, False)
		end

	on_save_metric is
			-- Action to be performed when save a metric.
		local
			l_old_metric: EB_METRIC
			l_new_metric: EB_METRIC
			l_dlg: EV_ERROR_DIALOG
			l_ok: BOOLEAN
			l_message: STRING
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
				l_message := metric_names.t_metric_with_name + " %"" + l_new_metric.name + "%" " + metric_names.t_metric_exists
			elseif
				current_metric_editor.mode = {EB_METRIC_EDITOR}.edit_mode and then
				l_old_metric /= Void and then
				not l_old_metric.name.is_case_insensitive_equal (l_new_metric.name) and then
				metric_manager.has_metric (l_new_metric.name)
			then
				l_ok := False
				l_message := metric_names.t_metric_with_name + " %"" + l_new_metric.name + "%" " + metric_names.t_metric_exists
			end
			if l_ok then
				metric_manager.save_metric (l_new_metric, current_metric_editor.mode = {EB_METRIC_EDITOR}.new_mode, l_old_metric)
				metric_tool.store_metrics
				metric_selector.set_last_selected_metric (l_new_metric.name)
				metric_tool.load_metrics (True, metric_names.t_saving_metrics)
			else
				create l_dlg.make_with_text (l_message + "%N" + metric_names.t_metric_not_saved)
				l_dlg.set_buttons (<<metric_names.t_ok>>)
				l_dlg.show_modal_to_window (metric_tool_window)
			end
		end

	on_select is
			-- Action to be performed when current is selected
		do
			if not is_selected then
				set_is_selected (True)
			end
			if not is_up_to_date then
				metric_selector.load_metrics (True)
				metric_selector.try_to_selected_last_metric
				if metric_selector.selected_metric = Void then
					metric_definition_area.wipe_out
					metric_definition_area.extend (no_metric_frame)
					save_metric_btn.disable_sensitive
					remove_metric_btn.disable_sensitive
					current_metric_editor := Void
				end
				if last_update_request = compilation_start_update_request then
						-- This is an update when Eiffel compilation starts.
					synchronize_when_compile_start
				else
						-- This is an update when Eiffel compilation stops.
					synchronize_when_compile_stop
				end
				set_is_up_to_date (True)
			end
		end

	on_create_new_metric (a_type: INTEGER; a_unit: QL_METRIC_UNIT) is
			-- Action to be performed when create a new metric of type `a_type' and unit `a_unit'.
			-- For metric type information, see `basic_metric_type', `linear_metric_type' and `ratio_metric_type'.
		require
			a_type_valid: is_valid_metric_type (a_type)
			a_unit_attached: a_unit /= Void
		do
			metric_selector.remove_selection
			load_metric_definition (Void, a_type, a_unit, True)
		end

	on_remove_metric is
			-- Action to be performed when user wants to remove selected metric
		local
			l_dlg: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			check
				original_metric /= Void
				current_metric_editor /= Void
			end
			create l_dlg.make_initialized (
				2, preferences.dialog_data.confirm_remove_metric_string,
				metric_names.t_remove_metric +  "%"" + current_metric_editor.name_area.name.twin + "%"?",
				metric_names.t_discard_remove_prompt,
				preferences.preferences
			)
			l_dlg.set_ok_action (agent remove_metric)
			l_dlg.show_modal_to_window (metric_tool_window)
		end

	remove_metric is
			-- Remove current editing metric.
		do
			check
				original_metric /= Void
				current_metric_editor /= Void
			end
			metric_manager.remove_metric (original_metric.name)
			metric_tool.store_metrics
			metric_selector.select_first_metric
			metric_tool.load_metrics (True, metric_names.t_removing_metrics)
		end

	on_group_selected is
			-- Action to be performed when a group in `metric_selector' is selected
		do
			remove_metric_btn.disable_sensitive
		end

	on_metric_changed is
			-- Action to be performed when definition or description of current metric changes
		do
			is_metric_changed := True
			save_metric_btn.enable_sensitive
		ensure
			definition_changed: is_metric_changed
		end

	on_reload_metrics is
			-- Action to be performed when reload metrics
		do
			metric_tool.load_metrics (True, metric_names.t_loading_metrics)
			metric_tool.check_metric_validation
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

feature -- Basic operations

	load_metric_definition (a_metric: EB_METRIC; a_type: INTEGER; a_unit: QL_METRIC_UNIT; a_new: BOOLEAN) is
			-- Load `a_metric' definition whose type is `a_type' and unit is `a_unit'.
			-- `a_new' is True indicates that we are creating a new metric.
		require
			a_type_valid: is_valid_metric_type (a_type)
			a_new_valid: not a_new implies a_metric /= Void
			a_unit_attached: a_unit /= Void
		local
			l_mode: INTEGER
			l_uuid_generator: UUID_GENERATOR
		do
				-- Decide editor mode: read-only, edit or new.
			if a_new then
				l_mode := new_mode
			else
				if a_metric.is_predefined then
					l_mode := readonly_mode
				else
					l_mode := edit_mode
				end
			end
			is_metric_changed := (l_mode = new_mode)

				-- Synchronize interface.
			inspect
				l_mode
			when new_mode then
				save_metric_btn.enable_sensitive
				remove_metric_btn.disable_sensitive
			when readonly_mode then
				save_metric_btn.disable_sensitive
				remove_metric_btn.disable_sensitive
			when edit_mode then
				save_metric_btn.disable_sensitive
				remove_metric_btn.enable_sensitive
			end
			original_metric := a_metric
				-- Refresh metric definition area.
			if not is_current_metric_editor_reusable (a_type) then
				current_metric_editor := new_metric_editor (a_type)
				current_metric_editor.change_actions.extend (agent on_metric_changed)
				metric_definition_area.wipe_out
				metric_definition_area.extend (current_metric_editor.widget)
			end
			if original_metric /= Void then
				current_metric_editor.initialize_editor (a_metric, l_mode, a_unit, original_metric.uuid)
			else
				create l_uuid_generator
				current_metric_editor.initialize_editor (a_metric, l_mode, a_unit, l_uuid_generator.generate_uuid)
			end
		end

	metric_type (a_metric: EB_METRIC): INTEGER is
			-- Type name of `a_metric'
		require
			a_metric_attached: a_metric /= Void
		do
			if a_metric.is_basic then
				Result := basic_metric_type
			elseif a_metric.is_linear then
				Result := linear_metric_type
			elseif a_metric.is_ratio then
				Result := ratio_metric_type
			end
		end

feature -- Notification

	update (a_observable: QL_OBSERVABLE; a_data: ANY) is
			-- Notification from `a_observable' indicating that `a_data' changed.
		local
			l_data: BOOLEAN_REF
		do
			set_is_up_to_date (False)
			if a_data /= Void then
				l_data ?= a_data
				check l_data /= Void end
				if l_data /= Void then
					if l_data.item then
							-- This is an update when Eiffel compilation starts.
						set_last_update_request (compilation_start_update_request)
					else
							-- This is an update when Eiffel compilation stops.
						set_last_update_request (compilation_stop_update_request)
					end
				end
			end
			if is_selected then
				on_select
			end
		end

feature -- Access

	metric_selector: EB_METRIC_SELECTOR
			-- Metric selector

feature{NONE} -- Access

	new_basic_metric_panel: EB_BASIC_METRIC_DEFINITION_AREA

	current_metric_editor: EB_METRIC_EDITOR
			-- Current metric editor

	original_metric: EB_METRIC
			-- Current metric

feature{NONE} -- Implementation

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
				create l_submenu.make_with_text (displayed_name (metric_names.t_basic) + " metric")
				l_submenu.set_data (basic_metric_type)
				l_submenu.set_pixmap (pixmaps.icon_pixmaps.metric_basic_icon)
				l_new_menu.extend (l_submenu)

				create l_submenu.make_with_text (displayed_name (metric_names.t_linear) + " metric")
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
						create l_menu_item.make_with_text_and_action (displayed_name (l_unit_list.item.l_unit.name), agent on_create_new_metric (l_type.item, l_unit_list.item.l_unit))
						l_menu_item.set_pixmap (l_unit_list.item.l_pixmap)
						l_submenu.extend (l_menu_item)
						l_unit_list.forth
					end
					l_new_menu.forth
				end
				create l_menu_item.make_with_text_and_action (displayed_name (ratio_unit.name + " metric"), agent on_create_new_metric (ratio_metric_type, ratio_unit))
				l_menu_item.set_pixmap (pixmaps.icon_pixmaps.metric_ratio_icon)
				l_new_menu.extend (l_menu_item)
				new_metric_menu_internal := l_new_menu
			end
			Result := new_metric_menu_internal
		ensure
			result_attached: Result /= Void
		end

	new_metric_editor (a_type: INTEGER): like current_metric_editor is
			-- New metric editor for metric of type `a_type'
		require
			a_type_valid: is_valid_metric_type (a_type)
		do
			if a_type = basic_metric_type then
				if basic_metric_definition_area = Void then
					create basic_metric_definition_area.make (metric_tool)
				end
				Result := basic_metric_definition_area
			elseif a_type = linear_metric_type then
				if linear_metric_defintion_area = Void then
					create linear_metric_defintion_area.make (metric_tool)
				end
				result := linear_metric_defintion_area
			elseif a_type = ratio_metric_type then
				if ratio_metric_definition_area = Void then
					create ratio_metric_definition_area.make (metric_tool)
				end
				Result := ratio_metric_definition_area
			end
			Result.attach_metric_selector (metric_selector)
		ensure
			result_attached: Result /= Void
		end

	new_metric_menu_internal: like new_metric_menu
			-- Implementation of `new_metric_menu_internal'

	basic_metric_definition_area: EB_BASIC_METRIC_DEFINITION_AREA
			-- Internal basic metric definition area

	linear_metric_defintion_area: EB_LINEAR_METRIC_DEFINITION_AREA
			-- Internal linear metric definition area

	ratio_metric_definition_area: EB_RATIO_METRIC_DEFINITION_AREA
			-- Internal ratio metric definition area			

feature -- Recycle

	recycle is
			-- To be called when the button has became useless.
		do
		end

invariant
	metric_tool_attached: metric_tool /= Void

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

