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
			create l_dir.make (cdd_path)
			if not l_dir.exists then
				l_dir.create_dir
			end
			create l_dir.make (test_cases_path)
			if not l_dir.exists then
				l_dir.create_dir
			end

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
		do
			create cdd_path.make_from_string (eiffel_project.project_directory.path)
			cdd_path.extend (cluster_name)
			create test_cases_path.make_from_string (cdd_path)
			test_cases_path.extend ("tests")

			 -- check if testing was enabled before
			l_system := eiffel_universe.conf_system
			if eiffel_universe.cluster_of_name (cluster_name) /= Void and can_enable_testing then
				-- enable_testing
				-- parse_test_cases
			else
				is_testing_enabled := False
			end
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

	test_cases_path: DIRECTORY_NAME

feature {NONE} -- Implementation

	parse_test_cases is
			--
		local
			l_dir: DIRECTORY
			l_files: ARRAYED_LIST [STRING]
			l_file_name: STRING
			l_file: PLAIN_TEXT_FILE
			l_line: STRING
			l_cluster: STRING
			l_conf_group: CONF_GROUP
			l_class: STRING
			l_class_i: EIFFEL_CLASS_I
			l_feature: STRING
			l_tc: CDD_TEST_CASE
			i,j: INTEGER
		do
			create l_dir.make_open_read (test_cases_path)
			l_files := l_dir.linear_representation
			from
				l_files.start
			until
				l_files.after
			loop
				l_file_name := l_files.item
				if l_file_name.has_substring (".e") then
					create l_file.make (test_cases_path + "/" + l_file_name)
					if l_file.is_readable then
						from
							l_file.open_read
						until
							(l_cluster /= Void and
							l_class /= Void and
							l_feature /= Void) or
							l_file.end_of_file
						loop
							l_file.read_line
							l_line := l_file.last_string
							if l_line.has_substring ("cluster: ") then
								i := l_line.index_of ('"', 1)
								j := l_line.index_of ('"', i + 1)
								l_cluster := l_line.substring (i+1, j-1)
							elseif l_line.has_substring ("class: ") then
								i := l_line.index_of ('"', 1)
								j := l_line.index_of ('"', i + 1)
								l_class := l_line.substring (i+1, j-1)
							elseif l_line.has_substring ("feature: ") then
								i := l_line.index_of ('"', 1)
								j := l_line.index_of ('"', i + 1)
								l_feature := l_line.substring (i+1, j-1)
							end
						end
						if (l_cluster /= Void and
							l_class /= Void and
							l_feature /= Void) then
							l_conf_group := eiffel_universe.group_of_name (l_cluster)
							l_class_i ?= eiffel_universe.class_named (l_class, l_conf_group)
							l_file_name.prune_all_trailing ('e')
							l_file_name.prune_all_trailing ('.')
							create l_tc.make (l_class_i, l_feature, eiffel_universe.class_named (l_file_name.as_upper, cluster))
							add_test_case (l_tc)
						end
						l_file.close
					end
				end
				l_files.forth
			end
		end



end -- class CDD_TEST

