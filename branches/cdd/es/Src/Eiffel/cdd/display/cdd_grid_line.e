indexing
	description: "Objects that represent sortable grid rows"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_GRID_LINE [reference G -> COMPARABLE]

inherit

	EB_GRID_ROW

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE} -- Initialization

	make (a_row: like grid_row; some_data: like row_data) is
			-- Set 'data' to 'some_data'
		require
			a_row_not_void: a_row /= Void
			some_data_not_void: some_data /= Void
		do
			set_grid_row (a_row)
			row_data := some_data
		ensure
			data_set: row_data = some_data
		end

feature -- Access

	grid: CDD_GRID is
			-- CDD_TREE instance of parent_tree
		do
			Result ?= grid_row.parent
		ensure then
			not_void: Result /= Void
		end


	row_data: G
			-- Comparable user data.

feature -- Element change

	add_test_case (a_tc: CDD_TEST_CASE) is
			--
		require
			a_tc_not_void: a_tc /= Void
		deferred
		end


invariant
	binded_to_grid: is_binded_to_grid
	data_not_void: row_data /= Void

end
