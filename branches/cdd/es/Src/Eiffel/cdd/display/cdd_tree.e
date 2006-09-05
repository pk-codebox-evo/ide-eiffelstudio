indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TREE

inherit
	EV_TREE

	CDD_TREE_HELPER
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		redefine
			data_type
		end

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

	new_item (a_cluster: like data_type): CDD_TREE_CLUSTER_ITEM is
			--
		do
			create Result.make (a_cluster)
		end


feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	data_type: CONF_CLUSTER

invariant
	invariant_clause: True -- Your invariant here

end
