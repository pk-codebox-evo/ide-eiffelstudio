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

-- TODO gemäss bernd unnötig
--	is_inserted (v: G): BOOLEAN is
--			-- Has `v' been inserted by the most recent insertion?
--			-- (By default, the value returned is equivalent to calling
--			-- `has (v)'. However, descendants might be able to provide more
--			-- efficient implementations.)
--		use
--			use_own_representation: representation
--		do
--			Result := has (v)
--		end

feature -- Element change

	extend (v: G) is
			-- Ensure that structure includes `v' iff `v' can be added.
		require
			can_add_element: can_extend (v)
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
		modify
			modify_own_representation: representation
		deferred
		ensure
			model_updated: model |=| old model.extended (v)
			model_correspondends: model.contains (v)
			confined representation
		end

-- TODO gemäss bernd erstmal ignorieren
--	fill (other: CC_CONTAINER [G]) is
--			-- Fill with as many items of `other' as possible.
--			-- The representations of `other' and current structure
--			-- need not be the same.
--		require
--			other_not_void: other /= Void
--			extendible: extendible
--		use
--			use_other_representation: other.representation
--		modify
--			modify_own_representation: representation
--		local
--			lin_rep: CC_LINEAR [G]
--		do
--			lin_rep := other.linear_representation
--			from
--				lin_rep.start
--			until
--				not extendible or else lin_rep.off
--			loop
--				extend (lin_rep.item)
--				lin_rep.forth
--			end
--		ensure
--			--count: count = old count + other.count -- keine gute idee, da plötzlich !extendible sein könnte
--			--model |=| old model.united (other.model)
--			--TODO
--			confined representation
--		end

feature -- Removal

	prune (v: G) is
			-- Remove one occurrence of `v' if any.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		require
			prunable: prunable
		modify
			modify_own_representation: representation
		deferred
		ensure
			-- TODO übel??
			old has (v) implies (old count = count - 1) -- TODO ev unnötig, da mit unterem statement das schon gesagt wird
			model_corresponds: old model |=| model.pruned (v)
			confined representation
		end

	prune_all (v: G) is
			-- Remove all occurrences of `v'.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			--|Default implementation, usually inefficient.
		require
			prunable: prunable
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
		use
			use_own_representation: representation
		do
			Result := extendible
			-- TODO hier schon definieren oder erst deferred?
		end

	can_put (v: G) : BOOLEAN is
			-- Can `an_item' be added?
		use
			use_own_representation: representation
		do
			Result := extendible
			-- TODO hier schon definieren oder erst deferred?
		end

-- TODO nötig? gibt ja keine verschiedenen prune mechanismen im vergleich zu extend <> put <> force_*
	can_prune (v: G) : BOOLEAN is
			-- Can `an_item' be pruned?
		use
			use_own_representation: representation
		do
			Result := prunable
		end

invariant

	empty_defined_through_model: is_empty = model.is_empty
	count_defined_through_model: count = model.count

end
