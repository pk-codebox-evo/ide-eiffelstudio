note
	description: "[
		An event list service {EVENT_LIST_S} tool to show all errors and warning event items in a single list in the EiffelStudio UI
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_ERROR_LIST_TOOL_PANEL

inherit
	ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE
		redefine
			build_tool_interface,
			on_before_initialize,
			on_after_initialized,
			internal_recycle,
			is_appliable_event,
			is_event_list_synchronized_on_initialized,
			show,
			show_context_menu,
			update_content_applicable_widgets,
			on_unlocked,
			on_event_item_added,
			on_event_item_removed,
			on_handle_key,
			create_right_tool_bar_items
		end

	ES_ERROR_LIST_COMMANDER_I
		export
			{ES_ERROR_LIST_COMMANDER_I} all
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	ES_SHARED_OUTPUTS
		export
			{NONE} all
		end

	SESSION_EVENT_OBSERVER
		export
			{NONE} all
		redefine
			on_session_value_changed
		end

	SHARED_ERROR_TRACER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization: User interface

	 build_tool_interface (a_widget: ES_GRID)
			-- Builds the tools user interface elements.
			-- Note: This function is called prior to showing the tool for the first time.
			--
			-- `a_widget': A widget to build the tool interface using.
		local
			l_col: EV_GRID_COLUMN
		do
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE} (a_widget)
			a_widget.set_column_count_to (position_column)

				-- Create columns
			l_col := a_widget.column (1)
			l_col.set_width (20)
			l_col := a_widget.column (category_column)
			l_col.set_width (20)

			l_col := a_widget.column (error_column)
			l_col.set_title (interface_names.l_description)
			l_col.set_width (100)

			l_col := a_widget.column (context_column)
			l_col.set_title (interface_names.l_location)
			l_col.set_width (200)

			l_col := a_widget.column (position_column)
			l_col.set_title (interface_names.l_position)
			l_col.set_width (80)

			a_widget.enable_tree
			a_widget.disable_row_height_fixed
			a_widget.enable_auto_size_best_fit_column (error_column)
			a_widget.enable_multiple_row_selection
			register_action (a_widget.row_deselect_actions, agent (a_row: EV_GRID_ROW)
				do
						-- Updates UI based on selection and row count.
					update_content_applicable_widgets (grid_events.row_count > 0)
					on_row_deselected (a_row)
				end)
			register_action (a_widget.row_select_actions, agent (a_row: EV_GRID_ROW)
				do
						-- Updates UI based on selection and row count.
					update_content_applicable_widgets (grid_events.row_count > 0)
					on_row_selected (a_row)
				end)

				-- Enable sorting
			enable_sorting_on_columns (<<a_widget.column (category_column),
				a_widget.column (error_column),
				a_widget.column (context_column),
				a_widget.column (position_column)>>)
		end

	on_before_initialize
			-- <Precursor>
		do
			Precursor

				-- We want the tool to synchronize with the event list, when first initialized.
			is_event_list_synchronized_on_initialized := True

			create syntax_errors.make_default
			syntax_errors.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [EVENT_LIST_ERROR_ITEM_I]}.make (
				agent (ia_item: EVENT_LIST_ERROR_ITEM_I; ia_other: EVENT_LIST_ERROR_ITEM_I): BOOLEAN
						-- Equality tester to ensure two like syntax errors are considered the same.
					do
						Result := ia_item ~ ia_other or else (
								ia_item /= Void and then
								ia_other /= Void and then
								attached {SYNTAX_ERROR} ia_item.data as l_item_error and then
								attached {SYNTAX_ERROR} ia_other.data as l_other_error and then
								l_item_error.line = l_other_error.line and then
								l_item_error.column = l_other_error.column and then
								l_item_error.file_name ~ l_other_error.file_name)
					end))
		end

	on_after_initialized
			-- <Precursor>
		do
				-- Enable copying to clipboard
			enable_copy_to_clipboard

				-- Bind redirecting pick and drop actions
			stone_director.bind (grid_events, Current)

				-- Hook up events for session data
			if session_manager.is_service_available then
				session_data.session_connection.connect_events (Current)
				if attached {BOOLEAN_REF} session_data.value_or_default (expand_errors_session_id, False) as l_expand then
					is_expanding_errors := l_expand.item
					if is_expanding_errors then
						expand_errors_button.enable_select
					else
						expand_errors_button.disable_select
					end
				end
			end

				-- Set UI based on initial state
			update_content_applicable_navigation_buttons

			Precursor
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			if is_initialized then
				if session_manager.is_service_available then
					if session_data.session_connection.is_connected (Current) then
						session_data.session_connection.disconnect_events (Current)
					end
				end
			end
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE}
		end

feature {NONE} -- Access

	error_count: NATURAL
			-- Number of errors

	warning_count: NATURAL
			-- Number of warnings

	syntax_errors: DS_ARRAYED_LIST [EVENT_LIST_ERROR_ITEM_I]
			-- List of managed syntax errors, used to perform error adoption.
			-- Note: Adoption takes place when a compiler reports an error and then the editor it opened.

feature {NONE} -- Access: Help

	help_context_id: STRING = "62F36EFA-1D3A-9E48-3A6A-7DA40B7E2046"
			-- <Precursor>

feature {NONE} -- Access: User interface

	errors_button: detachable SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to show/hide error events

	warnings_button: detachable SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to show/hide warning events

	expand_errors_button: detachable SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to expanded error events automatically

--	fix_button: detachable SD_TOOL_BAR_DUAL_POPUP_BUTTON
--			-- Automatic fix button

	delete_button: detachable SD_TOOL_BAR_BUTTON
			-- Delete selected items button

	error_info_button: detachable SD_TOOL_BAR_BUTTON
			-- Error information button

	filter_button: detachable SD_TOOL_BAR_POPUP_BUTTON
			-- Filter button to filter information in list

	filter_widget: detachable ES_WARNINGS_FILTER_WIDGET
			-- Filter widget

feature {NONE} -- Element change

	set_error_count (a_count: like error_count)
			-- Sets `error_count' to `a_count'
		do
			error_count := a_count
		ensure
			error_count_set: error_count = a_count
		end

	set_warning_count (a_count: like warning_count)
			-- Sets `warning_count' to `a_count'
		do
			warning_count := a_count
		ensure
			warning_count_set: warning_count = a_count
		end

