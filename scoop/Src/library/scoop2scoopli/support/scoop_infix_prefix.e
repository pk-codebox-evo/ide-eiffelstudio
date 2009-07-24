indexing
	description: "Summary description for {SCOOP_INFIX_PREFIX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_INFIX_PREFIX

feature -- infix and prefix text names

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

--	non_infix_text (l_as: SYMBOL_STUB_AS): STRING is
--			-- Literal text of this token
--		require else
--			True
--		do
--			inspect
--				l_as.code
--			 when {EIFFEL_TOKENS}.te_semicolon then Result := once "te_semicolon"	-- ";"
--			 when {EIFFEL_TOKENS}.te_colon then Result := once "te_colon"	-- ":"
--			 when {EIFFEL_TOKENS}.te_comma then Result := once "te_comma"	-- ","
--			 when {EIFFEL_TOKENS}.te_dotdot then Result := once "te_dotdot"	-- ".."
--			 when {EIFFEL_TOKENS}.te_question then Result := once "te_question"	-- "?"
--			 when {EIFFEL_TOKENS}.te_tilde then Result := once "te_tilde"	-- "~"
--			 when {EIFFEL_TOKENS}.te_not_tilde then Result := once "te_not_tilde"	-- "/~"
--			 when {EIFFEL_TOKENS}.te_curlytilde then Result := once "te_curlytilde"	-- "}~"
--			 when {EIFFEL_TOKENS}.te_dot then Result := once "te_dot"	-- "."
--			 when {EIFFEL_TOKENS}.te_address then Result := once "te_address"	-- "$"
--			 when {EIFFEL_TOKENS}.te_assignment then Result := once "te_assignment"	-- ":="
--			 when {EIFFEL_TOKENS}.te_accept then Result := once "te_accept"	-- "?="
--			 when {EIFFEL_TOKENS}.te_eq then Result := once "te_eq"	-- "="
--			 when {EIFFEL_TOKENS}.te_lt then Result := once "te_lt"	-- "<"
-- 			 when {EIFFEL_TOKENS}.te_gt then Result := once "te_gt"	-- ">"
--			 when {EIFFEL_TOKENS}.te_le then Result := once "te_le"	-- "<="
-- 			 when {EIFFEL_TOKENS}.te_ge then Result := once "te_ge"	-- ">="
--			 when {EIFFEL_TOKENS}.te_ne then Result := once "te_ne"	-- "/="
--			 when {EIFFEL_TOKENS}.te_lparan then Result := once "te_lparan"	-- ""	-- "("
--			 when {EIFFEL_TOKENS}.te_rparan then Result := once "te_rparan"	-- ")"
--			 when {EIFFEL_TOKENS}.te_lcurly then Result := once "te_lcurly"	-- "{"
-- 			 when {EIFFEL_TOKENS}.te_rcurly then Result := once "te_rcurly"	-- "}"
--			 when {EIFFEL_TOKENS}.te_lsqure then Result := once "te_lsqure"	-- "["
-- 			 when {EIFFEL_TOKENS}.te_rsqure then Result := once "te_rsqure"	-- "]"
--			 when {EIFFEL_TOKENS}.te_plus then Result := once "te_plus"	-- ""	-- "+"
--			 when {EIFFEL_TOKENS}.te_minus then Result := once "te_minus"	-- "-"
--			 when {EIFFEL_TOKENS}.te_star then Result := once "te_star"	-- "*"
--			 when {EIFFEL_TOKENS}.te_slash then Result := once "te_slash"	-- "/"
--			 when {EIFFEL_TOKENS}.te_power then Result := once "te_power"	-- "^"
--			 when {EIFFEL_TOKENS}.te_constrain then Result := once "te_constrain"	-- "->"
--			 when {EIFFEL_TOKENS}.te_bang then Result := once "te_bang"	-- "!"
--			 when {EIFFEL_TOKENS}.te_larray then Result := once "te_larray"	-- "<<"
--			 when {EIFFEL_TOKENS}.te_rarray then Result := once "te_rarray"	-- ">>"
--			 when {EIFFEL_TOKENS}.te_div then Result := once "te_div"	-- "//"
--			 when {EIFFEL_TOKENS}.te_mod then Result := once "te_mod"	-- "\\"
--			end
--		end

end
