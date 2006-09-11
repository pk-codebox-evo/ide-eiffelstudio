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

	EB_CONSTANTS
		export
			{NONE} all
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
			initialize

			manager.extend (Current)
			tester.extend (Current)

			if manager.test_suite.is_initialized then
				enable_testing
				refresh
			else
				disable_testing
			end
		end

	initialize is
			-- Initialize all widgets used in 'Current'
		local
			l_hbox: EV_HORIZONTAL_BOX
		do
			create widget
			create l_hbox
			widget.set_padding (5)
			l_hbox.set_padding (5)

			build_tool_bar

			build_tree (l_hbox)
			build_output (l_hbox)

			widget.extend (l_hbox)

			build_status_bar
		end

	build_tool_bar is
			-- Create widgets for displaying a tool bar
		local
			l_vbox: EV_VERTICAL_BOX
		do
			create l_vbox
			create tool_bar

			create run_button
			run_button.set_tooltip ("Run all test cases")
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

			create enable_testing_button
			enable_testing_button.set_tooltip ("Enable Testing")
			enable_testing_button.set_pixmap (pixmaps.icon_pixmaps.breakpoints_enable_icon)
			enable_testing_button.select_actions.extend (agent on_enable_testing_button)
			enable_testing_button.disable_sensitive

			create delete_button
			delete_button.set_tooltip ("Remove test case")
			delete_button.set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)
			delete_button.select_actions.extend (agent on_delete_button)
			delete_button.disable_sensitive

			tool_bar.extend (run_button)
			tool_bar.extend (pause_button)
			tool_bar.extend (stop_button)
			tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
			tool_bar.extend (enable_testing_button)
			tool_bar.extend (delete_button)

			l_vbox.extend (tool_bar)
			l_vbox.extend (create {EV_HORIZONTAL_SEPARATOR})
			widget.extend (l_vbox)
			widget.disable_item_expand (l_vbox)
		end

	build_tree (a_list: EV_BOX) is
			--
		require
			valid_list: a_list /= Void and then a_list.extendible
			list_not_destroyed: not a_list.is_destroyed
		local
			l_frame: EV_FRAME
			l_cell: EV_CELL
		do
			create l_frame.make_with_text ("Test cases")
			create l_cell
			create tree.make_with_tool (Current)
			l_frame.extend (tree)
			tree.deselect_actions.extend (agent on_deselect_item)
			a_list.extend (l_frame)
			a_list.disable_item_expand (l_frame)
		end

	build_output (a_list: EV_BOX) is
			--
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
		local
			l_frame: EV_FRAME
		do
			create status_bar

			create l_frame
			create status_label.make_with_text ("Testing...")
			status_label.align_text_left
			l_frame.extend (status_label)
			status_bar.extend (l_frame)

			create l_frame
			create progress_bar
			l_frame.set_minimum_width (200)
			l_frame.extend (progress_bar)
			progress_bar.leap_forward
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

	manager: CDD_TEST_SUITE_MANAGER is
			-- Manager for test suite operations
		do
			Result := manager_singleton
		end

	tester: CDD_TEST_SUITE_TESTER is
			-- Tester for executing test cases
		do
			Result := tester_singleton
		end



feature -- Status setting

	refresh is
			--
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
		do
			development_window.lock_update
			run_button.disable_sensitive
			tree.wipe_out

			from
				l_cursor := manager.test_suite.test_cases.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				tree.add_test_case (l_cursor.item)
				l_cursor.forth
			end

			if tree.count > 0 then
				run_button.enable_sensitive
			end

			development_window.unlock_update
		end

	add_test_case (a_tc: CDD_TEST_CASE) is
			-- Display 'a_tc' in tree.
		do
			tree.add_test_case (a_tc)
			if not run_button.is_sensitive then
				run_button.enable_sensitive
			end
		end

	remove_test_case (a_tc: CDD_TEST_CASE) is
			-- Remove 'a_tc' from tree.
		do
			tree.remove_test_case (a_tc)
			if tree.is_empty then
				run_button.disable_sensitive
			end
		end


	enable_testing is
			-- Enable widgets for handling test cases
		do
			enable_testing_button.disable_sensitive
		end

	disable_testing is
			-- Disable widgets for handling test cases
		do
			enable_testing_button.enable_sensitive
		end

	start_testing is
			-- Wipe out output text
		do
			output.remove_text
			stop_button.enable_sensitive
			pause_button.enable_sensitive
			run_button.disable_sensitive
		end

	stop_testing is
			-- Show test results
		do
			stop_button.disable_sensitive
			run_button.enable_sensitive
			pause_button.disable_sensitive
		end

	pause_testing is
			-- Pause testing
		do
			run_button.enable_sensitive
			pause_button.disable_sensitive
		end

	resume_testing is
			--
		do
			run_button.disable_sensitive
			pause_button.enable_sensitive
		end


	finish_testing is
			-- Notify user that testing is finished
		do
			stop_button.disable_sensitive
			pause_button.disable_sensitive
			run_button.enable_sensitive
		end


	append_output (an_output: STRING) is
			-- Show output
		do
			output.append_text (an_output)
		end

	recycle is
			-- Prune from manager and test suite
		do
			manager.prune (Current)
		end


