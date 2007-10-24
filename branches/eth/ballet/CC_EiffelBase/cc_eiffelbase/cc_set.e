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
			model as model_collection
		redefine
			changeable_comparison_criterion,
			can_extend,
			can_put
		end

feature -- Element change

	extend (v: G) is
			-- Ensure that set includes `v' iff `v' can be added.
		deferred
		ensure then
			added_to_set: not old has (v) implies (count = old count + 1)
		end

	put (v: G) is
			-- Ensure that set includes `v'.
		deferred
		ensure then
			in_set_already: old has (v) implies (count = old count)
			added_to_set: not old has (v) implies (count = old count + 1)
		end

feature -- Removal

	prune (v: G) is
			-- Remove `v' if present.
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
		do
			Result := is_empty
		ensure then
			only_on_empty: Result = is_empty
		end

feature -- Element specific status report

	can_extend (v: G) : BOOLEAN is
			-- Can `an_item' be added?
			-- True only if it is not already in the set.
		do
			Result := extendible and not has(v)
		ensure then
			element_not_in_set: Result = not has (v)
			model_corresponds: Result = not model.contains (v)
		end

	can_put (v: G) : BOOLEAN is
			-- Can `an_item' be added?
		do
			Result := extendible
		end

feature -- Model

	model: MML_SET [G] is
			-- Model of a set
		use
			use_own_representation: representation
		do
			Result := model_collection.domain
		ensure
			Result_not_void: Result /= Void
		end

invariant

	models_correspondend: model.count = model_collection.count
	models_equivalent: model |=| model_collection.domain

end
