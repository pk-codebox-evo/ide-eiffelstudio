indexing
	description: "Objects that represent a test class containing test routines"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_CLASS

inherit
	CDD_CONSTANTS
		export
			{NONE} all
		end

	CDD_ROUTINES
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	KL_SHARED_STRING_EQUALITY_TESTER
		export
			{NONE} all
		end

	INTERNAL
		rename
			class_name as int_class_name
		export
			{NONE} all
		end

create
	make_with_class,
	make_manual,
	make_extracted

feature {NONE} -- Initialization

	make_with_class (a_class: like compiled_class) is
			-- Initialize test class given a compiled class.
		require
			a_class_not_void: a_class /= Void
			a_class_valid: is_valid_test_class (a_class)
		do
			test_class_name := a_class.name_in_upper.twin
			set_compiled_class (a_class)
			initialize
		ensure
			compiled_class_set: compiled_class = a_class
		end

	make_manual (an_ast: like parsed_class; a_class_file_name: like class_file_name) is
			-- Initialize `Current' as a test class representing a manual test case.
		require
			an_ast_not_void: an_ast /= Void
			a_class_file_name_valid: a_class_file_name /= Void and then not a_class_file_name.is_empty
		do
			class_file_name := a_class_file_name
			is_manual := True
			initialize_with_ast (an_ast)
		end

	make_extracted (an_ast: like parsed_class; a_class_file_name: like class_file_name; an_original_outcome_list: DS_LIST [CDD_ORIGINAL_OUTCOME]) is
			-- Initialize `Current' with `an_ast' and set for each available test routine an original outcome.
		require
			an_ast_not_void: an_ast /= Void
			an_original_outcome_list_not_void: an_original_outcome_list /= Void
		do
			class_file_name := a_class_file_name
			is_extracted := True
			initialize_with_ast (an_ast)
			check
				number_of_test_routines_equals_number_of_outcomes: test_routines.count = an_original_outcome_list.count
			end

			from
				test_routines.start
				an_original_outcome_list.start
			until
				test_routines.after or else
				an_original_outcome_list.after
			loop
				test_routines.item_for_iteration.set_original_outcome (an_original_outcome_list.item_for_iteration)
				test_routines.forth
				an_original_outcome_list.forth
			end
		end

	initialize_with_ast (an_ast: CLASS_AS) is
			-- Initialize test class given only the class name `a_name' and
			-- a list of routines names `some_rounite_names' which will be
			-- used to initialize `test_routines'.
		require
			an_ast_not_void: an_ast /= Void
		do
			internal_parsed_class := an_ast
			test_class_name := an_ast.class_name.name.as_upper
			initialize
		ensure
			parsed_class_set: parsed_class = an_ast
		end

	initialize is
			-- Initialize `Current'
		do
			create {DS_ARRAYED_LIST [CDD_TEST_ROUTINE_UPDATE]} status_updates.make_default
			update
		end

