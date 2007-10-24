indexing
	description: "[
		Finite data structures of the most general kind,
		used to hold zero or more items.
		]"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_CONTAINER [G]

inherit
	CC_ANY

feature -- Access

	has (v: G): BOOLEAN is
			-- Does structure include `v'?
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		use
			use_own_representation: representation
		deferred
		ensure
			not_found_in_empty: Result implies not is_empty
			model_correspondends: Result = model.contains (v)
		end

feature -- Measurement

	count: INTEGER is
			-- Number of items
		use
			use_own_representation: representation
		deferred
		ensure
			model_correspondends: Result = model.count
		end

feature -- Status report

	is_empty: BOOLEAN is
			-- Is there no element?
		use
			use_own_representation: representation
		deferred
		ensure
			model_correspondends: Result = model.is_empty
		end

-- TODO what to do here? and how :-D
	object_comparison: BOOLEAN
			-- Must search operations use `equal' rather than `='
			-- for comparing references? (Default: no, use `='.)


	changeable_comparison_criterion: BOOLEAN is
			-- May `object_comparison' be changed?
			-- (Answer: yes by default.)
		use
			use_own_representation: representation
		do
			Result := True
		end

feature -- Status setting

	compare_objects is
			-- Ensure that future search operations will use `equal'
			-- rather than `=' for comparing references.
		require
			changeable_comparison_criterion: changeable_comparison_criterion
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		do
			object_comparison := True
		ensure
			object_comparison
			confined representation
		end

	compare_references is
			-- Ensure that future search operations will use `='
			-- rather than `equal' for comparing references.
		require
			changeable_comparison_criterion: changeable_comparison_criterion
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		do
			object_comparison := False
		ensure
			reference_comparison: not object_comparison
			confined representation
		end

feature -- Conversion

	linear_representation: CC_LINEAR [G] is
			-- Representation as a linear structure
		use
			use_own_representation: representation
		deferred
		ensure
			models_equivalent: model.domain |=| Result.model.first.range
		end

feature -- Model

	model: MML_BAG [G] is
			-- Model of a general container
		use
			use_own_representation: representation
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
			result_not_void: Result /= Void
		end

feature -- Framing

	representation: FRAME is
			-- Representation of a general container
		use
			use_own_representation: representation
		deferred
		ensure
			result_not_void: Result /= Void
		end

invariant

	empty_defined_through_model: is_empty = model.is_empty
	count_defined_through_model: count = model.count

end
