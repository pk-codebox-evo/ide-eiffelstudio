indexing
	description: "Tool for displaying testing results"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TOOL

inherit

	EB_TOOL
		rename
			manager as window
		redefine
			make
		end

	EB_EDITOR_TOKEN_GRID_SUPPORT
		redefine
			grid
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: like window) is
			--
		do
			manager := a_window.eb_debugger_manager.cdd_manager
			Precursor {EB_TOOL} (a_window)

			internal_add_test_case_agent := agent add_test_case
			internal_remove_test_case_agent := agent remove_test_case
			internal_refresh_agent := agent refresh
			internal_testing_status_agent := agent update_testing_status

			manager.add_test_case_actions.extend (internal_add_test_case_agent)
			manager.remove_test_case_actions.extend (internal_remove_test_case_agent)
			manager.refresh_actions.extend (internal_refresh_agent)

			tester.update_status_actions.extend (internal_testing_status_agent)

			refresh
		end


	build_interface is
			-- Build `widget' for displaying and controlling testing.
		do
			create widget
			create grid.make
			enable_editor_token_pnd
			enable_ctrl_right_click_to_open_new_window
			grid.row_select_actions.extend (agent select_test_case)
			grid.row_deselect_actions.extend (agent deselect_test_case)
			widget.extend (grid)
			build_status_bar
			build_tool_bar
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
			l_frame.set_minimum_width (100)
			l_frame.extend (progress_bar)
			status_bar.extend (l_frame)
			status_bar.disable_item_expand (l_frame)

			widget.extend (status_bar)
			widget.disable_item_expand (status_bar)
		end

	build_tool_bar is
			-- Create widgets for displaying a tool bar
		do
			create mini_tool_bar

			create run_button
			run_button.set_tooltip ("Run test cases in background")
			run_button.set_pixmap (pixmaps.icon_pixmaps.debug_run_icon)
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
			enable_testing_button.set_pixmap (pixmaps.mini_pixmaps.general_toogle_icon)
			enable_testing_button.select_actions.extend (agent on_enable_testing_button)
			enable_testing_button.disable_sensitive

			mini_tool_bar.extend (run_button)
			mini_tool_bar.extend (debug_button)
			mini_tool_bar.extend (pause_button)
			mini_tool_bar.extend (stop_button)
			mini_tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
			mini_tool_bar.extend (delete_button)
			mini_tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
			mini_tool_bar.extend (enable_testing_button)
		end

	build_explorer_bar_item (an_explorer_bar: EB_EXPLORER_BAR) is
			-- Create `explorer_bar_item' and add it to the explorer bar.
		do
			create explorer_bar_item.make_with_mini_toolbar (an_explorer_bar, widget, title, True, mini_tool_bar)
			explorer_bar_item.set_menu_name (title)
			explorer_bar_item.set_pixmap (pixmaps.icon_pixmaps.tool_feature_icon)
			an_explorer_bar.add (explorer_bar_item)
		end

feature -- Access

	title: STRING is "Testing"

	widget: EV_VERTICAL_BOX

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
			-- NOTE: Full refresh because there is a problem with redrawing the grid when only a single line is removed.
			refresh
		end

	refresh is
			-- Refresh widget elements with current test suite status.
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
		do
			window.lock_update
			run_button.disable_sensitive
			grid.remove_and_clear_all_rows
			if manager.is_testing_enabled then
				enable_testing_button.disable_sensitive
				grid.enable_sensitive
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
			end
			window.unlock_update
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
				if selected_test_case /= Void then
					debug_button.enable_sensitive
				else
					debug_button.disable_sensitive
				end
			end
			status_label.set_text (tester.status_text)
		end

	recycle is
			-- Prune 'Current' from manager and tester and remove widgets.
		do
			manager.add_test_case_actions.prune (internal_add_test_case_agent)
			manager.remove_test_case_actions.prune (internal_remove_test_case_agent)
			manager.refresh_actions.prune (internal_refresh_agent)
			tester.update_status_actions.prune (internal_testing_status_agent)
			grid.wipe_out
		end

feature {CDD_GRID_TEST_CASE_LINE} -- Selection

	selected_test_case: CDD_TEST_CASE
			-- Currently selected test case in tree, Void if no test case is selected

	select_test_case (a_row: CDD_GRID_ROW) is
			-- Actions performed when test case item in tree is selected.
		require
			valid_item: a_row /= Void
		local
			l_tc_line: CDD_GRID_TEST_CASE_LINE
		do
			l_tc_line ?= a_row.grid_line
			if l_tc_line /= Void then
				selected_test_case := l_tc_line.test_case
				delete_button.enable_sensitive
				debug_button.enable_sensitive
			else
				deselect_test_case (a_row)
			end
		end

	deselect_test_case (a_row: CDD_GRID_ROW) is
			-- Actions performed when item in tree is deselected.
		do
			selected_test_case := Void
			delete_button.disable_sensitive
			debug_button.disable_sensitive
		ensure
			nothing_selected: selected_test_case = Void
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
				l_wd.show_modal_to_window (window.window)
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
			test_case_selected: selected_test_case /= Void
		do
			if tester.is_paused then
				tester.resume
			elseif tester.can_start_debugged_testing then
				tester.start_debugged_testing (selected_test_case)
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
			test_case_selected: selected_test_case /= Void
		local
			l_msg: STRING
			l_cd: EV_CONFIRMATION_DIALOG
		do
			l_msg := "The selected test case will be permanently removed from the system and from the disc.%N%N%
					%Are you sure this is what you want?"
			create l_cd.make_with_text_and_actions (l_msg, << agent try_remove_test_case >>)
			l_cd.show_modal_to_window (window.window)
		end

	try_remove_test_case is
			-- If test suite still contains `selected_test_case' remove it.
		require
			test_case_selected: selected_test_case /= Void
		do
			if manager.test_suite.test_cases.has (selected_test_case) then
				manager.remove_test_case (selected_test_case)
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

feature {NONE} -- Implementation

	mini_tool_bar: EV_TOOL_BAR
			-- Toolbar

	enable_testing_button: EV_TOOL_BAR_BUTTON
			-- Button for enabling testing

	run_button, stop_button, pause_button: EV_TOOL_BAR_BUTTON
			-- Buttons for controlling test execution

	debug_button: EV_TOOL_BAR_BUTTON
			-- Button for running selected test cases in the debugger

	delete_button: EV_TOOL_BAR_BUTTON
			-- Button for deleting a single test case

	status_bar: EV_STATUS_BAR
			-- Status bar showing the current tester status

	status_label: EV_LABEL
			-- Label describing current tester status

	progress_bar: EV_HORIZONTAL_PROGRESS_BAR
			-- Progress bar showing current tester status

	grid: CDD_GRID
			-- Grid for hierarchically displaying test cases

invariant
	manager_not_void: manager /= Void
	widget_not_void: widget /= Void
	valid_grid: grid /= Void
	valid_mini_tool_bar: mini_tool_bar /= Void
	enable_testing_button_valid: enable_testing_button /= Void
	run_button_valid: run_button /= Void
	stop_button_valid: stop_button /= Void
	pause_button_valid: pause_button /= Void
	delete_button_valid: delete_button /= Void
	valid_debug_button: debug_button /= Void
	status_bar_valid: status_bar /= Void
	status_label_valid: status_label /= Void
	progress_bar_valid: progress_bar /= Void

end
