indexing
	description: "Meta information (name, outcomes, but not the actual implementation) of a CDD test routine"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_ROUTINE

inherit

	KL_SHARED_STRING_EQUALITY_TESTER
		export
			{NONE} all
		end

	HASHABLE

create
	make

feature {NONE} -- Initialization

	make (a_test_class: like test_class; an_ast: like ast) is
			-- Initialize `Current'.
		require
			a_test_class_not_void: a_test_class /= Void
			an_ast_not_void: an_ast /= Void
		do
			test_class := a_test_class
			set_ast (an_ast)
			hash_code := (test_class.test_class_name + "." + name).hash_code
			create internal_outcomes.make
			update
		ensure
			test_class_set: test_class = a_test_class
		end


feature -- Status report

	has_matching_tag (a_pattern: STRING): BOOLEAN is
			-- Does routine have a tag that matches `a_pattern'?
			-- A tag matches a pattern if the tag contains the pattern (substring).
		require
			a_pattern_not_void: a_pattern /= Void
		local
			cs: DS_LINEAR_CURSOR [STRING]
			regexp: RX_PCRE_REGULAR_EXPRESSION
		do
			create regexp.make
			regexp.set_caseless (True)
			regexp.compile (a_pattern)
			from
				cs := tags.new_cursor
				cs.start
			until
				cs.off or Result
			loop
				if regexp.matches (cs.item) then
					Result := True
				else
					cs.forth
				end
			end
			cs.go_after
		end

	has_original_outcome: BOOLEAN is
			-- Does original outcome exist for `Current'?
		do
			Result := (original_outcome /= Void)
		ensure
			definition: Result = (original_outcome /= Void)
		end

	has_outcome:  BOOLEAN is
			-- Does at least one outcome exist for `Current'?
		do
			Result := not internal_outcomes.is_empty
		ensure
			definition: Result = not internal_outcomes.is_empty
		end


	has_reproducing_outcome: BOOLEAN is
			-- Has testing routine attached to `Current' been able to reproduce the `original_outcome'
			-- at least once?
		do
			Result := has_original_outcome and then has_outcome
			if Result then
				from
					Result := False
					outcomes.start
				until
					outcomes.after or else Result
				loop
					Result := outcomes.item_for_iteration.matches_original_outcome (original_outcome)
					outcomes.forth
				end
			end
		end

	is_automatic_reextraction_required: BOOLEAN is
			-- Should the test routine attached to `Current' be automatically reextracted?
		do
				-- If not `has_outcome' or not `has_original_failure', there is no reason to for reextraction.
				-- Otherwise reextraction is required if no reproducing outcome exists
			Result := has_outcome and then has_original_outcome and then not has_reproducing_outcome

				-- TODO: Consider lines below: Test routines with passing original outcomes are never reextracted, since semantics are unclear.
				-- NOTE: Currently no passing original outcomes are ever produced.
			Result := Result and then not original_outcome.is_passing
		end

feature -- Access

	test_class: CDD_TEST_CLASS
			-- Class which contains `Current'

	name: STRING is
			-- Name of testable routine in `test_class'
		do
			Result := ast.feature_name.name
		ensure
			not_void: Result /= Void
			first_visual_in_ast: Result = ast.feature_names.first.visual_name
		end

	tags: DS_LINEAR [STRING] is
			-- Tags associated with this test routine
		do
			Result := internal_tags
		ensure
			not_void: Result /= Void
			valid: not Result.has (Void)
		end

	outcomes: DS_BILINEAR [CDD_TEST_EXECUTION_RESPONSE] is
			-- List of recorded test execution responses
			-- where last item is most recent.
		do
			Result := internal_outcomes
		ensure
			not_void: Result /= Void
			not_has_void: not Result.has (Void)
		end

	original_outcome: CDD_ORIGINAL_OUTCOME
			-- Original outcome upon extraction of the test case associated with `Current'

	is_modified: BOOLEAN
			-- Has `Current' updated its tags since last call to `update' or `add_outcome'?

	hash_code: INTEGER
			-- Hash code for using `Current' in a hash table

	class_file_name: STRING_8 is
			-- File name of the eiffel class associated with `Current'
		do
			Result := test_class.class_file_name
		end

	tags_with_prefix (a_prefix: STRING): DS_ARRAYED_LIST [STRING] is
			-- List of tags with prefix `a_prefix'
		require
			a_prefix_not_void: a_prefix /= Void
		local
			cs: DS_LINEAR_CURSOR [STRING]
			item: STRING
			count: INTEGER
		do
			from
				create Result.make (5)
				cs := tags.new_cursor
				cs.start
				count := a_prefix.count
			until
				cs.off
			loop
				item := cs.item
				if item.count >= count and item.substring (1, count).is_equal (a_prefix) then
					Result.force_last (item)
				end
				cs.forth
			end
		ensure
			list_not_void: Result /= Void
			list_doesnt_have_void: not Result.has (Void)
		end

	status_string_verbose: STRING is
			-- Verbose status message about `Current'
		do
			Result := ""

			if has_original_outcome then
				if has_outcome then
					if has_reproducing_outcome then
						Result.append_string ("Reproduced original failure (at least once)")
					else
						Result.append_string ("Never reproduced original failure")
					end
				else
					Result.append_string ("Waiting for initial execution")
				end
			else
				if has_outcome then
					Result.append_string ("Executed")
				else
					Result.append_string ("Has not been executed yet")
				end
			end
			Result.append_string ("%N%N")

			if has_outcome then
				Result.append_string ("Last execution:%N")
				Result.append_string (outcomes.last.out)
				if outcomes.last.has_bad_communication then
					Result.append_string ("%N%NOutput:%N%N")
					if outcomes.last.setup_response.is_bad then
						Result.append_string (outcomes.last.setup_response.response_text)
					elseif outcomes.last.test_response.is_bad then
						Result.append_string (outcomes.last.test_response.response_text)
					elseif outcomes.last.teardown_response.is_bad then
						Result.append_string (outcomes.last.teardown_response.response_text)
					end
				end
				Result.append_string ("%N%N")
			end

			if has_original_outcome then
				Result.append_string ("Original Outcome%N")
				Result.append_string (original_outcome.out)
			end
		end

	status_string: STRING is
			-- Verbose status message about `Current'
		do
			Result := ""

			if has_original_outcome then
				if has_outcome then
					if has_reproducing_outcome then
						Result.append_string ("Reproduced original failure (at least once)")
					else
						Result.append_string ("Never reproduced original failure")
					end
				else
					Result.append_string ("Waiting for initial execution")
				end
			else
				if has_outcome then
					Result.append_string ("Executed")
				else
					Result.append_string ("Has not been executed yet")
				end
			end
			Result.append_string ("%N%N")

			if has_outcome then
				Result.append_string ("Last execution:%N")
				Result.append_string (outcomes.last.out_short)
				if outcomes.last.has_bad_communication then
					Result.append_string ("%N%NOutput:%N%N")
					if outcomes.last.setup_response.is_bad then
						Result.append_string (outcomes.last.setup_response.response_text)
					elseif outcomes.last.test_response.is_bad then
						Result.append_string (outcomes.last.test_response.response_text)
					elseif outcomes.last.teardown_response.is_bad then
						Result.append_string (outcomes.last.teardown_response.response_text)
					end
				end
				Result.append_string ("%N%N")
			end

			if has_original_outcome then
				Result.append_string ("Original Outcome%N")
				Result.append_string (original_outcome.out_short)
			end
		end

