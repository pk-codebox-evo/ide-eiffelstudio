indexing
	description: "Objects that visualize a test suite in a grid"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE_TOOL

inherit
	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EB_EDITOR_TOKEN_GRID_SUPPORT
		redefine
			grid
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EV_LAYOUT_CONSTANTS
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make_with_tool

feature {NONE} -- Initialization

	make_with_tool (a_window: EB_DEVELOPMENT_WINDOW; a_tool: EB_CONTEXT_TOOL) is
			-- Set 'development_window' to 'a_window' list all available
			-- test cases in the test suite if testing is enabled.
		require
			a_window_not_void: a_window /= Void
		do
			development_window := a_window
			manager := development_window.eb_debugger_manager.cdd_manager
			internal_add_test_case_agent := agent add_test_case
			internal_remove_test_case_agent := agent remove_test_case
			internal_refresh_agent := agent refresh
			internal_testing_status_agent := agent update_testing_status
			internal_output_agent := agent append_output
			initialize

			manager.add_test_case_actions.extend (internal_add_test_case_agent)
			manager.remove_test_case_actions.extend (internal_remove_test_case_agent)
			manager.refresh_actions.extend (internal_refresh_agent)

			tester.update_status_actions.extend (internal_testing_status_agent)
			tester.output_actions.extend (internal_output_agent)

			refresh
		end

	initialize is
			-- Initialize all widgets used in 'Current'
		local
			l_split: EV_HORIZONTAL_SPLIT_AREA
		do
			create widget
			create l_split

			build_tool_bar

			build_grid (l_split)
			build_output (l_split)
			l_split.set_split_position (400)

			widget.extend (l_split)

			build_status_bar
		end

	build_tool_bar is
			-- Create widgets for displaying a tool bar
		require
			widget_not_void: widget /= Void
		local
			l_vbox: EV_VERTICAL_BOX
		do
			create l_vbox
			create tool_bar

			create run_button
			run_button.set_tooltip ("Run test cases in background")
			run_button.set_pixmap (pixmaps.icon_pixmaps.debug_run_without_breakpoint_icon)
			run_button.select_actions.extend (agent on_run_button)
			run_button.disable_sensitive

			create pause_button
			pause_button.set_tooltip ("Pause testing")
			pause_button.set_pixmap (pixmaps.icon_pixmaps.debug_pause_icon)
			pause_button.select_actions.extend (agent on_pause_button)
			pause_button.disable_sensitive

			create stop_button
			stop_button.set_tooltip ("Stop testing")
			stop_button.set_pixmap (pixmaps.icon_pixmaps.debug_stop_icon)
			stop_button.select_actions.extend (agent on_stop_button)
			stop_button.disable_sensitive

			create delete_button
			delete_button.set_tooltip ("Remove test case")
			delete_button.set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)
			delete_button.select_actions.extend (agent on_delete_button)
			delete_button.disable_sensitive

			create debug_button
			debug_button.set_tooltip ("Run test case in debugger")
			debug_button.set_pixmap (pixmaps.icon_pixmaps.debug_run_icon)
			debug_button.select_actions.extend (agent on_debug_button)
			debug_button.disable_sensitive

			create enable_testing_button
			enable_testing_button.set_tooltip ("Enable Testing")
			enable_testing_button.set_pixmap (pixmaps.icon_pixmaps.breakpoints_enable_icon)
			enable_testing_button.select_actions.extend (agent on_enable_testing_button)
			enable_testing_button.disable_sensitive

			tool_bar.extend (run_button)
			tool_bar.extend (debug_button)
			tool_bar.extend (pause_button)
			tool_bar.extend (stop_button)
			tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
			tool_bar.extend (delete_button)
			tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
			tool_bar.extend (enable_testing_button)

			l_vbox.extend (tool_bar)
			l_vbox.extend (create {EV_HORIZONTAL_SEPARATOR})
			widget.extend (l_vbox)
			widget.disable_item_expand (l_vbox)
		end

	build_grid (a_list: EV_CONTAINER) is
			-- Initialize grid widget for hierarchically listing test cases
			-- and extend 'a_list' with grid widget.
		require
			valid_list: a_list /= Void and then a_list.extendible
			list_not_destroyed: not a_list.is_destroyed
		do
			create grid.make
			enable_editor_token_pnd
			a_list.extend (grid)
		end

	build_output (a_list: EV_CONTAINER) is
			-- Initialize output box for displaying messages from
			-- the tester.
		require
			valid_list: a_list /= Void and then a_list.extendible
			list_not_destroyed: not a_list.is_destroyed
		local
			l_frame: EV_FRAME
		do
			create l_frame.make_with_text ("Ouput")
			create output
			l_frame.extend (output)
			a_list.extend (l_frame)
		end


	build_status_bar is
			-- Create 'status_bar' and extend
		require
			widget_not_void: widget /= Void
		local
			l_frame: EV_FRAME
		do
			create status_bar

			create l_frame
			create status_label.make_with_text (tester.status_text)
			status_label.align_text_left
			l_frame.extend (status_label)
			status_bar.extend (l_frame)

			create l_frame
			create progress_bar
			l_frame.set_minimum_width (200)
			l_frame.extend (progress_bar)
			status_bar.extend (l_frame)
			status_bar.disable_item_expand (l_frame)

			widget.extend (status_bar)
			widget.disable_item_expand (status_bar)
		end

