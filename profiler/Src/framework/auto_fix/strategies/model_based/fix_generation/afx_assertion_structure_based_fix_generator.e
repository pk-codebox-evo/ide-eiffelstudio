note
	description: "Summary description for {AFX_ASSERTION_STRUCTURE_BASED_FIX_GENERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	AFX_ASSERTION_STRUCTURE_BASED_FIX_GENERATOR

inherit
	AFX_SHARED_SESSION

	AFX_UTILITY

	AFX_FIX_SKELETON_CONSTANT

feature{NONE} -- Initialization

	make (a_analyzer: like structure_analyzer; a_fixing_locations: like fixing_locations)
			-- Initialize.
		require
			a_analyzer_is_matched: a_analyzer.is_matched
		do
			create fixes.make
			structure_analyzer := a_analyzer
			fixing_locations := a_fixing_locations.twin
		end

feature -- Access

	fixes: LINKED_LIST [AFX_FIX_SKELETON]
			-- Fixes generated

	structure_analyzer: EPA_EXPRESSION_STRUCTURE_ANALYZER
			-- Failing assertion structure analyzer

--	exception_spot: AFX_EXCEPTION_SPOT
--			-- Exception spot containing information of the failing

	fixing_locations: LINKED_LIST [TUPLE [scope_level: INTEGER; instructions: LINKED_LIST [AFX_AST_STRUCTURE_NODE]]]
			-- List of fixing locations

--	config: AFX_CONFIG
--			-- Config for current AutoFix session

	test_case_execution_status: HASH_TABLE [AFX_TEST_CASE_EXECUTION_STATUS, STRING]
			-- Table of test case execution status
			-- Key is a test case, value is the execution status
			-- assoicated with that test case

--feature -- Constants

--	afore_skeleton_complexity: INTEGER is 1
--			-- Complexity level for afore fix skeleton

--	wrapping_skeleton_complexity: INTEGER is 2
--			-- Complexity level for wrapping fix skeleton

feature -- Basic operations

	generate
			-- Generate fixes into `fixes'.
		deferred
		end

feature{NONE} -- Implementation

	new_afore_fix_skeleton (
			a_fixing_location: LINKED_LIST [AFX_AST_STRUCTURE_NODE];
			a_guard: detachable EPA_EXPRESSION;
			a_precondition: detachable EPA_STATE;
			a_postcondition: detachable EPA_STATE;
			a_scope_level: INTEGER;
			a_guard_in_negation: BOOLEAN): AFX_AFORE_FIX_SKELETON
				-- New afore fix sekelton.
		local
			l_ranking: AFX_FIX_RANKING
		do
			create Result.make (a_guard_in_negation)
			Result.set_guard_condition (a_guard)
			Result.set_precondition (a_precondition)
			Result.set_postcondition (a_postcondition)
			Result.set_relevant_ast (a_fixing_location)

			create l_ranking
			l_ranking.set_fix_skeleton_complexity (afore_skeleton_complexity)
			l_ranking.set_scope_levels (a_scope_level)
			Result.set_ranking (l_ranking)
		end

	new_wrapping_fix_skeleton (
			a_fixing_location: LINKED_LIST [AFX_AST_STRUCTURE_NODE];
			a_guard: detachable EPA_EXPRESSION;
			a_precondition: detachable EPA_STATE;
			a_postcondition: detachable EPA_STATE;
			a_scope_level: INTEGER;
			a_guard_in_negation: BOOLEAN): AFX_WRAP_FIX_SKELETON
				-- New afore fix sekelton.
		require
			a_fixing_location_attached: a_fixing_location /= Void
			not_a_fixing_location_is_empty: not a_fixing_location.is_empty
		local
			l_ranking: AFX_FIX_RANKING
		do
			create Result.make (a_guard, a_guard_in_negation)
			Result.set_precondition (a_precondition)
			Result.set_postcondition (a_postcondition)
			Result.set_relevant_ast (a_fixing_location)

			create l_ranking
			l_ranking.set_fix_skeleton_complexity (wrapping_skeleton_complexity)
			l_ranking.set_scope_levels (a_scope_level)
			Result.set_ranking (l_ranking)
		end

end
