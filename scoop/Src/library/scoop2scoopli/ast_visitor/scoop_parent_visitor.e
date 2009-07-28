indexing
	description: "Summary description for {SCOOP_PARENT_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCOOP_PARENT_VISITOR

inherit
	SCOOP_CONTEXT_AST_PRINTER
		redefine
			process_parent_list_as,
			process_rename_clause_as,
			process_export_clause_as,
			process_undefine_clause_as,
			process_redefine_clause_as,
			process_select_clause_as,
			process_export_item_as,
			process_rename_as
		end

feature -- Initialisation

	make_with_context(a_context: ROUNDTRIP_CONTEXT)
			-- Initialise and reset flags
		require
			a_context_not_void: a_context /= Void
		do
			context := a_context
		end

feature -- Access

	process_internal_conforming_parents(l_as: PARENT_LIST_AS) is
			-- Process `l_as'.
		do
			if l_as /= Void then
				context.add_string ("%N%Ninherit")
				safe_process (l_as)
			end
		end

	process_internal_non_conforming_parents(l_as: PARENT_LIST_AS) is
			-- Process `l_as'
		do
			if l_as /= Void then
				context.add_string ("%N%Ninherit {NONE}")
				safe_process (l_as)
			end
		end

feature {NONE} -- Visitor implementation

	process_parent_list_as (l_as: PARENT_LIST_AS) is
			-- Process `l_as'.
		do
			last_index := l_as.start_position - 1
			process_eiffel_list (l_as)
		end

	process_rename_clause_as (l_as: RENAME_CLAUSE_AS) is
			-- Process `l_as'.
		do
			last_index := l_as.start_position
			context.add_string ("%N%T%T")
			Precursor (l_as)
		end

	process_export_clause_as (l_as: EXPORT_CLAUSE_AS) is
			-- Process `l_as'.
		do
			last_index := l_as.start_position
			context.add_string ("%N%T%T")
			Precursor (l_as)
		end

	process_undefine_clause_as (l_as: UNDEFINE_CLAUSE_AS) is
			-- Process `l_as'.
		do
			last_index := l_as.start_position
			context.add_string ("%N%T%T")
			Precursor (l_as)
		end

	process_redefine_clause_as (l_as: REDEFINE_CLAUSE_AS) is
			-- Process `l_as'.
		do
			last_index := l_as.start_position
			context.add_string ("%N%T%T")
			Precursor (l_as)
		end

	process_select_clause_as (l_as: SELECT_CLAUSE_AS) is
			-- Process `l_as'.
		do
			last_index := l_as.start_position
			context.add_string ("%N%T%T")
			Precursor (l_as)
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS) is
		do
			is_process_export_clause := true
			safe_process (l_as.clients)
			is_process_export_clause := false
			safe_process (l_as.features)
		end

	process_rename_as (l_as: RENAME_AS) is
		do
			safe_process (l_as.old_name)
			context.add_string (" ")
			safe_process (l_as.as_keyword (match_list))
			safe_process (l_as.new_name)
		end

feature {NONE} -- Implementation

	is_process_export_clause: BOOLEAN
		-- indicates that the internal exports are processed.

end
