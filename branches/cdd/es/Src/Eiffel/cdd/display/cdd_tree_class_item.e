indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TREE_CLASS_ITEM

inherit
	CDD_TREE_ITEM
		rename
			data as target_class
		redefine
			make, target_class
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: like target_class) is
			--
		do
			Precursor (a_class)
			set_text (target_class.name)
			set_pixmap (pixmaps.icon_pixmaps.tool_class_icon)
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
