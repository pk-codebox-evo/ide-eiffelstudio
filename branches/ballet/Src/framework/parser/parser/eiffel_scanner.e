indexing

	description: "Scanners for Eiffel parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_SCANNER

inherit
	EIFFEL_SCANNER_SKELETON

	STRING_HANDLER

create
	make


feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= PRAGMA)
		end

feature {NONE} -- Implementation

	yy_build_tables is
			-- Build scanner tables.
		do
			yy_nxt := yy_nxt_template
			yy_chk := yy_chk_template
			yy_base := yy_base_template
			yy_def := yy_def_template
			yy_ec := yy_ec_template
			yy_meta := yy_meta_template
			yy_accept := yy_accept_template
			yy_acclist := yy_acclist_template
		end

	yy_execute_action (yy_act: INTEGER) is
			-- Execute semantic action.
		do
if yy_act <= 107 then
if yy_act <= 54 then
if yy_act <= 27 then
if yy_act <= 14 then
if yy_act <= 7 then
if yy_act <= 4 then
if yy_act <= 2 then
if yy_act = 1 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 40 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 40")
end
 ast_factory.create_break_as (Current)  
else
	yy_end := yy_end - 2
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 42 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 42")
end
 
				last_break_as_start_position := position
				last_break_as_start_line := line
				last_break_as_start_column := column
				ast_factory.set_buffer (token_buffer2, Current)
				set_start_condition (PRAGMA)					
		
end
else
if yy_act = 3 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 51 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 51")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				last_line_pragma := ast_factory.new_line_pragma (Current)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 56 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 56")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
			
end
end
else
if yy_act <= 6 then
if yy_act = 5 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 60 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 60")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 64 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 64")
end

			less (0)
			ast_factory.create_break_as_with_data (token_buffer2, 
																last_break_as_start_line, 
																last_break_as_start_column, 
																last_break_as_start_position, 
																token_buffer2.count)
			set_start_condition (INITIAL)						
		
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 86 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 86")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SEMICOLON, Current)
				last_token := TE_SEMICOLON
			
end
end
else
if yy_act <= 11 then
if yy_act <= 9 then
if yy_act = 8 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 90 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 90")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_COLON, Current)
				last_token := TE_COLON
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 94 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 94")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_COMMA, Current)
				last_token := TE_COMMA
			
end
else
if yy_act = 10 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 98 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 98")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOTDOT, Current)
				last_token := TE_DOTDOT
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 102 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 102")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_QUESTION, Current)
				last_token := TE_QUESTION
			
end
end
else
if yy_act <= 13 then
if yy_act = 12 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 106 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 106")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_TILDE, Current)
				last_token := TE_TILDE
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 110 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 110")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_CURLYTILDE, Current)
				last_token := TE_CURLYTILDE
			
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 114 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 114")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOT, Current)
				last_token := TE_DOT
			
end
end
end
else
if yy_act <= 21 then
if yy_act <= 18 then
if yy_act <= 16 then
if yy_act = 15 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 118 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 118")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ADDRESS, Current)
				last_token := TE_ADDRESS
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 122 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 122")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_ASSIGNMENT, Current)
				last_token := TE_ASSIGNMENT
			
end
else
if yy_act = 17 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 126 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 126")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ACCEPT, Current)
				last_token := TE_ACCEPT
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 130 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 130")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_EQ, Current)
				last_token := TE_EQ
			
end
end
else
if yy_act <= 20 then
if yy_act = 19 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 134 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 134")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LT, Current)
				last_token := TE_LT
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 138 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 138")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_GT, Current)
				last_token := TE_GT
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 142 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 142")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LE, Current)
				last_token := TE_LE
			
end
end
else
if yy_act <= 24 then
if yy_act <= 23 then
if yy_act = 22 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 146 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 146")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_GE, Current)
				last_token := TE_GE
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 150 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 150")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_NE, Current)
				last_token := TE_NE
			
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 154 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 154")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LPARAN, Current)
				last_token := TE_LPARAN
			
end
else
if yy_act <= 26 then
if yy_act = 25 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 158 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 158")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_RPARAN, Current)
				last_token := TE_RPARAN
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 162 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 162")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LCURLY, Current)
				last_token := TE_LCURLY
			
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 166 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 166")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RCURLY, Current)
				last_token := TE_RCURLY
			
end
end
end
end
else
if yy_act <= 41 then
if yy_act <= 34 then
if yy_act <= 31 then
if yy_act <= 29 then
if yy_act = 28 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 170 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 170")
end
				
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_LSQURE, Current)
				last_token := TE_LSQURE
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 174 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 174")
end
				
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_RSQURE, Current)
				last_token := TE_RSQURE
			
end
else
if yy_act = 30 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 178 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 178")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_PLUS, Current)
				last_token := TE_PLUS
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 182 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 182")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MINUS, Current)
				last_token := TE_MINUS
			
end
end
else
if yy_act <= 33 then
if yy_act = 32 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 186 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 186")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_STAR, Current)
				last_token := TE_STAR
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 190 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 190")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SLASH, Current)
				last_token := TE_SLASH
			
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 194 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 194")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_POWER, Current)
				last_token := TE_POWER
			
end
end
else
if yy_act <= 38 then
if yy_act <= 36 then
if yy_act = 35 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 198 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 198")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_CONSTRAIN, Current)
				last_token := TE_CONSTRAIN
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 202 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 202")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_BANG, Current)
				last_token := TE_BANG
			
end
else
if yy_act = 37 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 206 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 206")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LARRAY, Current)
				last_token := TE_LARRAY
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 210 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 210")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RARRAY, Current)
				last_token := TE_RARRAY
			
end
end
else
if yy_act <= 40 then
if yy_act = 39 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 214 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 214")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DIV, Current)
				last_token := TE_DIV
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 218 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 218")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MOD, Current)
				last_token := TE_MOD
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 226 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 226")
end

				last_token := TE_FREE
				process_id_as
			
end
end
end
else
if yy_act <= 48 then
if yy_act <= 45 then
if yy_act <= 43 then
if yy_act = 42 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 234 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 234")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 238 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 238")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
end
else
if yy_act = 44 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 242 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 242")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 246 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 246")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
end
end
else
if yy_act <= 47 then
if yy_act = 46 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 250 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 250")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 254 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 254")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ASSIGN, Current)
				if last_keyword_as_value /= Void then
					last_keyword_as_id_index := last_keyword_as_value.index
				end
				last_token := TE_ASSIGN
			
end
else
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 261 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 261")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of `attribute', possibly a new keyword in future definition of `Eiffel'."))
				end
			
end
end
else
if yy_act <= 51 then
if yy_act <= 50 then
if yy_act = 49 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 270 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 270")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_BIT, Current)
				last_token := TE_BIT
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "The `bit' keyword will be removed in the future according to ECMA Eiffel and should not be used."))
				end
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 279 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 279")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
end
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 283 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 283")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
end
else
if yy_act <= 53 then
if yy_act = 52 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 287 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 287")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 291 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 291")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
end
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 295 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 295")
end
				
				last_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION				
			
end
end
end
end
end
else
if yy_act <= 81 then
if yy_act <= 68 then
if yy_act <= 61 then
if yy_act <= 58 then
if yy_act <= 56 then
if yy_act = 55 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 299 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 299")
end
				
				last_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 303 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 303")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
end
else
if yy_act = 57 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 307 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 307")
end
				
				last_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED			
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 311 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 311")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
end
end
else
if yy_act <= 60 then
if yy_act = 59 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 315 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 315")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 319 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 319")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
end
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 323 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 323")
end
				
				last_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
end
end
else
if yy_act <= 65 then
if yy_act <= 63 then
if yy_act = 62 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 327 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 327")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 331 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 331")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
end
else
if yy_act = 64 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 335 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 335")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 339 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 339")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
end
end
else
if yy_act <= 67 then
if yy_act = 66 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 343 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 343")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 347 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 347")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 351 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 351")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
end
end
end
else
if yy_act <= 75 then
if yy_act <= 72 then
if yy_act <= 70 then
if yy_act = 69 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 355 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 355")
end
				
				last_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 359 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 359")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
end
else
if yy_act = 71 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 363 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 363")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 367 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 367")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INDEXING, Current)
				last_token := TE_INDEXING
			
end
end
else
if yy_act <= 74 then
if yy_act = 73 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 371 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 371")
end
				
				last_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
				last_token := TE_INFIX
			
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 375 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 375")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
end
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 379 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 379")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
end
end
else
if yy_act <= 78 then
if yy_act <= 77 then
if yy_act = 76 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 383 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 383")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 387 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 387")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IS, Current)
				last_token := TE_IS
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 391 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 391")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
end
else
if yy_act <= 80 then
if yy_act = 79 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 395 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 395")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 399 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 399")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
end
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 403 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 403")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_MODIFY, Current)
				last_token := TE_MODIFY
			
