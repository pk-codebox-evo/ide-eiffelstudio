indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REL_INT_STORE

inherit
	INT_STORE
	redefine
		set_item, repr, item
	end

create
	make

feature -- Initialization

	make (a_store: INT_STORE) is
			-- Creation
		require
			not_void: a_store /= Void
			not_current: a_store /= Current
		use
			uses_a_store: a_store.repr
		modify
			modifies_repr: own_frame
		do
			store := a_store
			value := 0
		ensure
			store_set: store = a_store
			item_set: item = a_store.item
		end

feature -- Implementation

	item: INTEGER is
			-- Compute result
		use
			rrrr: repr
		do
			Result := value + store.item
		ensure then
			Result = value + store.item -- TODO: this is not nice, remove me...
		end

	set_item (a_value: INTEGER) is
		use
			uses_repr: repr.united (store.repr)
		modify
			modifies_repr: own_frame
		do
			value := a_value - store.item
			check
				minus_minus: value = a_value - store.item -- TODO: thisone should we be able to prove this
				plus_minus: value + store.item = item
			end
		ensure then
			store_did_not_change: store = old store
		end

feature {NONE} -- Implementation

	store: INT_STORE
	value: INTEGER

feature -- Framing
	repr: FRAME is
		use
			own: repr
		do
--			create Result.make_from_element (Current)
--			Result := Result.united(store.repr)
		ensure then
			own_frame.is_subset_of(Result)
			store_included: Result.is_superset_of(store.repr)
		end

	own_frame: FRAME is
		use
			own: own_frame
		do
--			create Result.make_from_element (Current)
		end

invariant

	store_not_void: store /= Void
	store_not_current: store /= Current
end
