indexing
	description: "[
		"Active" data structures, which at every stage have
		a possibly undefined "current item".
		Basic access and modification operations apply to the current item.
		]"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_ACTIVE [G]

inherit
	CC_COLLECTION [G]

feature -- Access

	item: G is
			-- Current item
		require
			readable: readable
		use
			use_own_representation: representation
		deferred
		end

feature -- Status report

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		use
			use_own_representation: representation
		deferred
		end

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		use
			use_own_representation: representation
		deferred
		end

feature -- Element change

	replace_item_with (v: G) is
			-- Replace current item by `v'.
		require
			writable: writable
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
			item_replaced: item = v
			model_contains_new_element: model.contains (v)
			-- TODO underspecification
			confined representation
		end

feature -- Removal

	remove_item is
			-- Remove current item.
		require
			prunable: prunable
			writable: writable
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
			model_corresponds: model |=| old model.pruned (item)
			confined representation
		end

invariant

	writable_constraint: writable implies readable
	empty_constraint: is_empty implies (not readable) and (not writable)

end
