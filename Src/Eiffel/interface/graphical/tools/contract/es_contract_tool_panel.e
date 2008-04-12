indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CONTRACT_TOOL_PANEL

inherit
	ES_DOCKABLE_STONABLE_TOOL_PANEL [EV_HORIZONTAL_BOX]
		redefine
			on_after_initialized,
			internal_recycle,
			query_set_stone,
			synchronize,
			create_right_tool_bar_items,
			on_show
		end

	SESSION_EVENT_OBSERVER
		export
			{NONE} all
		redefine
			on_session_value_changed
		end

	ES_MODIFIABLE
		undefine
			internal_detach_entities
		redefine
			internal_recycle,
			query_save_modified,
			on_dirty_state_changed
		end

create {ES_CONTRACT_TOOL}
	make

feature {NONE} -- Initialization

    build_tool_interface (a_widget: EV_HORIZONTAL_BOX)
            -- Builds the tools user interface elements.
            -- Note: This function is called prior to showing the tool for the first time.
            --
            -- `a_widget': A widget to build the tool interface using.
		do
				-- `contract_editor'
			create contract_editor.make (develop_window)

			a_widget.extend (contract_editor.widget)
			register_action (contract_editor.source_selection_actions, agent on_source_selected_in_editor)

			register_action (save_modifications_button.select_actions, agent on_save)
			register_action (add_contract_button.select_actions, agent add_contract_button.perform_select)
			register_action (remove_contract_button.select_actions, agent on_remove_contract)
			register_action (edit_contract_button.select_actions, agent on_edit_contract)
			register_action (refresh_button.select_actions, agent on_refresh)
			register_action (contract_mode_button.select_actions, agent on_contract_mode_selected)
			register_action (preconditions_menu_item.select_actions, agent set_contract_mode ({ES_CONTRACT_TOOL_EDIT_MODE}.preconditions))
			register_action (postconditions_menu_item.select_actions, agent set_contract_mode ({ES_CONTRACT_TOOL_EDIT_MODE}.postconditions))
			register_action (invaraints_menu_item.select_actions, agent set_contract_mode ({ES_CONTRACT_TOOL_EDIT_MODE}.invariants))
			register_action (show_all_lines_button.select_actions, agent on_show_all_rows)
			register_action (show_callers_button.select_actions, agent on_show_callers)

				-- Register action to perform updates on focus
			register_action (content.focus_in_actions, agent update_if_modified)

				-- Register menu item actions
			register_action (add_manual_menu_item.select_actions, agent on_add_contract)
			register_action (add_from_template_menu.select_actions, agent on_add_contract_from_template)
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor {ES_DOCKABLE_STONABLE_TOOL_PANEL}
			propagate_drop_actions (Void)

			if session_manager.is_service_available then
					-- Connect session observer.
				project_window_session_data.connect_events (Current)
			end

			if code_template_catalog.is_service_available then
					-- Update the menu
				update_code_template_list
			else
					-- Disable the menu entries because they cannot be used
				add_from_template_for_entity_menu.disable_sensitive
				add_from_template_menu.disable_sensitive
			end

				-- Performs UI initialization
			set_contract_mode (contract_mode)
			set_is_showing_all_rows (is_showing_all_rows)

				-- Set button states
			update_stone_buttons
		end

feature {NONE} -- Clean up

	internal_recycle
			-- To be called when the button has became useless.
			-- Note: It's recommended that you do not detach objects here.
		do
			if session_manager.is_service_available then
				if project_window_session_data.is_connected (Current) then
						-- Retrieve contract mode from the project session.
					project_window_session_data.disconnect_events (Current)
				end
			end

			Precursor {ES_MODIFIABLE}
			Precursor {ES_DOCKABLE_STONABLE_TOOL_PANEL}
		end

feature {NONE} -- Access

	contract_mode: NATURAL_8 assign set_contract_mode
			-- Contract edition mode.
			-- See {ES_CONTRACT_TOOL_EDIT_MODE} for applicable modes.
		do
			if session_manager.is_service_available then
				if {l_mode: NATURAL_8_REF} project_window_session_data.value (contract_mode_session_id) and then (create {ES_CONTRACT_TOOL_EDIT_MODE}).is_valid_mode (l_mode.item) then
					Result := l_mode.item
				else
					Result := {ES_CONTRACT_TOOL_EDIT_MODE}.preconditions
				end
			end
		end

	context: !ES_CONTRACT_EDITOR_CONTEXT [CLASSI_STONE]
			-- Available editor context.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
		do
			check contract_editor_has_context: contract_editor.has_context end
			Result ?= contract_editor.context
		end

	contract_code_templates: !DS_BILINEAR [!CODE_TEMPLATE_DEFINITION]
			-- Code template definitions for contracts.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			code_template_catalog_is_service_available: code_template_catalog.is_service_available
		local
			l_categories: DS_ARRAYED_LIST [STRING_32]
		once
			create l_categories.make (1)
			l_categories.put_last ({CODE_TEMPLATE_ENTITY_NAMES}.contract_category)
			Result ?= code_template_catalog.service.templates_by_category (l_categories, False)
		end

