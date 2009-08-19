indexing
	description: "Summary description for {SCOOP_PROXY_ASSIGN_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_PROXY_ASSIGN_VISITOR

inherit
	AST_ROUNDTRIP_ITERATOR
		export
			{NONE} all
		redefine
			process_class_as,
			process_parent_as,
			process_rename_clause_as,
			process_rename_as
		end

	SCOOP_WORKBENCH
		export
			{NONE} all
		end

feature -- Access

	get_renamings (an_original_feature_name: STRING; a_class_c: CLASS_C): like parent_renamings is
			-- Returns a list of Tuples containing the class name and the old name
			-- if the corresponding parent clause renames `an_original_feature_name'.
		require
			an_original_feature_name_not_void: an_original_feature_name /= Void
			a_class_c_not_void: a_class_c /= Void
		do
			-- setup visitor
			setup (a_class_c.ast, match_list_server.item (a_class_c.class_id), false, false)

			original_feature_name := an_original_feature_name
			create parent_renamings.make

			-- process class
			safe_process (a_class_c.ast)

			Result := parent_renamings
		end

feature {NONE} -- Visitor implementation

	process_class_as (l_as: CLASS_AS) is
		do
			-- check renamings of parents
			safe_process (l_as.internal_conforming_parents)
			safe_process (l_as.internal_non_conforming_parents)
		end

	process_parent_as (l_as: PARENT_AS) is
		do
			-- save the current parent name
			current_parent_name := l_as.type.class_name.name

			safe_process (l_as.internal_renaming)
		end

	process_rename_clause_as (l_as: RENAME_CLAUSE_AS) is
			 -- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_rename_as (l_as: RENAME_AS) is
		local
			l_old_name, l_new_name: STRING
			l_feature_name_visitor: SCOOP_FEATURE_NAME_VISITOR
			l_tuple: TUPLE [parent_name: STRING; old_assigner_name: STRING]
		do
			-- get old and new name
			create l_feature_name_visitor.make
			l_feature_name_visitor.setup (parsed_class, match_list, true, true)
			l_feature_name_visitor.process_original_feature_name (l_as.new_name, false)
			l_new_name := l_feature_name_visitor.get_feature_name

			-- test if the current processed assigner is renamed in this parent
			if l_new_name.as_lower.is_equal (original_feature_name) then
				l_feature_name_visitor.process_original_feature_name (l_as.old_name, false)
				l_old_name := l_feature_name_visitor.get_feature_name

				-- insert tuple 'class name', 'old assigner name' in list
				create l_tuple
				l_tuple.parent_name := current_parent_name
				l_tuple.old_assigner_name := l_old_name
				parent_renamings.extend (l_tuple)
			end
		end

feature {NONE} -- Implementation

	original_feature_name: STRING
			-- Name of the feature name we want to find

	current_parent_name: STRING
			-- Current processed parent (in `parent_as')

	parent_renamings: LINKED_LIST [TUPLE [parent_name: STRING; old_feature_name: STRING]]
			-- List of parent names which renames `an_original_feature_name'
			-- with associated old assigner name

end
