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
			changeable_comparison_criterion
		end

feature -- Element change

	extend, put (v: G) is
			-- Ensure that set includes `v'.
		modify
			modify_own_representation: representation
		deferred
		ensure then
			in_set_already: old has (v) implies (count = old count)
			added_to_set: not old has (v) implies (count = old count + 1)
			-- TODO hier noch contracts oder reicht das geerbte?
		end

feature -- Removal

	prune (v: G) is
			-- Remove `v' if present.
		modify
			modify_own_representation: representation
		deferred
		ensure then
			removed_count_change: old has (v) implies (count = old count - 1)
			not_removed_no_count_change: not old has (v) implies (count = old count)
			item_deleted: not has (v)
			model_corresponds: not model.contains (v)
		end

	changeable_comparison_criterion: BOOLEAN is
			-- May `object_comparison' be changed?
			-- (Answer: only if set empty; otherwise insertions might
			-- introduce duplicates, destroying the set property.)
		use
			use_own_representation: representation
		do
			Result := is_empty
		ensure then
			only_on_empty: Result = is_empty
		end

feature -- Model

	model: MML_SET [G] is
			-- Model of a set
		modify
			modify_own_representation: representation
		do
			Result := model_collection.domain
		ensure
			Result_not_void: Result /= Void
		end

invariant

	empty_defined_through_model: is_empty = model.is_empty
	count_defined_through_model: count = model.count
	models_correspondend: model.count = model_collection.count
	models_equivalent: model |=| model_collection.domain

end
