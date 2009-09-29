indexing
	description: "Summary description for {SCOOP_EXPLICIT_PROCESSOR_TAG_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_EXPLICIT_PROCESSOR_SPECIFICATION_VISITOR

inherit
	AST_ROUNDTRIP_ITERATOR
		export
			{NONE} all
			{SCOOP_VISITOR_FACTORY} setup
		redefine
			process_class_type_as,
			process_generic_class_type_as,
			process_named_tuple_type_as,
			process_bits_as,
			process_bits_symbol_as,
			process_formal_as,
			process_like_cur_as,
			process_like_id_as,
			process_none_type_as,
			process_explicit_processor_specification_as
		end

feature -- Access

	get_explicit_processor_specification (l_as: TYPE_AS): TUPLE [has_explicit_processor_specification: BOOLEAN; entity_name: STRING; has_handler: BOOLEAN] is
			-- Evaluate `a_type' and return the processor and the handler.
		local
			l_last_index: INTEGER
		do
			-- reset
			has_explicit_processor_specification := false
			has_handler := false
			entity_name := Void

			-- remeber leaf list index
			l_last_index := last_index
			last_index := l_as.start_position

			-- process type as
			safe_process (l_as)

			-- set result
			create Result
			Result.entity_name := entity_name
			Result.has_handler := has_handler

			-- reset leaf list index
			last_index := l_last_index
		end

feature {NONE} -- Visitor implementation: Type nodes

	process_class_type_as (l_as: CLASS_TYPE_AS) is
		do
			safe_process (l_as.explicit_processor_specification)
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS) is
		do
			safe_process (l_as.explicit_processor_specification)
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS) is
		do
			safe_process (l_as.explicit_processor_specification)
		end

	process_bits_as (l_as: BITS_AS) is
		do
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS) is
		do
		end

	process_formal_as (l_as: FORMAL_AS) is
		do
		end

	process_like_cur_as (l_as: LIKE_CUR_AS) is
		do
			-- todo
		end

	process_like_id_as (l_as: LIKE_ID_AS) is
		do
			-- todo
		end

	process_none_type_as (l_as: NONE_TYPE_AS) is
		do
		end

	process_explicit_processor_specification_as (l_as: EXPLICIT_PROCESSOR_SPECIFICATION_AS) is
			-- Process `l_as'.
			-- added for SCOOP by paedde
		do
			has_explicit_processor_specification := true
			safe_process (l_as.entity)
			entity_name := l_as.entity.name
			if l_as.handler /= Void then
				has_handler := true
			end
		end

feature {NONE} -- Implementation

	entity_name: STRING
		-- Return value of current query

	has_handler: BOOLEAN
		-- Return value of current query

	has_explicit_processor_specification: BOOLEAN
		-- Returns true if the explicit processor specification is not void

end
