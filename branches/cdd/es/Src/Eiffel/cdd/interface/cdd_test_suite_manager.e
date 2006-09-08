indexing
	description: "Objects that handle operations on a test suite"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE_MANAGER

inherit

	EB_CLUSTER_MANAGER_OBSERVER
		export
			{NONE} all
		redefine
			on_project_loaded,
			on_class_removed,
			refresh
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

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
			-- Create list for tools and subscribe as observer for project changes
		do
			create test_suite_tools.make
			manager.add_observer (Current)
		end


feature -- Access

	test_suite: CDD_TEST_SUITE is
			--
		do
			Result := test_suite_singleton
		end

	can_enable_testing: BOOLEAN is
			--
		require
			not_enabled_yet: not test_suite.is_initialized
		do
			if eiffel_project.initialized then
				if False then -- can create cdd cluster??
					Result := True
				end
			end
		end


feature -- Measurement

feature -- Status report

feature -- Status setting

	report_postcondition_violation (an_app_status: APPLICATION_STATUS; a_window: EB_DEVELOPMENT_WINDOW) is
			-- Try to create a new test case from 'an_app_status' and add it to 'a_test_suite'.
			-- 'a_window' is the window in which the application was launched.
		require
			app_status_valid: an_app_status /= Void and an_app_status.is_stopped
			exception_occurred: an_app_status.exception_occurred
			valid_exception: an_app_status.exception_code = 4
			a_window_not_void: a_window /= Void
		local
			l_cd: EV_CONFIRMATION_DIALOG
		do
			if an_app_status.dynamic_class.is_eiffel_class_c then
				create l_cd.make_with_text_and_actions ("Would you like to create a test case?",
					<< agent generate_test_case (an_app_status, a_window) >>)
				l_cd.show_modal_to_window (a_window.window)
			end
		end

	enable_testing is
			--
		require
			not_enabled_yet: not test_suite.is_initialized
			can_enable: can_enable_testing
		local
			l_cluster: CLUSTER_I
		do
			l_cluster := eiffel_universe.cluster_of_name (tests_cluster_name)
			if l_cluster = Void then
				-- TODO: create cluster
			end
			test_suite.set_tests_cluster (l_cluster)
			notify_tools (agent notify_enable_testing)
			refresh
		end

	run_tests is
			--
		require
			can_run_tests: test_suite.can_be_tested
		local
			l_tester: CDD_TEST_SUITE_TESTER
		do
			create l_tester
			l_tester.set_test_suite (test_suite)
			l_tester.execute
		end



feature -- Cursor movement

feature -- Element change

	extend (a_tool: CDD_TEST_SUITE_TOOL) is
			--
		require
			a_tool_not_void: a_tool /= Void
		do
			test_suite_tools.put_last (a_tool)
		ensure
			inserted: test_suite_tools.has (a_tool)
		end

	prune (a_tool: CDD_TEST_SUITE_TOOL) is
			--
		require
			a_tool_not_void: a_tool /= Void
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_SUITE_TOOL]
		do
			l_cursor := test_suite_tools.new_cursor
			l_cursor.start
			l_cursor.search_forth (a_tool)
			l_cursor.remove
		ensure
			removed: not test_suite_tools.has (a_tool)
		end


feature -- Test suite manipulation

	remove_test_case (a_tc: CDD_TEST_CASE) is
			--
		require
			a_tc_not_void: a_tc /= Void
			test_suite_initialized: test_suite.is_initialized
			a_tc_valid: test_suite.test_cases.has (a_tc)
		do
			manager.remove_observer (Current)
			test_case_factory.remove (a_tc)
			manager.remove_class (a_tc.test_class)
			window_manager.synchronize_all
			notify_tools (agent notify_remove_test_case (?, a_tc))
			manager.add_observer (Current)
		end


feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature {EB_CLUSTERS} -- Project Events

	on_project_loaded is
			-- Initialize all project specific attributes and
			-- fill 'Current' with existing test cases
		local
			l_cluster: CLUSTER_I
		do
			l_cluster := eiffel_universe.cluster_of_name (tests_cluster_name)
			if l_cluster /= Void then
				test_suite.set_tests_cluster (l_cluster)
				notify_tools (agent notify_enable_testing)
				refresh
			end
		end

	refresh is
			-- Refresh test suite.
		local
			l_classes: HASH_TABLE [EIFFEL_CLASS_I, STRING]
		do
			if test_suite.is_initialized then
				l_classes := test_suite.tests_cluster.classes
				from
					l_classes.start
				until
					l_classes.after
				loop
					if not test_suite.has_test_case_for_class (l_classes.item_for_iteration) then
						test_case_factory.create_from_class (l_classes.item_for_iteration, eiffel_universe)
						test_suite.add_test_case (test_case_factory.last_created_test_case)
						notify_tools (agent notify_add_test_case (?, test_case_factory.last_created_test_case))
					end
					l_classes.forth
				end
			end
		end


	on_class_removed (a_class: CLASS_I) is
			-- If class was test class, remove corresponding test case.
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
		do
			if test_suite.has_test_case_for_class (a_class) then
				from
					l_cursor := test_suite.test_cases.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					if l_cursor.item.test_class = a_class then
						notify_tools (agent notify_remove_test_case (?, l_cursor.item))
						test_suite.remove_test_case (l_cursor.item)
						l_cursor.go_after
					else
						l_cursor.forth
					end
				end
			end
		end


feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation tools

	test_suite_tools: DS_LINKED_LIST [CDD_TEST_SUITE_TOOL]

	notify_tools (a_proc: PROCEDURE [ANY, TUPLE [CDD_TEST_SUITE_TOOL]]) is
			--
		local
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_SUITE_TOOL]
		do
			from
				l_cursor := test_suite_tools.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				a_proc.call ([l_cursor.item])
				l_cursor.forth
			end
		end

	notify_refresh (a_tool: CDD_TEST_SUITE_TOOL) is
			--
		do
			a_tool.refresh
		end

	notify_add_test_case (a_tool: CDD_TEST_SUITE_TOOL; a_tc: CDD_TEST_CASE) is
			--
		do
			a_tool.add_test_case (a_tc)
		end

	notify_remove_test_case (a_tool: CDD_TEST_SUITE_TOOL; a_tc: CDD_TEST_CASE) is
			--
		do
			a_tool.remove_test_case (a_tc)
		end

	notify_enable_testing (a_tool: CDD_TEST_SUITE_TOOL) is
			--
		do
			a_tool.enable_testing
		end

	test_suite_singleton: CDD_TEST_SUITE is
			-- NOTE: Temporary solution for creating a shared test suite.
			-- In future test suites will be project-related.
		once
			create Result.make
		end

feature {NONE} -- Implementation

	generate_test_case (an_app_status: APPLICATION_STATUS; a_window: EB_DEVELOPMENT_WINDOW) is
			-- Create a new test case from 'an_app_status'. If error occurs, notify user through 'a_window'
		require
			app_status_valid: an_app_status /= Void
			a_window_not_void: a_window /= Void
		local
			l_reflection: CDD_REFLECTED_OBJECT
			l_warn: EV_WARNING_DIALOG
		do
			if an_app_status.is_stopped and
				an_app_status.exception_occurred and
				an_app_status.exception_code = 4 and
				an_app_status.dynamic_class.is_eiffel_class_c then

				l_reflection := make_reflection (an_app_status)
				if not l_reflection.reflection_succeded then
					create l_warn.make_with_text ("Was not able to reflect current state of the application.")
					l_warn.show_modal_to_window (a_window.window)
				elseif False then
					-- TODO: Check with md5 hash if test case already exists...
				else
					test_case_factory.create_with_reflection (l_reflection, test_suite.tests_cluster)
					test_suite.add_test_case (test_case_factory.last_created_test_case)
					notify_tools (agent notify_add_test_case (?, test_case_factory.last_created_test_case))
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
	test_suite_not_void: test_suite /= Void

end
