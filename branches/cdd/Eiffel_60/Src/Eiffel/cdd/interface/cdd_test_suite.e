indexing
	description: "Objects that store and manage test cases"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE

create
	make_with_target

feature {NONE} -- Initialization

	make_with_target (a_target: like target) is
			-- Set `target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			target := a_target
			create test_cases.make
			refresh
		ensure
			target_set: target = a_target
		end

feature -- Access

	test_cases: DS_LINKED_LIST [CDD_TEST_CASE]
			-- Sorted list with all test cases

	has_test_case_for_class (a_class: EIFFEL_CLASS_C): BOOLEAN is
			-- Does `test_cases' contain a test case for test case class `a_class'?
		require
			a_class_not_void: a_class /= Void
		do
			Result := has_test_case_with_property (agent (a_tc: CDD_TEST_CASE; a_cl: EIFFEL_CLASS_C): BOOLEAN
					do
						Result := a_tc.test_class = a_cl
					end (?, a_class)
				)
		end

feature -- Element change

--	add_test_case (a_test_case: CDD_TEST_CASE) is
--			-- Add test case `a_test_case' and notify add actions.
--		do
--		end

	add_test_case_for_class (a_class: EIFFEL_CLASS_C) is
			-- Add test case represented by test case class `a_class'.
		require
			a_class_not_void: a_class /= Void
			not_added_yet: not has_test_case_for_class (a_class)
		local
			l_tc: CDD_TEST_CASE
		do
			create l_tc.make_with_class (a_class)
			test_cases.put_last (l_tc)
			add_test_case_actions.call ([l_tc])
		ensure
			added: has_test_case_for_class (a_class)
		end

feature -- Status setting

	refresh is
			-- Check `target' for new or removed
			-- test cases and update `test_cases'.
		do
		end

feature -- Removal

	remove_test_case (a_test_case: CDD_TEST_CASE) is
			-- Remove test case `a_test_case' and notify remove actions.
		do
		end

feature -- Event handling

	add_test_case_actions: ACTION_SEQUENCE [TUPLE [CDD_TEST_CASE]]
			-- Agents called when test case is added to `Current'

	remove_test_case_actions: ACTION_SEQUENCE [TUPLE [CDD_TEST_CASE]]
			-- Agents called when test case is removed from `Current'

feature {NONE} -- Implementation

	target: CONF_TARGET

	has_test_case_with_property (a_prop: FUNCTION [ANY, TUPLE [CDD_TEST_CASE], BOOLEAN]): BOOLEAN is
			-- Does `test_cases' contain an item, for which `a_prop' returns True?
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
		do
			from
				create l_cursor.make (test_cases)
				l_cursor.start
			until
				l_cursor.after or Result
			loop
				a_prop.call ([l_cursor.item])
				if a_prop.last_result then
					Result := True
				else
					l_cursor.forth
				end
			end
		end



invariant
	target_not_void: target /= Void
	test_cases_not_void: test_cases /= Void

end
