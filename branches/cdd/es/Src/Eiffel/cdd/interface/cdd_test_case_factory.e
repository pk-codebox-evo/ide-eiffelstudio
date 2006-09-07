indexing
	description: "Singleton for creating and removing test cases"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_CASE_FACTORY

inherit

	CDD_CONSTANTS

	EB_CLUSTER_MANAGER_OBSERVER
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

feature {CDD_TEST_SUITE} -- Project loading

	parse_cluster (a_cluster: CLUSTER_I; a_test_suite: CDD_TEST_SUITE) is
			--

		local
			l_classes: HASH_TABLE [EIFFEL_CLASS_I, STRING]
			l_class: EIFFEL_CLASS_I
		do
			l_classes := a_cluster.classes
			from
				l_classes.start
			until
				l_classes.after
			loop
				l_class := l_classes.item_for_iteration
				if not a_test_suite.test_class_exists (l_class) then
					parse_class (l_class, a_test_suite)
				end
				l_classes.forth
			end
		end

	parse_class (a_class: EIFFEL_CLASS_I; a_test_suite: CDD_TEST_SUITE) is
			--
		local
			l_file: KL_BINARY_INPUT_FILE
			l_ast: CLASS_AS
			l_ilist: INDEXING_CLAUSE_AS
			l_item: INDEX_AS

			l_name, l_icluster, l_iclass, l_ifeature, l_itag, l_iid: STRING
			l_class: EIFFEL_CLASS_I
			l_tc: CDD_TEST_CASE
		do
			create l_file.make (a_class.file_name)
			if l_file.exists then
				if not a_class.is_compiled then
					if l_file.is_readable then
						l_file.open_read
						eiffel_parser.parse (l_file)
						l_file.close
						l_ast := eiffel_parser.root_node
					end
				else
					l_ast := a_class.compiled_class.ast
				end
				if l_ast /= Void then
					l_ilist := l_ast.top_indexes
					from
						l_ilist.start
					until
						l_ilist.after
					loop
						l_item := l_ilist.item
						l_name := l_item.tag
						if l_name.is_equal ("cdd_cluster") then
							l_icluster := parse_indexing_item (l_item)
						elseif l_name.is_equal ("cdd_class") then
							l_iclass := parse_indexing_item (l_item)
						elseif l_name.is_equal ("cdd_feature") then
							l_ifeature := parse_indexing_item (l_item)
						elseif l_name.is_equal ("cdd_tag") then
							l_itag := parse_indexing_item (l_item)
						elseif l_name.is_equal ("cdd_id") then
							l_iid := parse_indexing_item (l_item)
						end
						l_ilist.forth
					end
					if l_icluster /= Void and l_iclass /= Void and l_ifeature /= Void and l_itag /= Void and l_iid /= Void then
						l_class := class_of_group (l_iclass, l_icluster)
						if l_class /= Void then
							create l_tc.make (l_class, l_ifeature, a_class, l_itag, l_iid)
							a_test_suite.add_test_case (l_tc)
						end
					end
				end
			end
		end

	parse_indexing_item (an_item: INDEX_AS): STRING is
			--
		require
			an_item_not_void: an_item /= Void
		local
			l_list: EIFFEL_LIST [ATOMIC_AS]
		do
			l_list := an_item.index_list
			if not l_list.is_empty then
				create Result.make_empty
				from
					l_list.start
				until
					l_list.after
				loop
					Result.append (l_list.item.string_value)
					l_list.forth
				end
				Result.prune_all_leading ('"')
				Result.prune_all_trailing ('"')
			end
		end

	class_of_group (a_class, a_group: STRING): EIFFEL_CLASS_I is
			--
		local
			l_group: CONF_GROUP
		do
			l_group := eiffel_universe.group_of_name (a_group)
			if l_group /= Void then
				Result ?= eiffel_universe.class_named (a_class, l_group)
			end
		end


feature {CDD_TEST_SUITE} -- Removal

	remove_test_case (a_tc: CDD_TEST_CASE) is
			-- Remove test class in 'a_tc' from file system and notify
			-- EB_CLUSTERS and EB_WINDOW_MANAGER.
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make (a_tc.test_class.file_name)
			if l_file.exists and l_file.is_writable then
				l_file.delete
			end
			manager.remove_class (a_tc.test_class)
			window_manager.synchronize_all
		end



feature {EB_DEBUGGER_MANAGER} -- Status report

	report_postcondition_violation (an_app_status: APPLICATION_STATUS; a_window: EV_WINDOW; a_test_suite: CDD_TEST_SUITE) is
			-- Try to create a new test case from 'an_app_status' and add it to 'a_test_suite'.
			-- 'a_window' is the window in which the application was launched.
		require
			app_status_valid: an_app_status /= Void and an_app_status.is_stopped
			exception_occurred: an_app_status.exception_occurred
			valid_exception: an_app_status.exception_code = 4
			a_window_not_void: a_window /= Void
			valid_test_suite: a_test_suite /= Void
			testing_enabled: a_test_suite.is_testing_enabled
		local
			l_ok_flag: BOOLEAN_REF
			l_reflection: CDD_REFLECTED_OBJECT
			l_class_name: STRING
			l_class: CLASS_I
		do
			create l_ok_flag
			confirm_creation (a_window, l_ok_flag)
			if l_ok_flag.item then
				l_reflection := make_reflection (an_app_status)
				if not l_reflection.reflection_succeded then
					notify_bad_object (a_window)
					set_abort (l_ok_flag)
				end
			end

			if l_ok_flag.item then
				l_class_name := new_test_class_name (a_test_suite, l_reflection.root_object.dynamic_type)
				if l_class_name = Void then
					notify_exhausted (a_window)
					l_ok_flag.set_item (False)
				end
			end

			if l_ok_flag.item then
				create_test_class (l_class_name, l_reflection, a_test_suite)
				l_class := class_instance (l_class_name, a_test_suite)
				create_test_case (l_reflection, l_class, a_test_suite)
			end
		end

