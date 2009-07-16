indexing
	description: "Summary description for {SCOOP_GENERICS_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_GENERICS_VISITOR

inherit
	AST_ROUNDTRIP_ITERATOR
		redefine
			process_class_type_as,
			process_generic_class_type_as,
			process_named_tuple_type_as,
			process_keyword_as,
			process_symbol_as,
			process_bool_as,
			process_char_as,
			process_typed_char_as,
			process_result_as,
			process_retry_as,
			process_unique_as,
			process_deferred_as,
			process_void_as,
			process_string_as,
			process_verbatim_string_as,
			process_current_as,
			process_integer_as,
			process_real_as,
			process_break_as,
			process_symbol_stub_as,
			process_none_id_as,
			process_id_as
		end
	SHARED_SCOOP_WORKBENCH

create
	make_with_context

feature -- Initialisation

	make_with_context(a_context: ROUNDTRIP_CONTEXT)
			-- Initialise and reset flags
		require
			a_context_not_void: a_context /= Void
		do
			context := a_context
		end

feature -- Access

	process_internal_generics (l_as: TYPE_LIST_AS) is
			-- Process `l_as'.
		do
			is_set_prefix := true
			if l_as /= Void then
				last_index := l_as.start_position - 1
				safe_process (l_as)
			end
		end

	process_class_internal_generics(l_as: EIFFEL_LIST [FORMAL_DEC_AS]) is
			-- Process `l_as'.
		do
			is_set_prefix := true
			if l_as /= Void then
				last_index := l_as.start_position - 1
				safe_process (l_as)
			end
		end

	process_type_internal_generics(l_as: TYPE_LIST_AS) is
			-- Process `l_as'.
		do
			is_set_prefix := false
			if l_as /= Void then
				last_index := l_as.start_position - 1
				safe_process (l_as)
			end
		end

feature {NONE} -- Visitor implementation

	l_process_id_as (l_as: ID_AS; is_separate: BOOLEAN) is
		local
			l_class_name_visitor: SCOOP_CLASS_NAME_VISITOR
		do
			process_leading_leaves (l_as.index)

			create l_class_name_visitor.make_with_context (context)
			l_class_name_visitor.setup (parsed_class, match_list, true, true)
			l_class_name_visitor.process_id (l_as, is_set_prefix)
		end

	process_class_type_as (l_as: CLASS_TYPE_AS) is
		do
			safe_process (l_as.lcurly_symbol (match_list))

				-- generic separate type should be attached.
			if not l_as.is_separate then
				safe_process (l_as.attachment_mark (match_list))
			end

			safe_process (l_as.expanded_keyword (match_list))

			if l_as.is_separate then
				l_process_id_as (l_as.class_name, true)
			else
				l_process_id_as (l_as.class_name, false)
			end

			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS) is
		local
			l_generics_visitor: SCOOP_GENERICS_VISITOR
		do
			safe_process (l_as.lcurly_symbol (match_list))

				-- generic separate type should be attached.
			if not l_as.is_separate then
				safe_process (l_as.attachment_mark (match_list))
			end

			safe_process (l_as.expanded_keyword (match_list))

			if l_as.is_separate then
				l_process_id_as (l_as.class_name, true)
			else
				l_process_id_as (l_as.class_name, false)
			end

			create l_generics_visitor.make_with_context (context)
			l_generics_visitor.setup (parsed_class, match_list, true, true)
			l_generics_visitor.process_internal_generics (l_as.internal_generics)

			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS) is
		do
			safe_process (l_as.lcurly_symbol (match_list))

				-- generic separate type should be attached.
			if not l_as.is_separate then
				safe_process (l_as.attachment_mark (match_list))
			end

			if l_as.is_separate then
				l_process_id_as (l_as.class_name, true)
			else
				l_process_id_as (l_as.class_name, false)
			end

			safe_process (l_as.parameters)
			safe_process (l_as.rcurly_symbol (match_list))
		end

feature {NONE} -- Roundtrip: process leaf

	process_break_as (l_as: BREAK_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_keyword_as (l_as: KEYWORD_AS) is
			-- Process `l_as'.
		do
			if not l_as.is_separate_keyword then
				Precursor (l_as)
				put_string (l_as)
			end
		end

	process_symbol_as (l_as: SYMBOL_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_symbol_stub_as (l_as: SYMBOL_STUB_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_bool_as (l_as: BOOL_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_char_as (l_as: CHAR_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_typed_char_as (l_as: TYPED_CHAR_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_result_as (l_as: RESULT_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_retry_as (l_as: RETRY_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_unique_as (l_as: UNIQUE_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_deferred_as (l_as: DEFERRED_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_void_as (l_as: VOID_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_string_as (l_as: STRING_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_current_as (l_as: CURRENT_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_integer_as (l_as: INTEGER_AS) is
		do
			Precursor (l_as)
			context.add_string (l_as.number_text (match_list))
		end

	process_real_as (l_as: REAL_AS) is
		do
			Precursor (l_as)
			context.add_string (l_as.number_text (match_list))
		end

	process_none_id_as (l_as: NONE_ID_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			context.add_string ("NONE")
		end

	process_id_as (l_as: ID_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

feature {NONE} -- Implementation

	get_class_as (a_class_name: STRING): CLASS_AS is
			-- Get a class_as by name
		local
			i: INTEGER
			a_class: CLASS_C
		do
			from
				i := 1
			until
				i > system.classes.count
			loop
				a_class := system.classes.item (i)
				if a_class /= Void then
					if a_class.name_in_upper.is_equal (a_class_name.as_upper) then
						Result := a_class.ast
					end
				end
				i := i + 1
			end
		end

	is_basic_type (a_name: STRING): BOOLEAN is
			-- Is `a_class_type' a special type (such as ARRAY, STRING, HASHABLE, that are treated as special by EiffelStudio)?
			-- Such classes should not inherit from SCOOP_SEPARATE_CLIENT, otherwise EiffelStudio reports a library error.
		require
			a_name /= Void
		do
			if a_name.is_equal ("ANY")
				or else a_name.is_equal ("ARRAY")
				or else a_name.is_equal ("STRING")
				or else a_name.is_equal ("STRING_HANDLER")
				or else a_name.is_equal ("TO_SPECIAL")
				or else a_name.is_equal ("HASHABLE")
				or else a_name.is_equal ("MISMATCH_CORRECTOR")
				or else a_name.is_equal ("PART_COMPARABLE")
				or else a_name.is_equal ("REFACTORING_HELPER")
				or else a_name.is_equal ("DEBUG_OUTPUT")
				or else a_name.is_equal ("CONTAINER")
				or else a_name.is_equal ("INTERNAL")
				or else a_name.is_equal ("EXCEP_CONST")
			then
				Result := True
			else
				Result := False
			end
		end

	context: ROUNDTRIP_CONTEXT
		-- reference to actual context.

	is_set_prefix: BOOLEAN
			-- indicates if prefix should be printed or not.

	put_string (l_as: LEAF_AS) is
			-- Print text contained in `l_as' into `context'.
		do
			context.add_string (l_as.text (match_list))
		end

invariant
	invariant_clause: True -- Your invariant here

end
