indexing
	description: "Summary description for {SCOOP_PROXY_TYPE_LOCALS_PRINTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_PROXY_TYPE_LOCALS_PRINTER

inherit
	SCOOP_PROXY_TYPE_VISITOR
		redefine
			process_like_cur_as
		end

create
	make_with_context

feature {NONE} -- Roundtrip: process nodes

	process_like_cur_as (l_as: LIKE_CUR_AS) is
		do
			-- get flags 'is_filter_detachable' and 'is_print_with_prefix'
			evaluate_like_current_type_flags

			-- process lcurly symbol
			safe_process (l_as.lcurly_symbol (match_list))

			-- process attachment mark
			process_attachment_mark (l_as.has_detachable_mark, l_as.attachment_mark_index, l_as.attachment_mark (match_list))

			-- process like keyword
			safe_process (l_as.like_keyword (match_list))

			-- print 'implementation' instead of 'current'
			context.add_string ("implementation_")
			last_index := l_as.current_keyword.end_position

			-- process rcurly symbol
			safe_process (l_as.rcurly_symbol (match_list))
		end

feature {NONE} -- Feature implementation

	evaluate_class_type_flags (is_expanded, is_separate: BOOLEAN) is
			-- the flags are set dependant on the situation
		do
			if is_separate and not is_expanded then
				is_print_with_prefix := true
			else
				is_print_with_prefix := false
			end
			is_filter_detachable := true
		end

	evaluate_generic_class_type_flags (is_expanded, is_separate: BOOLEAN) is
			-- the flags are set dependant on the situation
		do
			if is_separate and not is_expanded then
				is_print_with_prefix := true
			else
				is_print_with_prefix := false
			end
			is_filter_detachable := true
		end

	evaluate_named_tuple_type_flags (is_separate: BOOLEAN) is
			-- the flags are set dependant on the situation
		do
			if is_separate then
				is_print_with_prefix := true
			else
				is_print_with_prefix := false
			end
			is_filter_detachable := true
		end

	evaluate_like_current_type_flags is
			-- the flags are set dependant on the situation
		do
			is_print_with_prefix := true
			is_filter_detachable := true
		end

end
