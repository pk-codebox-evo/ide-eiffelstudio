indexing
	description: "Objects that list clusters, classes test cases in a tree-like grid"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GRID

inherit

	EV_GRID
		redefine
			initialize
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize grid with columns for displaying test case
		local
			col: EV_GRID_COLUMN
			i: INTEGER
		do
			Precursor
			set_column_count_to (4)

			enable_tree
			from
				i := 1
			until
				i > column_count
			loop
				col := column (i)
				col.set_title (column_titles[i])
				col.set_width (column_widths[i])
				i := i + 1
			end
			enable_row_height_fixed
			enable_single_row_selection
		end


feature -- Access

	feature_column_index: INTEGER is 1
			-- Index of the feature column

	status_column_index: INTEGER is 2
			-- Index of the status column

	test_class_column_index: INTEGER is 3
			-- Index of the test class column

	file_column_index: INTEGER is 4
			-- Index of the file column


feature {NONE} -- Implementation

	column_titles: ARRAY [STRING] is
			-- Titles for each column
		once
			Result := << "Feature", "Status", "Test Class Name", "File" >>
		end

	column_widths: ARRAY [INTEGER] is
			-- Widths for each column
		once
			Result := << 300, 150, 250, 300 >>
		end

end
