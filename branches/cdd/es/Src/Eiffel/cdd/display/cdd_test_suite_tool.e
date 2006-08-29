indexing
	description: "Objects that ..."
	author: ""
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
			-- Initialize
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
			--
		do
			create widget

			build_tool_bar
			create grid
			widget.extend (grid)
		end




feature -- Access

	development_window: EB_DEVELOPMENT_WINDOW

	widget: EV_VERTICAL_BOX

	test_suite: CDD_TEST_SUITE is
			--
		do
			Result := test_suite_singleton
		end


feature -- Measurement

feature -- Status report


feature -- Status setting

	on_add_test_case (a_test_case: CDD_TEST_CASE) is
			-- Add Test Case
		local
			i: INTEGER
			l_cluster: CONF_CLUSTER
			l_class: EIFFEL_CLASS_I
			l_cluster_line: CDD_GRID_CLUSTER_LINE
			l_class_line: CDD_GRID_CLASS_LINE
			l_tc_line: CDD_GRID_TEST_CASE_LINE
			l_done: BOOLEAN
		do
			l_cluster := a_test_case.target_cluster
			l_class := a_test_case.target_class
			from
				i := 1
				l_done := False
			until
				i > grid.row_count or l_done
			loop
				l_cluster_line ?= grid.row (i).data
				check l_cluster /= Void end
				if l_cluster < l_cluster_line.target_cluster then
					l_cluster_line := Void
					l_done := True
				elseif l_cluster /= l_cluster_line.target_cluster then
					l_cluster_line := Void
					i := i + grid.row (i).subrow_count_recursive
				end
			end
			if l_cluster_line = Void then
				grid.insert_new_row (i)
				create l_cluster_line.make_with_cluster (l_cluster, grid, grid.row (i))
			end
			from
				i := l_cluster_line.row.index + 1
				l_done := False
			until
				i > l_cluster_line.row.index + l_cluster_line.row.subrow_count_recursive or l_done
			loop
				l_class_line ?= grid.row (i).data
				check l_class_line /= Void end
				if l_class < l_class_line.target_class then
					l_class_line := Void
					l_done := True
				elseif l_class /= l_class_line.target_class then
					l_class_line := Void
					i := i + grid.row (i).subrow_count_recursive
				end
			end
			if l_class_line = Void then
				grid.insert_new_row_parented (i, l_cluster_line.row)
				create l_class_line.make_with_class (l_class, grid, grid.row (i))
			end
			from
				i := l_class_line.row.index + 1
				l_done := False
			until
				i > l_class_line.row.index + l_class_line.row.subrow_count_recursive or l_done
			loop
				l_tc_line ?= grid.row (i).data
				check l_tc_line /= Void end
				if a_test_case < l_tc_line.test_case then
					l_done := True
				else
					i := i + 1
				end
			end
			grid.insert_new_row_parented (i, l_class_line.row)
			create l_tc_line.make_with_test_case (a_test_case, grid, grid.row (i))
		end

	on_remove_test_case (a_tc: CDD_TEST_CASE) is
			--
		do

		end


	on_enable_testing is
			--
		do

		end

	on_disable_testing is
			--
		do

		end



	on_button_enable_testing (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			--
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



feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature {NONE} -- Test Suite

	test_suite_singleton: CDD_TEST_SUITE is
			-- temporary solution for creating a shared test suite
			-- in future test suites will be project-related
		once
			create Result.make
		end



feature {NONE} -- EV widget mplementation

	tool_bar: EV_TOOL_BAR

	enable_testing_btn: EV_TOOL_BAR_BUTTON

	run_tc_button: EV_TOOL_BAR_BUTTON

	run_all_tc_button: EV_TOOL_BAR_BUTTON

	del_tc_button: EV_TOOL_BAR_BUTTON

	build_tool_bar is
			--
		do
			create tool_bar
			create enable_testing_btn.make_with_text ("Enable Testing")
			enable_testing_btn.set_pixmap (pixmaps.icon_pixmaps.breakpoints_enable_icon)
			enable_testing_btn.pointer_button_press_actions.extend (agent on_button_enable_testing)
			create run_all_tc_button.make_with_text ("Run all test cases")
			run_all_tc_button.set_pixmap (pixmaps.icon_pixmaps.debug_run_icon)
			create run_tc_button.make_with_text ("Run test tase")
			run_tc_button.set_pixmap (pixmaps.icon_pixmaps.debug_run_icon)
			create del_tc_button.make_with_text ("Remove test case")
			del_tc_button.set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)
			tool_bar.extend (run_all_tc_button)
			tool_bar.extend (run_tc_button)
			tool_bar.extend (del_tc_button)
			tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
			tool_bar.extend (enable_testing_btn)
			widget.extend (tool_bar)
			widget.disable_item_expand (tool_bar)
		end

	grid: CDD_GRID


invariant
	invariant_clause: True -- Your invariant here

end
