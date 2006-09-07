indexing
	description: "Objects that represent a test suite containing test cases"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE

inherit

	CDD_CONSTANTS
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	EB_CLUSTER_MANAGER_OBSERVER
		rename
			refresh as on_refresh
		export
			{NONE} all
		redefine
			on_project_loaded,
			on_class_removed,
			on_refresh
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

	CONF_ACCESS
		export
			{NONE} all
		end

	CDD_SHARED_FACTORY
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize 'Current'
		do
			create add_test_case_actions.make (5)
			create remove_test_case_actions.make (5)
			create enable_testing_actions.make (5)
			create disable_testing_actions.make (5)

				-- Create List for storing test cases
			create test_cases.make

				-- register as observer when project status changes
			manager.add_observer (Current)
		end

feature -- Access

	is_testing_enabled: BOOLEAN
			-- Is testing enabled?

	can_enable_testing: BOOLEAN is
			-- Does the current state of the project allow us to enable testing?
		require
			testing_not_enabled: not is_testing_enabled
		do
			Result := False
		end

	changed: BOOLEAN
		-- Has the test suite changed since last compilation?

	test_cases: DS_LINKED_LIST [CDD_TEST_CASE]
			-- Sorted list of all test cases in 'Current'
			-- Note: Do not modify directly!

feature -- Status report

	test_class_exists (a_class: CLASS_I): BOOLEAN is
			-- Does 'Current' have a test case for test class 'a_class'
		require
			a_class_not_void: a_class /= Void
			a_class_is_test_class: a_class.group = tests_cluster
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
		do
			from
				l_cursor := test_cases.new_cursor
				l_cursor.start
			until
				l_cursor.after or Result
			loop
				if l_cursor.item.test_class = a_class then
					Result := True
				end
				l_cursor.forth
			end
		end


feature -- Status change

	enable_testing is
			-- Set 'is_testing_enabled' to True. If necessary, add new
			-- cluster, target and library for testing support to the project.
		require
			can_enable_testing: can_enable_testing
		do
			is_testing_enabled := True
			-- TODO: create directories, clusters and targets for cdd
		ensure
			testing_is_enabled: is_testing_enabled
		end


feature -- Element change

	add_test_case (a_tc: CDD_TEST_CASE) is
			-- Add 'a_tc' to 'test_cases' and notify agents
		require
			valid_test_case: a_tc /= Void
			not_added_yet: not test_cases.has (a_tc)
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
				end
				test_cases.forth
			end
			test_cases.put_left (a_tc)
			add_test_case_actions.do_all (agent notify_test_case_change (a_tc, ?))
		ensure
			test_case_added: test_cases.count = old test_cases.count + 1 and test_cases.has (a_tc)
		end

	remove_test_case (a_tc: CDD_TEST_CASE) is
			-- Remove test class for 'a_tc' and notify class manager.
		require
			valid_test_case: a_tc /= Void
			contains_test_case: test_cases.has (a_tc)
		do
			remove_test_case_only (a_tc)
			-- remove Current from observer list since there is no need
			-- to be notified that a class has been removed.
			manager.remove_observer (Current)
			test_case_factory.remove_test_case (a_tc)
			manager.add_observer (Current)
		ensure
			test_case_removed: not test_cases.has (a_tc)
		end



feature {EB_CLUSTERS} -- Project Events

	on_project_loaded is
			-- Initialize all project specific attributes and
			-- fill 'Current' with existing test cases
		local
			l_current_target: CONF_TARGET
			l_clusters: HASH_TABLE [CONF_CLUSTER, STRING]
			l_targets: LIST [CONF_TARGET]
		do
			tests_cluster := eiffel_universe.cluster_of_name (tests_cluster_name)
			l_current_target := eiffel_universe.target
			l_targets := l_current_target.child_targets
			from
				l_targets.start
			until
				l_targets.after or tester_target /= Void
			loop
				if l_targets.item.name.is_equal (tester_target_name) then
					tester_target := l_targets.item
				else
					l_targets.forth
				end
			end
			if tester_target /= Void then
				l_clusters := tester_target.clusters
				if l_clusters.has (tester_cluster_name) then
					tester_cluster := l_clusters.item (tester_cluster_name)
				end
			end
			if tests_cluster /= Void and tester_target /= Void and tester_cluster /= Void then
				is_testing_enabled := True
				enable_testing_actions.do_all (agent notify_test_suite_status)
			end
		end

	on_refresh is
			-- Refresh test suite.
		do
			if is_testing_enabled then
				test_case_factory.parse_cluster (tests_cluster, Current)
			end
		end


	on_class_removed (a_class: CLASS_I) is
			-- If class was test class, remove corresponding test case.
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
			l_item: CDD_TEST_CASE
		do
			if a_class.group = tests_cluster then
				from
					l_cursor := test_cases.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					if l_cursor.item.test_class = a_class then
						remove_test_case_only (l_cursor.item)
						l_cursor.go_after
					else
						l_cursor.forth
					end
				end
			end
		end



feature -- Events

	add_test_case_actions: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]]]
			-- agents called when test case wass added to 'Current'

	remove_test_case_actions: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]]]
			-- agents called when test case was removed from 'Current'

	enable_testing_actions: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- agents called when testing is enabled

	disable_testing_actions: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- agents called when testing is disabled


feature {NONE} -- Event Handling

	notify_test_case_change (a_tc: CDD_TEST_CASE; a_proc: PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]]) is
			-- Call 'a_proc' with argument 'a_tc'
		do
			a_proc.call ([a_tc])
		end

	notify_test_suite_status (a_proc: PROCEDURE [ANY, TUPLE]) is
			-- Call 'a_proc'
		do
			a_proc.call ([])
		end

feature -- Project specific

	tester_target: CONF_TARGET
			-- target for executing test cases

	tester_cluster: CONF_CLUSTER
			-- cluster where tester class is stored

	tests_cluster: CLUSTER_I
			-- cluster where all generated classes for testing are stored


feature {NONE} -- Implementation

	remove_test_case_only (a_tc: CDD_TEST_CASE) is
			-- Remove 'a_tc' from 'test_cases' and notify all agents.
		require
			a_tc_not_void: a_tc /= Void
			contains_test_case: test_cases.has (a_tc)
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
		do
			l_cursor := test_cases.new_cursor
			l_cursor.start
			l_cursor.search_forth (a_tc)
			l_cursor.remove
			remove_test_case_actions.do_all (agent notify_test_case_change (a_tc, ?))
		ensure
			removed: not test_cases.has (a_tc)
		end




end -- class CDD_TEST_SUITE