feature {NONE} -- Status report

	is_error_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Determines if event `a_event_item' is an error event
		do
			if a_event_item.type = {EVENT_LIST_ITEM_TYPES}.error and then attached {EVENT_LIST_ERROR_ITEM_I} a_event_item as l_error then
				Result := not l_error.is_warning
			end
		ensure
			not_is_warning_event: Result implies not is_warning_event (a_event_item)
		end

	is_warning_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Determines if event `a_event_item' is an error event
		require
			a_event_item_attached: a_event_item /= Void
		do
			if a_event_item.type = {EVENT_LIST_ITEM_TYPES}.error and then attached {EVENT_LIST_ERROR_ITEM_I} a_event_item as l_error then
				Result := l_error.is_warning
			end
		ensure
			not_is_error_event: Result implies not is_error_event (a_event_item)
		end

	is_appliable_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- <Precursor>
		do
			Result := is_error_event (a_event_item) or is_warning_event (a_event_item)
		ensure then
			is_error_or_warning_event: Result implies (is_error_event (a_event_item) or is_warning_event (a_event_item))
		end

	is_displaying_errors: BOOLEAN
			-- Indicates if errors should be shown.
		do
			Result := not is_initialized or else errors_button.is_selected
		end

	is_displaying_warnings: BOOLEAN
			-- Indicates if errors should be shown.
		do
			Result := not is_initialized or else warnings_button.is_selected
		end

	is_expanding_errors: BOOLEAN
			-- Indicates if errors should be shown automatically.

	is_expanding_all_errors: BOOLEAN
			-- Indicates if the errors are being expanded, as a result of the expand errors button being pressed

	is_event_list_synchronized_on_initialized: BOOLEAN
			-- <Precursor>

feature {NONE} -- Command items

	go_to_next_error_command: ES_NEXT_ERROR_COMMAND
			-- Go to next error command.
		do
			Result := develop_window.commands.go_to_next_error_command
		ensure
			result_attached: Result /= Void
		end

	go_to_previous_error_command: ES_PREVIOUS_ERROR_COMMAND
			-- Go to previous error command.
		do
			Result := develop_window.commands.go_to_previous_error_command
		ensure
			result_attached: Result /= Void
		end

	go_to_next_warning_command: ES_NEXT_WARNING_COMMAND
			-- Go to next warning command.
		do
			Result := develop_window.commands.go_to_next_warning_command
		ensure
			result_attached: Result /= Void
		end

	go_to_previous_warning_command: ES_PREVIOUS_WARNING_COMMAND
			-- Go to previous warning command
		do
			Result := develop_window.commands.go_to_previous_warning_command
		ensure
			result_attached: Result /= Void
		end

	error_info_command: EB_ERROR_INFORMATION_CMD
			-- Error information command.

feature {NONE} -- Query

	event_context_stone (a_event_item: EVENT_LIST_ITEM_I): STONE
			-- Retrieve an event item's context stone, if one is available
			--
			-- `a_event_item': An event item to retrieve a strone from.
			-- `Result': A context stone, if any.
		require
			a_event_item_attached: a_event_item /= Void
			is_appliable_event: is_appliable_event (a_event_item)
		local
			l_row: EV_GRID_ROW
		do
			l_row := find_event_row (a_event_item)
			if l_row /= Void then
				Result := event_context_stone_from_row (l_row)
			end
		end

	event_context_stone_from_row (a_row: EV_GRID_ROW): STONE
			-- Retrieve an event item's context stone, if one is available
			--
			-- `EV_GRID_ROW': A row to retrieve an event context from.
			-- `Result': A context stone, if any.
		require
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_data_set: ({EVENT_LIST_ITEM_I}) #? a_row.data /= Void
		local
			l_event_item: EVENT_LIST_ITEM_I
			l_error: ERROR
			l_line: INTEGER
			l_classi_stone: CLASSI_STONE
			l_classc_stone: CLASSC_STONE
			l_line_stone: LINE_STONE
		do
			l_event_item ?= a_row.data
			if l_event_item /= Void then
				Result ?= a_row.item (context_column).data
				if Result /= Void then
					l_error ?= l_event_item.data
					if l_error /= Void then
						l_line := l_error.line
						if l_line > 0 then
							l_classc_stone ?= Result
							if l_classc_stone /= Void then
								create {COMPILED_LINE_STONE}Result.make_with_line (l_classc_stone.e_class, l_line, True)
							else
								l_classi_stone ?= Result
								create {UNCOMPILED_LINE_STONE}Result.make_with_line (l_classi_stone.class_i, l_line, True)
							end
							l_line_stone ?= Result
							if l_line_stone /= Void then
								l_line_stone.set_should_line_be_selected (True)
								if l_error.column > 0 then
									l_line_stone.set_column_number (l_error.column)
								end
							end
						end
					end
				end
			end
		end

