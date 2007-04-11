indexing
	description: "Collection, where each element must be unique."
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_SET [G]

inherit
	CC_COLLECTION [G]
		rename
			model as collection_model
		redefine
			changeable_comparison_criterion
		end

feature -- Measurement

	count: INTEGER is
			-- Number of items
		use
			use_own_repr: repr
		deferred
		end

feature -- Element change

	extend, put (v: G) is
			-- Ensure that set includes `v'.
		modify
			modify_own_repr: repr
		deferred
		ensure then
			in_set_already: old has (v) implies (count = old count)
			added_to_set: not old has (v) implies (count = old count + 1)
		end

feature -- Removal

	prune (v: G) is
			-- Remove `v' if present.
		modify
			modify_own_repr: repr
		deferred
		ensure then
			removed_count_change: old has (v) implies (count = old count - 1)
			not_removed_no_count_change: not old has (v) implies (count = old count)
			item_deleted: not has (v)
		end

	changeable_comparison_criterion: BOOLEAN is
			-- May `object_comparison' be changed?
			-- (Answer: only if set empty; otherwise insertions might
			-- introduce duplicates, destroying the set property.)
		use
			use_own_repr: repr
		do
			Result := is_empty
		ensure then
			only_on_empty: Result = is_empty
		end

feature -- Model
-- TODO hier schon implementierung oder erst deferred???
	model: MML_SET [G] is
			-- Model of a set
		modify
			modify_own_repr: repr
		local
			linear: CC_LINEAR [G]
		do
			create {MML_DEFAULT_SET [G]} Result.make_empty
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
			-- Representation of a set
		use
			use_own_repr: repr
		deferred
		end

end
