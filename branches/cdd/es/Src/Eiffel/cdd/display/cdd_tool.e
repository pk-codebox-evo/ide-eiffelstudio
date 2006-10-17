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
			manager.update_state_actions.extend (internal_testing_status_agent)

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
			create status_label.make_with_text ("")
			status_label.align_text_left
			l_frame.extend (status_label)
			status_bar.extend (l_frame)

			widget.extend (status_bar)
			widget.disable_item_expand (status_bar)
		end

	build_tool_bar is
			-- Create widgets for displaying a tool bar
		do
			create mini_tool_bar

			create run_button
			run_button.set_tooltip ("Run test case in debugger")
			run_button.set_pixmap (pixmaps.mini_pixmaps.general_next_icon)
			run_button.select_actions.extend (agent on_run_button)
			run_button.disable_sensitive

			create delete_button
			delete_button.set_tooltip ("Remove test case")
			delete_button.set_pixmap (pixmaps.mini_pixmaps.general_delete_icon)
			delete_button.select_actions.extend (agent on_delete_button)
			delete_button.drop_actions.extend (agent on_drop_class)
			delete_button.enable_sensitive

			create enable_testing_button
			enable_testing_button.set_tooltip ("Enable Testing")
			enable_testing_button.set_pixmap (pixmaps.mini_pixmaps.general_toogle_icon)
			enable_testing_button.select_actions.extend (agent on_enable_testing_button)
			enable_testing_button.disable_sensitive

			mini_tool_bar.extend (run_button)
			mini_tool_bar.extend (delete_button)
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

	manager: CDD_MANAGER
			-- Manager for test suite operations

feature -- Status setting

	add_test_case (a_tc: CDD_TEST_CASE) is
			-- Add `a_tc' to `grid'.
		require
			a_tc_not_void: a_tc /= Void
		do
			grid.add_test_case (a_tc)
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
			else
				enable_testing_button.enable_sensitive
				grid.disable_sensitive
			end
			window.unlock_update
		end

	update_testing_status (a_message: STRING) is
			-- Adapt widgets to current testing status.
		require
			manager.is_testing_enabled
			a_message_not_void: a_message /= Void
		do
			status_label.set_text (a_message)
			if manager.is_running or selected_test_case = Void then
				run_button.disable_sensitive
			else
				run_button.enable_sensitive
			end
		end

	recycle is
			-- Prune 'Current' from manager and tester and remove widgets.
		do
			manager.add_test_case_actions.prune (internal_add_test_case_agent)
			manager.remove_test_case_actions.prune (internal_remove_test_case_agent)
			manager.refresh_actions.prune (internal_refresh_agent)
			manager.update_state_actions.prune (internal_testing_status_agent)
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
				run_button.enable_sensitive
			else
				deselect_test_case (a_row)
			end
		end

	deselect_test_case (a_row: CDD_GRID_ROW) is
			-- Actions performed when item in tree is deselected.
		do
			selected_test_case := Void
			run_button.disable_sensitive
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
			-- Run selected test case in the debugger.
		require
			manager_not_running: not manager.is_running
			test_case_selected: selected_test_case /= Void
		do
			if manager.can_start_debugging then
				manager.start_debugging (selected_test_case)
			else
				-- TODO: Notify user that debugged testing is not possible
			end
		end

	on_delete_button is
			-- If test case is selected, ask user if he wants to delete it.
		local
			l_msg: STRING
			l_cd: EV_CONFIRMATION_DIALOG
		do
			if selected_test_case /= Void then
				confirm_delete (selected_test_case)
			end
		end

	on_drop_class (a_stone: CLASSI_STONE) is
			-- Remove associated class of `a_stone' from test suite.
		local
			l_tc: CDD_TEST_CASE
		do
			l_tc := manager.test_suite.test_case_for_class (a_stone.class_i)
			if l_tc /= Void then
				confirm_delete (l_tc)
			end
		end

	confirm_delete (a_tc: CDD_TEST_CASE) is
			-- Ask user if he really wants to delete `a_tc'?
		require
			a_tc_not_void: a_tc /= Void
		local
			l_msg: STRING
			l_cd: EV_CONFIRMATION_DIALOG
		do
			l_msg := "Test case " + a_tc.test_class.name + " will be permanently%N removed from the system and from the disc.%N%N%
					%Are you sure this is what you want?"
			create l_cd.make_with_text_and_actions (l_msg, << agent try_remove_test_case (a_tc) >>)
			l_cd.show_modal_to_window (window.window)
		end

	try_remove_test_case (a_tc: CDD_TEST_CASE) is
			-- If test suite still contains `a_tc' remove it.
		require
			a_tc_not_void: a_tc /= Void
		do
			if manager.test_suite.test_cases.has (a_tc) then
				manager.remove_test_case (a_tc)
			end
		ensure
			removed: not manager.test_suite.test_cases.has (a_tc)
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

	internal_testing_status_agent: PROCEDURE [like Current, TUPLE [STRING]]
			-- Agent called when testing status changes

feature {NONE} -- Implementation

	mini_tool_bar: EV_TOOL_BAR
			-- Toolbar

	enable_testing_button: EV_TOOL_BAR_BUTTON
			-- Button for enabling testing

	run_button: EV_TOOL_BAR_BUTTON
			-- Buttons for controlling test execution

	delete_button: EV_TOOL_BAR_BUTTON
			-- Button for deleting a single test case

	status_bar: EV_STATUS_BAR
			-- Status bar showing the current tester status

	status_label: EV_LABEL
			-- Label describing current tester status

	grid: CDD_GRID
			-- Grid for hierarchically displaying test cases

invariant
	manager_not_void: manager /= Void
	widget_not_void: widget /= Void
	valid_grid: grid /= Void
	valid_mini_tool_bar: mini_tool_bar /= Void
	enable_testing_button_valid: enable_testing_button /= Void
	run_button_valid: run_button /= Void
	delete_button_valid: delete_button /= Void
	status_bar_valid: status_bar /= Void
	status_label_valid: status_label /= Void

end