feature {NONE} -- Element change

	set_contract_mode (a_mode: like contract_mode)
			-- Sets the current contract edition mode.
			--
			-- `a_mode': The contract edition mode to see. See {ES_CONTRACT_TOOL_EDIT_MODE} for applicable modes
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_mode_is_valid_mode: (create {ES_CONTRACT_TOOL_EDIT_MODE}).is_valid_mode (a_mode)
		do
			contract_mode_button.set_text (contract_mode_label (a_mode))
			inspect a_mode
			when {ES_CONTRACT_TOOL_EDIT_MODE}.preconditions then
				preconditions_menu_item.enable_select
			when {ES_CONTRACT_TOOL_EDIT_MODE}.postconditions then
				postconditions_menu_item.enable_select
			when {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
				invaraints_menu_item.enable_select
			end

			if session_manager.is_service_available then
				project_window_session_data.value_changed_event.perform_suspended_action (agent (ia_mode: like contract_mode)
					do
						project_window_session_data.set_value (ia_mode, contract_mode_session_id)
					end (a_mode))
			end

				-- Make this check before updating incase the mode determination changes in the future.
			check contract_mode_set: contract_mode = a_mode end
			if has_stone and stone_change_notified then
				refresh_stone
			end
		ensure
			contract_mode_set: contract_mode = a_mode
		end

feature {NONE} -- Status report

	is_showing_all_rows: BOOLEAN assign set_is_showing_all_rows
			-- Indicates if all contract rows should be shown.
			-- Note: By default only those entities with contracts are shown.
		require
			is_interface_usable: is_interface_usable
		do
			if session_manager.is_service_available then
				if {l_value: BOOLEAN_REF} window_session_data.value (show_all_lines_session_id) then
					Result := l_value.item
				end
			end
		end

	is_saving: BOOLEAN
			-- Indicates if Current's modifications are currently being saved

feature {NONE} -- Status setting

	set_is_showing_all_rows (a_show: like is_showing_all_rows)
			-- Set status to show/hide rows without contracts.
			--
			-- `a_show': True to show all rows; False to show only rows with contracts
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_running: BOOLEAN
		do
			if show_all_lines_button.is_selected /= a_show then
				l_running := show_all_lines_button.select_actions.state = {ACTION_SEQUENCE [TUPLE]}.normal_state
				if l_running then
					show_all_lines_button.select_actions.block
				end
				if a_show then
					show_all_lines_button.enable_select
				else
					show_all_lines_button.disable_select
				end
				if l_running then
					show_all_lines_button.select_actions.resume
				end
			end

			contract_editor.is_showing_all_rows := a_show

			if session_manager.is_service_available then
				window_session_data.set_value (a_show, show_all_lines_session_id)
			end
		ensure
			is_showing_all_rows_set: is_showing_all_rows = a_show
		end

feature {ES_STONABLE_I, ES_TOOL} -- Query

	query_set_stone (a_stone: ?STONE): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_stone)
			if Result and then is_initialized then
				if is_dirty then
						-- Check with user if they want to save any modifications.
					Result := query_save_modified
				end

					-- Delegate the query to the actual editor.
				if Result and then has_stone then
						-- Note: Using Void is somewhat of a hack because a context cannot be set an incorrect stone (i.e Class context being set a feature stone)
						--       For this we use Void because it triggers a request to change the stone.
					Result := context.query_set_stone (Void)
				end
			end
		end

