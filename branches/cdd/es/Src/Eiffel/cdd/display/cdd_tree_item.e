indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_TREE_ITEM

inherit
	EV_TREE_ITEM
		redefine
			data
		end

feature {NONE} -- Initialization

	make (some_data: like data) is
			-- Initialize `Current'.
		do
			default_create
			set_data (some_data)
		end

feature -- Access

	data: COMPARABLE

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
