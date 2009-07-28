indexing
	description: "Summary description for {SCOOP_FEATURE_NAME_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_FEATURE_NAME_VISITOR

inherit
	SCOOP_CONTEXT_AST_PRINTER
		rename
			get_context as get_feature_name
		redefine
			process_infix_prefix_as,
			process_keyword_as,
			process_feat_name_id_as
		end

	SCOOP_INFIX_PREFIX

create
	make

feature {NONE} -- Initialization

	make
			-- create visitor with new context
		do
			context := create {ROUNDTRIP_STRING_LIST_CONTEXT}.make
		end

feature -- Access

	process_feature_name (a_feature_name: FEATURE_NAME) is
			-- Given a FEATURE_NAME node, try to evaluate the feature name.
		require
			a_feature_name_not_void: a_feature_name /= Void
		do
			reset_context
			last_index := a_feature_name.start_position
			safe_process (a_feature_name)
		end

	process_infix_prefix (l_as: INFIX_PREFIX_AS) is
			-- Given a INFIX_PREFIX_AS node, try to evaluate the non infix notation
		require
			l_as_not_void: l_as /= Void
		do
			reset_context
			last_index := l_as.start_position
			safe_process (l_as)
		end

feature {NONE} -- Visitor implementation

	process_keyword_as (l_as: KEYWORD_AS) is
			-- Process `l_as'.
		do
			if l_as.is_prefix_keyword or l_as.is_infix_keyword then
				Precursor (l_as)
				context.add_string ("_infix")
			end
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS) is
		do
			-- only process name without frozen keyword
			safe_process (l_as.feature_name)
		end

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS) is
		do
			safe_process (l_as.infix_prefix_keyword (match_list))
			context.add_string (non_infix_text (l_as.alias_name.value))
		end

end