end
end
end
end
else
if yy_act <= 94 then
if yy_act <= 88 then
if yy_act <= 85 then
if yy_act <= 83 then
if yy_act = 82 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 407 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 407")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 411 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 411")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of `note', possibly a new keyword in future definition of `Eiffel'."))
				end
			
end
else
if yy_act = 84 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 420 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 420")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 424 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 424")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
end
end
else
if yy_act <= 87 then
if yy_act = 86 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 440 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 440")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text,  line, column, position, 4)
				last_token := TE_ONCE_STRING
			
else
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 444 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 444")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text_substring (1, 4),  line, column, position, 4)
					-- Assume all trailing characters are in the same line (which would be false if '\n' appears).
				ast_factory.create_break_as_with_data (text_substring (5, text_count), line, column + 4, position + 4, text_count - 4)
				last_token := TE_ONCE_STRING			
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 451 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 451")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
end
end
else
if yy_act <= 91 then
if yy_act <= 90 then
if yy_act = 89 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 455 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 455")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of `only', possibly a new keyword in future definition of `Eiffel'."))
				end
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 464 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 464")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
end
else
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 468 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 468")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
end
else
if yy_act <= 93 then
if yy_act = 92 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 472 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 472")
end
				
				last_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 476 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 476")
end
				
				last_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
				last_token := TE_PREFIX
			
end
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 480 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 480")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
end
end
end
else
if yy_act <= 101 then
if yy_act <= 98 then
if yy_act <= 96 then
if yy_act = 95 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 484 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 484")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 488 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 488")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
end
else
if yy_act = 97 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 492 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 492")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 496 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 496")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
end
end
else
if yy_act <= 100 then
if yy_act = 99 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 500 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 500")
end
					
				last_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 504 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 504")
end
				
				last_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
end
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 508 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 508")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
end
end
else
if yy_act <= 104 then
if yy_act <= 103 then
if yy_act = 102 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 512 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 512")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 516 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 516")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 520 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 520")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
end
else
if yy_act <= 106 then
if yy_act = 105 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 524 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 524")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 528 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 528")
end

				last_token := TE_TUPLE
				process_id_as
			
end
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 532 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 532")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
end
end
end
end
end
end
else
if yy_act <= 161 then
if yy_act <= 134 then
if yy_act <= 121 then
if yy_act <= 114 then
if yy_act <= 111 then
if yy_act <= 109 then
if yy_act = 108 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 536 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 536")
end
				
				last_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 540 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 540")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
end
else
if yy_act = 110 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 544 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 544")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_USE, Current)
				last_token := TE_USE
			
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 548 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 548")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
end
end
else
if yy_act <= 113 then
if yy_act = 112 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 552 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 552")
end
				
				last_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 556 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 556")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
end
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 560 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 560")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
end
end
else
if yy_act <= 118 then
if yy_act <= 116 then
if yy_act = 115 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 568 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 568")
end

				last_token := TE_ID
				process_id_as
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 575 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 575")
end

				last_token := TE_A_BIT			
				last_id_as_value := ast_factory.new_filled_bit_id_as (Current)

				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of bit syntax will be removed in the future according to ECMA Eiffel and should not be used."))
				end
			
end
else
if yy_act = 117 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 589 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 589")
end
		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when' `1.' `.2' `then'
					-- instead of:
					--     `when' `1' `..' `2' `then'

				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
else
	yy_end := yy_end - 2
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 590 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 590")
end
		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when' `1.' `.2' `then'
					-- instead of:
					--     `when' `1' `..' `2' `then'

				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
end
end
else
if yy_act <= 120 then
if yy_act = 119 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 602 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 602")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 608 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 608")
end
		-- Recognizes octal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 614 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 614")
end
		-- Recognizes binary integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
end
end
end
else
if yy_act <= 128 then
if yy_act <= 125 then
if yy_act <= 123 then
if yy_act = 122 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 620 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 620")
end
		-- Recognizes erronous binary and octal numbers.
				report_invalid_integer_error (token_buffer)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 627 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 627")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				last_token := TE_REAL
			
end
else
if yy_act = 124 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 637 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 637")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 643 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 643")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
end
end
else
if yy_act <= 127 then
if yy_act = 126 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 650 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 650")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 656 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 656")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 662 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 662")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
end
else
if yy_act <= 131 then
if yy_act <= 130 then
if yy_act = 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 668 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 668")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 674 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 674")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 680 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 680")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
if yy_act <= 133 then
if yy_act = 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 686 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 686")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 692 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 692")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 698 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 698")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
end
end
end
else
if yy_act <= 148 then
if yy_act <= 141 then
if yy_act <= 138 then
if yy_act <= 136 then
if yy_act = 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 704 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 704")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 710 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 710")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
if yy_act = 137 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 716 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 716")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 722 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 722")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
end
else
if yy_act <= 140 then
if yy_act = 139 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 728 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 728")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 734 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 734")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 740 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 740")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
end
else
if yy_act <= 145 then
if yy_act <= 143 then
if yy_act = 142 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 746 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 746")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 752 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 752")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
if yy_act = 144 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 758 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 758")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 764 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 764")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
end
else
if yy_act <= 147 then
if yy_act = 146 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 770 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 770")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 776 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 776")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 777 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 777")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
end
end
else
if yy_act <= 155 then
if yy_act <= 152 then
if yy_act <= 150 then
if yy_act = 149 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 778 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 778")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 779 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 779")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
if yy_act = 151 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 786 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 786")
end

				report_invalid_integer_error (token_buffer)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 791 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 791")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
end
end
else
if yy_act <= 154 then
if yy_act = 153 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 792 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 792")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 801 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 801")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LT
			
end
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 805 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 805")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GT
			
end
end
else
if yy_act <= 158 then
if yy_act <= 157 then
if yy_act = 156 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 809 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 809")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LE
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 813 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 813")
end
			
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GE
			
end
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 817 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 817")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_PLUS
			
end
else
if yy_act <= 160 then
if yy_act = 159 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 821 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 821")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MINUS
			
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 825 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 825")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_STAR
			
end
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 829 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 829")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_SLASH
			
end
end
end
end
end
else
if yy_act <= 188 then
if yy_act <= 175 then
if yy_act <= 168 then
if yy_act <= 165 then
if yy_act <= 163 then
if yy_act = 162 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 833 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 833")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_POWER
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 837 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 837")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_DIV
			
end
else
if yy_act = 164 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 841 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 841")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MOD
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 845 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 845")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_BRACKET
			
end
end
else
if yy_act <= 167 then
if yy_act = 166 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 849 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 849")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND
			
else
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 855 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 855")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND_THEN
			
end
else
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 861 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 861")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_IMPLIES
			
end
end
else
if yy_act <= 172 then
if yy_act <= 170 then
if yy_act = 169 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 867 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 867")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_NOT
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 873 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 873")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR
			
end
else
if yy_act = 171 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 879 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 879")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR_ELSE
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 885 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 885")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_XOR
			
end
end
else
if yy_act <= 174 then
if yy_act = 173 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 891 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 891")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 900 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 900")
end

					-- Empty string.
				ast_factory.set_buffer (token_buffer2, Current)
				string_position := position
				last_token := TE_EMPTY_STRING
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 906 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 906")
end

					-- Regular string.
				string_position := position
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STRING
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
end
end
end
else
if yy_act <= 182 then
if yy_act <= 179 then
if yy_act <= 177 then
if yy_act = 176 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 917 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 917")
end

					-- Verbatim string.
				string_position := position
				verbatim_start_position := position
				token_buffer.clear_all
				verbatim_marker.clear_all
				if text_item (text_count) = '[' then
					verbatim_marker.append_character (']')
				else
					verbatim_marker.append_character ('}')
				end
				ast_factory.set_buffer (token_buffer2, Current)				
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				set_start_condition (VERBATIM_STR3)
			
else
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 935 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 935")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (VERBATIM_STR1)
			
end
else
if yy_act = 178 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 939 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 939")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 959 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 959")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				if is_verbatim_string_closer then
					set_start_condition (INITIAL)
						-- Remove the trailing new-line.
					if token_buffer.count >= 2 then
						check new_line: token_buffer.item (token_buffer.count) = '%N' end
						if token_buffer.item (token_buffer.count - 1) = '%R' then
								-- Under Windows a we have \r\n.
								-- Remove both characters.
							token_buffer.set_count (token_buffer.count - 2)
						else
							token_buffer.set_count (token_buffer.count - 1)
						end
					elseif token_buffer.count = 1 then
						check new_line: token_buffer.item (1) = '%N' end
						token_buffer.clear_all
					end
					if verbatim_marker.item (1) = ']' then
						if not has_old_verbatim_strings then
							align_left (token_buffer)
						end
						if has_old_verbatim_strings_warning then
							Error_handler.insert_warning (
								create {SYNTAX_WARNING}.make (line, column, filename,
									once "Default verbatim string handling is changed to follow standard semantics %
									%with alignment instead of previous non-standard one without alignment."))
						end
					end
					if token_buffer.is_empty then
							-- Empty string.
						last_token := TE_EMPTY_VERBATIM_STRING
					else
						last_token := TE_VERBATIM_STRING
						if token_buffer.count > maximum_string_length then
							report_too_long_string (token_buffer)
						end
					end
				else
					append_text_to_string (token_buffer)
					set_start_condition (VERBATIM_STR2)
				end
			
end
end
else
if yy_act <= 181 then
if yy_act = 180 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1002 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1002")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
else
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1007 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1007")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1015 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1015")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
end
end
else
if yy_act <= 185 then
if yy_act <= 184 then
if yy_act = 183 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1031 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1031")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1040 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1040")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1053 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1053")
end

					-- String with special characters.
				ast_factory.set_buffer (token_buffer2, Current)
				string_position := position
				string_start_position := position
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				set_start_condition (SPECIAL_STR)
			
