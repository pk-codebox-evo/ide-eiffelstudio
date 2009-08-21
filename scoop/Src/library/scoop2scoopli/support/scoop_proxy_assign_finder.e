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

	has_current_or_parents_feature_with_assigner (an_original_feature_name: STRING; a_parent_class: CLASS_C): BOOLEAN is
			-- Returns true if some ancestors have a feature with
			-- name `an_original_feature_name' and an assigner.
		do
			Result := has_feature (an_original_feature_name, a_parent_class, true)
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

				i := i + 1
			end
		end

end
