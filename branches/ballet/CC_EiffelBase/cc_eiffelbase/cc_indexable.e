indexing
	description: "Data structures that can be traversed and modified through integer access"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_INDEXABLE [G]

inherit
	CC_COLLECTION [G]
		rename
			put as put_last,
			extend as extend_last,
			model as model_collection
		export
			{NONE}
				model_collection
		end

feature -- Access

	infix "@", item (i: INTEGER): G is
			-- Item at index `i'.
		require
			valid_index: valid_index (i)
		use
			use_own_representation: representation
		deferred
		end

	first: G is
			-- First item in container.
		require
			not_empty: not is_empty
		use
			use_own_representation: representation
		deferred
		ensure
			definition: Result = item (1)
		end

	last: G is
			-- Last item in container.
		require
			not_empty: not is_empty
		use
			use_own_representation: representation
		deferred
		ensure
			definition: Result = item (count)
		end

feature -- Status report

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within allowable bounds?
		use
			use_own_representation: representation
		do
			Result := 1 <= i and i <= count
		ensure
			valid_index_definition: Result = (1 <= i and i <= count)
		end

feature -- Element change

-- TODO reichen can_add_element oder muss ein spezialisiertes can_add_element_at damit man auch
-- den index berücksichtigt?

	put (v: G; i: INTEGER) is
			-- Associate value `v' with index `i'.
		require
			can_add_element: can_put (v)
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
			-- TODO
			insertion_done: item (i) = v
--			model_updated: model |=| old model.extended (v)
--			model_correspondends: model.contains (v)
			confined representation
		end

	-- TODO ev auch ein extend (v, i)

feature -- Model

	model: MML_RELATION [INTEGER, G] is
			-- Model for an indexable data structure.
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

	-- TODO models verknüpfen
	models_equal: model.range |=| model_collection.domain

end
