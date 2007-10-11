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

	CDD_REQUEST_PARSER
		redefine
			is_valid_type_name,
			parse_type_name
		end

	EXCEPTIONS
		export
			{NONE} all
		end

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

feature {NONE} -- Execution

	execute is
			-- If command line arguments are provided, only execute
			-- test cases matching these arguments. Otherwise
			-- execute all test cases in `test_cases'.
		do
			make
			main_loop
		end

	main_loop is
			-- Wait for requests on standard input. If request
			-- is received, parse it.
		local
			l_input: STRING
		do
			from
			until
				should_quit or io.input.end_of_file
			loop
				io.input.read_line
				l_input := io.input.last_string
				if l_input = Void then
					print_and_flush ("error: empty input%N")
				else
					set_input (l_input)
					parse
				end
			end
		end


feature -- Access

	test_setting: DS_HASH_TABLE [TUPLE [instance: CDD_ABSTRACT_TEST_CASE; test_features: DS_HASH_TABLE [PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]], STRING]], STRING] is
			-- Main data structure containing an instance of all
			-- types representing a test case. Each instance comes
			-- with a number of procedures pointing to actual test
			-- features within the type. The operand of the
			-- procedure is the instance of the test type
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

	test_type_names: DS_BILINEAR [STRING] is
			-- Names of all test types
		do
			Result := test_setting.keys
		ensure
			not_void: Result /= Void
		end

	test_feature_names (a_type_name: STRING): DS_BILINEAR [STRING] is
			-- Feature names of all test features in type `a_type_name'
		require
			a_type_name_valid: a_type_name /= Void and then has_test_type (a_type_name)
		do
			Result := test_setting.item (a_type_name).test_features.keys
		ensure
			not_void: Result /= Void
		end

	has_test_type (a_type_name: STRING): BOOLEAN is
			-- Does `test_setting' contain a test type named `a_type_name'?
		require
			a_type_name_not_void: a_type_name /= Void
		do
			Result := test_setting.has (a_type_name)
		ensure
			correct_result: Result = test_setting.has (a_type_name)
		end

	has_test_feature (a_type_name, a_feature_name: STRING): BOOLEAN is
			-- Does `test_setting' contain a test feature named
			-- `a_feature_name' in type `a_type_name'?
		require
			a_type_name_valid: a_type_name /= Void and then has_test_type (a_type_name)
			a_feature_name_not_void: a_feature_name /= Void
		do
			Result := test_setting.item (a_type_name).test_features.has (a_feature_name)
		ensure
			correct_result: Result = test_setting.item (a_type_name).test_features.has (a_feature_name)
		end

	test_case (a_type_name: STRING): CDD_ABSTRACT_TEST_CASE is
			-- Instance of `a_type_name'
		require
			a_type_name_valid: a_type_name /= Void and then has_test_type (a_type_name)
		do
			Result := test_setting.item (a_type_name).instance
		ensure
			valid_result: Result /= Void and then Result = test_setting.item (a_type_name)
		end

	test_feature (a_type_name, a_feature_name: STRING): PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]] is
			-- Procedure calling `a_feature_name' in type `a_type_name'
		require
			a_type_name_valid: a_type_name /= Void and then has_test_type (a_type_name)
			a_feature_name_valid: a_feature_name /= Void and then has_test_feature (a_type_name, a_feature_name)
		do
			Result := test_setting.item (a_type_name).test_features.item (a_feature_name)
		ensure
			valid_result: Result /= Void and then
				Result = test_setting.item (a_type_name).test_features.item (a_feature_name)
		end

feature {NONE} -- Parsing

	parse_type_name is
			-- Parse type name (e.g: "LINKED_LIST [STRING]") and
			-- make resulting type name available via `last_string' or call
			-- any of the `report_and_set_error_*' routines on error.
		do
			Precursor
			if not has_error and then not has_test_type (last_string) then
				report_and_set_error_at_position ("`" + last_string + "' is not a valid type name.", position - last_string.count)
			end
		end

feature {NONE} -- Request handling

	report_quit_request is
			-- Set `should_quit' to True.
		do
			should_quit := True
		end

	report_list_request is
			-- Print a list of all test cases and their test features.
		local
			l_cursor: DS_BILINEAR_CURSOR [STRING]
		do
			test_type_names.do_all (agent report_list_of_type_request)
		end

	report_list_of_type_request (a_type_name: STRING) is
			-- Print a list of all test features in type `a_type_name'.
		do
			print ("Test cases for " + a_type_name + ":%N")
			test_feature_names (a_type_name).do_all (
				agent (a_test_feature_name: STRING)
					do
						print ("%T" + a_test_feature_name + "%N")
					end)
		end

	report_type_request (a_type_name: STRING) is
			-- Execute all tests found in type `a_type_name'.
		do
			test_feature_names (a_type_name).do_all (agent execute_test (a_type_name, ?))
		end

	report_type_and_feature_request (a_type_name, a_feature_name: STRING) is
			-- Execute test feature `a_feature_name' in type `a_type_name'.
			-- If `a_type_name' does not contain such a feature, print error message.
		do
			if has_test_feature (a_type_name, a_feature_name) then
				execute_test (a_type_name, a_feature_name)
			else
				report_error (a_type_name + " does not contain a test feature `" + a_feature_name + "'")
			end
		end

feature {NONE} -- Error handling

	report_error (a_reason: STRING) is
			-- Report error `a_reason'.
		do
			print_and_flush ("error: " + a_reason + "%N")
		end

feature {NONE} -- Control

	should_quit: BOOLEAN
			-- Should main loop quit?

feature {NONE} -- Output

	print_and_flush (a_text: STRING) is
			-- Print `a_text' and flush output stream.
		require
			a_text_not_void: a_text /= Void
		do
			print (a_text)
			io.output.flush
		end

feature -- Lexical validity

	is_valid_type_name (a_type_name: STRING): BOOLEAN is
			-- Is `a_type_name' a valid name for a type and
			-- do we have a test case for `a_type_name'?
		do
			Result := Precursor (a_type_name) and has_test_type (a_type_name)
		end

feature {NONE} -- Implementation

	execute_test (a_tc_name, a_feature_name: STRING) is
			-- Set up `a_tc' and call `a_feature' with `a_tc' as operand.
			-- Print results on standard out refering to `a_tc_name' and
			-- `a_feature_name'.
		require
			a_tc_name_valid: a_tc_name /= Void and then has_test_type (a_tc_name)
			a_feature_name_valid: a_feature_name /= Void and then has_test_feature (a_tc_name, a_feature_name)
		local
			l_invalid: BOOLEAN
			l_tc: CDD_ABSTRACT_TEST_CASE
		do
			l_tc := test_case (a_tc_name)
			safe_set_up_test (l_tc)
			if not has_failed then
				safe_execute_test (l_tc, test_feature (a_tc_name, a_feature_name))
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
