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
			on_project_loaded,
			on_class_removed
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

	test_cases: DS_LINKED_LIST [CDD_TEST_CASE]
			-- Sorted list of all test cases in 'Current'
			-- Note: Do not modify directly!

feature -- Status report

	test_class_exists (a_class: CLASS_I): BOOLEAN is
			-- Does 'Current' have a test case for test class 'a_class'
		require
			a_class_not_void: a_class /= Void
			a_class_is_test_class: a_class.group = cluster
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


			test_case_factory.parse_cluster (cluster, Current)


				-- TODO: create target for testing

				-- compile the project

				-- notify observers
			enable_testing_actions.do_all (agent notify_test_suite_status)
		ensure
			testing_is_enabled: is_testing_enabled
			-- TODO: create target
			--target_set: target /= Void
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
		local
			l_file: PLAIN_TEXT_FILE
		do
			test_case_factory.remove_test_case (a_tc)
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

	on_class_removed (a_class: CLASS_I) is
			-- If class was test class, remove corresponding test case.
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
		do
			if a_class.group = cluster or True then
				from
					l_cursor := test_cases.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					if l_cursor.item.test_class = a_class then
						l_cursor.remove
						remove_test_case_actions.do_all (agent notify_test_case_change (l_cursor.item, ?))
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

	target: CONF_TARGET
			-- target for executing test cases

	cluster: CLUSTER_I
			-- cluster where all generated classes for testing are stored

	path: DIRECTORY_NAME
			-- path of 'cluster'



end -- class CDD_TEST

