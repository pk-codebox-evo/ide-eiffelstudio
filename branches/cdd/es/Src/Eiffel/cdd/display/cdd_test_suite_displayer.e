indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE_DISPLAYER

inherit

	EV_VERTICAL_BOX

	CDD_SHARED_TEST_SUITE
		export
			{NONE} all
		undefine
			is_equal, default_create, copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, default_create, copy
		end

create
	make_with_tool

feature {NONE} -- Initialization

	make_with_tool (a_window: EB_DEVELOPMENT_WINDOW; a_tool: EB_CONTEXT_TOOL) is
			-- Initialize
		local
			titles: ARRAY [STRING]
			i: INTEGER
		do
			default_create
			test_suite.subscribe_new_test_case (agent add_test_case)

			build_tool_bar
			build_grid
		end



feature -- Access

feature -- Measurement

feature -- Status report

	has_test_case (a_test_case: CDD_TEST_CASE): BOOLEAN is
			--
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > grid.row_count or Result = True
			loop
				if grid.row (i).data = a_test_case then
					Result := True
				end
				i := i + 1
			end
		end


feature -- Status setting

	add_test_case (a_test_case: CDD_TEST_CASE) is
			-- Add Test Case
		require
			valid_test_case: a_test_case /= Void
			new_test_case: not has_test_case (a_test_case)
		local
			rc: INTEGER
			row: EV_GRID_ROW
			a_item: EV_GRID_LABEL_ITEM
		do
			rc := grid.row_count + 1
			grid.set_row_count_to (rc)
			row := grid.row (rc)
			create a_item.make_with_text (a_test_case.e_feature.name)
			a_item.set_pixmap (pixmaps.icon_pixmaps.tool_feature_icon)
			row.set_item (1, a_item)
			create a_item.make_with_text ("Fail")
			a_item.set_pixmap (pixmaps.icon_pixmaps.debug_exception_dialog_icon)
			row.set_item (2, a_item)
			create a_item.make_with_text (a_test_case.test_case_class_name)
			row.set_item (3, a_item)
			create a_item.make_with_text (a_test_case.file_name)
			row.set_item (4, a_item)
			row.ensure_expandable
			grid.redraw
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

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	tool_bar: EV_TOOL_BAR

	run_tc_button: EV_TOOL_BAR_BUTTON

	run_all_tc_button: EV_TOOL_BAR_BUTTON

	del_tc_button: EV_TOOL_BAR_BUTTON

	build_tool_bar is
			--
		do
			create tool_bar
			create run_all_tc_button.make_with_text ("Run all test cases")
			run_all_tc_button.set_pixmap (pixmaps.icon_pixmaps.debug_run_icon)
			create run_tc_button.make_with_text ("Run test tase")
			run_tc_button.set_pixmap (pixmaps.icon_pixmaps.debug_run_icon)
			create del_tc_button.make_with_text ("Remove test case")
			run_all_tc_button.set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)
			tool_bar.extend (run_all_tc_button)
			tool_bar.extend (run_tc_button)
			tool_bar.extend (del_tc_button)
			extend (tool_bar)
			disable_item_expand (tool_bar)
		end

	column_titles: ARRAY [STRING] is
		once
			Result := << "Feature", "Status", "Test Class Name", "File" >>
		end

	column_widths: ARRAY [INTEGER] is
		once
			Result := << 300, 250, 250, 200 >>
		end


	build_grid is
			--
		local
			i: INTEGER
			col: EV_GRID_COLUMN
		do
			create grid
			grid.set_column_count_to (column_titles.count)
			grid.enable_tree
			from
				i := 1
			until
				i > column_titles.count
			loop
				col := grid.column (i)
				col.set_title (column_titles[i])
				col.set_width (column_widths[i])
				i := i + 1
			end
			--grid.enable_partial_dynamic_content
			grid.enable_row_height_fixed
			grid.enable_single_row_selection
			extend (grid)
		end


	grid: EV_GRID


invariant
	invariant_clause: True -- Your invariant here

end
