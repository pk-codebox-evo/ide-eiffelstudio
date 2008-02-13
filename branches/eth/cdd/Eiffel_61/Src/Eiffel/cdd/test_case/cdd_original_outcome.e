indexing
	description: "Objects representing the original outcome of an extracted test case"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_ORIGINAL_OUTCOME

create
	make_passing,
	make_failing

feature {NONE} -- Initialization

	make_failing (a_covered_feature: E_FEATURE; an_exception: AUT_EXCEPTION) is
			-- Initialize `Current' as failing outcome.
		require
			a_covered_feature_not_void: a_covered_feature /= Void
			an_exception_not_void: an_exception /= Void
		do
			covered_feature := a_covered_feature
			exception := an_exception
		ensure
			covered_feature_set: covered_feature = a_covered_feature
			exception_set: exception = an_exception
			outcome_is_failing: is_failing
		end

	make_passing (a_covered_feature: E_FEATURE) is
			-- Initialize `Current' as passing outcome.
		require
			a_covered_feature_not_void: a_covered_feature /= Void
		do
			covered_feature := a_covered_feature
		ensure
			covered_feature_set: covered_feature = a_covered_feature
			outcome_is_passing: is_passing
		end

feature -- Access

	covered_feature: E_FEATURE
			-- Feature initially covered by the test routine associated with `Current'

	exception: AUT_EXCEPTION
			-- Exception thrown whereupon test routine associated with `Current' got extracted

feature -- Measurement

feature -- Status report

	is_failing: BOOLEAN is
			-- Does `Current' represent a failing outcome?
		do
			Result := exception /= Void
		ensure
			not_is_passing: Result = not is_passing
		end

	is_passing: BOOLEAN is
			-- Does `Current' represent a passing outcome?
		do
			Result := not is_failing
		ensure
			definition: Result = not is_failing
		end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	covered_feature_set: covered_feature /= Void

end
