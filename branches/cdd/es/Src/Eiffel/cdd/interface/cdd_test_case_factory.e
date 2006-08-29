indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_CASE_FACTORY

inherit

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EB_CLUSTER_MANAGER_OBSERVER
		export
			{NONE} all
		end

feature -- Access

feature -- Measurement

feature {EB_DEBUGGER_MANAGER} -- Status report

	report_postcondition_violation (an_app_status: APPLICATION_STATUS; a_window: EB_DEVELOPMENT_WINDOW) is
			-- Initialize Current.
		require
			app_status_valid: an_app_status /= Void and an_app_status.is_stopped
			exception_occurred: an_app_status.exception_occurred
			valid_exception: an_app_status.exception_code = 4
		local
			l_test_suite: CDD_TEST_SUITE
			l_tc: CDD_TEST_CASE
		do
			l_test_suite := a_window.context_tool.cdd_test_suite_view.test_suite
			if l_test_suite.is_testing_enabled then
				make_reflection (an_app_status)
				if reflection.reflection_succeded then
					create_test_class (l_test_suite)
					create l_tc.make (an_app_status.dynamic_class.eiffel_class_c.original_class, an_app_status.e_feature.name, test_class)
					l_test_suite.add_test_case (l_tc)
				end
			end
		end

feature {NONE} -- Test case generation

	reflection: CDD_REFLECTED_OBJECT

	test_class: CLASS_I

	make_reflection (an_app_status: APPLICATION_STATUS) is
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

			create reflection.make (l_cse)
		end

	create_test_class (a_test_suite: CDD_TEST_SUITE) is
		require
			valid_reflection: reflection /= Void and reflection.reflection_succeded
		local
			dclass: CLASS_C
			part, new_class_name, path: STRING
			i: INTEGER
			file: PLAIN_TEXT_FILE
			l_class_i: CLASS_I
		do
			dclass := reflection.root_object.dynamic_class
			part := "cdd_test_" + dclass.name.as_lower + "_"
			from
				i := 0
			until
				i > 0 and then not file.exists
			loop
				i := i + 1
				new_class_name := part + i.out
				path := a_test_suite.test_cases_path + "/" + new_class_name + ".e"
				create file.make (path)
			end

			file.open_write

			new_class_name.to_upper
			printer.print_test_case (reflection, new_class_name, file)
			manager.add_class_to_cluster (new_class_name, a_test_suite.cluster, "tests/" + file.name)
			test_class := manager.last_added_class
		end

feature {NONE} -- User interaction



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