feature -- Access

	development_window: EB_DEVELOPMENT_WINDOW
			-- Development window in which widget is displayed

	widget: EV_VERTICAL_BOX
			-- Widget for displaying 'Current'

	manager: CDD_TEST_SUITE_MANAGER
			-- Manager for test suite operations

	tester: CDD_TEST_SUITE_TESTER is
			-- Tester for executing test cases
		do
			Result := manager.tester
		end

feature -- Status setting

	add_test_case (a_tc: CDD_TEST_CASE) is
			-- Add `a_tc' to `grid'.
		require
			a_tc_not_void: a_tc /= Void
		do
			grid.add_test_case (a_tc)
			if not run_button.is_sensitive then
				run_button.enable_sensitive
			end
		end

	remove_test_case (a_tc: CDD_TEST_CASE) is
			-- Remove `a_tc' from `grid'.
		require
			a_tc_not_void: a_tc /= Void
		do
			if selected_test_case_line /= Void then
				selected_test_case_line.grid_row.disable_select
			end
			grid.remove_test_case (a_tc)
			if manager.test_suite.test_cases.count = 0 then
				run_button.disable_sensitive
			end
		end

	refresh is
			-- Refresh widget elements with current test suite status.
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
		do
			development_window.lock_update
			run_button.disable_sensitive
			grid.remove_and_clear_all_rows
			if manager.is_testing_enabled then
				enable_testing_button.disable_sensitive
				grid.enable_sensitive
				output.enable_sensitive
				from
					l_cursor := manager.test_suite.test_cases.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					grid.add_test_case (l_cursor.item)
					l_cursor.forth
				end

				if grid.row_count > 0 then
					run_button.enable_sensitive
				end
			else
				enable_testing_button.enable_sensitive
				grid.disable_sensitive
				output.disable_sensitive
			end
			development_window.unlock_update
		end

	update_testing_status is
			-- Adapt widgets to current testing status.
		require
			manager.is_testing_enabled
		do
			if tester.is_running then
				if tester.is_paused then
					if tester.is_debugging then
						debug_button.enable_sensitive
					else
						run_button.enable_sensitive
					end
					pause_button.disable_sensitive
				else
					pause_button.enable_sensitive
					if tester.is_testing and not tester.is_debugging then
						progress_bar.set_value (tester.current_index*100//tester.test_cases.count)
					end
				end
				stop_button.enable_sensitive
			else
				progress_bar.set_value (0)
				stop_button.disable_sensitive
				pause_button.disable_sensitive
				run_button.enable_sensitive
				debug_button.enable_sensitive
			end
			status_label.set_text (tester.status_text)
		end

	append_output (an_output: STRING) is
			-- Append 'an_output' to output box and scroll to bottom.
		require
			an_output_not_void: an_output /= Void
		do
			output.append_text (an_output)
			if output.line_count > 100 then
				output.select_lines (1, output.line_count - 100)
				output.delete_selection
			end
			output.scroll_to_line (output.line_count)
		end

	recycle is
			-- Prune 'Current' from manager and tester and remove widgets.
		do
			manager.add_test_case_actions.prune (internal_add_test_case_agent)
			manager.remove_test_case_actions.prune (internal_remove_test_case_agent)
			manager.refresh_actions.prune (internal_refresh_agent)
			tester.update_status_actions.prune (internal_testing_status_agent)
			tester.output_actions.prune (internal_output_agent)
			grid.wipe_out
		end

feature {CDD_GRID_TEST_CASE_LINE} -- Selection

	selected_test_case_line: CDD_GRID_TEST_CASE_LINE
			-- Currently selected test case in tree, Void if no test case is selected

	on_select_test_case (a_tc_line: like selected_test_case_line) is
			-- Actions performed when test case item in tree is selected.
		require
			valid_item: a_tc_line /= Void
		do
			selected_test_case_line := a_tc_line
			delete_button.enable_sensitive
			debug_button.enable_sensitive
		ensure
			selected_test_case_line_set: selected_test_case_line = a_tc_line
			delete_button_sensitive: delete_button.is_sensitive
		end

	on_deselect is
			-- Actions performed when item in tree is deselected.
		do
			selected_test_case_line := Void
			delete_button.disable_sensitive
			debug_button.disable_sensitive
		ensure
			nothing_selected: selected_test_case_line = Void
			delete_button_not_sensitive: not delete_button.is_sensitive
		end


feature {NONE} -- Button events

	on_enable_testing_button is
			-- Actions performed when enable testing button is pressed.
		require
			testing_not_enabled: not manager.is_testing_enabled
		local
			l_wd: EV_WARNING_DIALOG
		do
			if manager.can_enable_testing then -- Can initialize
				manager.enable_testing
			else
				create l_wd.make_with_text ("Can not add cdd_testing cluster because compiled configuration is not up to date, please recompile.")
				l_wd.show_modal_to_window (development_window.window)
			end
		end

	on_run_button is
			-- Start testing execution if not started yet, otherwise resume execution.
		require
			has_test_cases: manager.test_suite.test_cases.count > 0
		do
			if tester.is_paused then
				tester.resume
			elseif tester.can_start_background_testing then
				tester.start_background_testing
			else
				-- TODO: Notify user that background testing is not possible
			end
		end

	on_debug_button is
			-- Run selected test case in the debugger.
		require
			test_case_selected: selected_test_case_line /= Void
		do
			if tester.is_paused then
				tester.resume
			elseif tester.can_start_debugged_testing then
				tester.start_debugged_testing (selected_test_case_line.test_case)
			end
		end


	on_stop_button is
			-- Stop testing execution.
		require
			running: tester.is_running
		do
			tester.stop
		end

	on_pause_button is
			-- Pause testing execution.
		require
			running: tester.is_running
			not_paused: not tester.is_paused
		do
			tester.pause
		end

	on_delete_button is
			-- Delete single test case from test suite.
		require
			test_case_selected: selected_test_case_line /= Void
		local
			l_msg: STRING
			l_cd: EV_CONFIRMATION_DIALOG
		do
			l_msg := "The selected test case will be permanently removed from the system and from the disc.%N%N%
					%Are you sure this is what you want?"
			create l_cd.make_with_text_and_actions (l_msg, << agent try_remove_test_case >>)
			l_cd.show_modal_to_window (development_window.window)
		end

	try_remove_test_case is
			-- If test suite still contains `selected_test_case' remove it.
		require
			test_case_selected: selected_test_case_line /= Void
		do
			if manager.test_suite.test_cases.has (selected_test_case_line.test_case) then
				manager.remove_test_case (selected_test_case_line.test_case)
			end
		end

feature {NONE} -- Action implementation

	internal_status_agent: PROCEDURE [like Current, TUPLE]
			-- Agent called when testing is enabled/disabled

	internal_add_test_case_agent: PROCEDURE [like Current, TUPLE [CDD_TEST_CASE]]
			-- Agent called when test case is added

	internal_remove_test_case_agent: PROCEDURE [like Current, TUPLE [CDD_TEST_CASE]]
			-- Agent called when test case is removed

	internal_refresh_agent: PROCEDURE [like Current, TUPLE]
			-- Agent called when test suite is refreshed

	internal_testing_status_agent: PROCEDURE [like Current, TUPLE]
			-- Agent called when testing status changes

	internal_output_agent: PROCEDURE [like Current, TUPLE [STRING]]
			-- Agent called when output is read from tester


feature {NONE} -- Implementation

	tool_bar: EV_TOOL_BAR
			-- Tool bar for test case manipulation

	enable_testing_button: EV_TOOL_BAR_BUTTON
			-- Button for enabling testing

	run_button, stop_button, pause_button: EV_TOOL_BAR_BUTTON
			-- Buttons for controlling test execution

	debug_button: EV_TOOL_BAR_BUTTON
			-- Button for running selected test cases in the debugger

	delete_button: EV_TOOL_BAR_BUTTON
			-- Button for deleting a single test case

	output: EV_TEXT
			-- Output from external processes

	status_bar: EV_STATUS_BAR
			-- Status bar showing the current tester status

	status_label: EV_LABEL
			-- Label describing current tester status

	progress_bar: EV_HORIZONTAL_PROGRESS_BAR
			-- Progress bar showing current tester status

feature  -- Tree Implementation

	grid: CDD_GRID
			-- Grid for hierarchically displaying test cases


invariant
	development_window_not_void: development_window /= Void
	manager_not_void: manager /= Void
	widget_not_void: widget /= Void
	grid_valid: grid /= Void
	tool_bar_valid: tool_bar /= Void
	output_valid: output /= Void
	enable_testing_button_valid: enable_testing_button /= Void
	run_button_valid: run_button /= Void
	stop_button_valid: stop_button /= Void
	pause_button_valid: pause_button /= Void
	delete_button_valid: delete_button /= Void
	status_bar_valid: status_bar /= Void
	status_label_valid: status_label /= Void
	progress_bar_valid: progress_bar /= Void
	internal_testing_status_agent_not_void: internal_testing_status_agent /= Void
	internal_output_agent_not_void: internal_output_agent /= Void

end -- Class CDD_TEST_SUITE_TOOL
