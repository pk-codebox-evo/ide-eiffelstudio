indexing
	description: "Objects that represent a test suite containing test cases"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE

inherit

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

create
	make_with_cluster

feature {NONE} -- Initialization

	make_with_cluster (a_cluster: like tests_cluster) is
			-- Set 'tests_cluster' to 'a_cluster' and create test case list.
		require
			a_cluster /= Void
		do
			tests_cluster := a_cluster
			create test_cases.make
		ensure
			tests_cluster_set: tests_cluster = a_cluster
		end

feature -- Access

	test_cases: DS_LINKED_LIST [CDD_TEST_CASE]
			-- Sorted list of all test cases in 'Current'
			-- Note: Do not modify directly!

	target_under_test: CONF_TARGET is
			-- Currently opened target
		do
			Result := eiffel_universe.target
		end

	tests_cluster: CLUSTER_I
			-- Cluster where all generated classes for testing are stored

	test_case_for_class (a_class: CLASS_I): CDD_TEST_CASE is
			-- Associated test case for test class `a_class' if exists, otherwise Void
		require
			a_class_not_void: a_class /= Void
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
		do
			from
				l_cursor := test_cases.new_cursor
				l_cursor.start
			until
				l_cursor.after or Result /= Void
			loop
				if l_cursor.item.tester_class = a_class then
					Result := l_cursor.item
				end
				l_cursor.forth
			end
		end

feature -- Status report

	has_test_case_for_class (a_class: CLASS_I): BOOLEAN is
			-- Does 'Current' have a test case for test class 'a_class'
		require
			a_class_not_void: a_class /= Void
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
		do
			from
				l_cursor := test_cases.new_cursor
				l_cursor.start
			until
				l_cursor.after or Result
			loop
				if l_cursor.item.tester_class = a_class then
					Result := True
				end
				l_cursor.forth
			end
		end

feature -- Element change

	add_test_case (a_tc: CDD_TEST_CASE) is
			-- Add 'a_tc' to 'test_cases'
		require
			valid_test_case: a_tc /= Void
			not_added_yet: not test_cases.has (a_tc)
			valid_test_case: a_tc.tester_class.group = tests_cluster
		local
			l_found: BOOLEAN
		do
			from
				test_cases.start
			until
				test_cases.after or l_found
			loop
				if a_tc < test_cases.item_for_iteration then
					l_found := True
				else
					test_cases.forth
				end
			end
			test_cases.put_left (a_tc)
		ensure
			test_case_added: test_cases.count = old test_cases.count + 1 and test_cases.has (a_tc)
		end

	remove_test_case (a_tc: CDD_TEST_CASE) is
			-- Remove test class for 'a_tc' and notify class manager.
		require
			valid_test_case: a_tc /= Void
			contains_test_case: test_cases.has (a_tc)
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
		do
			l_cursor := test_cases.new_cursor
			l_cursor.start
			l_cursor.search_forth (a_tc)
			l_cursor.remove
		ensure
			test_case_removed: not test_cases.has (a_tc)
		end

invariant

	test_cases_not_void: test_cases /= Void
	tests_cluster_not_void: tests_cluster /= Void

end -- class CDD_TEST_SUITE
