indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GRID_CLASS_LINE

inherit
	CDD_GRID_LINE
		rename
			set_feature as set_class
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_class

feature {NONE} -- Initialization

	make_with_class (a_class: like target_class; a_grid: like grid; a_row: like row) is
			-- Initialize `Current'.
		require
			valid_class: a_class /= Void
			valid_grid: a_grid /= Void
			valid_row: a_row /= Void and then a_row.parent = a_grid
		do
			target_class := a_class
			make (a_grid, a_row)
			set_class (target_class.name, pixmaps.icon_pixmaps.tool_class_icon)
			row.ensure_expandable
		end


feature -- Access

	target_class: EIFFEL_CLASS_I

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