feature -- Access

	is_valid_test_class (a_class: like compiled_class): BOOLEAN is
			-- Is `a_class' a valid test class?
		require
			a_class_not_void: a_class /= Void
		do
			Result := a_class.has_ast and not a_class.is_deferred and
				is_descendant_of_class (a_class, test_ancestor_class_name)
		ensure
			result_implies_has_ast: Result implies a_class.has_ast
			result_implies_deferred: Result implies a_class.is_deferred
			result_implies_is_descendant: Result implies is_descendant_of_class (a_class, test_ancestor_class_name)
		end

	compiled_class: EIFFEL_CLASS_C
			-- Compiled instance of test class

	parsed_class: CLASS_AS is
			-- Abstract syntax tree of the corresponding eiffel class
		do
			if compiled_class /= Void then
				Result := compiled_class.ast
			else
				Result := internal_parsed_class
			end
		ensure
			not_void: Result /= Void
			valid: (compiled_class /= Void) implies (Result = compiled_class.ast)
			valid: (compiled_class = Void) implies (Result = internal_parsed_class)
		end

	test_class_name: STRING
			-- Name of the `compiled_class'

	class_file_name: STRING_8
			-- File name of file containing associated eiffel class.

	test_routines: DS_ARRAYED_LIST [CDD_TEST_ROUTINE]
			-- Test routines associated with this class;
			-- A test routine is a routine from class `compiled_class'
			-- which has a name starting with `test_routine_prefix'.
			-- This routine is updated whenever `test_routine_table' is.

	cdd_id: UUID
			-- ID of test class (currently used for logging only, in order to be more resilient against renaming)

	check_sum: TUPLE [NATURAL_64]
			-- Checksum of associated class, calculated from covered class, covered feature and context of associated class as written in the class file.

feature -- Element change

	set_compiled_class (a_class: like compiled_class) is
			-- Set `compiled_class' to `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_class_valid: is_valid_test_class (a_class)
		do
			compiled_class := a_class
			internal_parsed_class := Void
			class_file_name := compiled_class.original_class.file_name.string
			is_extracted := is_extracted_test_class (compiled_class)
			is_synthesized := is_synthesized_test_class (compiled_class)
			is_manual := is_manual_test_class (compiled_class)
		ensure
			compiled_class_set: compiled_class = a_class
		end

	ensure_cdd_id is
			-- Ensure that eiffel class associated with `Current' has an indexing clause item named "cdd_id".
		local
			l_ast: CLASS_AS
			l_ilist: INDEXING_CLAUSE_AS
			l_item: INDEX_AS
			l_has_id: BOOLEAN
			l_uuid: UUID
			l_input_file: KL_TEXT_INPUT_FILE
			l_output_file: KL_TEXT_OUTPUT_FILE
			l_file_content: STRING
			l_file_char_count: INTEGER
		do
			l_ast := parsed_class
			l_ilist := l_ast.top_indexes

			create l_uuid.default_create


			if l_ilist /= Void then
				from
					l_ilist.start
				until
					l_ilist.after or else l_has_id
				loop
					l_item := l_ilist.item
					if l_item.tag.name.is_equal ("cdd_id") then
						from
							l_item.index_list.start
						until
							l_item.index_list.after or else l_has_id
						loop
							uuid_regex.match (l_item.index_list.item.string_value)
							if uuid_regex.has_matched then
								create cdd_id.make_from_string (uuid_regex.captured_substring (0))
								l_has_id := True
							else
								l_item.index_list.forth
							end
						end
					end

					l_ilist.forth
				end
			end

			if cdd_id = Void then
						-- If `Current' doesn't have a cdd_id yet, try to add one to the indexing clause of the class
						-- associated with `Current'.

				create l_input_file.make (class_file_name)
				l_file_char_count := -1
				if l_input_file.exists and then l_input_file.is_closed then
					l_file_char_count := l_input_file.count
					l_input_file.open_read
				end
				if l_input_file.is_open_read and then l_file_char_count > -1 then
					l_input_file.read_string (l_file_char_count)
					l_file_content := l_input_file.last_string
					l_input_file.close
				end

				if l_file_content /= Void and then not l_file_content.is_empty then
							-- Double check: it happens that the compilation of the tester target right after compilation of sut
							-- does not recognize the updated file content (so the id is still not in the AST, even thoght it is in the file)
							-- TODO: why does tester target handle testsuite at all? Is this check necessary?
					cdd_id_indexing_available_regex.match (l_file_content)

					if cdd_id_indexing_available_regex.has_matched then
						create cdd_id.make_from_string (cdd_id_indexing_available_regex.captured_substring (1))
					else
								-- Insert "cdd_id" into indexing clause of file
						cdd_id := uuid_generator.generate_uuid
						if l_ilist = Void or else l_ilist.is_empty then
							header_indexing_available_regex.match (l_file_content)
							if header_indexing_available_regex.has_matched then
								l_file_content := header_indexing_available_regex.replace ("\1\%N%Tcdd_id: %"" + cdd_id.out + "%"\2\")
							else
								l_file_content.prepend_string ("indexing%N%Tcdd_id: %"" + cdd_id.out + "%"%N%N")
							end
						else
							cdd_id_indexing_insertion_regex.match (l_file_content)
							l_file_content := cdd_id_indexing_insertion_regex.replace ("\1\%N%Tcdd_id: %"" + cdd_id.out + "%"\2\")
						end

								-- TODO: currently the cdd_id is set even if its not possible to write it to the file again... is that ok?
						create l_output_file.make (class_file_name)
						l_output_file.open_write
						if l_output_file.is_open_write then
							l_output_file.put_string (l_file_content)
							l_output_file.close
						end
					end
				end
			end
		end

	update_check_sum is
			-- Update `check_sum' of associated class (file).
		local
			l_file: KL_TEXT_INPUT_FILE
			l_string: STRING_8
		do
				-- NOTE: If `Current' does not correspond to the usual layout of extracted test cases, no checksum is calculated

				-- Try to get "covers" tag
			if
				test_routines.count = 1 and then
				test_routines.first.tags_with_prefix ("covers.").count = 1
			then
				l_string := test_routines.first.tags_with_prefix ("covers.").first

					-- Try to find "Extracted Data" part of test class file
				create l_file.make (class_file_name)
				l_file.open_read
				if l_file.is_open_read then
						-- Read until "Extracted Data" feature line.
					from
						l_file.read_line
					until
						l_file.end_of_file or else l_file.last_string.is_equal ("feature {NONE} -- Extracted data")
					loop
						l_file.read_line
					end
					if not l_file.end_of_file then
							-- Calculate `check_sum' of test case.
							-- It's the checksum of
							-- <covers.CLASS.feature><context part of test class file>
							-- <context part of test class file> is everything between and not including
							-- the "feature {NONE} -- Extracted data" line and end of file.

						checksum_calculator.reset
						checksum_calculator.add_string (l_string)
						from
							l_file.read_character
						until
							l_file.end_of_file
						loop
							checksum_calculator.add_byte (l_file.last_character.code.to_natural_8)
							l_file.read_character
						end

						checksum_calculator.finalize_calculation

						check_sum := checksum_calculator.hashable_digest
					end
					l_file.close
				end
			end
		end


