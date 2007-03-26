indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REL_INT_STORE

inherit
	INT_STORE

create
	make

feature -- Initialization

	make (a_store: INT_STORE) is
			-- Creation
		require
			not_void: a_store /= Void
		do
			store := a_store
		ensure
			store_set: store = a_store
		end

feature -- Implementation

	item: INTEGER is
			-- Compute result
		do
			Result := value + store.item
		end

	set_item (a_value: INTEGER) is
		do
			value := a_value - store.item
		end

feature{NONE} -- Implementation

	store: INT_STORE
	value: INTEGER

invariant

	store_not_void: store /= Void

end
