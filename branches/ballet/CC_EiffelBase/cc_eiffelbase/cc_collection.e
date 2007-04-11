indexing
	description: "[
		General container data structures, 
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
	-- TODO hier renamen oder redefinen? oder überhaupt?
		rename
			model as container_model
		end

feature -- Status report

	extendible: BOOLEAN is
			-- May new items be added?
		use
			use_own_repr: repr
		deferred
		end

	prunable: BOOLEAN is
			-- May items be removed?
		use
			use_own_repr: repr
		deferred
		end

	is_inserted (v: G): BOOLEAN is
			-- Has `v' been inserted by the most recent insertion?
			-- (By default, the value returned is equivalent to calling
			-- `has (v)'. However, descendants might be able to provide more
			-- efficient implementations.)
		use
			use_own_repr: repr
		do
			Result := has (v)
		end

feature -- Element change

	put, extend (v: G) is
			-- Ensure that structure includes `v'.
		require
			extendible: extendible
		modify
			modify_own_repr: repr
		deferred
		ensure
			item_inserted: is_inserted (v)
		end

	fill (other: CC_CONTAINER [G]) is
			-- Fill with as many items of `other' as possible.
			-- The representations of `other' and current structure
			-- need not be the same.
		require
			other_not_void: other /= Void
			extendible: extendible
		use
			use_other_repr: other.repr
		modify
			modify_own_repr: repr
		local
			lin_rep: CC_LINEAR [G]
		do
			lin_rep := other.linear_representation
			from
				lin_rep.start
			until
				not extendible or else lin_rep.off
			loop
				extend (lin_rep.item)
				lin_rep.forth
			end
		end

feature -- Removal

	prune (v: G) is
			-- Remove one occurrence of `v' if any.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		require
			prunable: prunable
		modify
			modify_own_repr: repr
		deferred
		end

	prune_all (v: G) is
			-- Remove all occurrences of `v'.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			--|Default implementation, usually inefficient.
		require
			prunable: prunable
		modify
			modify_own_repr: repr
		do
			from
			until not has (v) loop
				prune (v)
			end
		ensure
			no_more_occurrences: not has (v)
		end

	wipe_out is
			-- Remove all items.
		require
			prunable: prunable
		modify
			modify_own_repr: repr
		deferred
		ensure
			wiped_out: is_empty
		end

feature -- Model
-- TODO hier schon implementierung oder erst deferred???
	model: MML_BAG [G] is
			-- Model of a general collection
		modify
			modify_own_repr: repr
		local
			linear: CC_LINEAR [G]
		do
			create {MML_DEFAULT_BAG [G]} Result.make_empty
			linear := linear_representation

			from
				linear.start
			until
				linear.off
			loop
				Result := Result.extended (linear.item)
				linear.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Framing

	repr: FRAME is
			-- Representation of a general collection
		use
			use_own_repr: repr
		deferred
		end

invariant

	empty_defined_through_model: is_empty = model.is_empty

end
