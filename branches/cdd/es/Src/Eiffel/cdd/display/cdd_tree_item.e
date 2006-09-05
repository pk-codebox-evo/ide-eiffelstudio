indexing
	description: "Objects that represent sorted items of CDD_TREE"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_TREE_ITEM [G -> COMPARABLE]

inherit
	EV_TREE_ITEM
		-- Note: redefine clause produced error.
--		redefine
--			data
		rename
			data as ev_data
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

	data: G
			-- Sortable user data.

invariant
	data_not_void: data /= Void

end
