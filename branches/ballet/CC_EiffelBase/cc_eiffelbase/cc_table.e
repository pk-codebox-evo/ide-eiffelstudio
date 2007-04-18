indexing
	description: "Containers whose items are accessible through keys"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_TABLE [G, H]
	-- TODO delete, G typ der items, H typ der keys

inherit
	CC_COLLECTION [G]
		rename
			model as model_container,
			put as collection_put
		end

feature -- Access

	item alias "[]", infix "@" (k: H): G assign put is
			-- Entry of key `k'.
		require
			valid_key: valid_key (k)
		use
			use_own_representation: representation
		deferred
		ensure
			-- TODO
		end

feature -- Measurement

	occurrences (v: G): INTEGER is
			-- Number of times `v' appears in structure
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		use
			use_own_representation: representation
		deferred
		ensure
			non_negative_occurrences: Result >= 0
			model_corresponds: Result = model_container.occurrences (v)
		end

feature -- Status report

	valid_key (k: H): BOOLEAN is
			-- Is `k' a valid key?
		use
			use_own_representation: representation
		deferred
		end

feature -- Element change

	put (v: G; k: H) is
			-- Associate value `v' with key `k'.
		require
			valid_key: valid_key (k)
		modify
			modify_own_representation: representation
		deferred
		ensure
			model_updated: model |=| old model.extended_by_pair (v, k)
			model_corresponds: model.contains_pair (v, k)
			confined representation
		end

feature {NONE} -- Inapplicable

	collection_put (v: G) is
		do
		end

feature -- Model

	model: MML_RELATION [G, H] is
			-- Model of a table
		modify
			modify_own_representation: representation
		do
			create {MML_DEFAULT_RELATION [G, H]} Result.make_empty
		ensure
			Result_not_void: Result /= Void
		end

invariant



end
