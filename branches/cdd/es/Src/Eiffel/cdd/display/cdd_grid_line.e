indexing
	description: "Objects that ..."
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
		end


	set_cell_text (i: INTEGER; s: STRING) is
			--
		local
			an_item: EV_GRID_LABEL_ITEM
		do
			an_item := item (i)
			an_item.set_text (s)
			an_item.set_tooltip (s)
		end

	set_cell_pixmap (i: INTEGER; p: EV_PIXMAP) is
			--
		do
			item (i).set_pixmap (p)
		end

	set_feature (a_name: STRING; a_pixmap: EV_PIXMAP) is
			--
		do
			set_cell_text (grid.feature_column_index, a_name)
			set_cell_pixmap (grid.feature_column_index, a_pixmap)
		end

	set_status (a_name: STRING; a_pixmap: EV_PIXMAP) is
			--
		do
			set_cell_text (grid.status_column_index, a_name)
			set_cell_pixmap (grid.status_column_index, a_pixmap)
		end

	set_test_class (a_name: STRING) is
			--
		do
			set_cell_text (grid.test_class_column_index, a_name)
		end

	set_file (a_name: STRING) is
			--
		do
			set_cell_text (grid.file_column_index, a_name)
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