feature {NONE} -- Query

	context_for_mode: ?ES_CONTRACT_EDITOR_CONTEXT [CLASSI_STONE]
			-- Fetches an editor context given a stone
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
		do
			inspect contract_mode
			when {ES_CONTRACT_TOOL_EDIT_MODE}.preconditions then
				create {ES_PRECONDITION_CONTRACT_EDITOR_CONTEXT} Result
			when {ES_CONTRACT_TOOL_EDIT_MODE}.postconditions then
				create {ES_POSTCONDITION_CONTRACT_EDITOR_CONTEXT} Result
			when {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
				create {ES_INVARIANT_CONTRACT_EDITOR_CONTEXT} Result
			end

			if Result /= Void and then Result.is_stone_usable (stone) then
					-- Set stone on context
				Result.set_stone_with_query (stone)
			else
				Result := Void
			end
		ensure
			stone_set: Result /= Void implies Result.stone = stone
		end

	query_save_modified: BOOLEAN
			-- Performs a query, generally involving some user interaction, determining if an action can be performed
			-- given a dirty state.
		local
			l_save_classes_prompt: ES_SAVE_CLASSES_PROMPT
			l_save_feature_prompt: ES_SAVE_FEATURES_PROMPT
			l_classes: DS_ARRAYED_LIST [CLASS_I]
			l_features: DS_ARRAYED_LIST [E_FEATURE]
			l_prompt: ES_PROMPT
		do
			check is_initialized: is_initialized end
			if contract_editor.has_context then
				if {l_feat_context: ES_FEATURE_CONTRACT_EDITOR_CONTEXT} context then
					create l_features.make_from_array (<<l_feat_context.context_feature>>)
					create l_save_feature_prompt.make_standard_with_cancel ("The contract tool has unsaved class feature changes.%NDo you wanted to save the following feature(s)?")
					l_save_feature_prompt.features := l_features
					l_prompt := l_save_feature_prompt
				elseif {l_class_context: ES_CLASS_CONTRACT_EDITOR_CONTEXT} context then
					create l_classes.make_from_array (<<l_class_context.context_class>>)
					create l_save_classes_prompt.make_standard_with_cancel ("The contract tool has unsaved class changes.%NDo you wanted to save the following class(es)?")
					l_save_classes_prompt.classes := l_classes
					l_prompt := l_save_classes_prompt
				end
				check l_prompt_attached: l_prompt /= Void end
				l_prompt.set_button_action (l_prompt.dialog_buttons.yes_button, agent on_save)
				l_prompt.show_on_active_window
				Result := l_prompt.dialog_result /= {ES_DIALOG_BUTTONS}.cancel_button
			else
				Result := Precursor
			end
		end

--	is_editable_row (a_row: !EV_GRID_ROW): BOOLEAN
--			-- Determines if a row is editable
--			--
--			-- `a_row': A row to determine editability.
--			-- `Result': True if the row is editable; False otherwise.
--		do
--			Result := True
--		end

feature {NONE} -- Basic operations

	refresh_context
			-- Refreshes the editor to include new changes.
			-- Note: This only refreshes the already set context information and will not go out to disk or the editor
			--       to refresh the context context. For this use `update'. However be sure the editor contains loaded
			--       text or your will recieve stale content.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
			not_is_dirty: not is_dirty
		do
			execute_with_busy_cursor (agent contract_editor.refresh)
		end

	update
			-- Updates the view with an new context.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_is_dirty: not is_dirty
		do
			if has_stone and then {l_context: !like context_for_mode} context_for_mode then
				execute_with_busy_cursor (agent contract_editor.set_context (l_context))
			end
			update_stone_buttons
		ensure
			not_is_dirty: not is_dirty
		end

	update_if_modified
			-- Performs an update if the class file has been modified
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if has_stone and then file_notifier.is_service_available and then {l_fn: !STRING_32} context.context_class.file_name.string.as_string_32 then
					-- Poll for modifications, which will call `on_file_modified' if have occurred.
				file_notifier.service.poll_modifications (l_fn).do_nothing
			end
		end

	save_contracts
			-- Saves the currently modified contracts.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			is_dirty: is_dirty
		do
			set_is_dirty (False)
		ensure
			not_is_dirty: not is_dirty
		end

feature {NONE} -- Extension

	add_contract_from_template (a_template: !CODE_TEMPLATE_DEFINITION) is
			-- Adds a contract from a template definition
			--
			-- `a_template' The template to use to add a contract with.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_template: ?CODE_TEMPLATE
			l_dialog: ES_CODE_TEMPLATE_BUILDER_DIALOG
			l_error: ES_ERROR_PROMPT
		do
			l_template := a_template.applicable_item
			if l_template /= Void then
				create l_dialog.make (l_template)
				l_dialog.show_on_active_window
			else
				create l_error.make_standard ("Unable to find an applicable template for the current version of EiffelStudio.")
				l_error.show_on_active_window
			end
		end

feature {ES_STONABLE_I, ES_TOOL} -- Synchronization

	synchronize
			-- Synchronizes any new data (compiled or other wise)
		do
			if is_initialized then
				is_in_stone_synchronization := True
				update
				is_in_stone_synchronization := False
			end
		rescue
			is_in_stone_synchronization := False
		end

feature {NONE} -- Helpers

	frozen file_notifier: !SERVICE_CONSUMER [FILE_NOTIFIER_S]
			-- Access to the file notifier service
		once
			create Result
		end

	frozen code_template_catalog: !SERVICE_CONSUMER [CODE_TEMPLATE_CATALOG_S]
			-- Access to the code template catalog service
		once
			create Result
		end

feature {NONE} -- User interface elements

	save_modifications_button:? SD_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Button to save modified contracts.

	save_menu_item: ?EV_MENU_ITEM
			-- Menu item to save contracts.

	save_and_open_menu_item: ?EV_MENU_ITEM
			-- Menu item to save contracts and open modified class.

	add_contract_button: ?SD_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Button to add a new contract to the current feature.

	add_manual_menu_item: ?EV_MENU_ITEM
			-- Menu item to save contracts.

	add_from_template_menu: ?EV_MENU
			-- Menu to save contracts and open modified class.

	add_from_template_for_entity_menu: ?EV_MENU
			-- Menu to add a template contract for a given argument/class attribute

	remove_contract_button: ?SD_TOOL_BAR_BUTTON
			-- Button to remove a selected contract.

	edit_contract_button: ?SD_TOOL_BAR_BUTTON
			-- Button to edit a selected contract.

	refresh_button: ?SD_TOOL_BAR_BUTTON
			-- Button to refresh the selected contract.

	contract_mode_button: ?SD_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Button to select the contract edit mode.

	preconditions_menu_item: ?EV_RADIO_MENU_ITEM
			-- Menu item to show preconditions.

	postconditions_menu_item: ?EV_RADIO_MENU_ITEM
			-- Menu item to show postconditions.

	invaraints_menu_item: ?EV_RADIO_MENU_ITEM
			-- Menu item to show invariants.

	show_all_lines_button: ?SD_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show/hide hidden non-contract enabled rows.

	show_callers_button: ?SD_TOOL_BAR_BUTTON
			-- Button to show the callers of the edited feature.

	contract_editor: ?ES_CONTRACT_EDITOR_WIDGET
			-- The editor used to edit the contracts.

feature {NONE} -- User interface manipulation

	update_stone_buttons
			-- Updates the buttons based on a stone.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if {l_fstone: FEATURE_STONE} stone then
					-- Feature context
				contract_mode_button.enable_sensitive
				invaraints_menu_item.disable_sensitive
				refresh_button.enable_sensitive
				show_all_lines_button.enable_sensitive
				show_callers_button.enable_sensitive
			elseif contract_editor.has_context then
					-- Class context
				contract_mode_button.disable_sensitive
				refresh_button.enable_sensitive
				show_all_lines_button.enable_sensitive
				show_callers_button.enable_sensitive
			else
					-- No context
				contract_mode_button.enable_sensitive
				invaraints_menu_item.enable_sensitive
				refresh_button.disable_sensitive
				show_all_lines_button.disable_sensitive
				show_callers_button.disable_sensitive
			end

			if contract_editor.has_context then
				if contract_mode = {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
					add_from_template_for_entity_menu.set_text ("Add Contract for Class Attribute")
				else
					add_from_template_for_entity_menu.set_text ("Add Contract for Argument")
				end
			end

			update_editable_buttons (has_stone and then contract_editor.selected_source /= Void and then contract_editor.selected_source.is_editable)
		end

	update_editable_buttons (a_editable: BOOLEAN)
			-- Updates the editable context buttons based on a supplied state.
			--
			-- `a_enable': True to enable the context button; False otherwise.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if a_editable then
				add_contract_button.enable_sensitive
				remove_contract_button.enable_sensitive
				edit_contract_button.enable_sensitive
			else
				add_contract_button.disable_sensitive
				remove_contract_button.disable_sensitive
				edit_contract_button.disable_sensitive
			end
		end

	update_code_template_list
			-- Updates the code template list for the add from template menu.
			--| Should only be called once per object
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			code_template_catalog_is_service_available: code_template_catalog.is_service_available
			add_from_template_menu_is_empty: add_from_template_menu.is_empty
		local
			l_cursor: DS_BILINEAR_CURSOR [!CODE_TEMPLATE_DEFINITION]
			l_definition: !CODE_TEMPLATE_DEFINITION
			l_title: !STRING_32
			l_menu: !EV_MENU
			l_menu_item: EV_MENU_ITEM
		do
			l_menu ?= add_from_template_menu
			l_menu.wipe_out

			l_cursor := contract_code_templates.new_cursor
			from l_cursor.start until l_cursor.after loop
				l_definition := l_cursor.item
				l_title := l_definition.metadata.title
				if l_title.is_empty then
					l_title := l_definition.metadata.shortcut
				end
				if not l_title.is_empty then
					create l_menu_item.make_with_text (l_title)
					l_menu_item.set_pixmap (stock_pixmaps.general_document_icon)
					l_menu_item.set_data (l_definition)
					l_menu_item.select_actions.extend (agent add_contract_from_template (l_definition))
					l_menu.extend (l_menu_item)
				end
				l_cursor.forth
			end
		end

	update_row_buttons
			-- Updates the buttons based on a stone.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
		end

feature {NONE} -- Actions handlers

	on_row_selected (a_row: EV_GRID_ROW)
			-- Called when a grid row is selected
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_row_attached: a_row /= Void
		do
			if {l_row: EV_GRID_ROW} a_row then
				--update_context_buttons (is_editable_row (l_row))
			end
		end

feature {SESSION_I} -- Event handlers

	on_session_value_changed (a_session: SESSION_I; a_id: STRING_8)
			-- Called when a event item is added to the event service.
			--
			-- `a_session': The session where the value changed.
			-- `a_id': The session data identifier of the changed value.
		local
			l_mode: NATURAL_8_REF
		do
			Precursor {SESSION_EVENT_OBSERVER} (a_session, a_id)
			if a_id.is_equal (contract_mode_session_id) then
				l_mode ?= project_window_session_data.value (contract_mode_session_id)
				if l_mode /= Void then
					set_contract_mode (l_mode.item)
				end
			end
		end

feature {NONE} -- Event handlers

	on_dirty_state_changed
			-- <Precursor>
		do
			Precursor
			if is_interface_usable and then is_initialized then
				if is_dirty then
					save_modifications_button.enable_sensitive
				else
					save_modifications_button.disable_sensitive
				end
			end
		end

	on_file_modified (a_modification_type: NATURAL_8)
			-- Called when a file is modified externally of Current.
			--
			-- `a_modification_type': The type of modification applied to the file. See FILE_NOTIFIER_MODIFICATION_TYPES for the respective flags
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if is_initialized and then has_stone and then not is_saving then
				if shown then
					if (a_modification_type & {FILE_NOTIFIER_MODIFICATION_TYPES}.file_deleted) = {FILE_NOTIFIER_MODIFICATION_TYPES}.file_deleted then
						set_stone (Void)
					elseif not is_dirty then
						refresh_stone
					end
				else
					last_file_change_notified_agent := agent on_file_modified (a_modification_type)
				end
			end
		end

feature {NONE} -- Action handlers

	on_stone_changed (a_old_stone: ?like stone)
			-- <Precursor>
		local
			l_service: FILE_NOTIFIER_S
		do
			if file_notifier.is_service_available then
				l_service := file_notifier.service
				if a_old_stone /= Void and then {l_old_cs: !CLASSI_STONE} a_old_stone and then {l_old_fn: !STRING_32} l_old_cs.class_i.file_name.string.as_string_32 then
						-- Remove old monitor
					if l_service.is_monitoring (l_old_fn) then
						l_service.uncheck_modifications_with_callback (l_old_fn, agent on_file_modified)
					end
				end

				if stone /= Void and then {l_new_cs: !CLASSI_STONE} stone and then {l_new_fn: !STRING_32} l_new_cs.class_i.file_name.string.as_string_32 then
						-- Add monitor
					l_service.check_modifications_with_callback (l_new_fn, agent on_file_modified)
				end
			end

			if {l_fs: !FEATURE_STONE} stone then
				if contract_mode = {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
						-- A feature was dropped so we should switch to a feature contract mode.
						-- Calling `set_contract_mode' will call `update'
					set_contract_mode ({ES_CONTRACT_TOOL_EDIT_MODE}.preconditions)
				end
			else
				if {l_cs: !CLASSI_STONE} stone then
					if contract_mode /= {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
							-- A feature was dropped so we should switch to a feature contract mode.
							-- Calling `set_contract_mode' will call `update'
						set_contract_mode ({ES_CONTRACT_TOOL_EDIT_MODE}.invariants)
					end
				end
			end

			set_is_dirty (False)
			update

				-- Update session.
				-- This is done here because it only needs to be persisted when there is a stone change.
			if session_manager.is_service_available then
				project_window_session_data.set_value (contract_mode, contract_mode_session_id)
			end
		end

	on_show
			-- <Precursor>
		do
			Precursor
			if last_file_change_notified_agent /= Void then
					-- There was a file change notification issued when the tool was not shown
				last_file_change_notified_agent.call (Void)
				last_file_change_notified_agent := Void
			else
					-- Just for piece of mind, update if the file was modified
				update_if_modified
			end
		ensure then
			last_file_change_notified_agent_detached: last_file_change_notified_agent = Void
		end

	on_save
			-- Called when the user chooses to save the modified contracts
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
			is_dirty: is_dirty
			not_is_saving: not is_saving
		local
			l_contracts: !DS_ARRAYED_LIST [!ES_CONTRACT_LINE]
			l_assertions: !DS_ARRAYED_LIST [STRING]

			l_error: ES_ERROR_PROMPT
			retried: BOOLEAN
		do
			if not retried then
				is_saving := True
				if {l_modifier: ES_CONTRACT_TEXT_MODIFIER [AST_EIFFEL]} context.text_modifier then
					l_contracts := contract_editor.context_contracts
					if not l_contracts.is_empty then
						create l_assertions.make (l_contracts.count)
						from l_contracts.start until l_contracts.after loop
							l_assertions.put_last (l_contracts.item_for_iteration.string)
							l_contracts.forth
						end
					else
						create l_assertions.make (0)
					end
					l_modifier.replace_contracts (l_assertions)
					if l_modifier.is_dirty then
						l_modifier.commit
							-- Check affected classes and open, if requested.

							-- Perform an update to recieve the most current information
						set_is_dirty (False)
						refresh_context
					else
						check False end
					end
				else
					check False end
				end

				is_saving := False
			else
				create l_error.make_standard ("There was a problem saving the contracts. Please check you have access to the class file.")
				l_error.show_on_active_window
			end
		ensure
			is_saving_unchanged: is_saving = old is_saving
		rescue
			retried := True
			is_saving := False
			retry
		end

	on_add_contract
			-- Called when the user chooses to add a new contract to the existing feature.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
		local
			l_window_manager: EB_SHARED_WINDOW_MANAGER
			l_editors: !DS_ARRAYED_LIST [EB_SMART_EDITOR]
			l_editor: EB_SMART_EDITOR
		do
			create l_window_manager
			l_editors := l_window_manager.window_manager.active_editors_for_class (context.context_class)
			if not l_editors.is_empty then
				from l_editors.start until l_editors.after loop
					if l_editors.item_for_iteration.is_editable then
						l_editors.forth
					else
						l_editors.remove_at
					end
				end
			end
			if not l_editors.is_empty then
					-- Point to the existing editor
				l_editor := l_editors.first
			else
					-- No editor exists, open a new one
				develop_window.commands.new_tab_cmd.execute_with_stone (create {CLASSI_STONE}.make (context.context_class))
				l_editor := develop_window.editors_manager.editor_with_class (context.context_class.file_name)
			end

			--l_editor.display_line_at_top_when_ready (context.text_modifier.contract_ast.start_location.line, 1)
		end

	on_add_contract_from_template (a_template: !CODE_TEMPLATE_DEFINITION)
			-- Called when the user chooses to add a new contract, from a template, to the existing feature.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
		local
			l_template: ?CODE_TEMPLATE
			l_dialog: ES_CODE_TEMPLATE_BUILDER_DIALOG
			l_error: ES_ERROR_PROMPT
			l_contract: !STRING_32
		do
			l_template := a_template.applicable_item
			if l_template /= Void then
				create l_dialog.make (l_template)
				l_dialog.show_on_active_window
				if l_dialog.dialog_result = l_dialog.dialog_buttons.ok_button then
						-- User committed changes
					l_contract := l_dialog.code_result
					if not l_contract.is_empty then

					end
				end
			else
				create l_error.make_standard ("Unable to find an applicable template for the current version of EiffelStudio.")
				l_error.show_on_active_window
			end
		end

	on_remove_contract
			-- Called when the user chooses to remove a contract from the existing feature.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
		local
			l_source: ?ES_CONTRACT_SOURCE_I
			l_question: ES_QUESTION_WARNING_PROMPT
		do
			l_source := contract_editor.selected_source
			if l_source /= Void then
				if {l_line: ES_CONTRACT_LINE} l_source then
						-- Remove selected contracts
					contract_editor.remove_contract (l_line)
					set_is_dirty (True)
				else
						-- User chooses to remove all contracts
					create l_question.make_standard_with_cancel ("Performing a removal like this will removal all the contracts.%NDo you want to continue?")
					l_question.show_on_active_window
				end
			end
		end

	on_edit_contract
			-- Called when the user chooses to edit a contract from the existing feature.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
		do
		end

	on_refresh
			-- Called when the user chooses to refresh the contracts
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			refresh_stone
		end

	on_contract_mode_selected
			-- Called when the user selects the contract mode button.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_mode: like contract_mode
		do
			if contract_mode /= {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
				l_mode := contract_mode + 1
				if not (create {ES_CONTRACT_TOOL_EDIT_MODE}).is_valid_mode (l_mode) or l_mode = {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
					l_mode := {ES_CONTRACT_TOOL_EDIT_MODE}.preconditions
				end
				perform_query_save_modified (agent set_contract_mode (l_mode))
			end
		end

	on_show_all_rows
			-- Called when the user chooses to show all the contract rows.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			set_is_showing_all_rows (show_all_lines_button.is_selected)
		end

	on_show_callers
			-- Called when the user chooses to show the callers of the edited contracts
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
		do
--			if {l_feature: !E_FEATURE} contract_editor.context then
--				if {l_tool: !ES_FEATURE_RELATION_TOOL} develop_window.shell_tools.tool ({ES_FEATURE_RELATION_TOOL}) then
--						-- Display feature relation tool using callers mode.
--					l_tool.set_mode_with_stone ({ES_FEATURE_RELATION_TOOL_VIEW_MODES}.callers, create {!FEATURE_STONE}.make (l_feature))
--					l_tool.show (True)
--				end
--			else

--			end
		end

	on_source_selected_in_editor (a_source: ?ES_CONTRACT_SOURCE_I)
			-- Called when the editor recieves a selection/deselection of a source row.
			--
			-- `a_source': A source row (or a contrac line {ES_CONTRACT_LINE}) or Void to indicate a deselection.
		do
			update_editable_buttons (a_source /= Void and then a_source.is_editable)
		end

feature {NONE} -- Action agents

	last_file_change_notified_agent: PROCEDURE [ANY, TUPLE]
			-- Last agent set for file notifications when the tool was not displayed

feature {NONE} -- Factory

    create_widget: EV_HORIZONTAL_BOX
            -- Create a new container widget upon request.
            -- Note: You may build the tool elements here or in `build_tool_interface'
		do
			create Result
		end

    create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display at the top of the tool.
		local
			l_button: SD_TOOL_BAR_BUTTON
			l_dual_button: SD_TOOL_BAR_DUAL_POPUP_BUTTON
			l_menu: EV_MENU
			l_sub_menu: EV_MENU
			l_menu_item: EV_MENU_ITEM
			l_menu_radio_item: EV_RADIO_MENU_ITEM
		do
			create Result.make (11)

				-- Save contract button
			create l_dual_button.make
			l_dual_button.set_pixel_buffer (stock_pixmaps.general_save_icon_buffer)
			l_dual_button.set_pixmap (stock_pixmaps.general_save_icon)
			l_dual_button.set_tooltip ("Save modifications to class.")
			l_dual_button.disable_sensitive
			save_modifications_button := l_dual_button
			Result.put_last (l_dual_button)

				-- Create menu for contract selection button
			create l_menu
			create l_menu_item.make_with_text ("&Save")
			l_menu.set_pixmap (stock_pixmaps.general_save_icon)
			l_menu.extend (l_menu_item)
			save_menu_item := l_menu_item

			create l_menu_item.make_with_text ("S&ave and Open Modified")
			l_menu.set_pixmap (stock_pixmaps.general_save_icon)
			l_menu.extend (l_menu_item)
			save_and_open_menu_item := l_menu_item
			l_dual_button.set_menu (l_menu)

			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Add contract button
			create l_dual_button.make
			l_dual_button.set_pixel_buffer (stock_pixmaps.general_add_icon_buffer)
			l_dual_button.set_pixmap (stock_pixmaps.general_add_icon)
			l_dual_button.set_tooltip ("Adds a new contract.")
			l_dual_button.disable_sensitive
			add_contract_button := l_dual_button
			Result.put_last (l_dual_button)

				-- Create menu for add selection button
			create l_menu
			create l_menu_item.make_with_text ("&Add Contract...")
			l_menu.set_pixmap (stock_pixmaps.general_add_icon)
			l_menu.extend (l_menu_item)
			add_manual_menu_item := l_menu_item

			create l_sub_menu.make_with_text ("&Add Contract from Template...")
			l_menu.extend (l_sub_menu)
			add_from_template_menu := l_sub_menu

			create l_sub_menu.make_with_text ("&Add Contract for Entity")
			l_menu.extend (l_sub_menu)
			add_from_template_for_entity_menu := l_sub_menu

			l_dual_button.set_menu (l_menu)

				-- Remove contract button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_remove_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_remove_icon)
			l_button.set_tooltip ("Removes the selected contract(s).")
			l_button.disable_sensitive
			remove_contract_button := l_button
			Result.put_last (l_button)

			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Edit contracts button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_edit_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_edit_icon)
			l_button.set_tooltip ("Edit the selected contract.")
			l_button.disable_sensitive
			edit_contract_button := l_button
			Result.put_last (l_button)

				-- Refresh contracts button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_refresh_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_refresh_icon)
			l_button.set_tooltip ("Refresh the current contracts to include an undetected changes.")
			l_button.disable_sensitive
			refresh_button := l_button
			Result.put_last (l_button)

			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Contract selection button
			create l_dual_button.make
			l_dual_button.set_text (contract_mode_label (contract_mode))
			l_dual_button.set_pixel_buffer (stock_pixmaps.view_contracts_icon_buffer)
			l_dual_button.set_pixmap (stock_pixmaps.view_contracts_icon)
			l_dual_button.set_tooltip ("Select the contracts to edit.")
			contract_mode_button := l_dual_button
			Result.put_last (l_dual_button)

				-- Create menu for contract selection button
			create l_menu
			create l_menu_radio_item.make_with_text (contract_mode_label ({ES_CONTRACT_TOOL_EDIT_MODE}.preconditions))
			l_menu.extend (l_menu_radio_item)
			l_menu_radio_item.enable_select
			preconditions_menu_item := l_menu_radio_item

			create l_menu_radio_item.make_with_text (contract_mode_label ({ES_CONTRACT_TOOL_EDIT_MODE}.postconditions))
			l_menu.extend (l_menu_radio_item)
			postconditions_menu_item := l_menu_radio_item

			create l_menu_radio_item.make_with_text (contract_mode_label ({ES_CONTRACT_TOOL_EDIT_MODE}.invariants))
			l_menu.extend (l_menu_radio_item)
			invaraints_menu_item := l_menu_radio_item
			l_dual_button.set_menu (l_menu)
		end

	create_right_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items that should be displayed at the top, but right aligned.
			-- Note: Redefine to add a right tool bar.
		local
			l_button: SD_TOOL_BAR_BUTTON
			l_toggle_button: SD_TOOL_BAR_TOGGLE_BUTTON
		do
			create Result.make (3)

				-- Show hidden rows button
			create l_toggle_button.make
			l_toggle_button.set_pixel_buffer (stock_pixmaps.general_show_hidden_icon_buffer)
			l_toggle_button.set_pixmap (stock_pixmaps.general_show_hidden_icon)
			l_toggle_button.set_tooltip ("Shows/hides the hidden contract place holders for inherited contracts.")
			l_toggle_button.disable_sensitive
			show_all_lines_button := l_toggle_button
			Result.put_last (l_toggle_button)

			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Show callers button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.feature_callees_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.feature_callees_icon)
			l_button.set_tooltip ("Show the callers of the currently edited feature.")
			l_button.disable_sensitive
			show_callers_button := l_button
			Result.put_last (l_button)
		end

	contract_mode_label (a_mode: like contract_mode): !STRING_32
			-- Retrieve the edit label for a given an edit mode.
			--
			-- `a_mode': An edit mode. See {ES_CONTRACT_TOOL_EDIT_MODE} for possible values.
			-- `Result': A label for the given edit mode.
		require
			a_mode_is_valid: (create {ES_CONTRACT_TOOL_EDIT_MODE}).is_valid_mode (a_mode)
		local
			l_result: STRING_32
		do
			inspect a_mode
			when {ES_CONTRACT_TOOL_EDIT_MODE}.preconditions then
				l_result := interface_names.m_edit_preconditions
			when {ES_CONTRACT_TOOL_EDIT_MODE}.postconditions then
				l_result := interface_names.m_edit_postconditions
			when {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
				l_result := interface_names.m_edit_invariants
			else
				l_result := interface_names.unknown_string
			end
				-- Remove ampersand from menu name.
			l_result ?= l_result.twin
			l_result.replace_substring_all ("&", "")
			create Result.make_from_string (l_result.as_string_32)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Constants

	contract_mode_session_id: !STRING = "com.eiffel.contract_tool.mode"
	show_all_lines_session_id: !STRING = "com.eiffel.contract_tool.show_all_lines"

invariant
	save_modifications_button_attached: (is_initialized and is_interface_usable) implies save_modifications_button /= Void
	save_menu_item_attached: (is_initialized and is_interface_usable) implies save_menu_item /= Void
	save_and_open_menu_item_attached: (is_initialized and is_interface_usable) implies save_and_open_menu_item /= Void
	add_contract_button_attached: (is_initialized and is_interface_usable) implies add_contract_button /= Void
	add_manual_menu_item_attached: (is_initialized and is_interface_usable) implies add_manual_menu_item /= Void
	add_from_template_menu_attached: (is_initialized and is_interface_usable) implies add_from_template_menu /= Void
	add_from_template_for_entity_menu_attached: (is_initialized and is_interface_usable) implies add_from_template_for_entity_menu /= Void
	remove_contract_button_attached: (is_initialized and is_interface_usable) implies remove_contract_button /= Void
	edit_contract_button_attached: (is_initialized and is_interface_usable) implies edit_contract_button /= Void
	refresh_button_attached: (is_initialized and is_interface_usable) implies refresh_button /= Void
	contract_mode_button_attached: (is_initialized and is_interface_usable) implies contract_mode_button /= Void
	preconditions_menu_item_attached: (is_initialized and is_interface_usable) implies preconditions_menu_item /= Void
	postconditions_menu_item_attached: (is_initialized and is_interface_usable) implies postconditions_menu_item /= Void
	invaraints_menu_item_attached: (is_initialized and is_interface_usable) implies invaraints_menu_item /= Void
	show_all_lines_button_attached: (is_initialized and is_interface_usable) implies show_all_lines_button /= Void
	show_callers_button_attached: (is_initialized and is_interface_usable) implies show_callers_button /= Void
	contract_editor_attached: (is_initialized and is_interface_usable) implies contract_editor /= Void

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
