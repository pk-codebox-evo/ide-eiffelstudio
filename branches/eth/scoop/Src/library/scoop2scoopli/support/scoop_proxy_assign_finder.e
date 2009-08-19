indexing
	description: "Summary description for {SCOOP_PROXY_ASSIGN_FINDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_PROXY_ASSIGN_FINDER

inherit
	SCOOP_WORKBENCH

feature -- Access

	has_parents_feature_with_assigner (an_original_feature_name: STRING; a_parent_class: CLASS_C): BOOLEAN is
			-- Returns true if some ancestors have a feature with
			-- name `an_original_feature_name' and an assigner.
		do
			Result := has_feature (an_original_feature_name, a_parent_class, false)
		end


	insert_redefine_for_feature_with_assigner (an_original_feature_name, a_new_feature_name: STRING; a_base_class: CLASS_C; a_string_context: ROUNDTRIP_STRING_LIST_CONTEXT) is
			-- Returns true if the current parent class or some ancestors have
			-- a feature with name `an_original_feature_name' and an assigner.
		require
			an_original_feature_name_not_void: an_original_feature_name /= Void
			a_new_feature_name_not_void: a_new_feature_name /= Void
			a_base_class_not_void: a_base_class /= Void
			a_string_context_not_void: a_string_context /= Void
		local
			a_value: BOOLEAN
		do
			string_context := a_string_context
			new_feature_name := a_new_feature_name
			a_value := has_feature (an_original_feature_name, a_base_class, true)
		end

feature {NONE} -- Implementation

	has_feature (an_original_feature_name: STRING; a_class_c: CLASS_C; is_redefine_base_class: BOOLEAN): BOOLEAN is
			-- Returns true if (the current parent class or) some ancestors have
			-- a feature with name `an_original_feature_name' and an assigner.
			-- if `is_redefine_base_class' then do not check the current class, but
			-- insert a redefine statement.
		local
			i, j, nb, nbj: INTEGER
			l_rename_str: STRING
			l_class_c: CLASS_C
			l_feature_i: FEATURE_I
			l_assign_visitor: SCOOP_PROXY_ASSIGN_VISITOR
			l_tuple: TUPLE [parent_name: STRING; old_feature_name: STRING]
			l_parent_renamings: LINKED_LIST [TUPLE [parent_name: STRING; old_feature_name: STRING]]
		do
			if not is_redefine_base_class then
				-- check current class
				if a_class_c.feature_table.has (an_original_feature_name) then
					l_feature_i := a_class_c.feature_table.item (an_original_feature_name)
					if l_feature_i.assigner_name /= Void then
						Result := true
					end
				end
			end

			-- get any renamings of `an_original_feature' of all parents
			create l_assign_visitor
			l_parent_renamings := l_assign_visitor.get_renamings (an_original_feature_name, a_class_c)

			-- check parents of this parent class
			from
				i := 1
				nb := a_class_c.parents_classes.count
			until
				i > nb or Result
			loop
				l_class_c := a_class_c.parents_classes.i_th (i)

				-- get rename of current assigner
				l_rename_str := an_original_feature_name
				from
					j := 1
					nbj := l_parent_renamings.count
				until
					j > nbj
				loop
					l_tuple := l_parent_renamings.i_th (j)
					if l_tuple.parent_name.is_equal (l_class_c.name_in_upper) then
						l_rename_str := l_tuple.old_feature_name
					end
					j := j + 1
				end

				-- check parents (recursive call - therefore check also current class)
				Result := has_feature (l_rename_str, l_class_c, false)

				if is_redefine_base_class and Result then
					insert_redefine_statement (l_class_c)
				end

				i := i + 1
			end
		end

	insert_redefine_statement (a_class_c: CLASS_C) is
			-- inserts a redefine statement
		require
			a_class_c_not_void: a_class_c /= Void
			string_context_not_void: string_context /= Void
		local
			l_str: STRING
			l_parent_object: SCOOP_PROXY_PARENT_OBJECT
		do
			l_parent_object := scoop_workbench_objects.get_proxy_parent_object (a_class_c.name_in_upper)
			if l_parent_object /= Void then
				create l_str.make_from_string (new_feature_name + "_scoop_separate_assigner_")

				l_parent_object.add_redefine_clause (l_str, string_context)
			end
		end

--					if l_parent_object /= Void then
--						create l_str.make_from_string (a_feature_name + "_scoop_separate_assigner_" + an_assigner_name + "_")

--						l_parent_object.add_redefine_clause (l_str, a_string_context)
--					end


--	is_feature_with_assigner_in_parents (an_original_feature_name: STRING; a_base_class_c: CLASS_C): BOOLEAN is
--			-- Returns true if there is a feature f with assigner in the parents
--		require
--			an_original_feature_name_not_void: an_original_feature_name /= Void
--			a_base_class_c_not_void: a_base_class_c /= Void
--		local
--			i, j, nb, nbj: INTEGER
--			l_rename_str: STRING
--			l_class_c: CLASS_C
--			l_feature_i: FEATURE_I
--			l_assign_visitor: SCOOP_PROXY_ASSIGN_VISITOR
--			l_tuple: TUPLE [parent_name: STRING; old_feature_name: STRING]
--			l_parent_renamings: LINKED_LIST [TUPLE [parent_name: STRING; old_feature_name: STRING]]
--		do
--			-- get any renamings of `an_original_feature' of all parents
--			create l_assign_visitor
--			l_parent_renamings := l_assign_visitor.get_renamings (an_original_feature_name, a_base_class_c)

