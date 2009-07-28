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
			process_id_as
		end

	SCOOP_BASIC_TYPE

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
			if l_as.type.class_name.name.as_upper.is_equal ("ANY") then
				process_leading_leaves (l_as.start_position)

					-- Replace `ANY' with `SCOOP_SEPARATE_CLIENT'.
				context.add_string ("%N%T%TSCOOP_SEPARATE_CLIENT")
			else
				context.add_string ("%N%T")
				last_index := l_as.type.start_position - 1
				safe_process (l_as.type)
			end

			safe_process (l_as.internal_renaming)
			safe_process (l_as.internal_exports)
			safe_process (l_as.internal_undefining)
			safe_process (l_as.internal_redefining)
			safe_process (l_as.internal_selecting)

			if l_as.end_keyword_index > 0 then
				context.add_string ("%N%T%T")
			end
			safe_process (l_as.end_keyword (match_list))
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
			last_index := l_as.end_position
		end


end
