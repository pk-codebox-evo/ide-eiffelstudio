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
		export
			{NONE} all
		redefine
			on_project_loaded
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
			create on_add_test_case.make (5)
			create on_remove_test_case.make (5)
			create on_enable_testing.make (5)
			create on_disable_testing.make (5)

				-- Create List for storing test cases
			test_cases := create {DS_LINKED_LIST [CDD_TEST_CASE]}.make

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
		local
			l_cdd_dir, l_project_dir: DIRECTORY
		do
			create l_cdd_dir.make (path)
			create l_project_dir.make (eiffel_project.project_directory.path)
			if (l_cdd_dir.exists and l_cdd_dir.is_writable) or l_project_dir.is_writable then
				if not eiffel_universe.target.system.date_has_changed then
					Result := True
				end
			end
		end

	changed: BOOLEAN
		-- Has the test suite changed since last compilation?

	test_cases: DS_LIST [CDD_TEST_CASE]
			-- Sorted list of all test cases in 'Current'
			-- Note: Do not modify directly!

feature -- Status change

	enable_testing is
			-- Set 'is_testing_enabled' to True. If necessary, add new
			-- cluster, target and library for testing support to the project.
		require
			can_enable_testing: can_enable_testing
		do
				-- create directory structure
			is_testing_enabled := True
--			create l_dir.make (cdd_path)
--			if not l_dir.exists then
--				l_dir.create_dir
--			end
--			create l_dir.make (test_cases_path)
--			if not l_dir.exists then
--				l_dir.create_dir
--			end

				-- create cdd_testing cluster
			cluster := eiffel_universe.cluster_of_name (cluster_name)
			if cluster = Void then
				manager.add_cluster (cluster_name, Void, path)
				cluster := manager.last_added_cluster
				if not cluster.is_recursive then
					cluster.set_recursive (True)
				end
				eiffel_universe.conf_system.store
				melt_project_cmd.execute_and_wait
			end


			test_case_factory.parse_test_cases (Current)


				-- TODO: create target for testing

				-- compile the project

				-- notify observers
			on_enable_testing.do_all (agent notify_test_suite_status)
		ensure
			testing_is_enabled: is_testing_enabled
			target_set: target /= Void
			cluster_set: cluster /= Void
		end

--	disable_testing is
--			--
--		require
--			testing_enabled: not is_testing_enabled
--		do
--			on_disable_testing.do_all (agent notify_test_suite_status)
--		end


feature -- Element change

	add_test_case (a_tc: CDD_TEST_CASE) is
			-- Add 'a_tc' to 'test_cases' and notify agents
		require
			valid_test_case: a_tc /= Void
			not_added_yet: not test_cases.has (a_tc)
		local
			l_done: BOOLEAN
		do
			from
				l_done := False
				test_cases.start
			until
				test_cases.after or l_done
			loop
				if test_cases.item_for_iteration < a_tc or test_cases.is_last then
					test_cases.put_right (a_tc)
					l_done := True
				end
				test_cases.forth
			end
			on_add_test_case.do_all (agent notify_test_case_change (a_tc, ?))
		ensure
			test_case_added: test_cases.has (a_tc)
		end

	remove_test_case (a_tc: CDD_TEST_CASE) is
			-- Remove 'a_tc' from 'test_cases' and notify agents
		require
			valid_test_case: a_tc /= Void and then test_cases.has (a_tc)
		do
			on_remove_test_case.do_all (agent notify_test_case_change (a_tc, ?))
		ensure
			test_case_removed: not test_cases.has (a_tc)
		end



feature {EB_CLUSTERS} -- Project Events

	on_project_loaded is
			-- Initialize all project specific attributes and
			-- fill 'Current' with existing test cases
		do
			create path.make_from_string (eiffel_project.project_directory.path)
			path.extend (cluster_name)

			 -- check if testing was enabled before
--			l_system := eiffel_universe.conf_system
--			if eiffel_universe.cluster_of_name (cluster_name) /= Void and can_enable_testing then
--				enable_testing
--				test_case_factory.parse_test_cases (Current)
--			else
--				is_testing_enabled := False
--			end
		ensure then
			valid_path: path /= Void and then not path.is_empty
		end


feature -- Events

	on_add_test_case: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]]]
			-- agents called when test case wass added to 'Current'

	on_remove_test_case: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]]]
			-- agents called when test case was removed from 'Current'

	on_enable_testing: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- agents called when testing is enabled

	on_disable_testing: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
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

	target: CONF_TARGET
			-- target for executing test cases

	cluster: CLUSTER_I
			-- cluster where all generated classes for testing are stored

	path: DIRECTORY_NAME
			-- path of 'cluster'


end -- class CDD_TEST

