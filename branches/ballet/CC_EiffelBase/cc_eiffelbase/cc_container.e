indexing
	description: "[
		Data structures of the most general kind,
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
			use_own_repr: repr
		deferred
		ensure
			not_found_in_empty: Result implies not is_empty
		end

feature -- Status report

	is_empty: BOOLEAN is
			-- Is there no element?
		use
			use_own_repr: repr
		deferred
		end

-- TODO obsolete Sachen aus meiner Base Library schmeissen?
	empty: BOOLEAN is
			-- Is there no element?
		obsolete
			"ELKS 2000: Use `is_empty' instead"
		do
			Result := is_empty
		end

-- TODO wie hier mahcen?
	object_comparison: BOOLEAN
			-- Must search operations use `equal' rather than `='
			-- for comparing references? (Default: no, use `='.)


	changeable_comparison_criterion: BOOLEAN is
			-- May `object_comparison' be changed?
			-- (Answer: yes by default.)
		do
			Result := True
		end

feature -- Status setting

	compare_objects is
			-- Ensure that future search operations will use `equal'
			-- rather than `=' for comparing references.
		require
			changeable_comparison_criterion: changeable_comparison_criterion
		modify
			modify_own_repr: repr
		do
			object_comparison := True
		ensure
			object_comparison
		end

	compare_references is
			-- Ensure that future search operations will use `='
			-- rather than `equal' for comparing references.
		require
			changeable_comparison_criterion: changeable_comparison_criterion
		modify
			modify_own_repr: repr
		do
			object_comparison := False
		ensure
			reference_comparison: not object_comparison
		end

feature -- Conversion

	linear_representation: CC_LINEAR [G] is
			-- Representation as a linear structure
		modify
			modify_own_repr: repr
		deferred
		end

feature -- Model
-- TODO hier schon implementierung oder erst deferred???
	model: MML_BAG [G] is
			-- Model of a general container
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
			-- Representation of a general container
		use
			use_own_repr: repr
		deferred
		end

invariant

	empty_defined_through_model: is_empty = model.is_empty

end
