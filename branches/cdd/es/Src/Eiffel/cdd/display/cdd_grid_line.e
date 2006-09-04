indexing
	description: "Objects that represent rows of CDD_GRID"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_GRID_LINE


feature {NONE} -- Initialize

	make (a_grid: like grid; a_row: like row; some_data: ANY) is
			-- Set 'grid' to 'a_gird', 'row' to 'a_row' and
			-- associate the rows data with 'Current'.
		do
			row := a_row
			row.set_data (some_data)
			grid := a_grid
		ensure
			row_set: row = a_row
			row_data_set: row.data = some_data
			grid_set: grid = a_grid
		end


feature -- Access

	row: EV_GRID_ROW
			-- Row of 'grid' attached to 'Current'

	grid: CDD_GRID
			-- Grid in which 'Current' is listed


feature {NONE} -- Row manipulation

	item (i: INTEGER): EV_GRID_LABEL_ITEM is
			-- Item of i'th cell in 'row'
		do
			Result ?= row.item (i)
			if Result = Void then
				create Result
				row.set_item (i, Result)
			end
		ensure
			not_void: Result /= Void
		end


	set_text (a_col: INTEGER; a_string: STRING) is
			-- Set text of a_col'th cell of 'row' to 'a_string'.
		require
			valid_col: a_col > 0 and a_col <= grid.column_count
			a_string_not_void: a_string /= Void
		local
			an_item: EV_GRID_LABEL_ITEM
		do
			an_item := item (a_col)
			an_item.set_text (a_string)
			an_item.set_tooltip (a_string)
		ensure
			text_set: item (a_col).text.is_equal(a_string)
			tooltip_set: item (a_col).tooltip.is_equal(a_string)
		end

	set_pixmap (a_col: INTEGER; a_pix: EV_PIXMAP) is
			-- Set pixmap of a_col'th cell of 'row' to 'a_string'.
		require
			valid_col: a_col > 0 and a_col <= grid.column_count
			a_string_not_void: a_pix /= Void
		do
			item (a_col).set_pixmap (a_pix)
		ensure
			pixmap_set: item (a_col).pixmap = a_pix
		end


invariant
	grid_not_void: grid /= Void
	row_not_void: row /= Void
	valid_row: row.parent = grid and row.data /= Void

end
