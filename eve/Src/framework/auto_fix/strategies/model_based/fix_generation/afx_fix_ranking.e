note
	description: "Summary description for {AFX_FIX_RANKING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AFX_FIX_RANKING

inherit
	AFX_SHARED_SESSION

feature -- Access

	relevant_instructions: INTEGER
			-- Number of relevant instructions in a fix
			-- Small is better.

	scope_levels: INTEGER
			-- Distance from the fix to the failing point
			-- Small is better.

	fix_skeleton_complexity: INTEGER
			-- Complexity level of the fix skeleton
			-- For example, afore fix skeleton is simpler than wrapping fix skeleton
			-- Small is better.

	snippet_complexity: INTEGER
			-- Snippet complexity
			-- Small is better.

	impact_on_passing_test_cases: DOUBLE
			-- Impact of the fix on passing test cases.
			-- This value measures how much the post state of passing test cases
			-- changes after applying the fix.
			-- The smaller the value, the better

	relevance_to_failure: REAL assign set_relevance_to_failure
			-- Relevance of the object states the fix is about to change to the program failure.

	set_relevance_to_failure (a_relevance: REAL)
			-- Set `relevance_to_failure'.
		do
			relevance_to_failure := a_relevance
		end

	pre_validation_score: DOUBLE
			-- Syntax ranking for a fix, which describe how large is
			-- the syntax change when the fix is applied to the original feature.
			-- Small is better.
		do
			if pre_validation_score_cache = 0 then
				pre_validation_score_cache :=
					(scope_levels            / max_scope_levels)          * scope_levels_weight
					+ (relevant_instructions   / max_relevant_instructions) * relevant_instructions_weight
					+ (fix_skeleton_complexity / max_skeleton_complexity)   * skeleton_complexity_weight
					+ (snippet_complexity      / max_snippet_complexity)    * snippet_complexity_weight
					- relevance_to_failure * relevance_weight
			end
			Result := pre_validation_score_cache
		end

	pre_validation_score_cache: DOUBLE

	post_validation_score: DOUBLE
			-- Sementics ranking for a fix, which describe how large is the change
			-- of the post state of all the passing test cases when the fix is applied.
			-- Ideally, the fix should not change the output of the passing test cases.
			-- Small is better.
		do
			Result := impact_on_passing_test_cases
		end

feature -- Constants

	max_scope_levels: INTEGER = 5
			-- Max value for `scope_levels'
			-- Note: this is an empirical value which works in most of the cases.
			-- The actual `scope_levels' can be larger than this.

	max_relevant_instructions: INTEGER = 10
			-- Max value for `relevant_instructions'
			-- Note: this is an empirical value which works in most of the cases.
			-- The actual `relevant_instructions' can be larger than this.

	max_skeleton_complexity: INTEGER = 2
			-- Max value for `skeleton_complexity'

	max_snippet_complexity: INTEGER = 5
			-- Max value for `snippet_complexity'
			-- Note: this is an empirical value which works in most of the cases.
			-- The actual `snippet_complexity' can be larger than this.	

	scope_levels_weight: DOUBLE = 2.5
			-- Weight of `scope_levels' in final syntax ranking calculation

	relevant_instructions_weight: DOUBLE = 1.0
			-- Weight of `relevant_instructions' in final syntax ranking calculation

	skeleton_complexity_weight: DOUBLE = 0.25
			-- Weight of `skeleton_complexity' in final syntax ranking calculation

	snippet_complexity_weight: DOUBLE = 5.0
			-- Weight of `snippet_complexity' in final syntax ranking calculation

	relevance_weight: DOUBLE = 5.0
			-- Weight of `relevance_to_failure' in pre-validation ranking calculation.

feature -- Setting

	set_relevant_instructions (i: INTEGER)
			-- Set `relevant_instructions' with `i'.
		do
			relevant_instructions := i
		ensure
			relevant_instructions_set: relevant_instructions = i
		end

	set_scope_levels (d: INTEGER)
			-- Set `scope_levels' with `d'.
		do
			scope_levels := d
		ensure
			failing_point_distance_set: scope_levels = d
		end

	set_fix_skeleton_complexity (c: INTEGER)
			-- Set `fix_skeleton_complexity' with `c'.
		do
			fix_skeleton_complexity := c
		ensure
			fix_skeleton_complexity_set: fix_skeleton_complexity = c
		end

	set_snippet_complexity (c: INTEGER)
			-- Set `snippet_complexity' with `c'.
		do
			snippet_complexity := c
		end

	set_impact_on_passing_test_cases (v: DOUBLE)
			-- Set `impact_on_passing_test_cases' with `v'.
		do
			impact_on_passing_test_cases := v
		ensure
			impact_on_passing_test_cases_set: impact_on_passing_test_cases = v
		end

end