end
else
if yy_act <= 187 then
if yy_act = 186 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1065 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1065")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1069 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1069")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%A")
				token_buffer.append_character ('%A')
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1073 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1073")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%B")
				token_buffer.append_character ('%B')
			
end
end
end
end
else
if yy_act <= 201 then
if yy_act <= 195 then
if yy_act <= 192 then
if yy_act <= 190 then
if yy_act = 189 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1077 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1077")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%C")
				token_buffer.append_character ('%C')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1081 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1081")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%D")
				token_buffer.append_character ('%D')
			
end
else
if yy_act = 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1085 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1085")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%F")
				token_buffer.append_character ('%F')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1089 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1089")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%H")
				token_buffer.append_character ('%H')
			
end
end
else
if yy_act <= 194 then
if yy_act = 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1093 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1093")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%L")
				token_buffer.append_character ('%L')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1097 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1097")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%N")
				token_buffer.append_character ('%N')
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1101 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1101")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%Q")
				token_buffer.append_character ('%Q')
			
end
end
else
if yy_act <= 198 then
if yy_act <= 197 then
if yy_act = 196 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1105 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1105")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%R")
				token_buffer.append_character ('%R')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1109 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1109")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%S")
				token_buffer.append_character ('%S')
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1113 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1113")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%T")
				token_buffer.append_character ('%T')
			
end
else
if yy_act <= 200 then
if yy_act = 199 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1117 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1117")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%U")
				token_buffer.append_character ('%U')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1121 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1121")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%V")
				token_buffer.append_character ('%V')
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1125 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1125")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%%")
				token_buffer.append_character ('%%')
			
end
end
end
else
if yy_act <= 208 then
if yy_act <= 205 then
if yy_act <= 203 then
if yy_act = 202 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1129 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1129")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%'")
				token_buffer.append_character ('%'')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1133 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1133")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%"")
				token_buffer.append_character ('%"')
			
end
else
if yy_act = 204 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1137 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1137")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%(")
				token_buffer.append_character ('%(')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1141 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1141")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%)")
				token_buffer.append_character ('%)')
			
end
end
else
if yy_act <= 207 then
if yy_act = 206 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1145 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1145")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%<")
				token_buffer.append_character ('%<')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1149 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1149")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%>")
				token_buffer.append_character ('%>')
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1153 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1153")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
end
end
else
if yy_act <= 211 then
if yy_act <= 210 then
if yy_act = 209 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1157 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1157")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			ast_factory.append_text_to_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1162 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1162")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				if text_count > 1 then
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				set_start_condition (INITIAL)
				if token_buffer.is_empty then
						-- Empty string.
					last_token := TE_EMPTY_STRING
				else
					last_token := TE_STRING
					if token_buffer.count > maximum_string_length then
						report_too_long_string (token_buffer)
					end
				end
			
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1178 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1178")
end

					-- Bad special character.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
end
else
if yy_act <= 213 then
if yy_act = 212 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line 1184 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1184")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1202 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1202")
end

				report_unknown_token_error (text_item (1))
			
end
else
yy_set_line_column
	yy_position := yy_position + 1
--|#line 0 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 0")
end
last_token := yyError_token
fatal_error ("scanner jammed")
end
end
end
end
end
end
end
		end

	yy_execute_eof_action (yy_sc: INTEGER) is
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0 then
--|#line 0 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 0")
end

				terminate
			
when 1 then
--|#line 0 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 0")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 2 then
--|#line 0 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 0")
end

					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 3 then
--|#line 0 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 0")
end

					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 4 then
--|#line 0 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 0")
end

					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 5 then