--		end


--	insert_redefine_statements (an_original_feature_name, a_feature_name, an_assigner_name: STRING; a_string_context: ROUNDTRIP_STRING_LIST_CONTEXT) is
--			-- Insert for each parent, which has already a feature f with assigner q
--			-- itself or within his ancestors, a redefinition statement for the new
--			-- wrapper feature. (-> "redefine f_scoop_separate_assigner_q_")
--			-- The original names contains the original infix notation.
--		require
--			a_feature_name_not_void: a_feature_name /= Void
--			an_assigner_name_not_void: an_assigner_name /= Void
--		local
--			i, nb: INTEGER
--			l_str: STRING
--			l_class_c: CLASS_C
--			l_parent_object: SCOOP_PROXY_PARENT_OBJECT
--		do
--			-- set attributes
--			original_feature_name := an_original_feature_name
--			feature_name := a_feature_name
--			assigner_name := an_assigner_name

--			-- check each parent separately
--			from
--				i := 1
--				nb := class_c.parents_classes.count
--			until
--				i > nb
--			loop
--				l_class_c := class_c.parents_classes.i_th (i)
--				if has_class_feature_and_an_assigner (l_class_c) then
--					l_parent_object := scoop_workbench_objects.get_proxy_parent_object (l_class_c.name_in_upper)
--					if l_parent_object /= Void then
--						create l_str.make_from_string (a_feature_name + "_scoop_separate_assigner_" + an_assigner_name + "_")

--						l_parent_object.add_redefine_clause (l_str, a_string_context)
--					end
--				end

--				i := i + 1
--			end
--		end

--	insert_rename_statements (an_original_old_name, an_old_name, a_new_name: STRING; a_parent_class: CLASS_C; a_context: ROUNDTRIP_CONTEXT) is
--			-- Insert for each rename statement a rename statement for the assigner wrapper feature
--			-- if the current old_name is used as assigner in an ancestor.
--			-- (-> "rename f_scoop_separate_assigner_ as g_scoop_separate_assigner_")
--			-- The original name contains the original infix notation.
--		require
--			an_original_old_name_not_void: an_original_old_name /= Void
--			a_new_name_not_void: a_new_name /= Void
--			a_parent_class_not_void: a_parent_class /= Void
--			a_context /= Void
--		local
--			i, nb: INTEGER
--			l_str, l_feature_name: STRING
--			do
--			-- create parent feature name list
--			create parent_feature_names.make

