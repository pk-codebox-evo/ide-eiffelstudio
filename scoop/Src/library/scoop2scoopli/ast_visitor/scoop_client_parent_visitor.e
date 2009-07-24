indexing
	description: "Summary description for {SCOOP_CLIENT_PARENT_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_CLIENT_PARENT_VISITOR

inherit
	SCOOP_CONTEXT_AST_PRINTER
		redefine
			process_parent_list_as,
			process_parent_as
		end
	SCOOP_BASIC_TYPE

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

	process_internal_conforming_parents(l_as: PARENT_LIST_AS) is
			-- Process `l_as'.
		do
			if l_as /= Void then
				context.add_string ("%N%Ninherit%N%T")
				safe_process (l_as)
			else
				if not is_basic_type (parsed_class.class_name.name.as_upper) then
						-- inherit from 'SCOOP_SEPARATE_CLIENT'.
					context.add_string ("%N%Ninherit%N%TSCOOP_SEPARATE_CLIENT")
				end
			end
		end

	process_non_conforming_parents(l_as: PARENT_LIST_AS) is
			-- Process `l_as'.
		do
			if l_as /= Void then
				context.add_string ("%N%Ninherit {NONE}%N%T")

				-- process parent list
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

	process_parent_as (l_as: PARENT_AS) is
		do
			if l_as.type.class_name.name.as_upper.is_equal ("ANY") then
				process_leading_leaves (l_as.start_position)

					-- Replace `ANY' with `SCOOP_SEPARATE_CLIENT'.
				context.add_string ("%N%T%TSCOOP_SEPARATE_CLIENT")
			else
				safe_process (l_as.type)
			end

			safe_process (l_as.internal_renaming)

			if l_as.internal_exports /= Void then
				safe_process (l_as.internal_exports)
					-- Export all features to `ANY'.
				context.add_string ("%N%T%Texport {ANY} all")
			end

			safe_process (l_as.internal_undefining)
			safe_process (l_as.internal_redefining)
			safe_process (l_as.internal_selecting)
			safe_process (l_as.end_keyword (match_list))
		end

end
