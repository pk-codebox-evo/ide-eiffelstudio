indexing
	description: "Objects that represent sorted items of CDD_TREE"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_TREE_ITEM [reference G -> COMPARABLE]

inherit
	EV_TREE_ITEM
		redefine
			parent_tree,
			data
		end

feature {NONE} -- Initialization

	make (some_data: like data) is
			-- Set 'data' to 'some_data'
		require
			some_data_not_void: some_data /= Void
		do
			default_create
			data := some_data
		ensure
			data_set: data = some_data
		end

feature -- Access

	parent_tree: CDD_TREE is
			-- CDD_TREE instance of parent_tree
		do
			Result ?= Precursor
		ensure then
			not_void: Result /= Void
		end


	data: G
			-- Comparable user data.

invariant
	data_not_void: data /= Void

end
