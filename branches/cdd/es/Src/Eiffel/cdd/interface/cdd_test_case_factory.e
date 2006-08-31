indexing
	description: "Objects that ..."
	author: ""
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

feature -- Access

feature -- Measurement

feature {CDD_TEST_SUITE} -- Project loading

	parse_test_cases (a_test_suite: CDD_TEST_SUITE) is
			-- Fill `a_test_suite' with test cases found in universe.
			-- Note: very ugly feature, temporarily solution for parsing existing test cases
		require
			a_test_suite_not_void: a_test_suite /= Void
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
			l_test_class: CLASS_I
			l_feature: STRING
			l_tc: CDD_TEST_CASE
			i,j: INTEGER
		do
			create l_dir.make_open_read (a_test_suite.cluster.path)
			l_files := l_dir.linear_representation
			from
				l_files.start
			until
				l_files.after
			loop
				l_file_name := l_files.item
				if l_file_name.has_substring (".e") then
					create l_file.make (a_test_suite.cluster.location.build_path ("", l_file_name))
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
							if l_conf_group /= Void then
								l_class_i ?= eiffel_universe.class_named (l_class, l_conf_group)
								if l_class_i /= Void then
									l_file_name.prune_all_trailing ('e')
									l_file_name.prune_all_trailing ('.')
									l_test_class := class_instance (l_file_name.as_upper, a_test_suite)
									create l_tc.make (l_class_i, l_feature, l_test_class)
									a_test_suite.add_test_case (l_tc)
								end
							end
						end
						l_file.close
					end
				end
				l_files.forth
			end
		end




feature {EB_DEBUGGER_MANAGER} -- Status report

	report_postcondition_violation (an_app_status: APPLICATION_STATUS; a_window: EV_WINDOW; a_test_suite: CDD_TEST_SUITE) is
			-- Try to create a new test case.
		require
			app_status_valid: an_app_status /= Void and an_app_status.is_stopped
			exception_occurred: an_app_status.exception_occurred
			valid_exception: an_app_status.exception_code = 4
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
				l_class_name := new_test_class_name (a_test_suite, l_reflection.root_object.dynamic_class)
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
			-- try to reflect current object in call stack
			-- return Void if external objects where found
		require
			is_eiffel_class: an_app_status.dynamic_class.is_eiffel_class_c
		local
			l_cse: EIFFEL_CALL_STACK_ELEMENT
		do
			l_cse ?= an_app_status.current_call_stack_element

			-- should be fine since dynamic_class is eiffel class
			check l_cse /= Void end

			create Result.make (l_cse)
		end


	new_test_class_name (a_test_suite: CDD_TEST_SUITE; a_target_class: CLASS_C): STRING is
			-- creates a new class unique test class name
			-- returns void if there are already 99 test cases for a class
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
				Result := l_prefix
				if i < 10 then
					Result.append_character ('0')
				end
				Result.append (i.out)
				create l_file.make (a_test_suite.cluster.location.build_path ("", Result.as_lower + ".e"))
				if l_file.exists then
					Result := Void
				end
				i := i + 1
			end
		end


	create_test_class (a_name: STRING; a_reflection: CDD_REFLECTED_OBJECT; a_test_suite: CDD_TEST_SUITE) is
		require
			valid_name: a_name /= Void and then not a_name.is_empty
			valid_reflection: a_reflection /= Void and a_reflection.reflection_succeded
		local
			l_path: STRING
			l_file: PLAIN_TEXT_FILE
		do
			l_path := a_test_suite.cluster.location.build_path ("", a_name.as_lower + ".e")
			create l_file.make_open_write (l_path)

			printer.print_test_case (a_reflection, a_name, l_file)

			if l_file.is_closed  then
				l_file.close
			end
		end

	class_instance (class_name: STRING; a_test_suite: CDD_TEST_SUITE): CLASS_I is
			-- returns the CLASS_I object for class_name
			-- if not in universe yet, create new
		do
			Result := eiffel_universe.class_named (class_name, a_test_suite.cluster)
			if Result = Void then
				manager.add_class_to_cluster (class_name.as_lower + ".e", a_test_suite.cluster, "")
				Result := manager.last_added_class
			end
		end

	create_test_case (a_reflection: CDD_REFLECTED_OBJECT; test_class: CLASS_I; a_test_suite: CDD_TEST_SUITE) is
			--
		local
			l_class: EIFFEL_CLASS_I
			l_tc: CDD_TEST_CASE
		do
			l_class := a_reflection.root_object.dynamic_class.eiffel_class_c.original_class
			create l_tc.make (l_class, a_reflection.called_routine.name, test_class)
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


		do
			confirm_dialog.show (window)
			if confirm_dialog.should_create_test_case then
			else
			end
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





feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	printer: CDD_TEST_CASE_PRINTER is
			--
		once
			create Result
		end

invariant
	invariant_clause: True -- Your invariant here

end
