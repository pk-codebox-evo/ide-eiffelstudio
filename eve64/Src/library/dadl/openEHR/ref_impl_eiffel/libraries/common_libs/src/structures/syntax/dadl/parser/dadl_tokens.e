indexing

	description: "Parser token codes"
	generator: "geyacc version 3.8"

class DADL_TOKENS

inherit

	YY_PARSER_TOKENS

feature -- Last values

	last_any_value: ANY
	last_integer_value: INTEGER
	last_real_value: REAL
	last_pointer_value: POINTER
	last_string_value: STRING
	last_character_value: CHARACTER

feature -- Access

	token_name (a_token: INTEGER): STRING is
			-- Name of token `a_token'
		do
			inspect a_token
			when 0 then
				Result := "EOF token"
			when -1 then
				Result := "Error token"
			when V_INTEGER then
				Result := "V_INTEGER"
			when V_REAL then
				Result := "V_REAL"
			when V_POINTER then
				Result := "V_POINTER"
			when V_TYPE_IDENTIFIER then
				Result := "V_TYPE_IDENTIFIER"
			when V_GENERIC_TYPE_IDENTIFIER then
				Result := "V_GENERIC_TYPE_IDENTIFIER"
			when V_ATTRIBUTE_IDENTIFIER then
				Result := "V_ATTRIBUTE_IDENTIFIER"
			when V_STRING then
				Result := "V_STRING"
			when V_ISO8601_EXTENDED_DATE then
				Result := "V_ISO8601_EXTENDED_DATE"
			when V_ISO8601_EXTENDED_TIME then
				Result := "V_ISO8601_EXTENDED_TIME"
			when V_ISO8601_EXTENDED_DATE_TIME then
				Result := "V_ISO8601_EXTENDED_DATE_TIME"
			when V_ISO8601_DURATION then
				Result := "V_ISO8601_DURATION"
			when V_CADL_BLOCK then
				Result := "V_CADL_BLOCK"
			when V_LOCAL_CODE then
				Result := "V_LOCAL_CODE"
			when V_QUALIFIED_TERM_CODE_REF then
				Result := "V_QUALIFIED_TERM_CODE_REF"
			when V_LOCAL_TERM_CODE_REF then
				Result := "V_LOCAL_TERM_CODE_REF"
			when V_URI then
				Result := "V_URI"
			when V_CHARACTER then
				Result := "V_CHARACTER"
			when SYM_START_DBLOCK then
				Result := "SYM_START_DBLOCK"
			when SYM_END_DBLOCK then
				Result := "SYM_END_DBLOCK"
			when SYM_EQ then
				Result := "SYM_EQ"
			when SYM_ELLIPSIS then
				Result := "SYM_ELLIPSIS"
			when SYM_LIST_CONTINUE then
				Result := "SYM_LIST_CONTINUE"
			when SYM_INFINITY then
				Result := "SYM_INFINITY"
			when SYM_INTERVAL_DELIM then
				Result := "SYM_INTERVAL_DELIM"
			when SYM_DT_UNKNOWN then
				Result := "SYM_DT_UNKNOWN"
			when SYM_QUERY_FUNC then
				Result := "SYM_QUERY_FUNC"
			when SYM_VOID then
				Result := "SYM_VOID"
			when SYM_TRUE then
				Result := "SYM_TRUE"
			when SYM_FALSE then
				Result := "SYM_FALSE"
			when SYM_LT then
				Result := "SYM_LT"
			when SYM_GT then
				Result := "SYM_GT"
			when SYM_LE then
				Result := "SYM_LE"
			when SYM_GE then
				Result := "SYM_GE"
			when ERR_CHARACTER then
				Result := "ERR_CHARACTER"
			when ERR_STRING then
				Result := "ERR_STRING"
			when ERR_V_QUALIFIED_TERM_CODE_REF then
				Result := "ERR_V_QUALIFIED_TERM_CODE_REF"
			when V_PATH then
				Result := "V_PATH"
			else
				Result := yy_character_token_name (a_token)
			end
		end

feature -- Token codes

	V_INTEGER: INTEGER is 258
	V_REAL: INTEGER is 259
	V_POINTER: INTEGER is 260
	V_TYPE_IDENTIFIER: INTEGER is 261
	V_GENERIC_TYPE_IDENTIFIER: INTEGER is 262
	V_ATTRIBUTE_IDENTIFIER: INTEGER is 263
	V_STRING: INTEGER is 264
	V_ISO8601_EXTENDED_DATE: INTEGER is 265
	V_ISO8601_EXTENDED_TIME: INTEGER is 266
	V_ISO8601_EXTENDED_DATE_TIME: INTEGER is 267
	V_ISO8601_DURATION: INTEGER is 268
	V_CADL_BLOCK: INTEGER is 269
	V_LOCAL_CODE: INTEGER is 270
	V_QUALIFIED_TERM_CODE_REF: INTEGER is 271
	V_LOCAL_TERM_CODE_REF: INTEGER is 272
	V_URI: INTEGER is 273
	V_CHARACTER: INTEGER is 274
	SYM_START_DBLOCK: INTEGER is 275
	SYM_END_DBLOCK: INTEGER is 276
	SYM_EQ: INTEGER is 277
	SYM_ELLIPSIS: INTEGER is 278
	SYM_LIST_CONTINUE: INTEGER is 279
	SYM_INFINITY: INTEGER is 280
	SYM_INTERVAL_DELIM: INTEGER is 281
	SYM_DT_UNKNOWN: INTEGER is 282
	SYM_QUERY_FUNC: INTEGER is 283
	SYM_VOID: INTEGER is 284
	SYM_TRUE: INTEGER is 285
	SYM_FALSE: INTEGER is 286
	SYM_LT: INTEGER is 287
	SYM_GT: INTEGER is 288
	SYM_LE: INTEGER is 289
	SYM_GE: INTEGER is 290
	ERR_CHARACTER: INTEGER is 291
	ERR_STRING: INTEGER is 292
	ERR_V_QUALIFIED_TERM_CODE_REF: INTEGER is 293
	V_PATH: INTEGER is 294

end
