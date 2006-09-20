indexing
	description: "Objects that handle operations on a test suite"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE_MANAGER

inherit

	EB_CLUSTER_MANAGER_OBSERVER
		rename
			manager as eb_cluster_manager
		export
			{NONE} all
		redefine
			on_project_loaded,
			on_class_removed,
			refresh
		end

	SHARED_EIFFEL_PROJECT

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	CDD_SHARED_FACTORY
		export
			{NONE} all
		end

	CDD_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Add `Current' to cluster observer list.
		do
			create refresh_actions
			create add_test_case_actions
			create remove_test_case_actions
			eb_cluster_manager.add_observer (Current)
		end

feature -- Access

	is_testing_enabled: BOOLEAN is
			-- Is testing currently enabled?
		do
			Result := (test_suite /= Void)
		end

	test_suite: CDD_TEST_SUITE
			-- Test suite which is managed by 'Current'

	can_enable_testing: BOOLEAN is
			-- Can testing mode be enabled?
		require
			not_enabled_yet: not is_testing_enabled
		do
			if eiffel_project.initialized then
				if False then -- can create cdd cluster??
					Result := True
				end
			end
		end

	valid_status (an_app_status: APPLICATION_STATUS): BOOLEAN is
			-- Is 'an_app_status' valid for creating a ccd test case?
		require
			an_app_status /= Void
		do
			Result := an_app_status.is_stopped and
				an_app_status.exception_occurred and
				(an_app_status.exception_code = {EXCEP_CONST}.void_call_target or
				an_app_status.exception_code = {EXCEP_CONST}.postcondition or
				an_app_status.exception_code = {EXCEP_CONST}.class_invariant)
		end

feature -- Status setting

	report_postcondition_violation (an_app_status: APPLICATION_STATUS; a_window: EB_DEVELOPMENT_WINDOW) is
			-- Try to create a new test case from 'an_app_status' and add it to 'a_test_suite'.
			-- 'a_window' is the window in which the application was launched.
		require
			testing_enabled: is_testing_enabled
			app_status_valid: an_app_status /= Void and then valid_status (an_app_status)
			a_window_not_void: a_window /= Void
		local
			l_msg: STRING
			l_cd: EV_CONFIRMATION_DIALOG
		do
			if an_app_status.dynamic_class.is_eiffel_class_c then
				l_msg := "EiffelStudio has detected a bug in one of your classes. Would you like to %
						%create a test case with the current state of the application for further testing?"
				create l_cd.make_with_text_and_actions (l_msg, << agent generate_test_case (an_app_status, a_window) >>)
				l_cd.show_modal_to_window (a_window.window)
			end
		end

	enable_testing is
			-- Create test suite and notify tools
		require
			not_enabled_yet: not is_testing_enabled
			can_enable: can_enable_testing
		local
			l_cluster: CLUSTER_I
		do
			l_cluster := eiffel_universe.cluster_of_name (tests_cluster_name)
			if l_cluster = Void then
				-- TODO: create cluster
			end
			create test_suite.make_with_cluster (l_cluster)
			refresh
		end

feature -- Test suite manipulation

	remove_test_case (a_tc: CDD_TEST_CASE) is
			-- Remove 'a_tc' from 'test_suite' and delete test class from disc.
		require
			a_tc_not_void: a_tc /= Void
			testing_enabled: is_testing_enabled
			a_tc_valid: test_suite.test_cases.has (a_tc)
		do
			-- Remove 'Current' from cluster manager so we do not get notified of the removed class
			eb_cluster_manager.remove_observer (Current)

			test_suite.remove_test_case (a_tc)
			test_case_factory.remove (a_tc)
			eb_cluster_manager.remove_class (a_tc.test_class)

			window_manager.synchronize_all
			remove_test_case_actions.call ([a_tc])
			eb_cluster_manager.add_observer (Current)
		end

feature {EB_CLUSTERS} -- Project Events

	on_project_loaded is
			--
		do
			eiffel_system.system.force_rebuild
			refresh
		end


	refresh is
			-- Refresh test suite.
		local
			l_tests_cluster: CLUSTER_I
			l_ttarget: CONF_TARGET
			l_tcluster: CONF_CLUSTER
			l_classes: HASH_TABLE [EIFFEL_CLASS_I, STRING]
			l_was_enabled: BOOLEAN
		do
			l_was_enabled := is_testing_enabled
			l_tests_cluster := eiffel_universe.cluster_of_name (tests_cluster_name)
			if l_tests_cluster /= Void then
				create test_suite.make_with_cluster (l_tests_cluster)
				l_classes := test_suite.tests_cluster.classes
				from
					l_classes.start
				until
					l_classes.after
				loop
					if not test_suite.has_test_case_for_class (l_classes.item_for_iteration) then
						test_case_factory.create_from_class (l_classes.item_for_iteration, eiffel_universe)
						if test_case_factory.last_created_test_case /= Void then
							test_suite.add_test_case (test_case_factory.last_created_test_case)
						end
					end
					l_classes.forth
				end
				if eiffel_universe.conf_system.targets.has (tester_target_name) then
					l_ttarget := eiffel_universe.conf_system.targets.item (tester_target_name)
					test_suite.set_tester_target (l_ttarget)
					if l_ttarget.clusters.has (tester_cluster_name) then
						l_tcluster := l_ttarget.clusters.item (tester_cluster_name)
						test_suite.set_tester_cluster (l_tcluster)
					end
				end
			else
				test_suite := Void
			end
			refresh_actions.call ([])
		end


	on_class_removed (a_class: CLASS_I) is
			-- If class was test class, remove corresponding test case.
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
			l_item: CDD_TEST_CASE
		do
			if test_suite.has_test_case_for_class (a_class) then
				from
					l_cursor := test_suite.test_cases.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					if l_cursor.item.test_class = a_class then
						l_item := l_cursor.item
						test_suite.remove_test_case (l_cursor.item)
						remove_test_case_actions.call ([l_item])
						l_cursor.go_after
					else
						l_cursor.forth
					end
				end
			end
		end

feature -- Actions

	refresh_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions performed after `Current' has refreshed the test suite

	add_test_case_actions: ACTION_SEQUENCE [TUPLE [CDD_TEST_CASE]]
			-- Actions performed when a test case is added to the test suite

	remove_test_case_actions: ACTION_SEQUENCE [TUPLE [CDD_TEST_CASE]]
			-- ACtions performed when a test case is removed from the test suite

