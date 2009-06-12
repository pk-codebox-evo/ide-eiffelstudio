indexing
	description: "Summary description for {SCOOP_FEATURE_NAME_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_FEATURE_NAME_VISITOR

inherit
	AST_ROUNDTRIP_ITERATOR
		redefine
			process_infix_prefix_as,
			process_keyword_as,
			process_feat_name_id_as,
			process_feature_name_alias_as,
			process_id_as,
			process_symbol_as,
			process_bool_as,
			process_char_as,
			process_typed_char_as,
			process_string_as,
			process_verbatim_string_as,
			process_break_as
		end

feature -- Access

	process_feature_name (a_feature_name: FEATURE_NAME): STRING is
			-- Given a FEATURE_NAME node, try to evaluate the feature name.
		require
			a_feature_name_not_void: a_feature_name /= Void
		do
			create feature_name.make_empty
			last_index := a_feature_name.start_position
			safe_process (a_feature_name)
			Result := feature_name
		end

	process_infix_prefix (l_as: INFIX_PREFIX_AS): STRING is
			-- Given a INFIX_PREFIX_AS node, try to evaluate the non infix notation
		require
			l_as_not_void: l_as /= Void
		do
			create feature_name.make_empty
			last_index := l_as.start_position
			safe_process (l_as)
			Result := feature_name
		end

feature {NONE} -- Visitor implementation

	process_keyword_as (l_as: KEYWORD_AS) is
			-- Process `l_as'.
		do
			if l_as.is_prefix_keyword or l_as.is_infix_keyword then
				Precursor (l_as)
				put_string (l_as)
				feature_name.append ("_")
			end
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS) is
		do
			safe_process (l_as.feature_name)
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS) is
		do
			safe_process (l_as.feature_name)
			if l_as.alias_name /= Void then
				safe_process (l_as.alias_name)
				feature_name.append (feature_name + l_as.alias_name.string_value)
			end
		end

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS) is
		do
			safe_process (l_as.infix_prefix_keyword (match_list))
			feature_name.append (non_infix_text (l_as.alias_name.value))
		end

	process_id_as (l_as: ID_AS) is
		do
			feature_name := feature_name + l_as.name
		end


feature {NONE} -- Roundtrip: process leaf

	process_break_as (l_as: BREAK_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_symbol_as (l_as: SYMBOL_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_bool_as (l_as: BOOL_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_char_as (l_as: CHAR_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_typed_char_as (l_as: TYPED_CHAR_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_string_as (l_as: STRING_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end


feature {NONE} -- implementation

	non_infix_text (a_symbol: STRING): STRING is
			-- Literal text of this token
		require
			a_symbol_not_void: a_symbol /= Void
		do
			if a_symbol.is_equal (";") then Result := "te_semicolon"
			elseif a_symbol.is_equal (":") then Result := "te_colon"
			elseif a_symbol.is_equal (",") then Result := "te_comma"
			elseif a_symbol.is_equal ("..") then Result := "te_dotdot"
			elseif a_symbol.is_equal ("?") then Result := "te_question"
			elseif a_symbol.is_equal ("~") then Result := "te_tilde"
			elseif a_symbol.is_equal ("/~") then Result := once "te_not_tilde"
			elseif a_symbol.is_equal ("}~") then Result := once "te_curlytilde"
			elseif a_symbol.is_equal (".") then Result := once "te_dot"
			elseif a_symbol.is_equal ("$") then Result := once "te_address"
			elseif a_symbol.is_equal (":=") then Result := once "te_assignment"
			elseif a_symbol.is_equal ("?=") then Result := once "te_accept"
			elseif a_symbol.is_equal ("=") then Result := once "te_eq"
			elseif a_symbol.is_equal ("<") then Result := once "te_lt"
			elseif a_symbol.is_equal (">") then Result := once "te_gt"
			elseif a_symbol.is_equal ("<=") then Result := once "te_le"
			elseif a_symbol.is_equal (">=") then Result := once "te_ge"
			elseif a_symbol.is_equal ("/=") then Result := once "te_ne"
			elseif a_symbol.is_equal ("(") then Result := once "te_lparan"
			elseif a_symbol.is_equal (")") then Result := once "te_rparan"
			elseif a_symbol.is_equal ("{") then Result := once "te_lcurly"
			elseif a_symbol.is_equal ("}") then Result := once "te_rcurly"
			elseif a_symbol.is_equal ("[") then Result := once "te_lsqure"
			elseif a_symbol.is_equal ("]") then Result := once "te_rsqure"
			elseif a_symbol.is_equal ("+") then Result := once "te_plus"
			elseif a_symbol.is_equal ("-") then Result := once "te_minus"
			elseif a_symbol.is_equal ("*") then Result := once "te_star"
			elseif a_symbol.is_equal ("/") then Result := once "te_slash"
			elseif a_symbol.is_equal ("^") then Result := once "te_power"
			elseif a_symbol.is_equal ("->") then Result := once "te_constrain"
			elseif a_symbol.is_equal ("!") then Result := once "te_bang"
			elseif a_symbol.is_equal ("<<") then Result := once "te_larray"
			elseif a_symbol.is_equal (">>") then Result := once "te_rarray"
			elseif a_symbol.is_equal ("//") then Result := once "te_div"
			elseif a_symbol.is_equal ("\\") then Result := once "te_mod"
			else
				Result := once "te_unknown"
			end
		end

	feature_name: STRING
		-- actual feature name.

	put_string (l_as: LEAF_AS) is
			-- Print text contained in `l_as' into `context'.
		do
			feature_name.append (l_as.text (match_list))
		end

end
