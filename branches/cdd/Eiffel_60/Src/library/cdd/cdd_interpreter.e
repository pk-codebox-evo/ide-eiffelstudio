indexing
	description: "[
			Objects that run test cases and print testing result
			to console. Descendants of this class should be used
			as the root class of some target.
		]"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_INTERPRETER

inherit

	EXCEPTIONS
		export
			{NONE} all
		end

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

feature -- Execution

	execute is
			-- If command line arguments are provided, only execute
			-- test cases matching these arguments. Otherwise
			-- execute all test cases in `test_cases'.
		local
			l_class, l_feature: STRING
			l_cursor: DS_BILINEAR_CURSOR [STRING]
			i: INTEGER
		do
			if command_line.argument_count > 0 then
				from
					i := 1
				until
					i > command_line.argument_count
				loop
					evaluate_argument (command_line.argument (i))
					i := i + 1
				end
			else
				l_cursor := test_setting.keys.new_cursor
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					execute_tests_for_class (l_cursor.item)
					l_cursor.forth
				end
			end
		end

feature -- Access

	test_setting: DS_HASH_TABLE [TUPLE [instance: CDD_ABSTRACT_TEST_CASE; test_features: DS_HASH_TABLE [PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]], STRING]], STRING] is
			-- Main data structure containing an instance of all
			-- classes representing a test case. Each instance comes
			-- with a number of procedures pointing to actual test
			-- features within the class. The operand of the
			-- procedure is the instance of the test class
			-- containing the test feature.
		deferred
		ensure
			not_void: Result /= Void
			valid_items: not Result.has (Void) and then
				Result.for_all (agent (a_tuple: TUPLE [test_case: CDD_ABSTRACT_TEST_CASE; hash_table: DS_HASH_TABLE [PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]], STRING]]): BOOLEAN
					do
						Result := a_tuple.test_case /= Void and a_tuple.hash_table /= Void and then not a_tuple.hash_table.has (Void)
					end)
		end


	test_cases: DS_HASH_TABLE [CDD_ABSTRACT_TEST_CASE, STRING] is
			-- Hash table of all test cases where keys are the names
			-- of each test class and the corresponding value is an
			-- instance of that class.
			-- Note: so far this list must be provided
			-- by a descendant of this class
		deferred
		ensure
			not_void: Result /= Void
		end

	test_features: DS_HASH_TABLE [DS_HASH_TABLE [PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]], STRING], STRING] is
			-- Double hash table with all callable features of all test cases. Keys are
			-- the test case instances and the test feature names in `test_cases',
			-- values are agents invoking a single test feature in the instance and
			-- taking the actual test case as an operand
		deferred
		ensure
			not_void: Result /= Void
			valid_keys: test_cases.keys.for_all (
				agent (a_key: STRING; a_hash_table: like test_features): BOOLEAN
					do
						Result := a_hash_table.has (a_key)
					end (?, Result))
			valid_items: not Result.has_item (Void)
			valid_items: Result.for_all (
				agent (a_hash_table: DS_HASH_TABLE [PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]], STRING]): BOOLEAN
					do
						Result := not a_hash_table.has (Void)
					end)
		end

feature -- Measurement

feature -- Status report

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

	evaluate_argument (an_argument: STRING) is
			-- If `an_argument' only consists of a class name, execute all tests
			-- found for that class. If `an_argument' also contains a feature name,
			-- only execute the corresponding test.
		require
			an_argument_valid: an_argument /= Void and then not an_argument.is_empty
		local
			l_class, l_feature: STRING
			l_pos: INTEGER
			l_features: DS_HASH_TABLE [PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]], STRING]
			l_test_case: CDD_ABSTRACT_TEST_CASE
		do
			l_class := an_argument
			l_pos := l_class.index_of ('.', 0)
			if l_pos > 0 then
				l_feature := l_class.substring (l_pos + 1, l_class.count)
				l_class := l_class.substring (1, l_pos - 1)
			else
				l_feature := Void
			end
			if test_cases.has (l_class) then
				if l_feature /= Void then
					l_features := test_features.item (l_class)
					if l_features.has (l_feature) then

					end
				else
--					create l_feature_cursor.make (test_features.item (l_test_case))
--					from
--						l_feature_cursor.start
--					until
--						l_feature_cursor.after
--					loop
--						execute_test (l_test_case, l_feature_cursor.item)
--						l_feature_cursor.forth
--					end
				end
			end
		end

	execute_tests_for_class (a_class_name: STRING) is
			-- Execute all tests found in `test_features' for class `a_class_name'.
		require
			a_class_name_not_void: a_class_name /= Void
			a_class_name_valid: test_setting.has (a_class_name)
		local
			l_cursor: DS_HASH_TABLE_CURSOR [PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]], STRING]
		do
			create l_cursor.make (test_setting.item (a_class_name).test_features)
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				--execute_test (a_class_name, l_cursor.item)
				l_cursor.forth
			end
		end

	execute_test (a_tc: CDD_ABSTRACT_TEST_CASE; a_feature: PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]]) is
			-- Set up `a_tc' and call `a_feature' with `a_tc' as operand.
			-- Print results any results on standard out.
		do
			safe_execute_test (a_tc, a_feature)
			if has_failed then
				-- Test case has produced some kind of error...
				has_failed := True
			else
				-- Test case executed without any errors...
			end
		end

	has_failed: BOOLEAN
			-- Has last call of `safe_execute_test_case' caused a violation?

	safe_execute_test (a_tc: CDD_ABSTRACT_TEST_CASE; a_feature: PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]]) is
			-- Set up `a_tc' and call `a_feature' with `a_tc' as operand.
			-- If any violation exception occurs, set `has_failed' to False.
		require
			a_tc_not_void: a_tc /= Void
		do
			if not has_failed then
				a_tc.set_up
			end
		rescue
			has_failed := True
			retry
		end

end
