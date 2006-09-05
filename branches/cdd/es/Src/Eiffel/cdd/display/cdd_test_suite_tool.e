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

			test_suite.on_add_test_case.extend (agent on_add_test_case)
			test_suite.on_remove_test_case.extend (agent on_remove_test_case)
			test_suite.on_enable_testing.extend (agent on_enable_testing)
			test_suite.on_disable_testing.extend (agent on_disable_testing)

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
		local
			l_hbox: EV_HORIZONTAL_BOX
		do
			create widget

			build_tool_bar
			create l_hbox

			create grid
			l_hbox.extend (grid)

			create tree
			l_hbox.extend (tree)

			widget.extend (l_hbox)
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
			l_cluster_line: CDD_GRID_CLUSTER_LINE
			l_class_line: CDD_GRID_CLASS_LINE
			l_tc_line: CDD_GRID_TEST_CASE_LINE
			l_item: CDD_TREE_ITEM
		do
			locate_row (a_test_case.target_cluster, 0)
			if last_row.data = Void then
				create l_cluster_line.make_with_cluster (a_test_case.target_cluster, grid, last_row)
			end
			locate_row (a_test_case.target_class, last_row.index)
			if last_row.data = Void then
				create l_class_line.make_with_class (a_test_case.target_class, grid, last_row)
			end
			locate_row (a_test_case, last_row.index)
			create l_tc_line.make_with_test_case (a_test_case, grid, last_row)

			locate_item (a_test_case.target_cluster, tree)
			if last_located_item = Void then
				last_located_item := create {CDD_TREE_CLUSTER_ITEM}.make (a_test_case.target_cluster)
				tree.extend (last_located_item)
			end
			l_item := last_located_item
			locate_item (a_test_case.target_class, last_located_item)
			if last_located_item = Void then
				last_located_item := create {CDD_TREE_CLASS_ITEM}.make (a_test_case.target_class)
				l_item.extend (last_located_item)
			end
			l_item := last_located_item
			locate_item (a_test_case, last_located_item)
			if last_located_item = Void then
				last_located_item := create {CDD_TREE_TEST_CASE_ITEM}.make (a_test_case)
				l_item.extend (last_located_item)
			end
		end

	on_remove_test_case (a_tc: CDD_TEST_CASE) is
			-- Remove test from grid
		require
			a_tc_not_void: a_tc /= Void
		do

		end

	on_enable_testing is
			-- Enable widgets for handling test cases
		do
			enable_testing_button.disable_sensitive
			grid.enable_sensitive
			run_button.enable_sensitive
			delete_button.enable_sensitive
		end

	on_disable_testing is
			-- Disable widgets for handling test cases
		do
			enable_testing_button.enable_sensitive
			grid.disable_sensitive
			run_button.disable_sensitive
			delete_button.disable_sensitive
		end

feature {NONE} -- Button events

	on_button_enable_testing (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Enable testing
		local
			wd: EV_WARNING_DIALOG
		do
			if not test_suite.is_testing_enabled then
				if test_suite.can_enable_testing then
					test_suite.enable_testing
				else
					create wd.make_with_text ("Can not add cdd_testing cluster because compiled configuration is not up to date, please recompile.")
					wd.show_modal_to_window (development_window.window)
				end
			end
		end


feature {NONE} -- Grid manipulation

	last_row: EV_GRID_ROW
			-- last row located by'locate_row'

	locate_row (a_comp: COMPARABLE; a_parent_index: INTEGER) is
			-- Set 'last_row' to row where data referes to 'a_comp'.
			-- If row does not exists, add it to Current.
		require
			a_comp_not_void: a_comp /= Void
			a_parent_index_not_negative: a_parent_index >= 0
		local
			a_row: EV_GRID_ROW
			l_data: COMPARABLE
			i, l_count: INTEGER
			found: BOOLEAN
		do
			last_row := Void
			if a_parent_index > 0 then
				l_count := a_parent_index + grid.row (a_parent_index).subrow_count_recursive
			else
				l_count := grid.row_count
			end
			from
				i := a_parent_index + 1
				found := False
			until
				i > l_count or found
			loop
				a_row := grid.row (i)
				l_data ?= a_row.data
				check row_data_not_void: l_data /= Void end
				if a_comp = l_data then
					last_row := a_row
					found := True
				elseif a_comp < l_data then
					found := True
				else
					i := i + grid.row (i).subrow_count_recursive + 1
				end
			end
			if last_row = Void then
				if a_parent_index > 0 then
					grid.insert_new_row_parented (i, grid.row (a_parent_index))
				else
					grid.insert_new_row (i)
				end
				a_row := grid.row (i)
				last_row := a_row
			end
		ensure
			last_row_not_void: last_row /= Void
		end

	last_located_item: CDD_TREE_ITEM

	locate_item (some_data: COMPARABLE; a_list: EV_TREE_NODE_LIST) is
			--
		local
			l_item: CDD_TREE_ITEM
			l_cluster: CONF_CLUSTER
			l_class: EIFFEL_CLASS_I
			l_tc: CDD_TEST_CASE
			found: BOOLEAN
		do
			from
				a_list.start
				last_located_item := Void
			until
				a_list.after or found
			loop
				l_item ?= a_list.item
				if some_data = l_item.data then
					last_located_item := l_item
					found := True
				elseif some_data < l_item.data then
					found := True
				else
					a_list.forth
				end
			end
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
			enable_testing_button.pointer_button_press_actions.extend (agent on_button_enable_testing)
			create run_button.make_with_text ("Run all test cases")
			run_button.set_pixmap (pixmaps.icon_pixmaps.debug_run_icon)
			create delete_button.make_with_text ("Remove test case")
			delete_button.set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)
			tool_bar.extend (run_button)
			tool_bar.extend (delete_button)
			tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
			tool_bar.extend (enable_testing_button)
			widget.extend (tool_bar)
			widget.disable_item_expand (tool_bar)
		end

	grid: CDD_GRID
			-- Grid in which test cases are listed


	tree: CDD_TREE


invariant
	development_window_not_void: development_window /= Void
	widget_not_void: widget /= Void
	test_suite_not_void: test_suite /= Void
	tool_bar_valid: tool_bar /= Void and then tool_bar.parent = widget
	enable_testing_button_valid: enable_testing_button /= Void and then enable_testing_button.parent = tool_bar
	run_button_valid: run_button /= Void and then run_button.parent = tool_bar
	delete_button_valid: delete_button /= Void and then delete_button.parent = tool_bar
	grid_valid: grid /= Void and then grid.parent = widget

end
