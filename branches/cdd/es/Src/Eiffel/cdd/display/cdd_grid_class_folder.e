indexing
	description: "Objects that represent grid rows for displaying classed"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GRID_CLASS_FOLDER

inherit

	CDD_GRID_LINE

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_class

feature {NONE} -- Initialization

	make_with_class (a_class: like target_class; a_grid: like grid; a_row: like row) is
			-- Set 'target_class' to 'a_class' and define items of 'a_row'
			-- to display the class properties in 'a_grid'.
		require
			valid_class: a_class /= Void
			valid_grid: a_grid /= Void
			valid_row: a_row /= Void and then a_row.parent = a_grid
		do
			target_class := a_class
			make (a_grid, a_row)
			set_text (grid.feature_column_index, target_class.name)
			set_pixmap (grid.feature_column_index, pixmaps.icon_pixmaps.tool_class_icon)
			row.ensure_expandable
		ensure
			target_class_set: target_class = a_class
		end


feature -- Access

	target_class: EIFFEL_CLASS_I
			-- class displayed on 'row'

invariant
	target_class_not_void: target_class /= Void

end