--feature {NONE} -- Helpers

--	fix_handlers: ES_ERROR_FIX_HANDLER
--			-- Shared access to fix operations.
--		once
--			create Result
--		ensure
--			result_attached: attached Result
--		end

feature {ES_TOOL} -- Basic operation

	show
			-- <Precursor>
		local
			l_width: INTEGER
			l_platform: PLATFORM
			l_grid: ES_GRID
		do
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE}

			create l_platform
			if l_platform.is_unix then
				-- This is hack for bug#13604
				l_grid := grid_events
				if l_grid /= Void and then not l_grid.is_destroyed then
					l_width := l_grid.width
				end
			end
		end

feature {NONE} -- Basic operations

	do_default_action (a_row: EV_GRID_ROW)
			-- <Precursor>
		do
			if attached {EVENT_LIST_ITEM_I} a_row.data as l_event_item then
				if attached {C_COMPILER_ERROR} l_event_item.data as l_error then
					if attached l_error.associated_feature as l_feature then
							-- Open the corresponding feature
						(create {EB_CONTROL_PICK_HANDLER}).launch_stone (create {FEATURE_STONE}.make (l_feature))
					elseif attached c_compiler_output as l_output then
							-- Show the C/C++ compiler output
						l_output.activate (True)
						if attached develop_window.shell_tools.tool ({ES_OUTPUTS_TOOL}) as l_tool then
							l_tool.show (True)
						end
					end
				else
					if
						attached event_context_stone_from_row (a_row) as l_stone and then
						l_stone.is_valid
					then
						(create {EB_CONTROL_PICK_HANDLER}).launch_stone (l_stone)
					end
				end
			end
		end

	show_context_menu (a_item: EV_GRID_ITEM; a_x: INTEGER; a_y: INTEGER)
			-- <Precursor>
		local
			l_menu: EV_MENU
			l_remove: EV_MENU_ITEM
		do
			if attached {EVENT_LIST_ITEM_I} a_item.row.data as l_item then
				create l_menu

					-- Remove, singluar
				create l_remove.make_with_text (interface_names.m_remove)
				l_remove.set_pixmap (stock_pixmaps.general_delete_icon)
				l_remove.select_actions.extend (agent remove_event_list_row (a_item.row))
				l_menu.extend (l_remove)

				if grid_events.selected_rows /= Void and then not grid_events.selected_rows.is_empty then
						-- Remove, multiple
					create l_remove.make_with_text (interface_names.m_remove_all)
					l_remove.set_pixmap (stock_pixmaps.general_delete_icon)
					l_remove.select_actions.extend (agent on_select_delete_button)
					l_menu.extend (l_remove)
				end
				l_menu.show_at (a_item.row.parent, a_x, a_y)
			else
					-- This occurs when the user requests a context menu on an error list subrow, which
					-- do not have context menus.
				check
					row_parented: a_item.row.parent_row /= Void
				end
			end

		end

	populate_event_grid_row_items (a_event_item: EVENT_LIST_ITEM_I; a_row: EV_GRID_ROW)
			-- Populates a grid row's item on a given row using the event `a_event_item'.
			--
			-- `a_event_item': A event to base the creation of a grid row on.
			-- `a_row': The row to create items on.
		local
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_gen: EB_EDITOR_TOKEN_GENERATOR
			l_item: EV_GRID_LABEL_ITEM
			l_error: ERROR
			l_tip: EB_EDITOR_TOKEN_TOOLTIP
			l_lines: LIST [EIFFEL_EDITOR_LINE]
			l_content: LIST [EDITOR_TOKEN]
			l_pixmap: EV_PIXMAP
			l_row: EV_GRID_ROW
			l_pos_token: EDITOR_TOKEN_NUMBER
			l_line: EIFFEL_EDITOR_LINE
			l_context_stone: STONE
			l_expanded: BOOLEAN
		do
			create l_item
			a_row.set_item (1, l_item)

				-- Set expand actions
			a_row.expand_actions.extend (agent on_row_expanded (a_row))

				-- Set category pixmap item
			create l_item
			l_pixmap := category_icon_from_event_item (a_event_item)
			if l_pixmap /= Void then
				l_item.set_pixmap (l_pixmap)

					-- Set string data for pixmap index, so it can be sorted.
				l_item.set_data (a_event_item.category.out)
				l_item.disable_full_select
			end
			a_row.set_item (category_column, l_item)

				-- Set error information
			l_error ?= a_event_item.data
			if l_error /= Void then
				create l_gen.make
				tracer.trace (l_gen, l_error, {ERROR_TRACER}.single_line)

				if l_gen.last_line /= Void and then l_gen.last_line.count > 0 then
					l_editor_item := create_clickable_grid_item (l_gen.last_line, False)
				else
					create l_editor_item.make_with_text ("No error message found!")
				end

					-- Lock update of editor item until everything has been set.
				l_editor_item.lock_update

				l_editor_item.disable_full_select
				if is_error_event (a_event_item) then
					l_editor_item.set_pixmap (stock_pixmaps.tool_error_icon)
				elseif is_warning_event (a_event_item) then
					l_editor_item.set_pixmap (stock_pixmaps.tool_warning_icon)
				else
					check False end
				end
				l_editor_item.set_spacing ({ES_UI_CONSTANTS}.grid_editor_item_spacing)

									-- Unlock editor item and call setting changed actions to signify that settings have changed.
				l_editor_item.unlock_update
				l_editor_item.try_call_setting_change_actions

				a_row.set_item (error_column, l_editor_item)

					-- Set row height
				a_row.set_height (l_editor_item.label_font_height.max ({ES_UI_CONSTANTS}.grid_row_height))

					-- Build full error text
				create l_gen.make
				l_gen.enable_multiline
				tracer.trace (l_gen, l_error, {ERROR_TRACER}.normal)
				l_lines := l_gen.lines
				if not l_lines.is_empty then
					l_tip := create_clickable_tooltip (l_lines, l_editor_item, a_row)
					a_row.select_actions.extend (agent l_tip.restart_tooltip_timer)

						-- Sub row full error
					a_row.insert_subrow (1)
					l_row := a_row.subrow (1)
					create l_item
					l_item.disable_full_select
					l_row.set_item (category_column, l_item)

					l_editor_item := create_multiline_clickable_grid_item (l_lines, True, False)
					l_row.set_height (l_tip.required_tooltip_height)
						-- No extra initialization needed so update `l_editor_item' to reflect settings.
					l_editor_item.try_call_setting_change_actions
					l_row.set_item (error_column, l_editor_item)
				end

					-- Context
				tracer.trace (l_gen, l_error, {ERROR_TRACER}.context)
				if l_gen.last_line /= Void then
					l_editor_item := create_clickable_grid_item (l_gen.last_line, False)
						-- No extra initialization needed so update `l_editor_item' to reflect settings.
					l_editor_item.try_call_setting_change_actions
					a_row.set_item (context_column, l_editor_item)
					l_content := l_gen.last_line.content
					if not l_content.is_empty then
							-- Set context pebble by iterating through the context content to find a feature
							-- or class token.
						from l_content.finish until l_content.before or l_context_stone /= Void loop
							if attached {EDITOR_TOKEN_FEATURE} l_content.item_for_iteration as l_ft then
								l_context_stone ?= l_ft.pebble
							elseif attached {EDITOR_TOKEN_CLASS} l_content.item_for_iteration as l_ct then
								l_context_stone ?= l_ct.pebble
							end
							l_content.back
						end
						if l_context_stone /= Void then
							l_editor_item.set_data (l_context_stone)
						end
					end
				end

					-- Line and column number
				l_editor_item := Void
				if l_error.line > 0 then
						-- Created position token
					create l_pos_token.make (l_error.line.out + ", " + l_error.column.max (1).out)
					if l_context_stone /= Void then
						l_pos_token.set_is_clickable (True)
							-- Note: We call `event_context_stone_from_row' instead of using `l_context_stone' because
							--       it uses line position information, unlike `l_context_stone'
						l_pos_token.set_pebble (event_context_stone_from_row (a_row))
					end

						-- Create editor item					
					create l_line.make_empty_line
					l_line.append_token (l_pos_token)
					l_editor_item := create_clickable_grid_item (l_line, False)
						-- No extra initialization needed so update `l_editor_item' to reflect settings.
					l_editor_item.try_call_setting_change_actions
				end
				a_row.set_item (position_column, l_editor_item)
			end

				-- Fill empty items
			if l_row /= Void then
				grid_events.grid_row_fill_empty_cells (l_row)
				l_row.set_height (l_row.height + 2)
			end
			grid_events.grid_row_fill_empty_cells (a_row)
			a_row.set_height (a_row.height + 2)

				-- Set visibility
			if is_error_event (a_event_item) then
				if not is_displaying_errors then
					a_row.hide
				end
			elseif is_warning_event (a_event_item) then
				if not is_displaying_warnings or else filter_widget /= Void and then not filter_widget.is_unfiltered (l_error) then
					a_row.hide
				end
			else
				check False end
			end

				-- Set expanded status
			if a_row.is_expandable and then is_error_event (a_event_item) then
				if is_expanding_errors then
					l_expanded := is_expanding_all_errors
					is_expanding_all_errors := True
					a_row.expand
					is_expanding_all_errors := l_expanded
				elseif a_row.is_expanded then
					a_row.collapse
				end
			end
		ensure then
			is_expanding_all_errors_unchanged: is_expanding_all_errors = old is_expanding_all_errors
		end

	update_tool_title_and_pixmap
			-- Sets the tool's title an pixmap based on the number of items existing in the list
		local
			l_title: STRING_32
			l_buffer: EV_PIXEL_BUFFER
		do
			l_title := interface_names.t_errors_and_warnings_tool.twin
			if item_count > 0 then
				l_title := l_title + " (" + error_count.out + "|" + warning_count.out + ")"
				if error_count > 0 and warning_count > 0 then
					l_buffer := stock_pixmaps.tool_errors_list_with_errors_and_warnings_icon_buffer
				elseif error_count > 0 then
					l_buffer := stock_pixmaps.tool_errors_list_with_errors_icon_buffer
				elseif warning_count > 0 then
					l_buffer := stock_pixmaps.tool_errors_list_with_warnings_icon_buffer
				else
					check False end
				end
			end

			if l_title /= Void and then not l_title.is_empty then
				set_title (l_title)
			end
			if l_buffer /= Void then
				set_icon (l_buffer)
			else
				set_icon (stock_pixmaps.tool_errors_list_with_errors_icon_buffer)
			end
		end

	update_content_applicable_widgets (a_enable: BOOLEAN)
			-- <Precursor>
		do
			if a_enable and grid_events.selected_rows.count >= 1 then
				error_info_command.enable_sensitive
				delete_button.enable_sensitive
			else
				error_info_command.disable_sensitive
