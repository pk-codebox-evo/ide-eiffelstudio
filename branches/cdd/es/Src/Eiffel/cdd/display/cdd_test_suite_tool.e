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

			test_suite.add_test_case_actions.extend (agent on_add_test_case)
			test_suite.remove_test_case_actions.extend (agent on_remove_test_case)
			test_suite.enable_testing_actions.extend (agent on_enable_testing)
			test_suite.disable_testing_actions.extend (agent on_disable_testing)


			if test_suite.is_testing_enabled then
				on_enable_testing
				from
					test_suite.test_cases.start
				until
					test_suite.test_cases.after
				loop
					on_add_test_case (test_suite.test_cases.item_for_iteration)
					test_suite.test_cases.forth
				end
			else
				on_disable_testing
			end
		end

	initialize is
			-- Initialize all widgets used in 'Current'
		do
			create widget

			build_tool_bar

			create tree
			tree.deselect_actions.extend (agent on_deselect_item)
			widget.extend (tree)
		end

feature -- Access

	development_window: EB_DEVELOPMENT_WINDOW
			-- Development window in which widget is displayed

	widget: EV_VERTICAL_BOX
			-- Widget for displaying 'Current'

	test_suite: CDD_TEST_SUITE is
			-- Test suite beeing displayed
		do
			Result := test_suite_singleton
		end

feature -- Status setting

	on_add_test_case (a_test_case: CDD_TEST_CASE) is
			-- Add test case to grid
		require
			a_test_case_not_void: a_test_case /= Void
		local
			l_cluster_item: CDD_TREE_CLUSTER_ITEM
			l_class_item: CDD_TREE_CLASS_ITEM
			l_tc_item: CDD_TREE_TEST_CASE_ITEM
		do
			tree.locate_item (a_test_case.target_cluster)
			l_cluster_item := tree.last_located_item
			l_cluster_item.locate_item (a_test_case.target_class)
			l_class_item := l_cluster_item.last_located_item
			l_class_item.locate_item (a_test_case)
			l_tc_item := l_class_item.last_located_item
			l_tc_item.select_actions.extend (agent on_select_test_case (l_tc_item))
			run_button.enable_sensitive
		end

	on_remove_test_case (a_tc: CDD_TEST_CASE) is
			-- Remove test from tree
		require
			a_tc_not_void: a_tc /= Void
		local
			l_cluster_item: CDD_TREE_CLUSTER_ITEM
			l_class_item: CDD_TREE_CLASS_ITEM
		do
			tree.locate_item (a_tc.target_cluster)
			l_cluster_item := tree.last_located_item
			l_cluster_item.locate_item (a_tc.target_class)
			l_class_item := l_cluster_item.last_located_item
			l_class_item.locate_item (a_tc)
			l_class_item.prune (l_class_item.last_located_item)
			if l_class_item.is_empty then
				l_cluster_item.prune (l_class_item)
				if l_cluster_item.is_empty then
					tree.prune (l_cluster_item)
				end
			end
			if tree.is_empty then
				run_button.disable_sensitive
			end
		end

	on_enable_testing is
			-- Enable widgets for handling test cases
		do
			enable_testing_button.disable_sensitive
		end

	on_disable_testing is
			-- Disable widgets for handling test cases
		do
			enable_testing_button.enable_sensitive
		end

feature {NONE} -- Selection events

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
			testing_not_enabled: not test_suite.is_testing_enabled
		local
			l_wd: EV_WARNING_DIALOG
		do
			if not test_suite.is_testing_enabled then
				if test_suite.can_enable_testing then
					test_suite.enable_testing
				else
					create l_wd.make_with_text ("Can not add cdd_testing cluster because compiled configuration is not up to date, please recompile.")
					l_wd.show_modal_to_window (development_window.window)
				end
			end
		end

	on_run_button is
			-- Actions performed when run button is pressed.
		require
			has_test_cases: not tree.is_empty
		do

		end


	on_delete_button is
			-- Actions permformed when delete button is pressed
		require
			test_case_selected: selected_test_case_item /= Void
		local
			l_cd: EV_CONFIRMATION_DIALOG
		do
			create l_cd.make_with_text_and_actions ("Are you sure?", << agent test_suite.remove_test_case (selected_test_case_item.test_case) >>)
			l_cd.show_modal_to_window (development_window.window)
		end



feature {NONE} -- Test suite

	test_suite_singleton: CDD_TEST_SUITE is
			-- NOTE: Temporary solution for creating a shared test suite.
			-- In future test suites will be project-related.
		once
			create Result.make
		end



feature {NONE} -- Implementation

	tool_bar: EV_TOOL_BAR
			-- Tool bar for test case manipulation

	enable_testing_button: EV_TOOL_BAR_BUTTON
			-- Button for enabling testing

	run_button: EV_TOOL_BAR_BUTTON
			-- Button for running all test cases

	delete_button: EV_TOOL_BAR_BUTTON
			-- Button for deleting a single test case

	build_tool_bar is
			-- Create widgets for displaying a tool bar
		do
			create tool_bar

			create enable_testing_button.make_with_text ("Enable Testing")
			enable_testing_button.set_pixmap (pixmaps.icon_pixmaps.breakpoints_enable_icon)
			enable_testing_button.select_actions.extend (agent on_enable_testing_button)
			enable_testing_button.disable_sensitive

			create run_button.make_with_text ("Run all test cases")
			run_button.set_pixmap (pixmaps.icon_pixmaps.debug_run_icon)
			run_button.select_actions.extend (agent on_run_button)
			run_button.disable_sensitive

			create delete_button.make_with_text ("Remove test case")
			delete_button.set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)
			delete_button.select_actions.extend (agent on_delete_button)
			delete_button.disable_sensitive

			tool_bar.extend (run_button)
			tool_bar.extend (delete_button)
			tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
			tool_bar.extend (enable_testing_button)
			widget.extend (tool_bar)
			widget.disable_item_expand (tool_bar)
		end

	tree: CDD_TREE
			-- Tree for hierarchically displaying test cases


invariant
	tree_not_void: tree /= Void
	development_window_not_void: development_window /= Void
	widget_not_void: widget /= Void
	test_suite_not_void: test_suite /= Void
	tool_bar_valid: tool_bar /= Void and then tool_bar.parent = widget

	enable_testing_button_valid: enable_testing_button /= Void and then enable_testing_button.parent = tool_bar

	run_button_valid: run_button /= Void and then run_button.parent = tool_bar
	correct_run_button_status: run_button.is_sensitive = not tree.is_empty

	delete_button_valid: delete_button /= Void and then delete_button.parent = tool_bar
	correct_delete_button_status: delete_button.is_sensitive = selected_test_case_item /= Void

end