feature -- Status changes

	status_updates: DS_LIST [CDD_TEST_ROUTINE_UPDATE]
			-- List of changes since creation or last call to `update_test_routines'.

feature {CDD_TEST_SUITE} -- Status change

	update is
			-- Update information about all test routines `compiled_class'
			-- and add update notifications to `status_updates'.
		do
				-- Internal updates not triggering any status updates
			if compiled_class /= Void then
				class_file_name := compiled_class.original_class.file_name.string
				is_extracted := is_extracted_test_class (compiled_class)
				is_synthesized := is_synthesized_test_class (compiled_class)
				is_manual := is_manual_test_class (compiled_class)
			end

			status_updates.wipe_out
			update_tags
			update_test_routines

					-- Make sure `Current' has a valid "cdd_id" indexing clause
			ensure_cdd_id

					-- Recalculate `check_sum' of associated class (file) if `Current' `is_extracted'.
			if is_extracted then
				update_check_sum
			end
		end

feature -- Status

	is_extracted: BOOLEAN

	is_synthesized: BOOLEAN

	is_manual: BOOLEAN


feature {CDD_TEST_ROUTINE} -- Test routine properties

	class_tags: DS_HASH_SET [STRING]
			-- CDD tags in `compiled_class'

feature {NONE} -- Implementation

	internal_parsed_class: like parsed_class
			-- Abstract syntax tree if `compiled_class' is not available

	test_routine_table: DS_HASH_TABLE [CDD_TEST_ROUTINE, STRING]
			-- Table mapping all test routine names to their actual instance

	is_valid_routine_name (a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid test routine name?
		require
			a_name_not_void: a_name /= Void
		do
			Result := a_name.count >= test_routine_prefix.count and then
				a_name.substring (1, test_routine_prefix.count).is_case_insensitive_equal (test_routine_prefix)
		end

	is_valid_feature (a_feature: FEATURE_I): BOOLEAN is
			-- Is `a_feature' a valid test routine feature?
		require
			a_feature_not_void: a_feature /= Void
		do
			Result := not a_feature.has_arguments and a_feature.is_routine and
				a_feature.export_status.is_all and is_valid_routine_name (a_feature.feature_name)
		end

	is_valid_feature_as (a_feature_as: FEATURE_AS): BOOLEAN is
			-- Is `a_feature_as' the syntax of a valid test routine?
			-- (Note: for now only with respect to the first name)
		do
			Result := (a_feature_as.body.arguments = Void or else a_feature_as.body.arguments.is_empty) and
				not a_feature_as.is_function and is_valid_routine_name (a_feature_as.feature_name.name)
		end

	is_valid_clause_as (a_clause_as: FEATURE_CLAUSE_AS): BOOLEAN is
			-- Is `a_clause_as' exported to ANY?
		require
			a_clause_as_not_void: a_clause_as /= Void
		local
			l_list: CLASS_LIST_AS
			l_old_cs: CURSOR
		do
			if a_clause_as.clients /= Void then
				l_list := a_clause_as.clients.clients
				from
					l_old_cs := l_list.cursor
					l_list.start
				until
					Result or l_list.after
				loop
					if l_list.item.name.is_case_insensitive_equal ("ANY") then
						Result := True
					end
					l_list.forth
				end
				l_list.go_to (l_old_cs)
			else
				Result := True
			end
		end

	update_test_routines is
			-- Update test_routine_table with information from currently compiled system.
		local
			l_ft: FEATURE_TABLE
			l_fcl: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			l_fl: EIFFEL_LIST [FEATURE_AS]
			l_feature: FEATURE_I
			l_old_cs, l_old_cs2: CURSOR
			l_feature_list: DS_ARRAYED_LIST [FEATURE_AS]
		do
			create l_feature_list.make_default
			if compiled_class /= Void and then compiled_class.has_feature_table then
				l_ft := compiled_class.feature_table
				from
					l_old_cs := l_ft.cursor
					l_ft.start
				until
					l_ft.after
				loop
					l_feature := l_ft.item_for_iteration
					if is_valid_feature (l_ft.item_for_iteration) then
						l_feature_list.force_last (l_ft.item_for_iteration.e_feature.ast)
					end
					l_ft.forth
				end
				l_ft.go_to (l_old_cs)
			elseif parsed_class.features /= Void then
				l_fcl := parsed_class.features
				if l_fcl /= Void then
					from
						l_old_cs := l_fcl.cursor
						l_fcl.start
					until
						l_fcl.after
					loop
						if is_valid_clause_as (l_fcl.item) and not l_fcl.item.features.is_empty then
							l_fl := l_fcl.item.features
							from
								l_old_cs2 := l_fl.cursor
								l_fl.start
							until
								l_fl.after
							loop
								if is_valid_feature_as (l_fl.item) then
									l_feature_list.force_last (l_fl.item)
								end
								l_fl.forth
							end
							l_fl.go_to (l_old_cs2)
						end
						l_fcl.forth
					end
					l_fcl.go_to (l_old_cs)
				end
			end
			update_test_routine_table (l_feature_list)
		end

	update_test_routine_table (a_routine_list: DS_LINEAR [FEATURE_AS]) is
			-- Update `test_routine_table' according to `a_routine_list' and
			-- add all create update for all notifications in `status_udpates'.
		require
			a_routine_list_not_void: a_routine_list /= Void
			a_routine_list_valid: not a_routine_list.has (Void)
		local
			l_old_table: like test_routine_table
			l_cursor: DS_LINEAR_CURSOR [FEATURE_AS]
			l_name: STRING
			l_test_routine: CDD_TEST_ROUTINE
			l_found: BOOLEAN
		do
			l_old_table := test_routine_table
			create test_routine_table.make (a_routine_list.count)

				-- Insert or update test routine for each item in `a_routine_list'
				-- Remove existing test routines in `l_old_table'
			l_cursor := a_routine_list.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_name := l_cursor.item.feature_name.name
				l_found := False
				if l_old_table /= Void then
					l_old_table.search (l_name)
					if l_old_table.found then
						l_found := True
						l_test_routine := l_old_table.found_item
						test_routine_table.put (l_test_routine, l_name)
						l_old_table.remove_found_item
						l_test_routine.set_ast (l_cursor.item)
						l_test_routine.update
						if l_test_routine.is_modified then
							status_updates.force_last (create {CDD_TEST_ROUTINE_UPDATE}.make (l_test_routine, {CDD_TEST_ROUTINE_UPDATE}.changed_code))
						end
					end
				end
				if not l_found then
					create l_test_routine.make (Current, l_cursor.item)
					test_routine_table.put (l_test_routine, l_name)
					status_updates.force_last (create {CDD_TEST_ROUTINE_UPDATE}.make (l_test_routine, {CDD_TEST_ROUTINE_UPDATE}.add_code))
				end
				l_cursor.forth
			end

				-- Add update message for each test routine left in `l_old_table'.
			if l_old_table /= Void and then not l_old_table.is_empty then
				from
					l_old_table.start
				until
					l_old_table.after
				loop
					status_updates.force_last (create {CDD_TEST_ROUTINE_UPDATE}.make (l_old_table.item_for_iteration, {CDD_TEST_ROUTINE_UPDATE}.remove_code))
					l_old_table.forth
				end
			end

			create test_routines.make_from_array (test_routine_table.to_array)
		end

	update_tags is
			-- Update tags of test routines contained in this class.
		do
			create class_tags.make_default
			class_tags.set_equality_tester (case_insensitive_string_equality_tester)
			add_explicit_tags
			add_implicit_tags
		end

	add_explicit_tags is
			-- Update `tags' with data from the indexing clause.
		local
			l_ast: CLASS_AS
			l_ilist: INDEXING_CLAUSE_AS
			l_item: INDEX_AS
			l_value_list: EIFFEL_LIST [ATOMIC_AS]
			v: STRING
		do
			l_ast := parsed_class
			l_ilist := l_ast.top_indexes
			if l_ilist /= Void then
				from
					l_ilist.start
				until
					l_ilist.after
				loop
					l_item := l_ilist.item
					if l_item.tag.name.is_equal ("tag") then
						from
							l_value_list := l_item.index_list
							l_value_list.start
						until
							l_value_list.after
						loop
							v := l_value_list.item.string_value.twin
							v.prune_all_leading ('"')
							v.prune_all_trailing ('"')
							class_tags.force (v)
							l_value_list.forth
						end
					end
					l_ilist.forth
				end
			end
		end

	add_implicit_tags is
			-- Add implicit tags for `Current' to `class_tags'.
		local
			l_tag: STRING
		do
			if
				is_extracted
			then
				create l_tag.make (20)
				l_tag := "type."
				l_tag.append ("extracted")
				class_tags.force (l_tag)
			elseif
				is_synthesized
			then
				create l_tag.make (20)
				l_tag := "type."
				l_tag.append ("synthesized")
				class_tags.force (l_tag)
			elseif
				is_manual
			then
				create l_tag.make (20)
				l_tag := "type."
				l_tag.append ("manual")
				class_tags.force (l_tag)
			end
		end

	uuid_generator: UUID_GENERATOR is
			-- UUID generator for creating uuid's
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	uuid_regex: RX_PCRE_REGULAR_EXPRESSION is
			-- Regular expression matching valid uuid's
		once
			create Result.make
			Result.compile ("[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}")
		end

	cdd_id_indexing_available_regex: RX_PCRE_REGULAR_EXPRESSION is
			-- Regular expression matching eiffel class files containing "cdd_id" indexing clause with valid uuid
		once
			create Result.make
			Result.set_multiline (True)
			Result.set_dotall (True)
			Result.compile (".*indexing.*cdd_id.*:.*%".*([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}).*%".*class")
		end

	cdd_id_indexing_insertion_regex: RX_PCRE_REGULAR_EXPRESSION is
			-- Regular expression matching eiffel class files for insertion of "cdd_id" indexing clause ("indexing" has to be available)
		once
			create Result.make
			Result.set_multiline (True)
			Result.set_dotall (True)
			Result.compile ("(.*indexing.*[^%%]%")(.*[ %T%N]class[ %T%N])")
		end

	header_indexing_available_regex: RX_PCRE_REGULAR_EXPRESSION is
			-- Regular expression matching eiffel class files containing a header indexing keyword
		once
			create Result.make
			Result.set_multiline (True)
			Result.set_dotall (True)
			Result.compile ("(.*indexing)(.*[ %T%N]class[ %T%N])")
		end

	checksum_calculator: CDD_HASH_CALCULATOR is
			-- Calculator for checksums
		once
			create {CDD_WHIRLPOOL_HASH_CALCULATOR} Result.make
		end

feature {NONE} -- Assertion helpers

	one_of (a: BOOLEAN; b: BOOLEAN; c: BOOLEAN): BOOLEAN
		-- Is exactly one out of the three variables `a', `b', `c' true?
		do
			Result := (a xor b xor c) and not (a and b and c)
		ensure
			definition: (a xor b xor c) and not (a and b and c)
		end


invariant
	test_class_name_not_void: test_class_name /= Void
	compiled_class_xor_internal_parsed_class_not_void: (compiled_class /= Void) xor (internal_parsed_class /= Void)
	compiled_class_not_void_implies_valid: (compiled_class /= Void) implies is_valid_test_class (compiled_class)
	test_routine_table_not_void: test_routine_table /= Void
	test_routines_not_void: test_routines /= Void
	test_routines_valid: test_routines.for_all (agent (a_routine: CDD_TEST_ROUTINE): BOOLEAN
		do
			Result := a_routine /= Void and then
				a_routine.test_class = Current
		end)
	status_updates_not_void: status_updates /= Void
	status_updates_valid: not status_updates.has (Void)
	class_tags_not_void: class_tags /= Void
	class_tags_has_equality_tester: class_tags.equality_tester = case_insensitive_string_equality_tester
	class_file_name_valid: class_file_name /= Void and then not class_file_name.is_empty
	exactly_one_type: one_of (is_manual, is_synthesized, is_extracted)
			-- Since a user can edit an extracted test case in arbitrary ways (e.g. completely removing context, removing indexing, ...)
			-- the following invariant is not possible. If calculation of checksum fails, it simply stays void (and clients have to be aware of this)
	-- checksum_available_if_extracted: is_extracted implies (checksum /= Void)

end
