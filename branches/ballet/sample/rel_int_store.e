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
		use
			uses_a_store: a_store.repr
		modify
			modifies_repr: own_frame
		do
			store := a_store
		ensure
			store_set: store = a_store
			item_set: item = a_store.item
		end

feature -- Implementation

	item: INTEGER is
			-- Compute result
		do
			Result := value + store.item
		end

	set_item (a_value: INTEGER) is
		use
			uses_repr: repr
		modify
			modifies_repr: own_frame
		do
			value := a_value - store.item
		ensure then
			store_did_not_change: store = old store
		end

feature{NONE} -- Implementation

	store: INT_STORE
	value: INTEGER

feature -- Framing
	repr: FRAME is
		use
			own: repr
		do
			create Result.make_from_element (Current)
			Result := Result.united(store.repr)
		ensure then
			Result.is_superset_of(own_frame)
		end

	own_frame: FRAME is
		use
			own: own_frame
		do
			create Result.make_from_element (Current)
		end

invariant

	store_not_void: store /= Void

end
