indexing
	description: "Summary description for {SCOOP_CLIENT_PARENT_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_CLIENT_PARENT_VISITOR

inherit
	SCOOP_PARENT_VISITOR
		redefine
			process_internal_conforming_parents,
			process_parent_as,
			process_id_as,
			process_infix_prefix_as,
			process_rename_as
		end

	SCOOP_BASIC_TYPE

	SCOOP_WORKBENCH
		-- Remove `SCOOP_WORKBENCH' with EiffelStudio 6.4

create
	make_with_context

feature -- Access

	process_internal_conforming_parents(l_as: PARENT_LIST_AS) is
			-- Process `l_as'.
		do
			if l_as /= Void then
				Precursor (l_as)
			else
				if not is_basic_type (parsed_class.class_name.name.as_upper) then
						-- inherit from 'SCOOP_SEPARATE_CLIENT'.
					context.add_string ("%N%Ninherit%N%TSCOOP_SEPARATE_CLIENT")
				end
			end
		end

feature {NONE} -- Visitor implementation

	process_parent_as (l_as: PARENT_AS) is
		do
			last_index := l_as.type.start_position - 1
			current_parent_c := get_parent_class_c_by_name (l_as.type.class_name.name)
--			if l_as.type.class_name.name.as_upper.is_equal ("ANY") then

--					-- Replace `ANY' with `SCOOP_SEPARATE_CLIENT'.
--				context.add_string ("SCOOP_SEPARATE_CLIENT")
--				-- skipe the rest of the parent clause
--				last_index := l_as.end_position
--			else
				context.add_string ("%N%T")

				if l_as.type.class_name.name.as_upper.is_equal ("ANY") then
					context.add_string ("SCOOP_SEPARATE_CLIENT")
					last_index := l_as.type.class_name.index
				else
					safe_process (l_as.type)
				end

				safe_process (l_as.internal_renaming)
				safe_process (l_as.internal_exports)
				safe_process (l_as.internal_undefining)

				if l_as.internal_redefining /= Void then
					safe_process (l_as.internal_redefining)
					insert_infix_prefix_redefine_list (false)
				else
					insert_infix_prefix_redefine_list (true)
				end

				safe_process (l_as.internal_selecting)

				if l_as.end_keyword_index > 0 then
					context.add_string ("%N%T%T")
				end
				safe_process (l_as.end_keyword (match_list))