feature {NONE} -- Implementation

	generate_test_case (an_app_status: APPLICATION_STATUS; a_window: EB_DEVELOPMENT_WINDOW) is
			-- Create test case from 'an_app_status' and notify user with in case of failure in 'a_window'.
		require
			an_app_status_not_void: an_app_status /= Void
			a_window_not_void: a_window /= Void
		local
			l_reflection: CDD_REFLECTED_OBJECT
			l_warn: EV_WARNING_DIALOG
			l_tc: CDD_TEST_CASE
		do
			if valid_status (an_app_status) then
				l_reflection := make_reflection (an_app_status)
				if not l_reflection.reflection_succeded then
					create l_warn.make_with_text ("Was not able to reflect current state of the application.")
					l_warn.show_modal_to_window (a_window.window)
				elseif False then
					-- TODO: Check if test case for same application state already exists...
				else
					test_case_factory.create_with_reflection (l_reflection, test_suite.tests_cluster)
					l_tc := test_case_factory.last_created_test_case
					test_suite.add_test_case (l_tc)
					add_test_case_actions.call ([l_tc])
				end
			end
		end

	make_reflection (an_app_status: APPLICATION_STATUS): CDD_REFLECTED_OBJECT is
			-- Try to reflect current object in call stack.
		require
			an_app_status_not_void: an_app_status /= Void
			exception_occured: an_app_status.exception_occurred
			is_eiffel_class: an_app_status.dynamic_class.is_eiffel_class_c
		local
			l_cse: EIFFEL_CALL_STACK_ELEMENT
			l_tag: STRING
		do
			l_cse ?= an_app_status.current_call_stack_element

			-- should be fine since dynamic_class is eiffel class
			check l_cse /= Void end

			l_tag := an_app_status.exception_tag
			if l_tag = Void or else l_tag.is_empty then
				l_tag := "postcondition violation"
			end
			create Result.make (l_cse, an_app_status.exception_tag)
		ensure
			not_void: Result /= Void
		end

invariant
	correct_testing_status: is_testing_enabled = (test_suite /= Void)
	refresh_actions_not_void: refresh_actions /= Void
	add_test_case_actions_not_void: add_test_case_actions /= Void
	remove_test_case_actions_not_void: remove_test_case_actions /= Void

end
