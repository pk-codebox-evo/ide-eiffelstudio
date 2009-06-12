indexing
	description: "Summary description for {SCOOP_CLASS_NAME_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_CLASS_NAME_VISITOR

inherit
	AST_ROUNDTRIP_ITERATOR
		redefine
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

create
	make_with_context

feature -- Initialisation

	make_with_context(a_context: ROUNDTRIP_CONTEXT; a_class_list: SCOOP_SEPARATE_CLASS_LIST)
			-- Initialise and reset flags
		require
			a_context_not_void: a_context /= Void
			a_class_list_not_void: a_class_list /= Void
		do
			context := a_context
			scoop_classes := a_class_list
		end

feature -- Access

	process_class_list_with_prefix (l_as: CLASS_LIST_AS; print_both: BOOLEAN) is
			-- Process `l_as'.
		do
			is_print_both := true
			is_set_prefix := true
			last_index := l_as.start_position
			process_eiffel_list (l_as)
			last_index := l_as.end_position - 1
		end

	process_id (l_as: ID_AS; a_set_prefix: BOOLEAN) is
			-- Process `l_as'.
		do
			is_print_both := false
			is_set_prefix := a_set_prefix
			last_index := l_as.start_position
			safe_process (l_as)
			last_index := l_as.end_position
		end

feature {NONE} -- Roundtrip: process nodes

	process_id_as (l_as: ID_AS) is
		do
			Precursor (l_as)
			if is_set_prefix and then scoop_classes.has (l_as.name.as_upper) then
				context.add_string ("SCOOP_SEPARATE__")
				if is_print_both then
					put_string (l_as)
					context.add_string (", ")
				end
			end
			put_string (l_as)
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

feature {NONE} -- Implementation

	put_string (l_as: LEAF_AS) is
			-- Print text contained in `l_as' into `context'.
		do
			context.add_string (l_as.text (match_list))
		end

	context: ROUNDTRIP_CONTEXT
		-- reference to actual context.

	scoop_classes: SCOOP_SEPARATE_CLASS_LIST
			-- contains all classes which have to be processed.

	is_print_both: BOOLEAN
			-- indicates if original name and name with prefix should be printed.

	is_set_prefix: BOOLEAN
			-- indicates if prefix should be printed or not.

end
