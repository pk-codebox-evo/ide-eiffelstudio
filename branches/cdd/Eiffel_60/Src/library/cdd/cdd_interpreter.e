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
		do
			l_class := an_argument
			l_pos := l_class.index_of ('.', 0)
			if l_pos > 0 then
				l_feature := l_class.substring (l_pos + 1, l_class.count)
				l_class := l_class.substring (1, l_pos - 1)
			else
				l_feature := Void
			end
			if test_setting.has (l_class) then
				if l_feature /= Void then
					if test_setting.item (l_class).test_features.has (l_feature) then
						execute_test (l_class, l_feature)
					else
						-- No test feature for `l_feature' in `test_features'
					end
				else
					execute_tests_for_class (l_class)
				end
			else
				-- No test case for class `l_class' in `test_settings'
			end
		end

	execute_tests_for_class (a_class_name: STRING) is
			-- Execute all tests found in `test_features' for class `a_class_name'.
		require
			a_class_name_not_void: a_class_name /= Void
			a_class_name_valid: test_setting.has (a_class_name)
		local
			l_cursor: DS_BILINEAR_CURSOR [STRING]
		do
			l_cursor := test_setting.item (a_class_name).test_features.keys.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				execute_test (a_class_name, l_cursor.item)
				l_cursor.forth
			end
		end

	execute_test (a_tc_name, a_feature_name: STRING) is
			-- Set up `a_tc' and call `a_feature' with `a_tc' as operand.
			-- Print results on standard out refering to `a_tc_name' and
			-- `a_feature_name'.
		require
			a_tc_name_valid: a_tc_name /= Void and then test_setting.has (a_tc_name)
			a_feature_name_valid: a_feature_name /= Void and then test_setting.item (a_tc_name).test_features.has (a_feature_name)
		local
			l_invalid: BOOLEAN
			l_tc: CDD_ABSTRACT_TEST_CASE
		do
			l_tc := test_setting.item (a_tc_name).instance
			safe_set_up_test (l_tc)
			if not has_failed then
				safe_execute_test (l_tc, test_setting.item (a_tc_name).test_features.item (a_feature_name))
			else
				l_invalid := True
			end
			io.put_string (cdd_token)
			io.put_string (a_tc_name)
			io.put_character ('.')
			io.put_string (a_feature_name)
			io.put_character (':')
			if has_failed then
				if l_invalid then
					io.put_string ("INV")
				else
					io.put_string ("FAIL|")
					io.put_string (last_exception.out + "|")
					io.put_string (last_class_name + "|")
					io.put_string (last_recipient_name + "|")
					io.put_string (last_tag_name + "|")
				end
				has_failed := False
			else
				io.put_string ("PASS")
			end
			io.put_string (cdd_token)
			io.put_new_line
		end

	has_failed: BOOLEAN
			-- Has last call of `safe_execute_test_case' caused a violation?

	last_exception: like exception
			-- Code of last exception

	last_tag_name: like tag_name
			-- Tag of last exception

	last_recipient_name: like recipient_name
			-- Recipient name of last exception

	last_class_name: like class_name
			-- Name of class including recipient of last exception

	safe_set_up_test (a_tc: CDD_ABSTRACT_TEST_CASE) is
			-- Set up `a_tc'. If any violation occurs set
			-- `has_failed' to False.
		require
			a_tc_not_void: a_tc /= Void
		do
			if not has_failed then
				a_tc.set_up
			end
		ensure
			not_failed_implies_set_up: not has_failed implies a_tc.is_set_up
		rescue
			retrieve_exception_details
			retry
		end

	safe_execute_test (a_tc: CDD_ABSTRACT_TEST_CASE; a_feature: PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]]) is
			-- Call `a_feature' with `a_tc' as operand. If any
			-- violation exception occurs set `has_failed' to False.
		require
			a_tc_not_void: a_tc /= Void
			a_feature_not_void: a_feature /= Void
		do
			if not has_failed then
				a_feature.call ([a_tc])
			end
		rescue
			retrieve_exception_details
			retry
		end

	retrieve_exception_details is
			-- Set `has_failed' to True and retrieve informations for
			-- `last_class_name', `last_recipient_name', `last_tag_name'
			-- and `last_exception_name'.
		require
			exception_occured: valid_code (original_exception)
		do
			has_failed := True
			last_exception := original_exception
			last_class_name := original_class_name
			last_recipient_name := original_recipient_name
			last_tag_name := original_tag_name
			if last_class_name = Void then
				create last_class_name.make_empty
			end
			if last_recipient_name = Void then
				create last_class_name.make_empty
			end
			if last_tag_name = Void then
				create last_tag_name.make_empty
			end
		ensure
			failed: has_failed
		end


	cdd_token: STRING is "###CDD###"
			-- Token which will surround cdd related messages
			-- on standard output

invariant

	has_failed_implies_last_class_name_not_void: has_failed implies last_class_name /= Void
	has_failed_implies_last_recipient_name_not_void: has_failed implies last_recipient_name /= Void
	has_failed_implies_last_tag_name_not_void: has_failed implies last_tag_name /= Void

end
