indexing
	description: "Summary description for {SCOOP_PROXY_PARENT_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_PROXY_PARENT_VISITOR

inherit
	AST_ROUNDTRIP_ITERATOR
		redefine
			process_parent_list_as,
			process_generic_class_type_as,
			process_infix_prefix_as,
			process_parent_as,
			process_rename_clause_as,
			process_rename_as,
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
			process_id_as,
			process_break_as,
			process_symbol_stub_as,
			process_none_id_as
		end

create
	make_with_system

feature -- Initialisation

	make_with_system(a_context: ROUNDTRIP_CONTEXT; a_class_list: SCOOP_SEPARATE_CLASS_LIST; a_system: SYSTEM_I)
			-- Initialise and reset flags
		require
			a_system_not_void: a_system /= Void
			a_context_not_void: a_context /= Void
		do
			context := a_context
			scoop_classes := a_class_list
			system := a_system

				-- reset flags
			is_process_first_select := false
		end

feature -- Access

	process_internal_conforming_parents(l_as: PARENT_LIST_AS) is
			-- Process `l_as'.
		do
			is_process_first_select := true
			if l_as /= Void then
				safe_process (l_as)
			else
					-- inherit 'SCOOP_SEPARATE__ANY' if (conforming) parent list contains no elemets.
				context.add_string ("%N%Ninherit%N%TSCOOP_SEPARATE__ANY")
				if parsed_class.is_expanded then
					context.add_string ("%N%T%Trename%N%T%T%Timplementation_ as implementation_any_%N%T%Tselect%N%T%T%Timplementation_any_%N%T%Tend")
				else
					context.add_string ("%N%T%Tredefine implementation_ end")
				end
			end
		end

	process_internal_non_conforming_parents(l_as: PARENT_LIST_AS) is
			-- Process `l_as'
		do
			is_process_first_select := false
			safe_process (l_as)
		end

feature {NONE} -- Visitor implementation

	process_parent_list_as (l_as: PARENT_LIST_AS) is
			-- Process `l_as'.
		do
			context.add_string ("%N%N")
			last_index := l_as.start_position - 1

			Precursor (l_as)
		end

	process_parent_as (l_as: PARENT_AS) is
			-- Process `l_as'.
		do
			-- skip parent if it is 'ANY'
			if l_as.type.class_name.name.is_equal ("ANY") then
				-- skip complete parent_clause
				last_index := l_as.end_position
			else
				context.add_string ("%N%T")
				last_index := l_as.type.start_position - 1
				safe_process (l_as.type)

				safe_process (l_as.internal_renaming)
				if parsed_class.is_expanded then
					if l_as.internal_renaming = Void then
						context.add_string ("%N%T%Trename")
					end

					-- add renaming of 'implementation_'
					context.add_string ("%N%T%T%Timplementation_ as implementation_" + l_as.type.class_name.name.as_lower + "_")
				end

				-- check
				if l_as.internal_exports /= Void then
					process_leading_leaves (l_as.internal_exports.clause_keyword_index)
					context.add_string ("%N%T%Texport {ANY} all")

					-- skip export tag
					last_index := l_as.internal_exports.end_position
				end

				safe_process (l_as.internal_undefining)

				safe_process (l_as.internal_redefining)
				if not parsed_class.is_expanded then
					if l_as.internal_redefining = Void then
						context.add_string ("%N%T%Tredefine")
					end
					if l_as.internal_redefining /= Void then
						context.add_string (",")
					end
					context.add_string ("%N%T%T%Timplementation_")
				end

				safe_process (l_as.internal_selecting)
				if parsed_class.is_expanded and then is_process_first_select then
					if l_as.internal_selecting = Void then
						context.add_string ("%N%T%Tselect")
					else
						context.add_string (", ")
					end
					context.add_string ("%N%T%T%Timplementation_" + l_as.type.class_name.name.as_lower + "_")
					is_process_first_select := false
				end

					-- add in each case the end keyword
				context.add_string ("%N%T%Tend")
				last_index := l_as.end_position
			end

		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS) is
			-- Process `l_as'.
		local
			l_generics_visitor: SCOOP_GENERICS_VISITOR
		do
			safe_process (l_as.lcurly_symbol (match_list))
			safe_process (l_as.attachment_mark (match_list))
			safe_process (l_as.expanded_keyword (match_list))
			safe_process (l_as.class_name)

			create l_generics_visitor.make_with_system (context, scoop_classes, system)
			l_generics_visitor.setup (parsed_class, match_list, true, true)
			l_generics_visitor.process_internal_generics (l_as.internal_generics)

			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_id_as (l_as: ID_AS) is
			-- Process `l_as'.
		local
			a_class: CLASS_AS
		do
			Precursor (l_as)

			if not is_basic_type (l_as.name) then
					-- add prefix if parent class is not expanded.
				a_class := get_class_as (l_as.name)
				if (a_class /= Void and then not a_class.is_expanded) then
					context.add_string ("SCOOP_SEPARATE__")
				end
			end

			put_string (l_as)
		end

	process_rename_clause_as (l_as: RENAME_CLAUSE_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.rename_keyword (match_list))
			context.add_string ("%N%T%T%T")
			safe_process (l_as.content)
		end

	process_rename_as (l_as: RENAME_AS) is
			-- Process `l_as'.
		local
			l_feature_name_visitor: SCOOP_FEATURE_NAME_VISITOR
			l_feature_name: STRING
		do
			create l_feature_name_visitor
			l_feature_name_visitor.setup (parsed_class, match_list, true, true)
			last_index := l_as.start_position - 1

				-- process old feature name
			l_feature_name := l_feature_name_visitor.process_feature_name (l_as.old_name)
			context.add_string (l_feature_name + " ")

				-- skip old name
			last_index := l_as.as_keyword_index - 1
			safe_process (l_as.as_keyword (match_list))

				-- process new feature name
			l_feature_name := l_feature_name_visitor.process_feature_name (l_as.new_name)
			context.add_string (" " + l_feature_name)
		end

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS) is
		local
			l_feature_name_visitor: SCOOP_FEATURE_NAME_VISITOR
			l_feature_name: STRING
		do
			create l_feature_name_visitor
			l_feature_name_visitor.setup (parsed_class, match_list, true, true)
			last_index := l_as.start_position - 1

			safe_process (l_as.frozen_keyword (match_list))
			l_feature_name := l_feature_name_visitor.process_infix_prefix (l_as)
			context.add_string (" " + l_feature_name)
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
			if not (l_as.is_separate_keyword or l_as.is_infix_keyword or l_as.is_prefix_keyword)  then
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

	system: SYSTEM_I
		-- reference to actual system.

	scoop_classes: SCOOP_SEPARATE_CLASS_LIST
			-- contains all classes which have to be processed.

	is_process_first_select: BOOLEAN
		-- indicates internal select of first parent should be processed.

	put_string (l_as: LEAF_AS) is
			-- Print text contained in `l_as' into `context'.
		do
			context.add_string (l_as.text (match_list))
		end

invariant
	invariant_clause: True -- Your invariant here

end
