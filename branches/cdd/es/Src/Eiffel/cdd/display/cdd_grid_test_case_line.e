indexing
	description: "Objects that ..."
	author: ""
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
			-- Initialize `Current'.
		do
			test_case := a_test_case
			make (a_grid, a_row)
			set_feature (test_case.e_feature, pixmaps.icon_pixmaps.tool_feature_icon)
			set_status ("Fail", pixmaps.icon_pixmaps.general_delete_icon)
			set_test_class (test_case.test_class.name)
			set_file (test_case.file_name)
		end

feature -- Resizing

feature -- Access

	test_case: CDD_TEST_CASE

feature -- Measurement

feature -- Status report

feature -- Status setting

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

invariant
	invariant_clause: True -- Your invariant here

end
