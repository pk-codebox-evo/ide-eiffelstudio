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

	CDD_TREE_HELPER
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
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

	i_th_cdd_item (an_index: INTEGER): CDD_TREE_ITEM is
			--
		do
			Result ?= i_th (an_index)
		end


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
