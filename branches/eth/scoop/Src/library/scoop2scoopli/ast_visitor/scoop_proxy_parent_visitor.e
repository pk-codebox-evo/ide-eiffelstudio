indexing
	description: "Summary description for {SCOOP_PROXY_PARENT_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_PROXY_PARENT_VISITOR

inherit
	SCOOP_PARENT_VISITOR
		redefine
			process_internal_conforming_parents,
			process_internal_non_conforming_parents,
			process_generic_class_type_as,
			process_infix_prefix_as,
			process_parent_as,
			process_rename_as,
			process_id_as
		end

	SHARED_SCOOP_WORKBENCH

	SCOOP_BASIC_TYPE

create
	make_with_context

feature -- Access

	process_internal_conforming_parents(l_as: PARENT_LIST_AS) is
			-- Process `l_as'.
		do
			is_process_first_select := true
			if l_as /= Void then
				Precursor (l_as)
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
			Precursor (l_as)
		end

feature {NONE} -- Visitor implementation

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

				-- process internal renaming
				safe_process (l_as.internal_renaming)
				if parsed_class.is_expanded then
					if l_as.internal_renaming = Void then
						context.add_string ("%N%T%Trename")
					end
					-- add renaming of 'implementation_'
					context.add_string ("%N%T%T%Timplementation_ as implementation_" + l_as.type.class_name.name.as_lower + "_")
				end

				-- process internal exports
				safe_process (l_as.internal_exports)

				-- process internal undefining	
				safe_process (l_as.internal_undefining)

				-- process internal redefining
				safe_process (l_as.internal_redefining)
				if l_as.internal_redefining /= Void then
					context.add_string (",")
				else
					context.add_string ("%N%T%Tredefine")
				end
				context.add_string ("%N%T%T%Timplementation_")

				-- process internal selection
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

			create l_generics_visitor.make_with_context (context)
			l_generics_visitor.setup (parsed_class, match_list, true, true)
			l_generics_visitor.process_internal_generics (l_as.internal_generics, true, false)

			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_id_as (l_as: ID_AS) is
			-- Process `l_as'.
		local
			a_class: CLASS_AS
			l_scoop_separate_str: STRING
		do
			create l_scoop_separate_str.make_from_string (" SCOOP_SEPARATE__")
			process_leading_leaves (l_as.index)

			if not is_basic_type (l_as.name) then
				if is_process_export_clause then
					-- print client and proxy class name when printing export clause
					context.add_string (l_scoop_separate_str)
					put_string (l_as)
					context.add_string (", ")
				else
					-- add prefix if parent class is not expanded.
					a_class := get_class_as_by_name (l_as.name)
					if (a_class /= Void and then not a_class.is_expanded) then
						context.add_string (l_scoop_separate_str)
					end
				end
			end

			-- print id
			put_string (l_as)
			last_index := l_as.end_position
		end

	process_rename_as (l_as: RENAME_AS) is
			-- Process `l_as'.
		local
			l_feature_name_visitor: SCOOP_FEATURE_NAME_VISITOR
		do
			create l_feature_name_visitor.make
			l_feature_name_visitor.setup (parsed_class, match_list, true, true)
			last_index := l_as.start_position - 1

				-- process old feature name
			l_feature_name_visitor.process_feature_name (l_as.old_name)
			context.add_string ("%N%T%T%T" + l_feature_name_visitor.get_feature_name + " ")

				-- skip old name
			last_index := l_as.as_keyword_index - 1
			safe_process (l_as.as_keyword (match_list))

				-- process new feature name
			l_feature_name_visitor.process_feature_name (l_as.new_name)
			context.add_string (" " + l_feature_name_visitor.get_feature_name)
		end

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS) is
		local
			l_feature_name_visitor: SCOOP_FEATURE_NAME_VISITOR
		do
			create l_feature_name_visitor.make
			l_feature_name_visitor.setup (parsed_class, match_list, true, true)
			last_index := l_as.start_position - 1

			safe_process (l_as.frozen_keyword (match_list))
			l_feature_name_visitor.process_infix_prefix (l_as)
			context.add_string (" " + l_feature_name_visitor.get_feature_name)
		end

feature {NONE} -- Implementation

	is_process_first_select: BOOLEAN
		-- indicates internal select of first parent should be processed.

invariant
	invariant_clause: True -- Your invariant here

end
