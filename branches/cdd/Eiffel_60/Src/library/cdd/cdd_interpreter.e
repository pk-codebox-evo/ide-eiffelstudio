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
			l_cursor: DS_HASH_TABLE_CURSOR [CDD_ABSTRACT_TEST_CASE, STRING]
			l_features: DS_HASH_TABLE [PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]], STRING]
			l_feature_cursor: DS_HASH_TABLE_CURSOR [PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]], STRING]
			l_test_case: CDD_ABSTRACT_TEST_CASE
			i, l_pos: INTEGER
		do
			if command_line.argument_count > 0 then
				from
					i := 1
				until
					i > command_line.argument_count
				loop
					l_class := command_line.argument (i)
					l_pos := l_class.index_of ('.', 0)
					if l_pos > 0 then
						l_feature := l_class.substring (l_pos + 1, l_class.count)
						l_class := l_class.substring (1, l_pos - 1)
					else
						l_feature := Void
					end
					if test_cases.has (l_class) then
						l_test_case := test_cases.item (l_class)
						if test_features.has (l_test_case) then
							if l_feature /= Void then
								l_features := test_features.item (l_test_case)
								if l_features.has (l_feature) then

								end
							else
								create l_feature_cursor.make (test_features.item (l_test_case))
								from
									l_feature_cursor.start
								until
									l_feature_cursor.after
								loop
									execute_test (l_test_case, l_feature_cursor.item)
									l_feature_cursor.forth
								end
							end
						end
					end
					i := i + 1
				end
			else
				create l_cursor.make (test_cases)
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					--execute_test_case (l_cursor.item)
					l_cursor.forth
				end
			end
		end

feature -- Access

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

	test_features: DS_HASH_TABLE [DS_HASH_TABLE [PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]], STRING], CDD_ABSTRACT_TEST_CASE] is
			-- Double hash table with all callable features of all test cases. Keys are
			-- the test case instances and the test feature names in `test_cases',
			-- values are agents invoking a single test feature in the instance and
			-- taking the actual test case as an operand
		deferred
		ensure
			not_void: Result /= Void
			valid_keys: test_cases.for_all (
				agent (a_tc: CDD_MANUAL_TEST_CASE; a_hash_table: like test_features): BOOLEAN
					do
						Result := a_hash_table.has (a_tc)
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