--			-- check current parent
--			collect_assigner_features (an_original_old_name, a_parent_class)
--			if not parent_feature_names.is_empty then
--				-- create a rename statement for each feature name
--				from
--					i := 1
--					nb := parent_feature_names.count
--				until
--					i > nb
--				loop
--					l_feature_name := parent_feature_names.i_th (i)
--					-- create rename statement
--					create l_str.make_from_string (",%N%T%T%T" + l_feature_name + "_scoop_separate_assigner_" + an_old_name + "_")
--					l_str.append (" as " + l_feature_name + "_scoop_separate_assigner_" + a_new_name + "_")
--					-- add rename statement
--					a_context.add_string (l_str)
--					i := i + 1
--				end
--			end
--		end

feature {NONE} -- Iteration

--	has_class_feature_and_an_assigner (a_class_c: CLASS_C): BOOLEAN is
--			-- Return true if `a_class_c' has a feature f with assigner q.
--		local
--			i, nb: INTEGER
--			l_feature_i: FEATURE_I
--			l_class_c: CLASS_C
--		do
--			-- check features in class
--			if a_class_c.feature_table.has (original_feature_name) then
--				l_feature_i := a_class_c.feature_table.item (original_feature_name)
--				if l_feature_i.assigner_name /= Void then
--					Result := true
--					io.put_string ("%N ANCESTORS: found '" + assigner_name + "' in '" + a_class_c.name_in_upper + " - feature: " + l_feature_i.feature_name)
--				end
--			end

--			-- check recursively parents
--			from
--				i := 1
--				nb := a_class_c.parents_classes.count
--			until
--				i > nb or Result
--			loop
--				l_class_c := a_class_c.parents_classes.i_th (i)
--				io.put_string ("%N    ANCESTORS: parent: " + l_class_c.name_in_upper)

--				-- process current parent
--				Result := Result or has_class_feature_and_an_assigner (l_class_c)

--				i := i + 1
--			end
--		end

--	collect_assigner_features (a_feature_name: STRING; a_class_c: CLASS_C) is
--			-- Returns true if `l_class_c' or a parent has a feature
--			-- with assigner called `an_old_name'.
--		local
--			i, nb: INTEGER
--			l_class_c: CLASS_C
--			l_old_assigner_name: STRING
--			l_assign_visitor: SCOOP_PROXY_ASSIGN_VISITOR
--		do
--			-- check current class
--			create l_assign_visitor
--			if l_assign_visitor.has_class_feature_with_an_assigner (a_feature_name, a_class_c) then
--				-- add feature names of assigner calls
--				parent_feature_names.append (l_assign_visitor.get_feature_names)
--			end

--			-- collect assigner features of all parents
--			from
--				i := 1
--				nb := a_class_c.parents_classes.count
--			until
--				i > nb
--			loop
--				-- get parent class
--				l_class_c := a_class_c.parents_classes.i_th (i)

--				-- get renamings of parent
--				if l_assign_visitor.has_renamed_assigner_name (l_class_c.name_in_upper) then
--					l_old_assigner_name := l_assign_visitor.get_old_renamed_assigner_name (l_class_c.name_in_upper)
--				else
--					l_old_assigner_name := an_assigner_name
--				end

--				-- visit the parent
--				collect_assigner_features (l_old_assigner_name, l_class_c)
--				i := i + 1
--			end
--		end

feature {NONE} -- Implementation

--	parent_feature_names: LINKED_LIST [STRING]
			-- List of feature names of parents which have an assigner.

--	original_feature_name, feature_name, assigner_name: STRING
			-- Current feature name f and assigner name q.

--	last_assigner_name: STRING
			-- Feature name of visited assigner.

	new_feature_name: STRING
			-- New feature name for redefine statement

	string_context: ROUNDTRIP_STRING_LIST_CONTEXT
			-- Reference to the current string context.

end