--			end
		end

	process_id_as (l_as: ID_AS) is
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)

			if not is_basic_type (l_as.name) then
				if is_process_export_clause then
					-- print client and proxy class name when printing export clause
					context.add_string (" SCOOP_SEPARATE__")
					put_string (l_as)
					context.add_string (", ")
				end
			end

			-- print id
			put_string (l_as)
			last_index := l_as.index
		end

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS) is
			-- Remove this feature with EiffelStuidio 6.4
			-- It creates for each infix / prefix feature name a list
			-- containing the infix and non-infix notation
		local
			l_feature_name_visitor: SCOOP_FEATURE_NAME_VISITOR
		do
			if not is_rename_clause then
				-- creates comma separated a list of non-infix and infix feature name
				create l_feature_name_visitor.make
				l_feature_name_visitor.setup (parsed_class, match_list, true, true)
				last_index := l_as.start_position - 1

				-- process INFIX_PREFIX_AS node
				if l_as.frozen_keyword_index > 0 then
					safe_process (l_as.frozen_keyword (match_list))
				else
					process_leading_leaves (l_as.infix_prefix_keyword_index)
				end
				l_feature_name_visitor.process_declaration_infix_prefix (l_as)
				context.add_string (" " + l_feature_name_visitor.get_feature_name + ", ")
				last_index := l_as.alias_name.index
			end

			Precursor (l_as)
		end

	process_rename_as (l_as: RENAME_AS) is
			-- Remove this feature with EiffelStudio 6.4

			-- Rename 'infx x as non-infix x:
			-- ------------------------------
			-- It creates from a renamed feature with infix / prefix
			-- feature name two statements: one undefine statment
			-- with infix / prefix and one rename statement with
			-- non-infix / non-prefix notation.

			-- Rename 'non-infix x' as 'infix x':
			-- ---------------------------------
			-- we create here only a 'non-infix x
			-- as infix x' renaming
		local
			l_str, l_original_name: STRING
			l_wrapper_name, l_wrapper_feature: STRING
			l_old_name, l_new_name: INFIX_PREFIX_AS
			l_feature_i: FEATURE_I
			l_feature_name_visitor: SCOOP_FEATURE_NAME_VISITOR
		do
			l_old_name ?= l_as.old_name

			-- flag current processing
			is_rename_clause := true

			if l_old_name /= Void then
				-- create first the undefine

				-- create feature name visitor
				create l_feature_name_visitor.make
				l_feature_name_visitor.setup (parsed_class, match_list, true, true)

				-- create string
				create l_str.make_from_string ("%N%T%T%T")

				-- create first the infix / prefix version of the renaming
				-- get old name without alias
				l_feature_name_visitor.process_original_feature_name (l_as.old_name, true)
				l_original_name := l_feature_name_visitor.get_feature_name
				l_str.append (l_original_name)

				l_str.append (" as ")

				l_new_name ?= l_as.new_name
				if l_new_name /= Void then
					-- infix to infix -> create 2 rename statements

					-- get new name without alias
					l_feature_name_visitor.process_original_feature_name (l_as.new_name, false)
					l_str.append (l_feature_name_visitor.get_feature_name)

				else
					-- infix to non-infix -> create for original rename statement
					-- a new wrapper feature which links to the renamed feature

					-- get FEATURE_I node of current node
					l_feature_name_visitor.process_original_feature_name (l_as.old_name, true)
					l_feature_i := current_parent_c.feature_table.item (l_feature_name_visitor.get_feature_name)

					-- create a new feature name
					l_feature_name_visitor.process_feature_name (l_as.old_name, false)
					create l_wrapper_name.make_from_string(l_feature_name_visitor.get_feature_name)
					l_wrapper_name.append ("_" + class_c.name.as_lower)
					l_wrapper_name.append ("_separate_scoop_wrapper_")

					-- add the new created feature name to the rename statement
					l_str.append (l_wrapper_name)

					-- create now the new feature with the call to the new feature
					create l_wrapper_feature.make_from_string ("%N%N%T" + l_wrapper_name + " ")

					-- get internal argument and type
					if l_old_name.is_infix then
						-- infix -> create a new argument
						l_wrapper_feature.append ("(i: ")

						if l_feature_i.arguments.first.is_formal then
							l_wrapper_feature.append (class_c.generics.first.name.name)
						else
							l_wrapper_feature.append (l_feature_i.arguments.first.name)
						end

						l_wrapper_feature.append (")")
					end

					l_wrapper_feature.append (": ")

					-- set type
					if l_feature_i.type.is_formal then
						l_wrapper_feature.append (class_c.generics.first.name.name)
					elseif l_feature_i.type.is_like_current then
						l_wrapper_feature.append (current_parent_c.name.as_lower)
					else
						l_wrapper_feature.append (l_feature_i.type.name)
					end

					-- set is keyword
					l_wrapper_feature.append (" is")

					-- set comment
					l_wrapper_feature.append ("%N%T%T%T-- Feature wrapper for infix / prefix rename statements.")
					l_wrapper_feature.append ("%N%T%T%T-- Hack for EiffelStudio 6.3")

					-- add do keyword
					l_wrapper_feature.append ("%N%T%Tdo")

					-- add feature call:
					l_wrapper_feature.append ("%N%T%T%TResult := ")
					-- get new name without alias
					l_feature_name_visitor.process_original_feature_name (l_as.new_name, false)
					l_wrapper_feature.append (l_feature_name_visitor.get_feature_name + " ")

					-- add internal arguments as actual arguments
					if l_old_name.is_infix then
						l_wrapper_feature.append ("(i)")
					end

					-- add end keyword
					l_wrapper_feature.append ("%N%T%Tend")

					-- save feature somewhere to add it somewhere
					scoop_workbench_objects.extend_proxy_infix_prefix_wrappers (l_wrapper_feature)

					-- add new feature to the redefine list
					if infix_prefix_redefine_list = Void then
						create infix_prefix_redefine_list.make
					end
					infix_prefix_redefine_list.extend (l_wrapper_name)
				end

				l_str.append (",")
				context.add_string (l_str)
			end

			-- process it again with non-infix notation
			Precursor (l_as)

			-- unflag current processing
			is_rename_clause := false
		end

	insert_infix_prefix_redefine_list (is_insert_with_rename_keyword: BOOLEAN) is
			-- Inserts the elements from `infix_prefix_redefine_list'
			-- Remove this feature with EiffelStudio 6.4
		local
			i, nb: INTEGER
		do
			if infix_prefix_redefine_list /= Void and then not infix_prefix_redefine_list.is_empty then

				if is_insert_with_rename_keyword then
					context.add_string ("%N%T%Tredefine")
				else
					-- add comma
					context.add_string (", ")
				end

				from
					i := 1
					nb := infix_prefix_redefine_list.count
				until
					i > nb
				loop
					-- add feature name
					context.add_string (infix_prefix_redefine_list.i_th (i))

					if i < nb then
						-- add comma
						context.add_string (", ")
					end

					i := i + 1
				end
				infix_prefix_redefine_list.wipe_out
			end
		end


feature {NONE} -- Implementation

	is_rename_clause: BOOLEAN
			-- Indicates that the rename clause is processed
			-- Remove this attribute with EiffelStudio 6.4
			-- It is only used for getting a list of non-infix and infix
			-- / non-prefix and prefix notation for a infix / prefix
			-- feature name.

	infix_prefix_redefine_list: LINKED_LIST [STRING]
			-- Remove this list with EiffelStudio 6.4
			-- List of renamed infix / prefix feature names which has
			-- to be inserted in the undefine list

	current_parent_c: CLASS_C
			-- Remove this list with EiffelStudio 6.4

end
