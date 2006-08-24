indexing
	description: "Objects that ..."
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

create
	make

feature {NONE} -- Initialization

	make is
			--
		do
			create observers.make
			test_cases := create {DS_LINKED_LIST [CDD_TEST_CASE]}.make

			manager.add_observer (Current)
		end

	check_testability is
		local
			group: CONF_GROUP
			dir_name: DIRECTORY_NAME
			dir: DIRECTORY
		do
			group := eiffel_universe.group_of_name ("cdd_testing")
			if group /= Void then
				if group.is_cluster then
					cluster ?= group
					enable_testing
				end
			else
				create dir_name.make_from_string (project_location.path)
				dir_name.extend ("cdd_testing")
				create dir.make (dir_name)
				if not dir.exists then
					dir.create_dir
				end
				manager.add_cluster ("cdd_testing", eiffel_system.root_cluster, dir_name)
				cluster := manager.last_added_cluster
				enable_testing
			end
		end

feature -- Access

	is_testing_enabled: BOOLEAN
			-- Is testing activated?

	can_enable_testing: BOOLEAN is
			--
		local
			a_parent: CONF_GROUP

		do
			Result := not eiffel_universe.target.date_has_changed
		end


	cluster: CLUSTER_I
			-- cluster in which all test classes will be stored
			-- is Void if testing is disabled

	test_cases: DS_LIST [CDD_TEST_CASE]
			-- Available test cases
			-- Do not modify directly!

	classes: DS_LIST [EIFFEL_CLASS_C] is
			--
		do
		end


feature -- Status change

	enable_testing is
			--
		require
			testing_disabled: not is_testing_enabled
		local
			dir_name: DIRECTORY_NAME
			dir: DIRECTORY
		do
			is_testing_enabled := True
			create dir_name.make_from_string (project_location.path)
			dir_name.extend ("cdd_testing")
			create dir.make (dir_name)
			if not dir.exists then
				dir.create_dir
			end
			manager.add_cluster ("cdd_testing", Void, dir_name)
			cluster := manager.last_added_cluster
			from
				observers.start
			until
				observers.after
			loop
				observers.item_for_iteration.on_enable_testing
				observers.forth
			end
		end

	disable_testing is
			--
		require
			testing_enabled: not is_testing_enabled
		do
			from
				observers.start
			until
				observers.after
			loop
				observers.item_for_iteration.on_enable_testing
				observers.forth
			end
		end



feature {CDD_TEST_CASE_FACTORY} -- Element change

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
			from
				observers.start
			until
				observers.after
			loop
				observers.item_for_iteration.on_add_test_case (a_tc)
				observers.forth
			end
		end


feature {EB_CLUSTERS} -- Project Events

	on_project_loaded is
			--
		local
			group: CONF_GROUP
		do
			group := eiffel_universe.group_of_name ("cdd_testing")
			if group /= Void and group.is_cluster then
				cluster ?= group
				is_testing_enabled := True
			else
				is_testing_enabled := False
			end
		end


feature -- Event handling

	subscribe_observer (an_observer: CDD_TEST_SUITE_OBSERVER) is
			--
		do

		end

	unsubscribe_observer (an_observer: CDD_TEST_SUITE_OBSERVER) is
			--
		do

		end


feature {NONE} -- Event Handling

	observers: DS_LINKED_LIST [CDD_TEST_SUITE_OBSERVER]


feature {NONE} -- Implementation




end -- class CDD_TEST

