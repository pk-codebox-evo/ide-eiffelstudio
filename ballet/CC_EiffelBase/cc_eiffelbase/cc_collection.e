indexing
	description: "[
		General finite container data structures, 
		characterized by the membership properties of their items.
		]"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_COLLECTION [G]

inherit
	CC_CONTAINER [G]

feature -- Status report

	extendible: BOOLEAN is
			-- May new items be added?
		use
			use_own_representation: representation
		deferred
		end

	prunable: BOOLEAN is
			-- May items be removed?
		use
			use_own_representation: representation
		deferred
		end

feature -- Element change

	extend (v: G) is
			-- Ensure that structure includes `v' iff `v' can be added.
		require
			can_add_element: can_extend (v)
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
			model_updated: model |=| old model.extended (v)
			model_correspondends: model.contains (v)
			confined representation
		end

	put (v: G) is
			-- Ensure that structure includes `v'.
		require
			can_add_element: can_put (v)
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
			model_updated: model |=| old model.extended (v)
			model_correspondends: model.contains (v)
			confined representation
		end

feature -- Removal

	prune (v: G) is
			-- Remove one occurrence of `v' if any.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		require
			prunable: prunable
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
			old has (v) implies (old count = count - 1) -- TODO ev unnötig, da mit unterem statement das schon gesagt wird
			model_corresponds: model |=| old model.pruned (v)
			confined representation
		end

	prune_all (v: G) is
			-- Remove all occurrences of `v'.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			--|Default implementation, usually inefficient.
		require
			prunable: prunable
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		do
			from
			until not has (v) loop
				prune (v)
			end
		ensure
			no_more_occurrences: not has (v)
			model_corresponds: not model.contains (v)
			confined representation
		end

	wipe_out is
			-- Remove all items.
		require
			prunable: prunable
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
			wiped_out: is_empty
			model_corresponds: model.is_empty
			confined representation
		end

feature -- Element specific status report

	can_extend (v: G) : BOOLEAN is
			-- Can `an_item' be added?
			-- Non-defensive -> strongest preconditions
		use
			use_own_representation: representation
		do
			Result := extendible
		end

	can_put (v: G) : BOOLEAN is
			-- Can `an_item' be added?
			-- Medium defensive -> mathematical view
		use
			use_own_representation: representation
		do
			Result := extendible
		end

end
