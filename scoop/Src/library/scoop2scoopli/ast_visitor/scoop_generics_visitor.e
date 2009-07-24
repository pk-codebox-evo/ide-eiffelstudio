indexing
	description: "Summary description for {SCOOP_GENERICS_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_GENERICS_VISITOR

inherit
	SCOOP_CONTEXT_AST_PRINTER
		redefine
			process_class_type_as,
			process_generic_class_type_as,
			process_named_tuple_type_as
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

feature {NONE} -- Implementation

	is_set_prefix: BOOLEAN
			-- indicates if prefix should be printed or not.

invariant
	invariant_clause: True -- Your invariant here

end
