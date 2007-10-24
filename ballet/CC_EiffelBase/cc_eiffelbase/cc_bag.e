indexing
	description: "[
		Collections of items, where each item may occur zero
		or more times, and the number of occurrences is meaningful.
		]"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_BAG [G]

inherit
	CC_COLLECTION [G]
		redefine
			extend
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
			model_corresponds: Result = model.occurrences (v)
		end

feature -- Element change

	extend (v: G) is
			-- Add a new occurrence of `v'.
		deferred
		ensure then
			one_more_occurrence: occurrences (v) = old (occurrences (v)) + 1
			model_corresponds: model.occurrences (v) = old model.occurrences (v) + 1
		end

end
