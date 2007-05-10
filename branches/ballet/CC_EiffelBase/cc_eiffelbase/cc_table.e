indexing
	description: "Containers whose items are accessible through keys"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_TABLE [G, K]
	-- TODO delete, G typ der items, K typ der keys

inherit
	CC_COLLECTION [G]
		rename
			model as model_container,
			put as collection_put,
			extend as collection_extend,
			can_extend as collection_can_extend,
			can_put as collection_can_put
		redefine
			collection_can_extend,
			collection_can_put
		end

feature -- Access

	item alias "[]", infix "@" (k: K): G assign put is
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

	valid_key (k: K): BOOLEAN is
			-- Is `k' a valid key?
		use
			use_own_representation: representation
		deferred
		end

feature -- Element change

	put (v: G; k: K) is
			-- Associate value `v' with key `k'.
		require
			valid_key: valid_key (k)
			can_put_element: can_put (v, k)
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
			model_updated: model |=| old model.extended_by_pair (v, k)
			model_corresponds: model.contains_pair (v, k)
			confined representation
		end

feature -- Element specific status report

-- die beiden machen eher keinen sinn, da die table eher key zentriert ist
	can_extend (v: G; k: K) : BOOLEAN is
			-- Can `an_item' be added? Only iff the key is not yet used.
		use
			use_own_representation: representation
		do
			-- auch checken, dass key noch nicht existiert
			Result := extendible and (item (k) = Void) -- TODO korrekt?
		ensure
			model_corresponds: not model.range.contains (k)
		end

	can_put (v: G; k: K) : BOOLEAN is
			-- Can `an_item' be added?
		use
			use_own_representation: representation
		do
			Result := extendible
		end

feature {NONE} -- Inapplicable

-- TODO sehr unschön

	collection_put (v: G) is
		do
		end

	collection_extend (v: G) is
		do
		end

	collection_can_extend (v: G) : BOOLEAN is
		do
		end

	collection_can_put (v: G) : BOOLEAN is
		do
		end

feature -- Model

	model: MML_RELATION [G, K] is
			-- Model of a table
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
			result_not_void: Result /= Void
			confined representation
		end

invariant

	--TODO models verknüpfen

end