--				fix_button.disable_sensitive
				delete_button.disable_sensitive
			end
		end

	update_content_applicable_navigation_buttons
			-- Updates content applicable navigation buttons
		do
			if error_count > 0 and errors_button.is_selected then
				go_to_next_error_command.enable_sensitive
				go_to_previous_error_command.enable_sensitive
			else
				go_to_next_error_command.disable_sensitive
				go_to_previous_error_command.disable_sensitive
			end

			if warning_count > 0  and warnings_button.is_selected then
				go_to_next_warning_command.enable_sensitive
				go_to_previous_warning_command.enable_sensitive
			else
				go_to_next_warning_command.disable_sensitive
				go_to_previous_warning_command.disable_sensitive
			end
		end

	update_error_and_warning_counters
			-- Updates the error and warning counters on the user interface.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_text: STRING_32
		do
			create l_text.make (20)
			l_text.append_natural_32 (error_count)
			l_text.append_character (' ')
			if error_count = 1 then
				l_text.append_string (interface_names.b_error)
			else
				l_text.append_string (interface_names.b_errors)
			end
			errors_button.set_text (l_text)

			create l_text.make (20)
			l_text.append_natural_32 (warning_count)
			l_text.append_character (' ')
			if warning_count = 1 then
				l_text.append_string (interface_names.b_warning)
			else
				l_text.append_string (interface_names.b_warnings)
			end
			warnings_button.set_text (l_text)

			update_tool_title_and_pixmap
		end

