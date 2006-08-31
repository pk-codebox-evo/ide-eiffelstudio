indexing
	description: "Objects that represent rows of CDD_GRID"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_GRID_LINE

feature {NONE} -- Initialize

	make (a_grid: like grid; a_row: like row) is
			--
		do
			row := a_row
			row.set_data (Current)
			grid := a_grid
		end


feature -- Access

	row: EV_GRID_ROW

	grid: CDD_GRID


feature -- Measurement

feature -- Status report

feature -- Status setting


feature {NONE} -- Row value setting

	item (i: INTEGER): EV_GRID_LABEL_ITEM is
			--
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
			--
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
			--
		require
			valid_col: a_col > 0 and a_col <= grid.column_count
			a_string_not_void: a_pix /= Void
		do
			item (a_col).set_pixmap (a_pix)
		ensure
			pixmap_set: item (a_col).pixmap = a_pix
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



invariant
	invariant_clause: True -- Your invariant here

end