feature {CDD_TREE, CDD_TREE_ITEM} -- Selection events

	selected_test_case_item: CDD_TREE_TEST_CASE_ITEM
			-- Currently selected test case in tree, Void if no test case is selected

	on_select_test_case (a_tc_item: CDD_TREE_TEST_CASE_ITEM) is
			-- Actions performed when test case item in tree is selected.
		require
			valid_item: a_tc_item /= Void and then tree.selected_item = a_tc_item
		do
			selected_test_case_item := a_tc_item
			delete_button.enable_sensitive
		ensure
			test_case_selected: selected_test_case_item /= Void
			delete_button_sensitive: delete_button.is_sensitive
		end

	on_deselect_item is
			-- Actions performed when item in tree is deselected.
		do
			selected_test_case_item := Void
			delete_button.disable_sensitive
		ensure
			nothing_selected: selected_test_case_item = Void
			delete_button_not_sensitive: not delete_button.is_sensitive
		end


feature {NONE} -- Button events

	on_enable_testing_button is
			-- Actions performed when enable testing button is pressed.
		require
			testing_not_enabled: not manager.test_suite.is_initialized
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
			-- Actions performed when run button is pressed.
		require
			has_test_cases: not tree.is_empty
		do
			if tester.is_running then
				tester.resume
			else
				tester.start
			end
		end

	on_stop_button is
			--
		require
			running: tester.is_running
		do
			tester.stop
		end

	on_pause_button is
			--
		require
			running: tester.is_running
		do
			tester.pause
		end


	on_delete_button is
			-- Actions permformed when delete button is pressed
		require
			test_case_selected: selected_test_case_item /= Void
		local
			l_cd: EV_CONFIRMATION_DIALOG
		do
			create l_cd.make_with_text_and_actions ("Are you sure?", << agent manager_remove_test_case (selected_test_case_item.test_case) >>)
			l_cd.show_modal_to_window (development_window.window)
		end



feature {NONE} -- Manager

	manager_singleton: CDD_TEST_SUITE_MANAGER is
			-- NOTE: Temporary solution for creating a shared manager.
			-- In future manager will be project-related.
		once
			create Result.make
		end

	tester_singleton: CDD_TEST_SUITE_TESTER is
			-- NOTE: Temporary solution for creating a shared tester.
			-- In future tester will be project-related.
		once
			create Result.make_with_test_suite (manager.test_suite)
		end


feature {NONE} -- Implementation

	manager_remove_test_case (a_tc: CDD_TEST_CASE) is
			--
		require
			a_tc_not_void: a_tc /= Void
		do
			if manager.test_suite.test_cases.has (a_tc) then
				manager.remove_test_case (a_tc)
			end
		end


feature {NONE} -- Implementation

	tool_bar: EV_TOOL_BAR
			-- Tool bar for test case manipulation

	enable_testing_button: EV_TOOL_BAR_BUTTON
			-- Button for enabling testing

	run_button, stop_button, pause_button: EV_TOOL_BAR_BUTTON
			-- buttons for controlling test execution

	delete_button: EV_TOOL_BAR_BUTTON
			-- Button for deleting a single test case

	output: EV_TEXT
			-- Output from external processes.

	status_bar: EV_STATUS_BAR

	status_label: EV_LABEL

	progress_bar: EV_HORIZONTAL_PROGRESS_BAR



feature {CDD_TREE, CDD_TREE_ITEM} -- Tree Implementation

	tree: CDD_TREE
			-- Tree for hierarchically displaying test cases


invariant
	tree_not_void: tree /= Void
	development_window_not_void: development_window /= Void
	widget_not_void: widget /= Void
	manager_not_void: manager /= Void
	tool_bar_valid: tool_bar /= Void

	enable_testing_button_valid: enable_testing_button /= Void

	run_button_valid: run_button /= Void

	delete_button_valid: delete_button /= Void
	--correct_delete_button_status: delete_button.is_sensitive = (selected_test_case_item /= Void)

end
