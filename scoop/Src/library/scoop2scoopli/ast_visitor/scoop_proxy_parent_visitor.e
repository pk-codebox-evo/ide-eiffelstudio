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
			process_parent_as,
			process_rename_as,
			process_id_as,
			process_redefine_clause_as
		end

	SCOOP_WORKBENCH

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
					-- rename and redefine 'implementation_'
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
		local
			l_parent_object: SCOOP_PROXY_PARENT_OBJECT
			l_string_context: ROUNDTRIP_STRING_LIST_CONTEXT
		do
			-- set current processed parent
			current_processed_parent := l_as

			last_index := l_as.type.start_position - 1
			-- skip parent if it is 'ANY'
			if l_as.type.class_name.name.is_equal ("ANY") then
				-- skip complete parent_clause
				last_index := l_as.end_position
			else
				context.add_string ("%N%T")
				l_string_context ?= context

				-- process parent object
				create l_parent_object.make (l_as.type.class_name.name)
				scoop_workbench_objects.add_proxy_parent_object (l_parent_object)
				l_parent_object.set_parent_name (l_as.type.class_name.name)

				-- process type
				safe_process (l_as.type)
				l_parent_object.set_parent_cursor (l_string_context.get_cursor)

				-- process internal renaming
				safe_process (l_as.internal_renaming)
				if parsed_class.is_expanded then
					if l_as.internal_renaming = Void then
						context.add_string ("%N%T%Trename")
					end
					-- add renaming of 'implementation_'
					context.add_string ("%N%T%T%Timplementation_ as implementation_" + l_as.type.class_name.name.as_lower + "_")

					-- mark rename clause
					l_parent_object.set_rename_cursor (l_string_context.get_cursor)
				elseif l_as.internal_renaming /= Void then
					-- mark rename clause
					l_parent_object.set_rename_cursor (l_string_context.get_cursor)
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
				l_parent_object.set_redefine_cursor (l_string_context.get_cursor)

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
				if l_as.end_keyword_index > 0 then
					last_index := l_as.end_keyword_index
				else
					last_index := l_as.type.end_position
				end
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
			last_index := l_as.index
		end

	process_rename_as (l_as: RENAME_AS) is
			-- Process `l_as'.
		local
			l_old_name, l_new_name, l_original_old_name, l_str: STRING
			l_class_c: CLASS_C
			l_feature_name_visitor: SCOOP_FEATURE_NAME_VISITOR
			l_assign_finder: SCOOP_PROXY_ASSIGN_FINDER
		do
			Precursor (l_as)

			-- Create rename statement for assigner wrapper features
			-- if the current rename statement renames a feature which
			-- is used as assigner in a parent classe. If the current
			-- statement renames f from g to f then add a rename feature
			-- "g_scoop_separate_assigner_ as f_scoop_separate_assigner_"

			-- create visitors
			create l_assign_finder
			create l_feature_name_visitor.make
			l_feature_name_visitor.setup (parsed_class, match_list, true, true)

			-- get current processed parent
			l_class_c := get_parent_class_c_by_name (current_processed_parent.type.class_name.name)

			-- get original old name
			l_feature_name_visitor.process_original_feature_name (l_as.old_name, false)
			l_original_old_name := l_feature_name_visitor.get_feature_name

			-- check if old name is a feature with assigner in an ancestor
			if l_assign_finder.has_parents_feature_with_assigner (l_original_old_name, l_class_c) then

				-- get old and new name (with infix replacement)
				l_feature_name_visitor.process_feature_name (l_as.old_name, false)
				l_old_name := l_feature_name_visitor.get_feature_name
				l_feature_name_visitor.process_feature_name (l_as.new_name, false)
				l_new_name := l_feature_name_visitor.get_feature_name

				-- create rename clause
				create l_str.make_from_string (",%N%T%T%T" + l_old_name + "_scoop_separate_assigner_")
				l_str.append (" as " + l_new_name + "_scoop_separate_assigner_")
				context.add_string (l_str)
			end
		end

	process_redefine_clause_as (l_as: REDEFINE_CLAUSE_AS) is
			-- Process `l_as'.
		local
			l_parent_renamings: LINKED_LIST [TUPLE [parent_name: STRING; redefine_name: STRING]]
			l_assign_finder: SCOOP_PROXY_ASSIGN_FINDER
		do
			Precursor (l_as)

			-- get all redefine statements which are features with assigner in an ancestor.
			create l_assign_finder
		--	l_parent_renamings := l_assign_finder.get_redefine_list
		--	currently working here!
		end

feature {NONE} -- Implementation

	get_parent_class_c_by_name (a_class_name: STRING): CLASS_C is
			-- Return CLASS_C with name `a_class_name'
		require
			a_class_name_not_void: a_class_name /= Void
		local
			i, nb: INTEGER
			l_class_c: CLASS_C
		do
			from
				i := 1
				nb := class_c.parents_classes.count
			until
				i > nb
			loop
				l_class_c := class_c.parents_classes.i_th (i)
				if l_class_c.name_in_upper.is_equal (a_class_name) then
					Result := l_class_c
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	is_process_first_select: BOOLEAN
			-- indicates internal select of first parent should be processed.

	current_processed_parent: PARENT_AS
			-- Reference to current processed parent.

invariant
	invariant_clause: True -- Your invariant here

end