--|#line 0 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 0")
end
					
			ast_factory.create_break_as_with_data (token_buffer2, 
																last_break_as_start_line, 
																last_break_as_start_column, 
																last_break_as_start_position, 
																token_buffer2.count)
			set_start_condition (INITIAL)
			
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   14,   15,   16,   15,   17,   18,   19,   20,   14,
			   19,   21,   22,   23,   24,   25,   26,   27,   28,   29,
			   30,   31,   32,   32,   33,   34,   35,   36,   37,   38,
			   19,   39,   40,   41,   42,   43,   44,   45,   45,   46,
			   45,   45,   47,   48,   49,   50,   51,   45,   52,   53,
			   54,   55,   56,   57,   58,   45,   45,   59,   60,   61,
			   62,   14,   14,   39,   40,   41,   42,   43,   44,   45,
			   45,   46,   45,   45,   47,   48,   49,   50,   51,   45,
			   52,   53,   54,   55,   56,   57,   58,   45,   45,   63,
			   19,   64,   65,   67,   67,  578,   68,   68,  109,   69,

			   69,   71,   72,   71,  617,   73,   71,   72,   71,  110,
			   73,   78,   79,   78,   78,   79,   78,   81,   82,   81,
			   81,   82,   81,   84,   84,   84,   84,   84,   84,  107,
			  135,  108,   83,  124,  125,   83,  126,  127,   85,  113,
			  111,   85,  112,  112,  112,  112,  115,  114,  116,  116,
			  117,  117,  155,  153,  156,  163,  141,  662,   74,  154,
			  118,  119,  135,   74,  616,  115,  142,  116,  116,  117,
			  117,  173,  115,  574,  117,  117,  117,  117,  203,  122,
			  174,  204,  120,  615,  155,  153,  156,  163,  141,  121,
			   74,  154,  118,  119,  662,   74,   87,   88,  142,   89,

			   88,  269,  269,  173,   90,   91,  217,   92,  121,   93,
			  164,  122,  174,  614,  120,  121,   94,  610,   95,  130,
			   88,   96,  493,  136,  131,  165,  132,  137,  161,   97,
			  138,  133,  134,  139,   98,   99,  140,  143,  217,  144,
			  171,  169,  164,  567,  100,  162,  170,  101,  102,  145,
			  103,  130,  445,   96,  172,  136,  131,  165,  132,  137,
			  161,   97,  138,  133,  134,  139,   98,   99,  140,  143,
			  146,  144,  171,  169,  147,  149,  100,  162,  170,  104,
			   88,  145,  150,  151,  157,  166,  172,  148,  152,  203,
			  520,  520,  207,  275,  158,  167,  159,  278,  168,  279,

			  160,  552,  146,  210,  211,  210,  147,  149,  519,  205,
			  203,  205,  515,  204,  150,  151,  157,  166,  573,  148,
			  152,  212,  212,  212,  280,  275,  158,  167,  159,  278,
			  168,  279,  160,  179,  179,  179,  214,  180,  218,   89,
			  181,   89,  182,  183,  184,  212,  212,  212,  219,  220,
			  185,   89,   89,   84,   84,   84,  280,  186,  203,  187,
			  574,  204,  188,  189,  190,  191,  206,  192,   85,  193,
			  281,  221,  264,  194,   89,  195,  385,  383,  196,  197,
			  198,  199,  200,  201,  222,   86,   86,  104,   86,  104,
			  215,  223,  225,   89,   89,   89,  282,  283,  206,  104,

			  104,  214,  281,  447,   89,  214,  214,  214,   89,   89,
			   89,  214,  224,  226,   89,  214,  284,  236,   89,  104,
			   89,  104,  104,  232,  233,  232,  385,  214,  282,  283,
			   89,  104,  104,  285,  262,  262,  262,  262,  286,  227,
			  383,  216,  104,  104,  228,  229,  372,  230,  284,  263,
			  231,  287,  104,  289,  104,  288,  104,  104,  104,  271,
			  271,  271,  104,  371,  370,  285,  104,  235,  104,  276,
			  286,  227,  277,  216,  104,  104,  228,  229,  104,  230,
			  234,  263,  231,  287,  104,  289,  294,  288,  104,  104,
			  104,  210,  211,  210,  104,  232,  233,  232,  104,  214,

			  104,  276,   89,  264,  277,  265,  265,  265,  265,  295,
			  104,  115,  296,  267,  267,  268,  268,  290,  294,  115,
			  266,  268,  268,  268,  268,  122,  273,  273,  273,  273,
			  369,  297,  291,  292,  303,  368,  304,  293,  306,  307,
			  308,  295,  309,  312,  296,  313,  310,  322,  305,  290,
			  104,  367,  266,  323,  121,  311,  577,  122,  366,  324,
			  325,  329,  121,  297,  291,  292,  303,  274,  304,  293,
			  306,  307,  308,  203,  309,  312,  207,  313,  310,  322,
			  305,  365,  104,  239,  364,  323,  240,  311,  241,  242,
			  243,  324,  325,  329,  269,  269,  244,  363,  578,  330,

			  362,  331,  298,  245,  299,  246,  300,  332,  247,  248,
			  249,  250,  320,  251,  361,  252,  321,  301,  333,  253,
			  302,  254,  269,  269,  255,  256,  257,  258,  259,  260,
			  314,  330,  315,  331,  298,  382,  299,  326,  300,  332,
			  316,  360,  327,  317,  320,  318,  319,  359,  321,  301,
			  333,  358,  302,  328,  179,  179,  179,  335,  335,  335,
			  335,  334,  314,  382,  315,  357,  205,  203,  205,  326,
			  204,  354,  316,  339,  327,  317,   89,  318,  319,  212,
			  212,  212,  338,  233,  338,  328,   86,  232,  233,  232,
			  340,  215,  341,   89,   89,   89,  214,  214,  389,   89,

			   89,  214,  353,  348,   89,  345,   89,  346,  214,  352,
			   89,   89,  232,  233,  232,  349,  214,  390,   89,   89,
			  351,  391,  350,  206,  104,  342,  355,  356,  356,  356,
			  389,  373,  373,  373,  373,  337,  343,  217,  392,  393,
			  394,  104,  216,  104,  209,  344,  263,  104,  104,  390,
			  347,  395,  104,  391,  104,  206,  104,  342,  104,  104,
			  178,  376,  376,  376,  376,  396,  104,  104,  343,  217,
			  392,  393,  394,  104,  216,  104,  377,  344,  263,  104,
			  104,  261,  347,  395,  104,  238,  104,  374,  397,  374,
			  104,  104,  375,  375,  375,  375,  109,  396,  104,  104,

			  271,  271,  271,  213,  378,  398,  378,  399,  377,  379,
			  379,  379,  379,  115,  400,  380,  380,  381,  381,  115,
			  397,  381,  381,  381,  381,  401,  386,  122,  387,  387,
			  387,  387,  388,  388,  388,  388,  402,  398,  404,  399,
			  405,  384,  406,  409,  410,  407,  400,  411,  412,  413,
			  403,  414,  415,  416,  417,  418,  121,  401,  408,  122,
			  419,  420,  121,  421,  422,  423,  426,  427,  402,  274,
			  404,  428,  405,  274,  406,  409,  410,  407,  429,  411,
			  412,  413,  403,  414,  415,  416,  417,  418,  424,  430,
			  408,  425,  419,  420,  432,  421,  422,  423,  426,  427,

			  433,  434,  435,  428,  436,  437,  438,  431,  439,  440,
			  429,  441,  442,  443,  444,  445,  446,  446,  446,  446,
			  424,  430,  214,  425,  209,   89,  432,  338,  233,  338,
			  465,  178,  433,  434,  435,  176,  436,  437,  438,  431,
			  439,  440,  466,  441,  442,  443,  444,  448,  451,  449,
			  214,   89,   89,   89,  175,  467,  453,  468,  450,   89,
			  128,  123,  465,  454,  356,  356,  356,  356,  454,  356,
			  356,  356,  356,  104,  466,  662,  455,  456,   76,  452,
			   76,  469,  217,  375,  375,  375,  375,  467,  662,  468,
			  450,  375,  375,  375,  375,  470,  471,  472,  457,  104,

			  104,  104,  662,  473,  474,  104,  662,  104,  455,  456,
			  461,  452,  461,  469,  217,  462,  462,  462,  462,  458,
			  458,  458,  458,  460,  460,  460,  460,  470,  471,  472,
			  457,  104,  104,  104,  263,  473,  474,  662,  377,  104,
			  379,  379,  379,  379,  379,  379,  379,  379,  463,  475,
			  380,  380,  381,  381,  463,  476,  381,  381,  381,  381,
			  459,  477,  122,  478,  479,  662,  263,  480,  481,  386,
			  377,  464,  464,  464,  464,  386,  482,  388,  388,  388,
			  388,  475,  483,  484,  485,  486,  662,  476,  487,  488,
			  489,  274,  490,  477,  122,  478,  479,  274,  491,  480,

			  481,  492,  496,  497,  498,  499,  500,  501,  482,  502,
			  503,  504,  274,  505,  483,  484,  485,  486,  274,  506,
			  487,  488,  489,  507,  490,  493,  493,  493,  508,  494,
			  491,  509,  510,  492,  496,  497,  498,  499,  500,  501,
			  495,  502,  503,  504,  511,  505,  512,  513,  530,  214,
			  214,  506,   89,   89,  214,  507,  531,   89,  662,  532,
			  508,  662,  662,  509,  510,  445,  514,  514,  514,  514,
			  522,  522,  522,  270,  270,  270,  511,  662,  512,  513,
			  530,  662,  535,  517,  458,  458,  458,  458,  531,  662,
			  518,  532,  662,  516,  525,  525,  525,  525,  533,  524,

			  104,  104,  534,  536,  537,  104,  526,  526,  526,  526,
			  462,  462,  462,  462,  535,  517,  462,  462,  462,  462,
			  538,  377,  518,  539,  264,  516,  526,  526,  526,  526,
			  533,  524,  104,  104,  534,  536,  537,  104,  540,  541,
			  529,  528,  388,  388,  388,  388,  542,  527,  543,  544,
			  545,  662,  538,  377,  546,  539,  547,  548,  549,  550,
			  493,  493,  493,  553,  551,  554,  555,  556,  557,  558,
			  540,  541,  559,  528,  560,  495,  561,  562,  542,  563,
			  543,  544,  545,  121,  564,  565,  546,  566,  547,  548,
			  549,  550,  588,  214,  589,  553,   89,  554,  555,  556,

			  557,  558,  214,  662,  559,   89,  560,  214,  561,  562,
			   89,  563,  571,  520,  520,  662,  564,  565,  662,  566,
			  575,  522,  522,  522,  588,  568,  589,  579,  590,  579,
			  662,  569,  580,  580,  580,  580,  581,  581,  581,  581,
			  526,  526,  526,  526,  104,  584,  584,  584,  584,  591,
			  570,  582,  592,  104,  572,  583,  593,  568,  104,  585,
			  590,  585,  576,  569,  586,  586,  586,  586,  594,  264,
			  595,  584,  584,  584,  584,  596,  104,  597,  598,  599,
			  600,  591,  570,  582,  592,  104,  587,  583,  593,  601,
			  104,  602,  603,  604,  605,  606,  607,  608,  609,  627,

			  594,  214,  595,  214,   89,  214,   89,  596,   89,  597,
			  598,  599,  600,  580,  580,  580,  580,  628,  587,  629,
			  662,  601,  662,  602,  603,  604,  605,  606,  607,  608,
			  609,  627,  611,  662,  613,  580,  580,  580,  580,  662,
			  618,  618,  618,  618,  612,  623,  623,  623,  623,  628,
			  630,  629,  104,  631,  104,  582,  104,  632,  633,  634,
			  624,  662,  662,  619,  611,  619,  613,  662,  620,  620,
			  620,  620,  621,  637,  621,  662,  612,  622,  622,  622,
			  622,  638,  630,  639,  104,  631,  104,  582,  104,  632,
			  633,  634,  624,  586,  586,  586,  586,  586,  586,  586,

			  586,  625,  640,  625,  641,  637,  626,  626,  626,  626,
			  635,  635,  635,  638,  214,  639,  643,   89,  644,   89,
			  662,   89,  582,  620,  620,  620,  620,  620,  620,  620,
			  620,  648,  649,  662,  640,  662,  641,  622,  622,  622,
			  622,  636,  622,  622,  622,  622,  662,  662,  459,  272,
			  272,  272,  642,  662,  582,  645,  645,  645,  645,  626,
			  626,  626,  626,  648,  649,  104,  651,  104,  652,  104,
			  624,  653,  646,  636,  646,  662,  655,  647,  647,  647,
			  647,  635,  635,  635,  642,  626,  626,  626,  626,  654,
			  624,  656,   89,  647,  647,  647,  647,  104,  651,  104,

			  652,  104,  624,  653,  647,  647,  647,  647,  655,  657,
			  658,  659,  650,  660,  661,  662,  527,  521,  521,  521,
			  662,  662,  624,  656,  105,  662,  105,  662,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  523,  523,  523,
			  104,  657,  658,  659,  650,  660,  661,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  177,  662,  177,  177,
			  177,  662,  177,  177,  177,  177,  177,  177,  177,  177,
			  177,  662,  104,   66,   66,   66,   66,   66,   66,   66,
			   66,   66,   66,   66,   66,   66,   66,   66,   70,   70,
			   70,   70,   70,   70,   70,   70,   70,   70,   70,   70,

			   70,   70,   70,   75,   75,   75,   75,   75,   75,   75,
			   75,   75,   75,   75,   75,   75,   75,   75,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   86,  662,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,  106,  662,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  202,  202,
			  202,  202,  202,  202,  202,  202,  202,  202,  202,  202,
			  202,  202,  202,  206,  206,  206,  206,  206,  206,  206,

			  206,  206,  206,  206,  206,  206,  206,  206,  208,  208,
			  208,  208,  208,  208,  208,  208,  208,  208,  208,  208,
			  208,  208,  208,   88,  662,   88,   88,   88,   88,   88,
			   88,   88,   88,   88,   88,   88,   88,   88,   89,  662,
			   89,  662,   89,   89,   89,   89,   89,   89,   89,   89,
			   89,   89,   89,  237,  662,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  336,  662,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  552,  552,  552,  552,  552,  552,  552,
			  552,  552,  552,  552,  552,  552,  552,  552,  610,  662,

			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,   13,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,

			  662,  662,  662,  662,  662,  662, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    3,    4,  578,    3,    4,   27,    3,

			    4,    5,    5,    5,  577,    5,    6,    6,    6,   27,
			    6,    9,    9,    9,   10,   10,   10,   11,   11,   11,
			   12,   12,   12,   15,   15,   15,   16,   16,   16,   21,
			   40,   21,   11,   35,   35,   12,   37,   37,   15,   29,
			   28,   16,   28,   28,   28,   28,   30,   29,   30,   30,
			   30,   30,   48,   47,   49,   52,   42,  576,    5,   47,
			   30,   30,   40,    6,  575,   31,   42,   31,   31,   31,
			   31,   57,   32,  574,   32,   32,   32,   32,   70,   31,
			   58,   70,   30,  573,   48,   47,   49,   52,   42,   30,
			    5,   47,   30,   30,  572,    6,   18,   18,   42,   18,

			   18,  118,  118,   57,   18,   18,   89,   18,   31,   18,
			   53,   31,   58,  571,   30,   32,   18,  567,   18,   39,
			   18,   18,  552,   41,   39,   53,   39,   41,   51,   18,
			   41,   39,   39,   41,   18,   18,   41,   43,   89,   43,
			   56,   55,   53,  515,   18,   51,   55,   18,   18,   43,
			   18,   39,  514,   18,   56,   41,   39,   53,   39,   41,
			   51,   18,   41,   39,   39,   41,   18,   18,   41,   43,
			   44,   43,   56,   55,   44,   46,   18,   51,   55,   18,
			   18,   43,   46,   46,   50,   54,   56,   44,   46,   74,
			  455,  455,   74,  130,   50,   54,   50,  132,   54,  133,

			   50,  495,   44,   78,   78,   78,   44,   46,  454,   71,
			   71,   71,  447,   71,   46,   46,   50,   54,  521,   44,
			   46,   81,   81,   81,  134,  130,   50,   54,   50,  132,
			   54,  133,   50,   69,   69,   69,   86,   69,   90,   86,
			   69,   90,   69,   69,   69,   82,   82,   82,   91,   92,
			   69,   91,   92,   84,   84,   84,  134,   69,  202,   69,
			  521,  202,   69,   69,   69,   69,   71,   69,   84,   69,
			  135,   93,  386,   69,   93,   69,  385,  383,   69,   69,
			   69,   69,   69,   69,   93,   88,   88,   86,   88,   90,
			   88,   94,   95,   88,   94,   95,  136,  137,   71,   91,

			   92,   96,  135,  337,   96,   99,   98,   97,   99,   98,
			   97,  100,   94,   95,  100,  102,  138,  103,  102,   86,
			  103,   90,   93,  101,  101,  101,  272,  101,  136,  137,
			  101,   91,   92,  139,  112,  112,  112,  112,  140,   96,
			  270,   88,   94,   95,   97,   98,  260,   99,  138,  112,
			  100,  141,   96,  143,   93,  141,   99,   98,   97,  119,
			  119,  119,  100,  259,  258,  139,  102,  102,  103,  131,
			  140,   96,  131,   88,   94,   95,   97,   98,  101,   99,
			  101,  112,  100,  141,   96,  143,  146,  141,   99,   98,
			   97,  210,  210,  210,  100,  104,  104,  104,  102,  104,

			  103,  131,  104,  115,  131,  115,  115,  115,  115,  147,
			  101,  116,  148,  116,  116,  116,  116,  144,  146,  117,
			  115,  117,  117,  117,  117,  116,  121,  121,  121,  121,
			  257,  150,  144,  145,  153,  256,  154,  145,  155,  156,
			  157,  147,  158,  161,  148,  162,  159,  165,  154,  144,
			  104,  255,  115,  166,  116,  159,  523,  116,  254,  167,
			  168,  170,  117,  150,  144,  145,  153,  121,  154,  145,
			  155,  156,  157,  206,  158,  161,  206,  162,  159,  165,
			  154,  253,  104,  107,  252,  166,  107,  159,  107,  107,
			  107,  167,  168,  170,  269,  269,  107,  251,  523,  171,

			  250,  172,  151,  107,  151,  107,  151,  173,  107,  107,
			  107,  107,  164,  107,  249,  107,  164,  151,  174,  107,
			  151,  107,  382,  382,  107,  107,  107,  107,  107,  107,
			  163,  171,  163,  172,  151,  269,  151,  169,  151,  173,
			  163,  248,  169,  163,  164,  163,  163,  247,  164,  151,
			  174,  246,  151,  169,  179,  179,  179,  185,  185,  185,
			  185,  179,  163,  382,  163,  245,  205,  205,  205,  169,
			  205,  243,  163,  222,  169,  163,  222,  163,  163,  212,
			  212,  212,  217,  217,  217,  169,  216,  216,  216,  216,
			  224,  216,  226,  224,  216,  226,  228,  227,  275,  228,

			  227,  229,  242,  234,  229,  230,  234,  230,  231,  241,
			  230,  231,  232,  232,  232,  235,  232,  276,  235,  232,
			  240,  279,  239,  205,  222,  227,  244,  244,  244,  244,
			  275,  262,  262,  262,  262,  213,  228,  217,  280,  282,
			  283,  224,  216,  226,  208,  229,  262,  228,  227,  276,
			  231,  284,  229,  279,  234,  205,  222,  227,  230,  231,
			  177,  265,  265,  265,  265,  285,  235,  232,  228,  217,
			  280,  282,  283,  224,  216,  226,  265,  229,  262,  228,
			  227,  108,  231,  284,  229,  106,  234,  263,  286,  263,
			  230,  231,  263,  263,  263,  263,   85,  285,  235,  232,

			  271,  271,  271,   83,  266,  287,  266,  288,  265,  266,
			  266,  266,  266,  267,  289,  267,  267,  267,  267,  268,
			  286,  268,  268,  268,  268,  291,  273,  267,  273,  273,
			  273,  273,  274,  274,  274,  274,  292,  287,  293,  288,
			  294,  271,  295,  297,  298,  296,  289,  299,  300,  301,
			  292,  302,  303,  304,  305,  306,  267,  291,  296,  267,
			  307,  308,  268,  310,  311,  312,  314,  315,  292,  273,
			  293,  316,  294,  274,  295,  297,  298,  296,  317,  299,
			  300,  301,  292,  302,  303,  304,  305,  306,  313,  318,
			  296,  313,  307,  308,  319,  310,  311,  312,  314,  315,

			  320,  321,  322,  316,  323,  324,  325,  318,  326,  327,
			  317,  328,  330,  331,  332,  335,  335,  335,  335,  335,
			  313,  318,  343,  313,   75,  343,  319,  338,  338,  338,
			  389,   66,  320,  321,  322,   64,  323,  324,  325,  318,
			  326,  327,  390,  328,  330,  331,  332,  342,  344,  342,
			  345,  344,  342,  345,   60,  391,  347,  392,  343,  347,
			   38,   33,  389,  355,  355,  355,  355,  355,  356,  356,
			  356,  356,  356,  343,  390,   13,  355,  355,    8,  345,
			    7,  393,  338,  374,  374,  374,  374,  391,    0,  392,
			  343,  375,  375,  375,  375,  394,  395,  396,  355,  344,

			  342,  345,    0,  397,  398,  343,    0,  347,  355,  355,
			  377,  345,  377,  393,  338,  377,  377,  377,  377,  373,
			  373,  373,  373,  376,  376,  376,  376,  394,  395,  396,
			  355,  344,  342,  345,  373,  397,  398,    0,  376,  347,
			  378,  378,  378,  378,  379,  379,  379,  379,  380,  399,
			  380,  380,  380,  380,  381,  400,  381,  381,  381,  381,
			  373,  401,  380,  402,  403,    0,  373,  404,  405,  387,
			  376,  387,  387,  387,  387,  388,  406,  388,  388,  388,
			  388,  399,  408,  409,  410,  411,    0,  400,  412,  413,
			  414,  380,  416,  401,  380,  402,  403,  381,  418,  404,

			  405,  420,  423,  424,  425,  426,  427,  428,  406,  429,
			  430,  431,  387,  432,  408,  409,  410,  411,  388,  433,
			  412,  413,  414,  434,  416,  421,  421,  421,  435,  421,
			  418,  438,  439,  420,  423,  424,  425,  426,  427,  428,
			  421,  429,  430,  431,  440,  432,  441,  442,  467,  448,
			  450,  433,  448,  450,  452,  434,  468,  452,    0,  471,
			  435,    0,    0,  438,  439,  446,  446,  446,  446,  446,
			  456,  456,  456,  679,  679,  679,  440,    0,  441,  442,
			  467,    0,  473,  450,  458,  458,  458,  458,  468,    0,
			  452,  471,    0,  448,  459,  459,  459,  459,  472,  458,

			  448,  450,  472,  475,  476,  452,  460,  460,  460,  460,
			  461,  461,  461,  461,  473,  450,  462,  462,  462,  462,
			  477,  460,  452,  478,  463,  448,  463,  463,  463,  463,
			  472,  458,  448,  450,  472,  475,  476,  452,  479,  480,
			  464,  463,  464,  464,  464,  464,  482,  460,  483,  484,
			  485,    0,  477,  460,  487,  478,  488,  489,  491,  492,
			  493,  493,  493,  496,  493,  497,  498,  499,  500,  501,
			  479,  480,  502,  463,  503,  493,  504,  506,  482,  507,
			  483,  484,  485,  464,  510,  511,  487,  513,  488,  489,
			  491,  492,  531,  516,  532,  496,  516,  497,  498,  499,

			  500,  501,  517,    0,  502,  517,  503,  518,  504,  506,
			  518,  507,  520,  520,  520,    0,  510,  511,    0,  513,
			  522,  522,  522,  522,  531,  516,  532,  524,  534,  524,
			    0,  517,  524,  524,  524,  524,  525,  525,  525,  525,
			  526,  526,  526,  526,  516,  527,  527,  527,  527,  535,
			  518,  525,  536,  517,  520,  526,  539,  516,  518,  528,
			  534,  528,  522,  517,  528,  528,  528,  528,  541,  529,
			  542,  529,  529,  529,  529,  544,  516,  545,  546,  547,
			  548,  535,  518,  525,  536,  517,  529,  526,  539,  550,
			  518,  553,  554,  556,  557,  559,  563,  564,  566,  588,

			  541,  569,  542,  568,  569,  570,  568,  544,  570,  545,
			  546,  547,  548,  579,  579,  579,  579,  590,  529,  592,
			    0,  550,    0,  553,  554,  556,  557,  559,  563,  564,
			  566,  588,  568,    0,  570,  580,  580,  580,  580,    0,
			  581,  581,  581,  581,  569,  584,  584,  584,  584,  590,
			  593,  592,  569,  594,  568,  581,  570,  597,  600,  601,
			  584,    0,    0,  582,  568,  582,  570,    0,  582,  582,
			  582,  582,  583,  603,  583,    0,  569,  583,  583,  583,
			  583,  604,  593,  605,  569,  594,  568,  581,  570,  597,
			  600,  601,  584,  585,  585,  585,  585,  586,  586,  586,

			  586,  587,  607,  587,  608,  603,  587,  587,  587,  587,
			  602,  602,  602,  604,  611,  605,  612,  611,  613,  612,
			    0,  613,  618,  619,  619,  619,  619,  620,  620,  620,
			  620,  627,  633,    0,  607,    0,  608,  621,  621,  621,
			  621,  602,  622,  622,  622,  622,    0,    0,  618,  680,
			  680,  680,  611,    0,  618,  623,  623,  623,  623,  625,
			  625,  625,  625,  627,  633,  611,  636,  612,  637,  613,
			  623,  639,  624,  602,  624,    0,  650,  624,  624,  624,
			  624,  635,  635,  635,  611,  626,  626,  626,  626,  642,
			  645,  651,  642,  646,  646,  646,  646,  611,  636,  612,

			  637,  613,  623,  639,  647,  647,  647,  647,  650,  655,
			  656,  657,  635,  658,  659,    0,  645,  682,  682,  682,
			    0,    0,  645,  651,  669,    0,  669,    0,  669,  669,
			  669,  669,  669,  669,  669,  669,  669,  683,  683,  683,
			  642,  655,  656,  657,  635,  658,  659,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  672,    0,  672,  672,
			  672,    0,  672,  672,  672,  672,  672,  672,  672,  672,
			  672,    0,  642,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,

			  664,  664,  664,  665,  665,  665,  665,  665,  665,  665,
			  665,  665,  665,  665,  665,  665,  665,  665,  666,  666,
			  666,  666,  666,  666,  666,  666,  666,  666,  666,  666,
			  666,  666,  666,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  668,    0,
			  668,  668,  668,  668,  668,  668,  668,  668,  668,  668,
			  668,  668,  668,  670,    0,  670,  670,  670,  670,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  673,  673,
			  673,  673,  673,  673,  673,  673,  673,  673,  673,  673,
			  673,  673,  673,  674,  674,  674,  674,  674,  674,  674,

			  674,  674,  674,  674,  674,  674,  674,  674,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  676,    0,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  677,    0,
			  677,    0,  677,  677,  677,  677,  677,  677,  677,  677,
			  677,  677,  677,  678,    0,  678,  678,  678,  678,  678,
			  678,  678,  678,  678,  678,  678,  678,  678,  681,    0,
			  681,  681,  681,  681,  681,  681,  681,  681,  681,  681,
			  681,  681,  681,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  685,    0,

			  685,  685,  685,  685,  685,  685,  685,  685,  685,  685,
			  685,  685,  685,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,

			  662,  662,  662,  662,  662,  662, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   90,   91,   99,  104,  977,  975,  109,
			  112,  115,  118,  975, 1913,  121,  124, 1913,  190,    0,
			 1913,  120, 1913, 1913, 1913, 1913, 1913,   81,  122,  120,
			  128,  147,  154,  934, 1913,  107, 1913,  109,  933,  182,
			   91,  185,  121,  195,  239,    0,  239,  114,  107,  109,
			  252,  197,  120,  175,  247,  197,  209,  133,  135, 1913,
			  896, 1913, 1913, 1913,  843, 1913,  925, 1913, 1913,  331,
			  175,  307, 1913, 1913,  286,  921, 1913, 1913,  301, 1913,
			 1913,  319,  343,  786,  351,  779,  330, 1913,  384,  149,
			  332,  342,  343,  365,  385,  386,  395,  401,  400,  399,

			  405,  421,  409,  411,  493,    0,  774,  577,  770, 1913,
			 1913, 1913,  414, 1913, 1913,  485,  493,  501,  181,  439,
			    0,  506, 1913, 1913, 1913, 1913, 1913, 1913, 1913,    0,
			  258,  430,  263,  250,  274,  320,  361,  366,  372,  398,
			  390,  419,    0,  404,  483,  487,  444,  478,  467,    0,
			  485,  568,    0,  493,  503,  504,  489,  491,  508,  513,
			    0,  495,  510,  596,  570,  499,  518,  508,  514,  603,
			  526,  551,  562,  572,  570, 1913, 1913,  754, 1913,  652,
			 1913, 1913, 1913, 1913, 1913,  637, 1913, 1913, 1913, 1913,
			 1913, 1913, 1913, 1913, 1913, 1913, 1913, 1913, 1913, 1913,

			 1913, 1913,  355, 1913, 1913,  664,  570, 1913,  741, 1913,
			  489, 1913,  677,  728, 1913, 1913,  685,  680, 1913, 1913,
			 1913, 1913,  667, 1913,  684, 1913,  686,  691,  690,  695,
			  701,  702,  710, 1913,  697,  709, 1913, 1913, 1913,  711,
			  709,  698,  691,  660,  706,  654,  640,  636,  630,  603,
			  589,  586,  573,  570,  547,  540,  524,  519,  453,  452,
			  435, 1913,  711,  772, 1913,  741,  789,  795,  801,  574,
			  379,  780,  365,  808,  812,  654,  686,    0,    0,  682,
			  690,    0,  706,  691,  699,  734,  740,  754,  772,  779,
			    0,  774,  805,  803,  791,  792,  802,  801,  809,  808,

			  813,  803,  820,  817,  822,  808,  816,  825,  816,    0,
			  828,  809,  815,  855,  831,  832,  840,  827,  856,  846,
			  865,  870,  863,  860,  870,  864,  873,  862,  872,    0,
			  873,  879,  870,    0, 1913,  896,    0,  329,  925, 1913,
			 1913, 1913,  943,  916,  942,  944, 1913,  950, 1913, 1913,
			 1913, 1913, 1913, 1913, 1913,  944,  949, 1913, 1913, 1913,
			 1913, 1913, 1913, 1913, 1913, 1913, 1913, 1913, 1913, 1913,
			 1913, 1913, 1913,  999,  963,  971, 1003,  995, 1020, 1024,
			 1030, 1036,  602,  316,    0,  315,  354, 1051, 1057,  880,
			  893,  918,  918,  940,  946,  961,  947,  968,  967, 1001,

			 1016, 1013, 1019, 1016, 1019, 1033, 1025,    0, 1047, 1044,
			 1030, 1031, 1040, 1054, 1042,    0, 1050,    0, 1062,    0,
			 1059, 1123,    0, 1063, 1052, 1065, 1069, 1058, 1064, 1070,
			 1059, 1069, 1058, 1086, 1075, 1082,    0,    0, 1096, 1096,
			 1093, 1104, 1116,    0,    0, 1913, 1146,  241, 1143, 1913,
			 1144, 1913, 1148, 1913,  297,  270, 1150,    0, 1164, 1174,
			 1186, 1190, 1196, 1206, 1222,    0,    0, 1104, 1124,    0,
			    0, 1111, 1163, 1138,    0, 1155, 1168, 1185, 1189, 1188,
			 1195,    0, 1198, 1204, 1214, 1211,    0, 1215, 1223, 1218,
			    0, 1203, 1224, 1258, 1913,  284, 1232, 1217, 1212, 1228,

			 1233, 1234, 1224, 1239, 1226,    0, 1227, 1248,    0,    0,
			 1245, 1250,    0, 1243,  233,  167, 1287, 1296, 1301, 1913,
			 1293,  299, 1301,  537, 1312, 1316, 1320, 1325, 1344, 1351,
			    0, 1241, 1244,    0, 1283, 1299, 1317,    0,    0, 1321,
			    0, 1337, 1335,    0, 1326, 1333, 1328, 1329, 1349,    0,
			 1339, 1913,  219, 1349, 1343,    0, 1349, 1350,    0, 1360,
			    0,    0,    0, 1346, 1353,    0, 1348,  150, 1397, 1395,
			 1399,  202,  175,  172,  112,  153,  138,   93,   34, 1393,
			 1415, 1420, 1448, 1457, 1425, 1473, 1477, 1486, 1349,    0,
			 1373,    0, 1385, 1416, 1411,    0,    0, 1420,    0,    0,

			 1414, 1424, 1508, 1428, 1446, 1450,    0, 1467, 1469,    0,
			    0, 1508, 1510, 1512, 1913, 1913, 1913, 1913, 1487, 1503,
			 1507, 1517, 1522, 1535, 1557, 1539, 1565, 1496,    0,    0,
			    0,    0,    0, 1482,    0, 1579, 1524, 1520,    0, 1536,
			    0,    0, 1583, 1913, 1913, 1555, 1573, 1584,    0,    0,
			 1534, 1560,    0,    0, 1913, 1578, 1561, 1562, 1564, 1565,
			    0, 1913, 1913, 1672, 1687, 1702, 1717, 1732, 1747, 1621,
			 1762, 1640, 1655, 1777, 1792, 1807, 1822, 1837, 1852, 1166,
			 1542, 1867, 1610, 1630, 1882, 1897, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  662,    1,  663,  663,  664,  664,  665,  665,  666,
			  666,  667,  667,  662,  662,  662,  662,  662,  668,  669,
			  662,  670,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  662,
			  662,  662,  662,  662,  662,  662,  672,  662,  662,  662,
			  673,  673,  662,  662,  674,  675,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  668,  662,  676,  677,
			  668,  668,  668,  668,  668,  668,  668,  668,  668,  668,

			  668,  668,  668,  668,  668,  669,  678,  678,  678,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  679,  679,
			  680,  662,  662,  662,  662,  662,  662,  662,  662,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  662,  662,  672,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,

			  662,  662,  673,  662,  662,  673,  674,  662,  675,  662,
			  662,  662,  662,  681,  662,  662,  676,  677,  662,  662,
			  662,  662,  668,  662,  668,  662,  668,  668,  668,  668,
			  668,  668,  668,  662,  668,  668,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  679,
			  679,  679,  680,  662,  662,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,

			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  662,  662,  681,  681,  677,  662,
			  662,  662,  668,  668,  668,  668,  662,  668,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  679,  679,  271,  680,  662,  662,  662,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,

			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  662,  662,  681,  668,  662,
			  668,  662,  668,  662,  662,  682,  682,  683,  662,  662,
			  662,  662,  662,  662,  662,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  662,  662,  662,  671,  671,  671,  671,

			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  662,  681,  668,  668,  668,  662,
			  682,  682,  682,  683,  662,  662,  662,  662,  662,  662,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  662,  684,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  681,  668,  668,
			  668,  662,  520,  662,  682,  662,  522,  662,  683,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  671,  671,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,

			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  685,  668,  668,  668,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  671,  671,  671,
			  671,  671,  671,  671,  671,  662,  671,  671,  671,  671,
			  671,  671,  668,  662,  662,  662,  662,  662,  671,  671,
			  662,  671,  671,  671,  662,  662,  671,  662,  671,  662,
			  671,  662,    0,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   23,   23,   24,   25,
			   26,   27,   28,   29,   30,   31,   32,   33,   34,   35,
			   36,   37,   38,   39,   40,   41,   42,   43,   44,   45,
			   46,   47,   48,   49,   50,   51,   52,   53,   54,   55,
			   56,   57,   58,   59,   60,   61,   62,   63,   64,   65,

			   66,   67,   68,   69,   70,   71,   72,   73,   74,   75,
			   76,   77,   78,   79,   80,   81,   82,   83,   84,   85,
			   86,   87,   88,   89,   90,   91,   92,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    2,    1,    3,    4,    3,    5,    6,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    7,    7,    8,    9,    3,    3,    3,    3,    3,    3,
			    3,    7,    7,    7,    7,    7,    7,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   11,   12,    3,    3,    3,
			    3,   13,    3,    7,    7,    7,    7,    7,    7,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   14,   15,    3,
			    3,    3,    3, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    2,    3,    4,    5,
			    5,    5,    5,    5,    6,    8,   11,   13,   16,   19,
			   22,   25,   28,   31,   34,   37,   40,   43,   46,   49,
			   52,   55,   58,   61,   64,   67,   70,   73,   76,   79,
			   82,   85,   88,   91,   94,   97,  100,  103,  106,  109,
			  112,  115,  118,  121,  124,  127,  130,  133,  136,  139,
			  142,  144,  147,  150,  153,  156,  159,  161,  163,  165,
			  167,  169,  171,  173,  175,  177,  179,  181,  183,  185,
			  187,  189,  192,  194,  196,  197,  197,  198,  199,  200,
			  200,  201,  202,  203,  204,  205,  206,  207,  208,  209,

			  210,  211,  213,  214,  215,  217,  218,  219,  220,  221,
			  222,  223,  224,  225,  226,  227,  228,  229,  230,  231,
			  231,  231,  231,  232,  233,  234,  235,  236,  237,  238,
			  239,  240,  241,  242,  244,  245,  246,  247,  248,  249,
			  250,  251,  252,  254,  255,  256,  257,  258,  259,  260,
			  262,  263,  264,  266,  267,  268,  269,  270,  271,  272,
			  273,  275,  276,  277,  278,  279,  280,  281,  282,  283,
			  284,  285,  286,  287,  288,  289,  290,  291,  292,  293,
			  293,  294,  295,  296,  297,  298,  298,  299,  300,  301,
			  302,  303,  304,  305,  306,  307,  308,  309,  310,  311,

			  312,  313,  314,  315,  316,  317,  318,  319,  321,  322,
			  323,  323,  324,  325,  326,  327,  329,  331,  332,  334,
			  336,  338,  340,  341,  343,  344,  346,  347,  348,  349,
			  350,  351,  352,  353,  354,  355,  356,  358,  359,  361,
			  362,  363,  364,  365,  366,  367,  368,  369,  370,  371,
			  372,  373,  374,  375,  376,  377,  378,  379,  380,  381,
			  382,  383,  385,  386,  386,  387,  388,  388,  389,  390,
			  392,  393,  395,  396,  397,  397,  398,  399,  401,  403,
			  404,  405,  407,  408,  409,  410,  411,  412,  413,  414,
			  415,  417,  418,  419,  420,  421,  422,  423,  424,  425,

			  426,  427,  428,  429,  430,  431,  432,  433,  435,  436,
			  438,  439,  440,  441,  442,  443,  444,  445,  446,  447,
			  448,  449,  450,  451,  452,  453,  454,  455,  456,  457,
			  459,  460,  461,  462,  464,  465,  465,  466,  467,  467,
			  469,  471,  473,  474,  475,  476,  477,  479,  480,  482,
			  484,  485,  486,  487,  488,  489,  490,  491,  492,  493,
			  494,  495,  496,  497,  498,  499,  500,  501,  502,  503,
			  504,  505,  506,  507,  508,  508,  509,  510,  510,  510,
			  511,  512,  513,  513,  513,  513,  513,  513,  514,  515,
			  516,  517,  518,  519,  520,  521,  522,  523,  524,  525,

			  526,  528,  529,  530,  531,  532,  533,  534,  536,  537,
			  538,  539,  540,  541,  542,  543,  545,  546,  548,  549,
			  551,  552,  554,  556,  557,  558,  559,  560,  561,  562,
			  563,  564,  565,  566,  567,  568,  569,  571,  573,  574,
			  575,  576,  577,  578,  580,  582,  583,  583,  584,  585,
			  587,  588,  590,  591,  593,  594,  594,  594,  594,  595,
			  595,  596,  596,  597,  598,  599,  601,  603,  604,  605,
			  607,  609,  610,  611,  612,  614,  615,  616,  617,  618,
			  619,  620,  622,  623,  624,  625,  626,  628,  629,  630,
			  631,  633,  634,  635,  635,  636,  636,  637,  638,  639,

			  640,  641,  642,  643,  644,  645,  647,  648,  649,  651,
			  653,  654,  655,  657,  658,  658,  659,  660,  661,  662,
			  663,  663,  663,  663,  663,  663,  664,  665,  665,  665,
			  666,  668,  669,  670,  672,  673,  674,  675,  677,  679,
			  680,  682,  683,  684,  686,  687,  688,  689,  690,  691,
			  693,  694,  695,  695,  696,  697,  699,  700,  701,  703,
			  704,  706,  708,  710,  711,  712,  714,  715,  716,  717,
			  718,  719,  719,  719,  719,  719,  719,  719,  719,  719,
			  719,  720,  721,  721,  721,  722,  722,  723,  723,  724,
			  726,  727,  729,  730,  731,  732,  734,  736,  737,  739,

			  741,  742,  743,  744,  745,  746,  747,  749,  750,  751,
			  753,  755,  756,  757,  758,  760,  761,  763,  764,  765,
			  765,  766,  766,  767,  768,  768,  768,  769,  770,  772,
			  774,  776,  778,  780,  781,  783,  783,  784,  785,  787,
			  788,  790,  792,  793,  795,  797,  798,  798,  799,  801,
			  803,  803,  804,  806,  808,  810,  810,  811,  811,  812,
			  812,  814,  815,  815, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  182,  182,  184,  184,  215,  213,  214,    1,  213,
			  214,    1,  214,   36,  213,  214,  185,  213,  214,   41,
			  213,  214,   15,  213,  214,  152,  213,  214,   24,  213,
			  214,   25,  213,  214,   32,  213,  214,   30,  213,  214,
			    9,  213,  214,   31,  213,  214,   14,  213,  214,   33,
			  213,  214,  117,  213,  214,  117,  213,  214,  117,  213,
			  214,    8,  213,  214,    7,  213,  214,   19,  213,  214,
			   18,  213,  214,   20,  213,  214,   11,  213,  214,  115,
			  213,  214,  115,  213,  214,  115,  213,  214,  115,  213,
			  214,  115,  213,  214,  115,  213,  214,  115,  213,  214,

			  115,  213,  214,  115,  213,  214,  115,  213,  214,  115,
			  213,  214,  115,  213,  214,  115,  213,  214,  115,  213,
			  214,  115,  213,  214,  115,  213,  214,  115,  213,  214,
			  115,  213,  214,  115,  213,  214,  115,  213,  214,   28,
			  213,  214,  213,  214,   29,  213,  214,   34,  213,  214,
			   26,  213,  214,   27,  213,  214,   12,  213,  214,  186,
			  214,  212,  214,  210,  214,  211,  214,  182,  214,  182,
			  214,  181,  214,  180,  214,  182,  214,  184,  214,  183,
			  214,  178,  214,  178,  214,  177,  214,    6,  214,    5,
			    6,  214,    5,  214,    6,  214,    1,  185,  174,  185,

			  185,  185,  185,  185,  185,  185,  185,  185,  185,  185,
			  185,  185, -390,  185,  185,  185, -390,   41,  152,  152,
			  152,    2,   35,   10,  123,   39,   23,  123,  117,  117,
			  116,  116,   16,   37,   21,   22,   38,   17,  115,  115,
			  115,  115,   46,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,   58,  115,  115,  115,  115,  115,  115,  115,
			   70,  115,  115,  115,   77,  115,  115,  115,  115,  115,
			  115,  115,  115,   90,  115,  115,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  115,   40,
			   13,  186,  210,  203,  201,  202,  204,  205,  206,  207,

			  187,  188,  189,  190,  191,  192,  193,  194,  195,  196,
			  197,  198,  199,  200,  182,  181,  180,  182,  182,  179,
			  180,  184,  183,  177,    5,    4,  175,  173,  175,  185,
			 -390, -390,  160,  175,  158,  175,  159,  175,  161,  175,
			  185,  154,  175,  185,  155,  175,  185,  185,  185,  185,
			  185,  185,  185, -176,  185,  185,  162,  175,  152,  124,
			  152,  152,  152,  152,  152,  152,  152,  152,  152,  152,
			  152,  152,  152,  152,  152,  152,  152,  152,  152,  152,
			  152,  152,  152,  125,  152,  123,  118,  123,  117,  117,
			  121,  122,  122,  120,  122,  119,  117,  115,  115,   44,

			  115,   45,  115,  115,  115,   49,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,   61,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  115,   82,  115,  115,   85,  115,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  110,  115,  115,
			  115,  115,  114,  115,  209,    4,    4,  163,  175,  156,
			  175,  157,  175,  185,  185,  185,  185,  170,  175,  185,
			  165,  175,  164,  175,  142,  140,  141,  143,  144,  153,
			  153,  145,  146,  126,  127,  128,  129,  130,  131,  132,

			  133,  134,  135,  136,  137,  138,  139,  123,  123,  123,
			  123,  117,  117,  117,  117,  115,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,  115,   59,  115,  115,  115,
			  115,  115,  115,  115,   68,  115,  115,  115,  115,  115,
			  115,  115,  115,   78,  115,  115,   80,  115,  115,   83,
			  115,  115,   88,  115,   89,  115,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  115,  104,
			  115,  105,  115,  115,  115,  115,  115,  115,  112,  115,
			  113,  115,  208,    4,  185,  166,  175,  185,  169,  175,
			  185,  172,  175,  153,  123,  123,  123,  123,  117,   42,

			  115,   43,  115,  115,  115,   50,  115,   51,  115,  115,
			  115,  115,   56,  115,  115,  115,  115,  115,  115,  115,
			   66,  115,  115,  115,  115,  115,   73,  115,  115,  115,
			  115,   79,  115,  115,  115,   86,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,  100,  115,  115,  115,  103,
			  115,  106,  115,  115,  115,  109,  115,  115,    4,  185,
			  185,  185,  147,  123,  123,  123,   47,  115,  115,  115,
			   53,  115,  115,  115,  115,   60,  115,   62,  115,  115,
			   64,  115,  115,  115,   69,  115,  115,  115,  115,  115,
			  115,   81,  115,  115,   87,  115,  115,   93,  115,  115,

			  115,   96,  115,  115,   98,  115,   99,  115,  101,  115,
			  115,  115,  108,  115,  115,    4,  185,  185,  185,  123,
			  123,  123,  123,  115,   52,  115,  115,   55,  115,  115,
			  115,  115,   67,  115,   71,  115,  115,   74,  115,   75,
			  115,  115,  115,  115,  115,  115,  115,   97,  115,  115,
			  115,  111,  115,    3,    4,  185,  185,  185,  150,  151,
			  151,  149,  151,  148,  123,  123,  123,  123,  123,  115,
			   54,  115,   57,  115,   63,  115,   65,  115,   72,  115,
			  115,   84,  115,  115,  115,   94,  115,  115,  102,  115,
			  107,  115,  185,  168,  175,  171,  175,  123,  123,   48,

			  115,   76,  115,  115,   92,  115,   95,  115,  167,  175,
			  115,  115,   91,  115,   91, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1913
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 662
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 663
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER is 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN is false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN is true
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN is true
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER is 214
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 215
			-- End of buffer rule code

	yyLine_used: BOOLEAN is true
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is true
			-- Is `position' used?

	INITIAL: INTEGER is 0
	SPECIAL_STR: INTEGER is 1
	VERBATIM_STR1: INTEGER is 2
	VERBATIM_STR2: INTEGER is 3
	VERBATIM_STR3: INTEGER is 4
	PRAGMA: INTEGER is 5
			-- Start condition codes

feature -- User-defined features



indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_SCANNER