feature {NONE} -- Test case generation

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


	new_test_class_name (a_test_suite: CDD_TEST_SUITE; a_target_class: CLASS_C): STRING is
			-- Create a new unique tes class name where 'a_target_class' is the class beeing tested.
			-- (returns void if there are too many test cases for 'a_target_class')
		require
			a_test_suite_not_void: a_test_suite /= Void
			a_target_class_not_void: a_target_class /= Void
		local
			l_prefix: STRING
			l_file: PLAIN_TEXT_FILE
			i: INTEGER
		do
			l_prefix := "CDD_TEST_" + a_target_class.name_in_upper + "_"
			from
				i := 1
			until
				i > 99 or Result /= Void
			loop
				create Result.make_from_string (l_prefix)
				if i < 10 then
					Result.append_character ('0')
				end
				Result.append (i.out)
				create l_file.make (a_test_suite.tests_cluster.location.build_path ("", Result.as_lower + ".e"))
				if l_file.exists then
					Result := Void
				end
				i := i + 1
			end
		end


	create_test_class (a_name: STRING; a_reflection: CDD_REFLECTED_OBJECT; a_test_suite: CDD_TEST_SUITE) is
			-- Create new test class in 'a_test_suite' with name 'a_name', which uses
			-- 'a_reflection' to restore the the state of the object
		require
			valid_name: a_name /= Void and then not a_name.is_empty
			valid_reflection: a_reflection /= Void and a_reflection.reflection_succeded
			a_test_suite_not_void: a_test_suite /= Void
		local
			l_path: STRING
			l_file: PLAIN_TEXT_FILE
		do
			l_path := a_test_suite.tests_cluster.location.build_path ("", a_name.as_lower + ".e")
			create l_file.make_open_write (l_path)

			printer.print_test_case (a_reflection, a_name, l_file)

			if l_file.is_closed  then
				l_file.close
			end
		end

	class_instance (class_name: STRING; a_test_suite: CDD_TEST_SUITE): CLASS_I is
			-- CLASS_I object for class named 'class_name'. Add to universe in case
			-- not class is not found.
		require
			class_name_not_empty: class_name /= Void and then not class_name.is_empty
			a_test_suite_not_void: a_test_suite /= Void
		do
			Result := eiffel_universe.class_named (class_name, a_test_suite.tests_cluster)
			if Result = Void then
				manager.add_class_to_cluster (class_name.as_lower + ".e", a_test_suite.tests_cluster, "")
				Result := manager.last_added_class
			end
		ensure
			not_void: Result /= Void
		end

	create_test_case (a_reflection: CDD_REFLECTED_OBJECT; a_test_class: CLASS_I; a_test_suite: CDD_TEST_SUITE) is
			-- Creates a new test case for object reflected in 'a_reflection' with test
			-- class 'a_test_class' and adds it to a_test_suite.
		local
			l_class: EIFFEL_CLASS_I
			l_tc: CDD_TEST_CASE
		do
			l_class := a_reflection.root_object.dynamic_type.original_class
			create l_tc.make (l_class, a_reflection.called_feature.name, a_test_class, a_reflection.exception_tag, a_reflection.id)
			a_test_suite.add_test_case (l_tc)
		end

feature {NONE} -- User interaction

	confirm_creation (a_window: EV_WINDOW; a_flag: BOOLEAN_REF) is
			--
		local
			l_conf: EV_CONFIRMATION_DIALOG
		do
			create l_conf.make_with_text_and_actions ("Would you like to create a test case?",
				<< agent set_continue (a_flag), agent set_abort (a_flag) >>)
			l_conf.show_modal_to_window (a_window)
		end

	notify_bad_object (a_window: EV_WINDOW) is
			--
		local
			l_warn: EV_WARNING_DIALOG
		do
			create l_warn.make_with_text ("not able to reflect current state of the application")
			l_warn.show_modal_to_window (a_window)
		end

	notify_exhausted (a_window: EV_WINDOW) is
			--
		local
			l_warn: EV_WARNING_DIALOG
		do
			create l_warn.make_with_text ("there are too many test cases for the actual class")
			l_warn.show_modal_to_window (a_window)
		end


	set_continue (a_flag: BOOLEAN_REF) is
			--
		do
			a_flag.set_item (True)
		end

	set_abort (a_flag: BOOLEAN_REF) is
			--
		do
			a_flag.set_item (False)
		end


feature {NONE} -- Implementation

	printer: CDD_TEST_CASE_PRINTER is
			--
		once
			create Result
		end

end