feature -- Element change

	add_outcome (an_outcome: CDD_TEST_EXECUTION_RESPONSE) is
			-- Add `an_outcome' to `outcomes' and notify observers.
		require
			an_outcome_not_void: an_outcome /= Void
		do
			internal_outcomes.put_last (an_outcome)
			update
		ensure
			added: outcomes.last = an_outcome
		end

	set_ast (an_ast: like ast) is
			-- Set `ast' to `an_ast'.
		require
			an_ast_not_void: an_ast /= Void
		do
			ast := an_ast
		end

	set_original_outcome (an_original_outcome: like original_outcome) is
			-- Set `original_outcome' to `an_original_outcome'.
		require
			an_original_outcome_not_void: an_original_outcome /= Void
		do
			original_outcome := an_original_outcome
		ensure
			original_outcome_set: original_outcome = an_original_outcome
		end

feature {CDD_TEST_CLASS} -- Update

	update is
			-- Update `tags' and set `is_modified' if tags have changed.
		local
			l_old_tags: like internal_tags
		do
			is_modified := False
			l_old_tags := internal_tags
			create internal_tags.make_default
			internal_tags.set_equality_tester (case_insensitive_string_equality_tester)
			internal_tags.merge (test_class.class_tags)
			add_implicit_tags
			add_explicit_tags
			if l_old_tags /= Void and then not l_old_tags.is_equal (internal_tags) then
				is_modified := True
			end
		end

feature {CDD_MANAGER} -- Update

	update_original_outcome is
			-- Update the information of `original_outcome' in order to reflect changes of system under test.
			-- NOTE: This feature will set `original_outcome' to Void if `original_outcome.covered_feature' is no longer available!
		require
			has_original_outcome: original_outcome /= Void
		do
			if original_outcome.covered_feature.updated_version /= Void then
				original_outcome.set_covered_feature (original_outcome.covered_feature.updated_version)
			else
				original_outcome := Void
			end
		end


feature {NONE} -- Implementation

	ast: FEATURE_AS
			-- Abstract syntax tree representation of `Current'

	internal_outcomes: DS_LINKED_LIST [CDD_TEST_EXECUTION_RESPONSE]
			-- List of recorded test execution responses
			-- where last item is most recent.

	internal_tags: DS_HASH_SET [STRING]
			-- Internal set of tags for `Current'

feature {NONE} -- Implementation

	add_explicit_tags is
			-- Add explicit indexing tags in `ast' to `internal_tags'.
		local
			l_ilist: INDEXING_CLAUSE_AS
			l_cs: CURSOR
			l_item: INDEX_AS
			l_value_list: EIFFEL_LIST [ATOMIC_AS]
			v: STRING
		do
			l_ilist := ast.indexes
			if l_ilist /= Void and then not l_ilist.is_empty then
				from
					l_cs := l_ilist.cursor
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
							internal_tags.force (v)
							l_value_list.forth
						end
					end
					l_ilist.forth
				end
				l_ilist.go_to (l_cs)
			end
		end

	add_implicit_tags is
			-- Add implicit tags for `Current' to `internal_tags'.
		local
			l_tag: STRING
		do
			create l_tag.make (20)
			l_tag := "name."
			l_tag.append (test_class.test_class_name)
			l_tag.append_character ('.')
			l_tag.append (name)
			internal_tags.force (l_tag)
			if not outcomes.is_empty then
				create l_tag.make (20)
				l_tag.append ("outcome.")
				l_tag.append (outcomes.last.text)
				internal_tags.force (l_tag)
			end
		end

invariant
	test_class_not_void: test_class /= Void
	routine_name_not_void: name /= Void
	ast_not_void: ast /= Void
	internal_outcomes_valid: internal_outcomes /= Void and then not internal_outcomes.has (Void)
	internal_tags_valid: internal_tags /= Void and then not internal_tags.has (Void) and then
		internal_tags.equality_tester = case_insensitive_string_equality_tester


end
