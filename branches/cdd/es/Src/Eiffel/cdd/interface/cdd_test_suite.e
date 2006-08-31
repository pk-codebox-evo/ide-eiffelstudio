indexing
	description: "Objects that ..."
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
			--
		do

			-- test suite event handling
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

	is_project_loaded: BOOLEAN

	is_testing_enabled: BOOLEAN
			-- Is testing activated?

	can_enable_testing: BOOLEAN is
			-- Are we able to activate cdd testing?
		require
			testing_not_enabled: not is_testing_enabled
		local
			l_cdd_dir, l_project_dir: DIRECTORY
		do
			create l_cdd_dir.make (cdd_path)
			create l_project_dir.make (eiffel_project.project_directory.path)
			if (l_cdd_dir.exists and l_cdd_dir.is_writable) or l_project_dir.is_writable then
				if not eiffel_universe.target.system.date_has_changed then
					Result := True
				end
			end
		end

	has_changed: BOOLEAN
		-- has the test suite changed since last compilation?

	test_cases: DS_LIST [CDD_TEST_CASE]
			-- Available test cases
			-- Do not modify directly!

feature -- Status change

	enable_testing is
			-- modify project so tests can be generated and executed
		require
			can_enable_testing: can_enable_testing
		local
			l_dir: DIRECTORY
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
				manager.add_cluster (cluster_name, Void, cdd_path)
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
		end

	disable_testing is
			--
		require
			testing_enabled: not is_testing_enabled
		do
			on_disable_testing.do_all (agent notify_test_suite_status)
		end


feature -- Element change

	add_test_case (a_tc: CDD_TEST_CASE) is
			--
		require
			not_added_yet: not test_cases.has (a_tc)
		local
			done: BOOLEAN
		do
			from
				done := False
				test_cases.start
			until
				test_cases.after or done
			loop
				if test_cases.item_for_iteration < a_tc or test_cases.is_last then
					test_cases.put_right (a_tc)
					done := True
				end
				test_cases.forth
			end
			on_add_test_case.do_all (agent notify_test_case_change (a_tc, ?))
		end

	remove_test_case (a_tc: CDD_TEST_CASE) is
			--
		require
			True
		do
			on_remove_test_case.do_all (agent notify_test_case_change (a_tc, ?))
		end



feature {EB_CLUSTERS} -- Project Events

	on_project_loaded is
			--
		local
			l_system: CONF_SYSTEM
			l_cursor: CURSOR
		do
			create cdd_path.make_from_string (eiffel_project.project_directory.path)
			cdd_path.extend (cluster_name)

			 -- check if testing was enabled before
--			l_system := eiffel_universe.conf_system
--			if eiffel_universe.cluster_of_name (cluster_name) /= Void and can_enable_testing then
--				enable_testing
--				test_case_factory.parse_test_cases (Current)
--			else
--				is_testing_enabled := False
--			end
		end


feature -- Event handling

	on_add_test_case: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]]]

	on_remove_test_case: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]]]

	on_enable_testing: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]

	on_disable_testing: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]


feature {NONE} -- Event Handling

	notify_test_case_change (a_tc: CDD_TEST_CASE; proc: PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]]) is
			--
		do
			proc.call ([a_tc])
		end

	notify_test_suite_status (proc: PROCEDURE [ANY, TUPLE]) is
			--
		do
			proc.call ([])
		end

feature -- Project specific

	target: CONF_TARGET

	cluster: CLUSTER_I

	cdd_path: DIRECTORY_NAME

feature {NONE} -- Implementation







end -- class CDD_TEST

