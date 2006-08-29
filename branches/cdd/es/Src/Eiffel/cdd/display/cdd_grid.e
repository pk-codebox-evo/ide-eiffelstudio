indexing
	description: "Objects that ..."
	author: ""
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
			--
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

	status_column_index: INTEGER is 2

	test_class_column_index: INTEGER is 3

	file_column_index: INTEGER is 4


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

	column_titles: ARRAY [STRING] is
		once
			Result := << "Feature", "Status", "Test Class Name", "File" >>
		end

	column_widths: ARRAY [INTEGER] is
		once
			Result := << 300, 250, 250, 200 >>
		end

invariant
	invariant_clause: True -- Your invariant here

end