feature {ES_ERROR_LIST_COMMANDER_I} -- Basic operations: Navigation

	go_to_next_error (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if is_displaying_errors then
				if error_count > 0 then
					move_next (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
						require
							a_item_attached: a_item /= Void
						do
							Result := is_error_event (a_item) and then
								(event_context_stone (a_item) /= Void or
									-- C compiler errors have not context stone so we need to account for this.
								({C_COMPILER_ERROR}) #? a_item.data /= Void)
						end)
				end
			end
		end

	go_to_previous_error (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if is_displaying_errors then
				if error_count > 0 then
					move_previous (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
						require
							a_item_attached: a_item /= Void
						do
							Result := is_error_event (a_item) and then
								(event_context_stone (a_item) /= Void or
									-- C compiler errors have not context stone so we need to account for this.
								({C_COMPILER_ERROR}) #? a_item.data /= Void)
						end)
				end
			end
		end

	go_to_next_warning (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if is_displaying_warnings then
				if warning_count > 0 then
					move_next (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
						require
							a_item_attached: a_item /= Void
						do
							Result := is_warning_event (a_item) and then event_context_stone (a_item) /= Void
						end)
				end
			end
		end

	go_to_previous_warning (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if is_displaying_warnings then
				if warning_count > 0 then
					move_previous (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
						require
							a_item_attached: a_item /= Void
						do
							Result := is_warning_event (a_item) and then event_context_stone (a_item) /= Void
						end)
				end
			end
		end

feature {NONE} -- Event handlers

	on_unlocked (a_sender: attached LOCKABLE_I)
			-- <Precursor>
		do
			update_error_and_warning_counters
			Precursor (a_sender)
		end

	on_event_item_added (a_service: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I)
			-- <Precursor>
		local
			l_applicable: BOOLEAN
		do
			l_applicable := is_appliable_event (a_event_item)
			if l_applicable and not is_initialized then
					-- We have to perform initialization to set the icon and counter.
					-- Synchronization with the event list service is surpress to prevent duplication of event items being added.
				is_event_list_synchronized_on_initialized := False
				initialize
			end

			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE} (a_service, a_event_item)

			if l_applicable then
				if is_error_event (a_event_item) then
					set_error_count (error_count + 1)
				elseif is_warning_event (a_event_item) then
					set_warning_count (warning_count + 1)
				else
					check False end
				end
				update_content_applicable_navigation_buttons
			end
		ensure then
			is_initialized: is_appliable_event (a_event_item) implies is_initialized
		end

	on_event_item_removed (a_service: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I)
			-- <Precursor>
		local
			l_applicable: BOOLEAN
		do
			l_applicable := is_appliable_event (a_event_item)
			if l_applicable and not is_initialized then
					-- We have to perform initialization to set the icon and counter
					-- Synchronization with the event list service is surpress to prevent duplication of event items being added.
				is_event_list_synchronized_on_initialized := False
				initialize
			end

			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE} (a_service, a_event_item)
			if l_applicable then
				if is_error_event (a_event_item) then
					set_error_count (error_count - 1)
				elseif is_warning_event (a_event_item) then
					set_warning_count (warning_count - 1)
				else
					check False end
				end
				update_content_applicable_navigation_buttons
			end
		ensure then
			is_initialized: is_appliable_event (a_event_item) implies is_initialized
		end

	on_session_value_changed (a_session: SESSION; a_id: STRING_8)
			-- <Precursor>
		do
			if a_id.is_equal (expand_errors_session_id) then
					-- Retrieve global session
				if attached {BOOLEAN_REF} a_session.value_or_default (expand_errors_session_id, False) as l_expand then
					if is_expanding_errors /= l_expand.item then
						is_expanding_errors := l_expand.item
						if is_expanding_errors then
							expand_errors_button.enable_select
						else
							expand_errors_button.disable_select
						end
						on_toggle_expand_errors_button
					end
				end
			end
		end

feature {NONE} -- Action handlers

	on_row_selected (a_row: EV_GRID_ROW)
			-- Called when a row is selected in the event list row.
			--
			-- `a_row': The selected row.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_row_attached: attached a_row
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_has_grid_events_as_parent: a_row.parent = grid_events
		local
--			l_fix_handlers: like fix_handlers
--			l_rows: ARRAYED_LIST [EV_GRID_ROW]
--			l_first_error: ERROR
--			l_enable: BOOLEAN
		do
--				-- Scan the selected errors for applicability to fix errors.
--			l_fix_handlers := fix_handlers
--			l_rows := grid_events.selected_rows
--			if not l_rows.is_empty then
--				l_enable := True
--				from l_rows.start until l_rows.after loop
--					if
--						attached {EVENT_LIST_ERROR_ITEM_I} l_rows.item_for_iteration.data as l_error_item and then
--						attached {EIFFEL_ERROR} l_error_item.data as l_error
--					then
--						if attached l_first_error then
--							l_enable := l_first_error.generating_type ~ l_error.generating_type
--						else
--							if l_fix_handlers.is_fixable (l_error) then
--								l_first_error := l_error
--							else
--								l_enable := False
--							end
--						end
--					end
--					l_rows.forth
--				end
--			end

--			if l_enable then
--				fix_button.enable_sensitive
--			else
--				fix_button.disable_sensitive
--			end
		end

	on_row_deselected (a_row: EV_GRID_ROW)
			-- Called when a row is deselected in the event list row.
			--
			-- `a_row': The deselected row.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_row_attached: attached a_row
		local
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			l_rows := grid_events.selected_rows
			if l_rows.is_empty then
--				fix_button.disable_sensitive
			end
		end

	on_row_expanded (a_row: EV_GRID_ROW)
			-- Called when the expand error button is selected.
			--
			-- `a_row': The row that was expanded.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_has_grid_events_as_parent: a_row.parent = grid_events
			a_row_is_expanded: a_row.is_expanded
		do
			if not is_expanding_all_errors then
				grid_events.selected_rows.do_all (agent {EV_GRID_ROW}.disable_select)
				a_row.enable_select
				if a_row.subrow_count > 0 then
						-- Ensure the row is visible.
					a_row.subrow (1).ensure_visible
				end
			end
		end

	on_handle_key (a_key: EV_KEY; a_alt: BOOLEAN; a_ctrl: BOOLEAN; a_shift: BOOLEAN; a_released: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
			if a_released and then not a_alt and then not a_ctrl and then not a_shift then
				if a_key.code = {EV_KEY_CONSTANTS}.key_delete then
					remove_all_selected_event_list_rows
					Result := True
				end
			end
			if not Result then
				Result := Precursor (a_key, a_alt, a_ctrl, a_shift, a_released)
			end
		end

	on_toogle_errors_button
			-- Called when `errors_button' is selected.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_grid: like grid_events
			l_row: EV_GRID_ROW
			l_event_item: EVENT_LIST_ITEM_I
			l_count, i: INTEGER
		do
			l_grid := grid_events
			from
				i := 1
				l_count := l_grid.row_count
			until
				i > l_count
			loop
				l_row := l_grid.row (i)
				l_event_item ?= l_row.data
				if l_event_item /= Void then
					if is_error_event (l_event_item) then
						if is_displaying_errors then
							l_row.show
						else
							l_row.hide
						end
					end
				end
				i := i + 1
			end

			update_content_applicable_navigation_buttons
		end

	on_toogle_warnings_button
			-- Called when `warnings_button' is selected
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_row: EV_GRID_ROW
			l_event_item: EVENT_LIST_ITEM_I
			l_warning: ERROR
			l_filter_widget: like filter_widget
			l_show: BOOLEAN
			l_count, i: INTEGER
		do
			l_filter_widget := filter_widget
			l_show := is_displaying_warnings
			from
				i := 1
				l_count := grid_events.row_count
			until
				i > l_count
			loop
				l_row := grid_events.row (i)
				l_event_item ?= l_row.data
				if l_event_item /= Void then
					if is_warning_event (l_event_item) then
						l_warning ?= l_event_item.data
						check l_warning_attached: l_warning /= Void end
						if l_warning /= Void and then l_show and l_filter_widget.is_unfiltered (l_warning) then
							l_row.show
						else
							l_row.hide
						end
					end
				end
				i := i + 1
			end

			update_content_applicable_navigation_buttons
		end

	on_toggle_expand_errors_button
			-- Called when the expand error button is selected
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_is_expanding_all_errors: not is_expanding_all_errors
		local
			l_expand: BOOLEAN
			l_grid: like grid_events
			l_row: EV_GRID_ROW
			l_event_item: EVENT_LIST_ERROR_ITEM_I
			l_count, i: INTEGER
		do
			l_expand := expand_errors_button.is_selected
			if is_expanding_errors /= l_expand then
				is_expanding_all_errors := l_expand
				is_expanding_errors := l_expand
				if session_manager.is_service_available then
					session_manager.service.retrieve (False).set_value (l_expand, expand_errors_session_id)
				end

					-- Set applicable grid items and open/closed because on expanded status
				l_grid := grid_events
				from
					i := 1
					l_count := l_grid.row_count
				until
					i > l_count
				loop
					l_row := l_grid.row (i)
					if l_row.is_expandable then
						l_event_item ?= l_row.data
						if l_event_item /= Void and then is_error_event (l_event_item) then
							if l_expand then
								l_row.expand
							else
								l_row.collapse
							end
						end
					end
					i := i + 1
				end
				is_expanding_all_errors := False
			end
		ensure
			is_expanding_errors_set: is_expanding_errors = expand_errors_button.is_selected
			not_is_expanding_all_errors: not is_expanding_all_errors
		end

--	on_select_fix_button
--			-- Caled when the `fix_errors_button' is selected.
--		require
--			is_interface_usable: is_interface_usable
--			is_initialized: is_initialized
--		local
--			l_selected: ARRAYED_LIST [EV_GRID_ROW]
--			l_errors: ARRAYED_LIST [EIFFEL_ERROR]
--			l_fix_handlers: like fix_handlers
--			l_handler: ES_JIM_ERROR_HANDLER [EIFFEL_ERROR]
--			l_items: ARRAYED_LIST [TUPLE [title: STRING_GENERAL; action: PROCEDURE [ANY, TUPLE]]]
--			l_menu_item: EV_MENU_ITEM
--			l_menu: EV_MENU
--		do
--			l_fix_handlers := fix_handlers
--			l_selected := grid_events.selected_rows
--			create l_errors.make (l_selected.count)
--			from l_selected.start until l_selected.after loop
--				if
--					attached {EVENT_LIST_ERROR_ITEM_I} l_selected.item_for_iteration.data as l_error_item and then
--					attached {EIFFEL_ERROR} l_error_item.data as l_error
--				then
--					if l_fix_handlers.is_fixable (l_error) then
--						l_errors.extend (l_error)
--					end
--				end
--				l_selected.forth
--			end

--			if not l_errors.is_empty then
--				l_handler := l_fix_handlers.fix_errors (l_errors)
--				l_items := l_handler.solution_actions
--				if attached l_items and not l_items.is_empty then
--					if l_items.count = 1 then
--							-- Only one item, just process the action.
--						l_items.first.action.call (Void)
--					else
--							-- Multiple items, as user to select.
--						l_menu := fix_button.menu
--						l_menu.wipe_out
--						from l_items.start until l_items.after loop
--							create l_menu_item.make_with_text_and_action (l_items.item.title, l_items.item.action)
--							l_menu.extend (l_menu_item)
--							l_items.forth
--						end
--						fix_button.perform_select
--					end
--				end
--			end
--		end

	on_select_delete_button
			-- Caled when the `delete_button' is selected.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			remove_all_selected_event_list_rows
		end

	on_select_error_info
			-- Call when the error information button is clicked.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_event: EVENT_LIST_ITEM_I
			l_error: ERROR
		do
			if not grid_events.selected_rows.is_empty then
					-- Retrieve event item set from {ES_EVENT_LIST_TOOL_PANEL_BASE}.on_event_added
				l_event ?= grid_events.selected_rows.first.data
				if l_event /= Void then
						-- Now retrieve error item
					l_error ?= l_event.data
					check
						l_error_attached: l_error /= Void
					end

				end
			end

			if l_error = Void then
					-- No error found. This can happen when the expanded information row is selected.
				error_info_command.execute
			else
				error_info_command.execute_with_stone (create {ERROR_STONE}.make (l_error))
			end
		end

	on_warnings_filter_changed (a_type: TYPE [ANY]; a_exact_only: BOOLEAN; a_exclude: BOOLEAN)
			-- Called when the filter has been changed
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_filter: ES_WARNINGS_FILTER_WIDGET
			l_grid: like grid_events
			l_row: EV_GRID_ROW
			l_event: EVENT_LIST_ITEM_I
			l_warning: ERROR
			l_count, i: INTEGER
		do
			l_filter := filter_widget
			l_grid := grid_events
			from l_count := l_grid.row_count; i := 1 until i > l_count loop
				l_row := l_grid.row (i)
				if a_exclude /= not l_row.is_show_requested then
					l_event ?= l_row.data
					if l_event /= Void and then is_warning_event (l_event) then
						l_warning ?= l_event.data
						if l_warning /= Void then
							if not l_filter.is_unfiltered (l_warning) then
								if a_exclude then
									l_row.hide
								end
							else
								if not a_exclude then
									l_row.show
								end
							end
						end
					end
				end

				if l_row.subrow_count_recursive > 1 then
					i := i + l_row.subrow_count_recursive
				else
					i := i + 1
				end
			end

			if l_filter.filtered.is_empty then
				filter_button.set_pixel_buffer (stock_pixmaps.errors_and_warnings_filter_icon_buffer)
				filter_button.set_pixmap (stock_pixmaps.errors_and_warnings_filter_icon)
			else
				filter_button.set_pixel_buffer (stock_pixmaps.errors_and_warnings_filter_active_icon_buffer)
				filter_button.set_pixmap (stock_pixmaps.errors_and_warnings_filter_active_icon)
			end
		end

feature {NONE} -- Factory

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
			create errors_button.make
			errors_button.set_text (("0 ").as_string_32 + interface_names.b_errors.as_string_32)
			errors_button.set_pixmap (stock_pixmaps.tool_error_icon)
			errors_button.set_pixel_buffer (stock_pixmaps.tool_error_icon_buffer)
			errors_button.enable_select
			errors_button.select_actions.extend (agent on_toogle_errors_button)
			errors_button.select_actions.compare_objects

			create warnings_button.make
			warnings_button.set_text (("0 ").as_string_32 + interface_names.b_warnings.as_string_32)
			warnings_button.set_pixmap (stock_pixmaps.tool_warning_icon)
			warnings_button.set_pixel_buffer (stock_pixmaps.tool_warning_icon_buffer)
			warnings_button.enable_select
			warnings_button.select_actions.extend (agent on_toogle_warnings_button)
			warnings_button.select_actions.compare_objects

			create Result.make (3)
			Result.put_last (errors_button)
			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)
			Result.put_last (warnings_button)
		ensure then
			errors_button_attached: errors_button /= Void
			warnings_button_attached: warnings_button /= Void
		end

	create_right_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_button: SD_TOOL_BAR_BUTTON
		do
			create Result.make (11)

				-- Navigation buttons
			l_button := go_to_next_error_command.new_sd_toolbar_item (False)
			Result.put_last (l_button)

			l_button := go_to_previous_error_command.new_sd_toolbar_item (False)
			Result.put_last (l_button)

			l_button := go_to_next_warning_command.new_sd_toolbar_item (False)
			Result.put_last (l_button)

			l_button := go_to_previous_warning_command.new_sd_toolbar_item (False)
			Result.put_last (l_button)

--				-- Separator
--			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

--			create fix_button.make
--			fix_button.set_pixel_buffer (stock_pixmaps.errors_and_warnings_fix_icon_buffer)
--			fix_button.set_pixmap (stock_pixmaps.errors_and_warnings_fix_icon)
--			fix_button.set_tooltip (locale_formatter.translation (tt_fix_errors))
--			fix_button.set_menu (create {EV_MENU})
--			register_action (fix_button.select_actions, agent on_select_fix_button)
--			Result.put_last (fix_button)

			create delete_button.make
			delete_button.set_pixel_buffer (stock_pixmaps.general_delete_icon_buffer)
			delete_button.set_pixmap (stock_pixmaps.general_delete_icon)
			delete_button.set_tooltip (locale_formatter.translation (tt_delete_items))
			register_action (delete_button.select_actions, agent on_select_delete_button)
			Result.put_last (delete_button)

				-- Separator
			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Automatic expand error button
			create expand_errors_button.make
			expand_errors_button.set_pixmap (stock_pixmaps.errors_and_warnings_expand_errors_icon)
			expand_errors_button.set_pixel_buffer (stock_pixmaps.errors_and_warnings_expand_errors_icon_buffer)
			expand_errors_button.set_tooltip (interface_names.f_toogle_expand_errors)
			register_action (expand_errors_button.select_actions, agent on_toggle_expand_errors_button)
			Result.put_last (expand_errors_button)

			create error_info_command.make
			error_info_button := error_info_command.new_sd_toolbar_item (False)
				-- We need to do something else, like handle grid selection
			error_info_button.select_actions.wipe_out
			register_action (error_info_button.select_actions, agent on_select_error_info)
			Result.put_last (error_info_button)

				-- Filter pop up widget
			create filter_widget.make
			register_action (filter_widget.filter_changed_actions, agent on_warnings_filter_changed)

				-- Filter button
			create filter_button.make
			filter_button.set_pixmap (stock_pixmaps.metric_filter_icon)
			filter_button.set_pixel_buffer (stock_pixmaps.metric_filter_icon_buffer)
			filter_button.set_tooltip (interface_names.f_filter_warnings)
			filter_button.set_popup_widget (filter_widget)

			Result.put_last (filter_button)
		ensure then
			filter_button_attached: filter_button /= Void
		end

feature {NONE} -- Constants

	category_column: INTEGER = 2
	error_column: INTEGER = 3
	context_column: INTEGER = 4
	position_column: INTEGER = 5

	expand_errors_session_id: STRING = "com.eiffel.error_list.expand_errors"

feature {NONE} -- Internationalization

	tt_delete_items: STRING = "Delete all the selected [completed] items"
--	tt_fix_errors: STRING = "Automatically fix the selected errors."

invariant
	errors_button_attached: (is_initialized and is_interface_usable) implies attached errors_button
	warnings_button_attached: (is_initialized and is_interface_usable) implies attached warnings_button
--	fix_button_attached: (is_initialized and is_interface_usable) implies attached fix_button
	deletebutton_attached: (is_initialized and is_interface_usable) implies attached delete_button
	expand_errors_button_attached: (is_initialized and is_interface_usable) implies attached expand_errors_button
	error_info_button_attached: (is_initialized and is_interface_usable) implies attached error_info_button
	filter_button_attached: (is_initialized and is_interface_usable) implies attached filter_button
	item_count_matches_error_and_warning_count: error_count + warning_count = item_count

;note
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
