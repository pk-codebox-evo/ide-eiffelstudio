indexing
	description: "Objects that represent grid rows for displaying test cases"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GRID_TEST_CASE_LINE

inherit
	CDD_GRID_LINE


	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_test_case

feature {NONE} -- Initialization

	make_with_test_case (a_test_case: like test_case; a_grid: like grid; a_row: like row) is
			-- Set 'test_case' to 'a_test_case' and define items of 'a_row'
			-- to display the test case properties in 'a_grid'.
		do
			make (a_grid, a_row, a_test_case)
			set_text (grid.feature_column_index, test_case.feature_name)
			set_pixmap (grid.feature_column_index, pixmaps.icon_pixmaps.tool_feature_icon)
			set_text (grid.status_column_index, "Fails")
			set_pixmap (grid.status_column_index, pixmaps.icon_pixmaps.general_delete_icon)
			set_text (grid.test_class_column_index, test_case.test_class.name)
			set_text (grid.file_column_index, test_case.test_class.path)
		end

feature -- Access

	test_case: CDD_TEST_CASE is
			-- test case displayed on 'row'
		do
			Result ?= row.data
		ensure
			not_void: Result /= Void
		end


invariant
	test_case_not_void: test_case /= Void

end
