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
if yy_act <= 104 then
if yy_act <= 52 then
if yy_act <= 26 then
if yy_act <= 13 then
if yy_act <= 7 then
if yy_act <= 4 then
if yy_act <= 2 then
if yy_act = 1 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 39 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 39")
end
 ast_factory.create_break_as (Current)  
else
	yy_end := yy_end - 2
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 41 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 41")
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
--|#line 50 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 50")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				last_line_pragma := ast_factory.new_line_pragma (Current)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 55 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 55")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
			
end
end
else
if yy_act <= 6 then
if yy_act = 5 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 59 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 59")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 63 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 63")
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
--|#line 85 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 85")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SEMICOLON, Current)
				last_token := TE_SEMICOLON
			
end
end
else
if yy_act <= 10 then
if yy_act <= 9 then
if yy_act = 8 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 89 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 89")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_COLON, Current)
				last_token := TE_COLON
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 93 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 93")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_COMMA, Current)
				last_token := TE_COMMA
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 97 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 97")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOTDOT, Current)
				last_token := TE_DOTDOT
			
end
else
if yy_act <= 12 then
if yy_act = 11 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 101 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 101")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_QUESTION, Current)
				last_token := TE_QUESTION
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 105 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 105")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_TILDE, Current)
				last_token := TE_TILDE
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 109 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 109")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_CURLYTILDE, Current)
				last_token := TE_CURLYTILDE
			
end
end
end
else
if yy_act <= 20 then
if yy_act <= 17 then
if yy_act <= 15 then
if yy_act = 14 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 113 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 113")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOT, Current)
				last_token := TE_DOT
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 117 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 117")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ADDRESS, Current)
				last_token := TE_ADDRESS
			
end
else
if yy_act = 16 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 121 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 121")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_ASSIGNMENT, Current)
				last_token := TE_ASSIGNMENT
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 125 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 125")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ACCEPT, Current)
				last_token := TE_ACCEPT
			
end
end
else
if yy_act <= 19 then
if yy_act = 18 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 129 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 129")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_EQ, Current)
				last_token := TE_EQ
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 133 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 133")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LT, Current)
				last_token := TE_LT
			
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 137 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 137")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_GT, Current)
				last_token := TE_GT
			
end
end
else
if yy_act <= 23 then
if yy_act <= 22 then
if yy_act = 21 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 141 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 141")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LE, Current)
				last_token := TE_LE
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 145 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 145")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_GE, Current)
				last_token := TE_GE
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 149 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 149")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_NE, Current)
				last_token := TE_NE
			
end
else
if yy_act <= 25 then
if yy_act = 24 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 153 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 153")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LPARAN, Current)
				last_token := TE_LPARAN
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 157 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 157")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_RPARAN, Current)
				last_token := TE_RPARAN
			
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 161 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 161")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LCURLY, Current)
				last_token := TE_LCURLY
			
end
end
end
end
else
if yy_act <= 39 then
if yy_act <= 33 then
if yy_act <= 30 then
if yy_act <= 28 then
if yy_act = 27 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 165 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 165")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RCURLY, Current)
				last_token := TE_RCURLY
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 169 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 169")
end
				
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_LSQURE, Current)
				last_token := TE_LSQURE
			
end
else
if yy_act = 29 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 173 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 173")
end
				
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_RSQURE, Current)
				last_token := TE_RSQURE
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 177 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 177")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_PLUS, Current)
				last_token := TE_PLUS
			
end
end
else
if yy_act <= 32 then
if yy_act = 31 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 181 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 181")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MINUS, Current)
				last_token := TE_MINUS
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 185 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 185")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_STAR, Current)
				last_token := TE_STAR
			
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 189 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 189")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SLASH, Current)
				last_token := TE_SLASH
			
end
end
else
if yy_act <= 36 then
if yy_act <= 35 then
if yy_act = 34 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 193 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 193")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_POWER, Current)
				last_token := TE_POWER
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 197 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 197")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_CONSTRAIN, Current)
				last_token := TE_CONSTRAIN
			
end
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 201 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 201")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_BANG, Current)
				last_token := TE_BANG
			
end
else
if yy_act <= 38 then
if yy_act = 37 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 205 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 205")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LARRAY, Current)
				last_token := TE_LARRAY
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 209 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 209")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RARRAY, Current)
				last_token := TE_RARRAY
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 213 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 213")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DIV, Current)
				last_token := TE_DIV
			
end
end
end
else
if yy_act <= 46 then
if yy_act <= 43 then
if yy_act <= 41 then
if yy_act = 40 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 217 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 217")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MOD, Current)
				last_token := TE_MOD
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 225 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 225")
end

				last_token := TE_FREE
				process_id_as
			
end
else
if yy_act = 42 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 233 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 233")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 237 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 237")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
end
end
else
if yy_act <= 45 then
if yy_act = 44 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 241 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 241")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 245 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 245")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 249 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 249")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
end
end
else
if yy_act <= 49 then
if yy_act <= 48 then
if yy_act = 47 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 253 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 253")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ASSIGN, Current)
				if last_keyword_as_value /= Void then
					last_keyword_as_id_index := last_keyword_as_value.index
				end
				last_token := TE_ASSIGN
			
else
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 260 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 260")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of `attribute', possibly a new keyword in future definition of `Eiffel'."))
				end
			
end
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 269 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 269")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_BIT, Current)
				last_token := TE_BIT
			
end
else
if yy_act <= 51 then
if yy_act = 50 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 273 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 273")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 277 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 277")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
end
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 281 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 281")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
end
end
end
end
end
else
if yy_act <= 78 then
if yy_act <= 65 then
if yy_act <= 59 then
if yy_act <= 56 then
if yy_act <= 54 then
if yy_act = 53 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 285 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 285")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 289 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 289")
end
				
				last_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION				
			
end
else
if yy_act = 55 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 293 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 293")
end
				
				last_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 297 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 297")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
end
end
else
if yy_act <= 58 then
if yy_act = 57 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 301 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 301")
end
				
				last_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED			
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 305 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 305")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 309 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 309")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
end
end
else
if yy_act <= 62 then
if yy_act <= 61 then
if yy_act = 60 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 313 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 313")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 317 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 317")
end
				
				last_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
end
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 321 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 321")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
end
else
if yy_act <= 64 then
if yy_act = 63 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 325 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 325")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 329 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 329")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
end
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 333 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 333")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
end
end
end
else
if yy_act <= 72 then
if yy_act <= 69 then
if yy_act <= 67 then
if yy_act = 66 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 337 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 337")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 341 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 341")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
end
else
if yy_act = 68 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 345 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 345")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 349 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 349")
end
				
				last_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
end
end
else
if yy_act <= 71 then
if yy_act = 70 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 353 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 353")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 357 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 357")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
end
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 361 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 361")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INDEXING, Current)
				last_token := TE_INDEXING
			
end
end
else
if yy_act <= 75 then
if yy_act <= 74 then
if yy_act = 73 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 365 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 365")
end
				
				last_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
				last_token := TE_INFIX
			
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 369 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 369")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
end
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 373 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 373")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
end
else
if yy_act <= 77 then
if yy_act = 76 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 377 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 377")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 381 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 381")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IS, Current)
				last_token := TE_IS
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 385 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 385")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
end
end
end
end
else
if yy_act <= 91 then
if yy_act <= 85 then
if yy_act <= 82 then
if yy_act <= 80 then
if yy_act = 79 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 389 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 389")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 393 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 393")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
end
else
if yy_act = 81 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 397 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 397")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_MODIFY, Current)
				last_token := TE_MODIFY
			
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 401 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 401")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
end
end
else
if yy_act <= 84 then
if yy_act = 83 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 405 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 405")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of `note', possibly a new keyword in future definition of `Eiffel'."))
				end
			
else
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 414 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 414")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
end
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 418 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 418")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
end
end
else
if yy_act <= 88 then
if yy_act <= 87 then
if yy_act = 86 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 434 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 434")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text,  line, column, position, 4)
				last_token := TE_ONCE_STRING
			
else
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 438 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 438")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text_substring (1, 4),  line, column, position, 4)
					-- Assume all trailing characters are in the same line (which would be false if '\n' appears).
				ast_factory.create_break_as_with_data (text_substring (5, text_count), line, column + 4, position + 4, text_count - 4)
				last_token := TE_ONCE_STRING			
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 445 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 445")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
end
else
if yy_act <= 90 then
if yy_act = 89 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 449 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 449")
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
--|#line 458 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 458")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
end
else
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 462 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 462")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
end
end
end
else
if yy_act <= 98 then
if yy_act <= 95 then
if yy_act <= 93 then
if yy_act = 92 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 466 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 466")
end
				
				last_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 470 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 470")
end
				
				last_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
				last_token := TE_PREFIX
			
end
else
if yy_act = 94 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 474 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 474")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
else
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 478 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 478")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
end
end
else
if yy_act <= 97 then
if yy_act = 96 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 482 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 482")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 486 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 486")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
end
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 490 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 490")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
end
end
else
if yy_act <= 101 then
if yy_act <= 100 then
if yy_act = 99 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 494 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 494")
end
					
				last_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 498 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 498")
end
				
				last_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
end
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 502 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 502")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
end
else
if yy_act <= 103 then
if yy_act = 102 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 506 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 506")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 510 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 510")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 514 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 514")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
end
end
end
end
end
end
else
if yy_act <= 156 then
if yy_act <= 130 then
if yy_act <= 117 then
if yy_act <= 111 then
if yy_act <= 108 then
if yy_act <= 106 then
if yy_act = 105 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 518 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 518")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 522 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 522")
end

				last_token := TE_TUPLE
				process_id_as
			
end
else
if yy_act = 107 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 526 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 526")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
else
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 530 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 530")
end
				
				last_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
end
end
else
if yy_act <= 110 then
if yy_act = 109 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 534 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 534")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 538 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 538")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_USE, Current)
				last_token := TE_USE
			
end
else
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 542 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 542")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
end
end
else
if yy_act <= 114 then
if yy_act <= 113 then
if yy_act = 112 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 546 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 546")
end
				
				last_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 550 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 550")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
end
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 554 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 554")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
end
else
if yy_act <= 116 then
if yy_act = 115 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 562 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 562")
end

				last_token := TE_ID
				process_id_as
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 569 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 569")
end

				last_token := TE_A_BIT			
				last_id_as_value := ast_factory.new_filled_bit_id_as (Current)
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 577 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 577")
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
end
else
if yy_act <= 124 then
if yy_act <= 121 then
if yy_act <= 119 then
if yy_act = 118 then
	yy_end := yy_end - 2
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 578 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 578")
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
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 590 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 590")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
end
else
if yy_act = 120 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 598 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 598")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end				
				last_token := TE_REAL
			
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 610 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 610")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
end
else
if yy_act <= 123 then
if yy_act = 122 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 616 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 616")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 623 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 623")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 629 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 629")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
end
else
if yy_act <= 127 then
if yy_act <= 126 then
if yy_act = 125 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 635 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 635")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 641 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 641")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 647 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 647")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
if yy_act <= 129 then
if yy_act = 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 653 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 653")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 659 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 659")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 665 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 665")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
end
end
end
end
else
if yy_act <= 143 then
if yy_act <= 137 then
if yy_act <= 134 then
if yy_act <= 132 then
if yy_act = 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 671 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 671")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 677 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 677")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
if yy_act = 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 683 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 683")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 689 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 689")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
end
else
if yy_act <= 136 then
if yy_act = 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 695 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 695")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 701 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 701")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 707 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 707")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
end
else
if yy_act <= 140 then
if yy_act <= 139 then
if yy_act = 138 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 713 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 713")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 719 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 719")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 725 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 725")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
if yy_act <= 142 then
if yy_act = 141 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 731 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 731")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 737 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 737")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 743 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 743")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
end
end
end
else
if yy_act <= 150 then
if yy_act <= 147 then
if yy_act <= 145 then
if yy_act = 144 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 749 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 749")
end

				process_character_code (text_substring (4, text_count - 2).to_integer)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 752 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 752")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
end
else
if yy_act = 146 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 753 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 753")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 762 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 762")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LT
			
end
end
else
if yy_act <= 149 then
if yy_act = 148 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 766 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 766")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GT
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 770 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 770")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LE
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 774 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 774")
end
			
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GE
			
end
end
else
if yy_act <= 153 then
if yy_act <= 152 then
if yy_act = 151 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 778 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 778")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_PLUS
			
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 782 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 782")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MINUS
			
end
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 786 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 786")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_STAR
			
end
else
if yy_act <= 155 then
if yy_act = 154 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 790 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 790")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_SLASH
			
else
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 794 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 794")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_POWER
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 798 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 798")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_DIV
			
end
end
end
end
end
else
if yy_act <= 182 then
if yy_act <= 169 then
if yy_act <= 163 then
if yy_act <= 160 then
if yy_act <= 158 then
if yy_act = 157 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 802 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 802")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MOD
			
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 806 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 806")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_BRACKET
			
end
else
if yy_act = 159 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 810 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 810")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND
			
else
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 816 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 816")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND_THEN
			
end
end
else
if yy_act <= 162 then
if yy_act = 161 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 822 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 822")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_IMPLIES
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 828 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 828")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_NOT
			
end
else
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 834 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 834")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR
			
end
end
else
if yy_act <= 166 then
if yy_act <= 165 then
if yy_act = 164 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 840 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 840")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR_ELSE
			
else
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 846 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 846")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_XOR
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 852 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 852")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
end
else
if yy_act <= 168 then
if yy_act = 167 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 861 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 861")
end

					-- Empty string.
				ast_factory.set_buffer (token_buffer2, Current)
				string_position := position
				last_token := TE_EMPTY_STRING
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 867 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 867")
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
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 878 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 878")
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
			
end
end
end
else
if yy_act <= 176 then
if yy_act <= 173 then
if yy_act <= 171 then
if yy_act = 170 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 896 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 896")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (VERBATIM_STR1)
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 900 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 900")
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
			
end
else
if yy_act = 172 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 920 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 920")
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
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 963 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 963")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
end
end
else
if yy_act <= 175 then
if yy_act = 174 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 968 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 968")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 976 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 976")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
end
else
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 992 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 992")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
end
end
else
if yy_act <= 179 then
if yy_act <= 178 then
if yy_act = 177 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1001 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1001")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1014 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1014")
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
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1026 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1026")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
			
end
else
if yy_act <= 181 then
if yy_act = 180 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1030 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1030")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%A")
				token_buffer.append_character ('%A')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1034 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1034")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%B")
				token_buffer.append_character ('%B')
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1038 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1038")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%C")
				token_buffer.append_character ('%C')
			
end
end
end
end
else
if yy_act <= 195 then
if yy_act <= 189 then
if yy_act <= 186 then
if yy_act <= 184 then
if yy_act = 183 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1042 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1042")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%D")
				token_buffer.append_character ('%D')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1046 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1046")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%F")
				token_buffer.append_character ('%F')
			
end
else
if yy_act = 185 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1050 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1050")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%H")
				token_buffer.append_character ('%H')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1054 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1054")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%L")
				token_buffer.append_character ('%L')
			
end
end
else
if yy_act <= 188 then
if yy_act = 187 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1058 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1058")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%N")
				token_buffer.append_character ('%N')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1062 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1062")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%Q")
				token_buffer.append_character ('%Q')
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1066 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1066")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%R")
				token_buffer.append_character ('%R')
			
end
end
else
if yy_act <= 192 then
if yy_act <= 191 then
if yy_act = 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1070 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1070")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%S")
				token_buffer.append_character ('%S')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1074 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1074")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%T")
				token_buffer.append_character ('%T')
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1078 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1078")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%U")
				token_buffer.append_character ('%U')
			
end
else
if yy_act <= 194 then
if yy_act = 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1082 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1082")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%V")
				token_buffer.append_character ('%V')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1086 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1086")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%%")
				token_buffer.append_character ('%%')
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1090 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1090")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%'")
				token_buffer.append_character ('%'')
			
end
end
end
else
if yy_act <= 201 then
if yy_act <= 198 then
if yy_act <= 197 then
if yy_act = 196 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1094 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1094")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%"")
				token_buffer.append_character ('%"')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1098 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1098")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%(")
				token_buffer.append_character ('%(')
			
end
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1102 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1102")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%)")
				token_buffer.append_character ('%)')
			
end
else
if yy_act <= 200 then
if yy_act = 199 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1106 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1106")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%<")
				token_buffer.append_character ('%<')
			
else
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1110 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1110")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%>")
				token_buffer.append_character ('%>')
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1114 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1114")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
end
end
else
if yy_act <= 204 then
if yy_act <= 203 then
if yy_act = 202 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1118 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1118")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			ast_factory.append_text_to_buffer (token_buffer2, Current)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1123 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1123")
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
--|#line 1139 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1139")
end

					-- Bad special character.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
end
else
if yy_act <= 206 then
if yy_act = 205 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line 1145 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1145")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
else
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1163 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1163")
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
			   30,   31,   32,   33,   34,   35,   36,   37,   38,   19,
			   39,   40,   41,   42,   43,   44,   45,   45,   46,   45,
			   45,   47,   48,   49,   50,   51,   45,   52,   53,   54,
			   55,   56,   57,   58,   45,   45,   59,   60,   61,   62,
			   14,   14,   39,   40,   41,   42,   43,   44,   45,   45,
			   46,   45,   45,   47,   48,   49,   50,   51,   45,   52,
			   53,   54,   55,   56,   57,   58,   45,   45,   63,   19,
			   64,   65,   67,   67,  201,   68,   68,  202,   69,   69,

			   71,   72,   71,  586,   73,   71,   72,   71,  481,   73,
			   78,   79,   78,   78,   79,   78,   81,   82,   81,   81,
			   82,   81,   84,   84,   84,   84,   84,   84,  107,  109,
			  108,   83,  122,  123,   83,  113,  551,   85,  133,  110,
			   85,  111,  114,  112,  112,  112,  153,  115,  139,  116,
			  116,  117,  124,  125,  154,  161,   74,  436,  140,  159,
			  118,   74,  201,  536,  115,  205,  116,  116,  117,  115,
			  133,  117,  117,  117,  507,  503,  160,  118,  153,  262,
			  139,  376,  119,  208,  209,  208,  154,  161,   74,  120,
			  140,  159,  118,   74,   87,   88,  438,   89,   88,  210,

			  210,  210,   90,   91,  376,   92,  120,   93,  160,  118,
			  171,  120,  366,   94,  119,   95,  128,   88,   96,  151,
			  134,  129,  162,  130,  135,  152,   97,  136,  131,  132,
			  137,   98,   99,  138,  141,  365,  142,  163,  167,  364,
			  363,  100,  171,  168,  101,  102,  143,  103,  128,  362,
			   96,  151,  134,  129,  162,  130,  135,  152,   97,  136,
			  131,  132,  137,   98,   99,  138,  141,  144,  142,  163,
			  167,  145,  147,  100,  169,  168,  104,   88,  143,  148,
			  149,  155,  164,  172,  146,  150,  212,  215,  170,   89,
			  361,  156,  165,  157,  270,  166,  273,  158,  360,  144,

			  210,  210,  210,  145,  147,  359,  169,   84,   84,   84,
			  358,  148,  149,  155,  164,  172,  146,  150,  201,  215,
			  170,  202,   85,  156,  165,  157,  270,  166,  273,  158,
			  177,  177,  177,  357,  178,  216,  104,  179,   89,  180,
			  181,  182,  203,  201,  203,  217,  202,  183,   89,   86,
			   86,  356,   86,  184,  213,  185,  355,   89,  186,  187,
			  188,  189,  354,  190,  218,  191,  353,   89,  104,  192,
			  219,  193,  352,   89,  194,  195,  196,  197,  198,  199,
			  351,  221,  349,  220,   89,  104,  348,  223,  212,  234,
			   89,   89,   89,  212,  212,  104,   89,   89,  204,  212,

			  347,  222,   89,  212,  214,  212,   89,  224,   89,  346,
			  274,  230,  231,  230,  104,  212,  271,  104,   89,  272,
			  104,  345,  268,  268,  268,  225,  275,  104,  276,  226,
			  204,  104,  227,  260,  260,  260,  214,  104,  104,  104,
			  228,  229,  274,  104,  104,  277,  104,  261,  271,  104,
			  332,  272,  104,  104,  207,  104,  233,  225,  275,  278,
			  276,  226,  269,  104,  227,  104,  176,  232,  259,  104,
			  104,  104,  228,  229,  236,  104,  104,  277,  279,  261,
			  280,  104,  230,  231,  230,  104,  212,  104,  281,   89,
			  262,  278,  263,  263,  263,  282,  284,  104,  115,  283,

			  265,  265,  266,  285,  109,  115,  264,  266,  266,  266,
			  279,  118,  280,  287,  289,  211,  290,  288,  286,  291,
			  281,  292,  298,  207,  301,  176,  302,  282,  284,  303,
			  304,  283,  307,  308,  317,  285,  104,  174,  264,  201,
			  120,  173,  205,  118,  126,  287,  289,  120,  290,  288,
			  286,  291,  318,  292,  298,  293,  301,  294,  302,  295,
			  121,  303,  304,  634,  307,  308,  317,  319,  104,  237,
			  296,  299,  238,  297,  239,  240,  241,   76,  177,  177,
			  177,   76,  242,  300,  318,  329,  634,  293,  243,  294,
			  244,  295,  305,  245,  246,  247,  248,  634,  249,  319,

			  250,  306,  296,  299,  251,  297,  252,  320,  324,  253,
			  254,  255,  256,  257,  258,  300,  309,  315,  310,  325,
			  321,  316,  326,  327,  305,  322,  311,  328,  380,  312,
			  381,  313,  314,  306,  634,  334,  323,  634,   89,  320,
			  324,  330,  330,  330,  208,  209,  208,  382,  309,  315,
			  310,  325,  321,  316,  326,  327,  634,  322,  311,  328,
			  380,  312,  381,  313,  314,  203,  201,  203,  323,  202,
			  210,  210,  210,   86,  230,  231,  230,  335,  213,  382,
			   89,   89,  333,  231,  333,  104,  634,  336,  212,  634,
			   89,   89,  212,  634,  212,   89,  212,   89,  340,   89,

			  341,  634,  634,   89,  230,  231,  230,  343,  212,  383,
			   89,   89,  350,  350,  350,  337,  344,  104,  368,   89,
			  368,  204,  634,  369,  369,  369,  634,  104,  214,  384,
			  115,  338,  374,  374,  375,  342,  215,  104,  104,  339,
			  634,  383,  104,  118,  104,  385,  104,  337,  634,  372,
			  104,  372,  634,  204,  373,  373,  373,  104,  104,  104,
			  214,  384,  634,  338,  634,  634,  104,  342,  215,  104,
			  104,  339,  120,  386,  104,  118,  104,  385,  104,  367,
			  367,  367,  104,  370,  370,  370,  379,  379,  379,  104,
			  104,  387,  115,  261,  375,  375,  375,  371,  104,  377,

			  388,  378,  378,  378,  389,  386,  390,  391,  392,  634,
			  393,  395,  396,  397,  398,  400,  401,  402,  403,  404,
			  405,  406,  407,  387,  394,  261,  269,  399,  408,  371,
			  409,  410,  388,  411,  120,  412,  389,  413,  390,  391,
			  392,  269,  393,  395,  396,  397,  398,  400,  401,  402,
			  403,  404,  405,  406,  407,  414,  394,  417,  415,  399,
			  408,  416,  409,  410,  418,  411,  419,  412,  420,  413,
			  421,  423,  424,  425,  426,  427,  428,  429,  430,  431,
			  432,  433,  434,  435,  333,  231,  333,  414,  422,  417,
			  415,  634,  439,  416,  440,  634,  418,   89,  419,  634,

			  420,  634,  421,  423,  424,  425,  426,  427,  428,  429,
			  430,  431,  432,  433,  434,  435,  436,  437,  437,  437,
			  422,  212,  442,  212,   89,   89,   89,  444,  634,  634,
			   89,  445,  350,  350,  350,  446,  446,  446,  215,  369,
			  369,  369,  453,  634,  104,  369,  369,  369,  454,  261,
			  634,  443,  448,  448,  448,  449,  441,  449,  634,  634,
			  450,  450,  450,  373,  373,  373,  371,  373,  373,  373,
			  215,  104,  104,  104,  453,  447,  104,  104,  634,  634,
			  454,  261,  451,  443,  374,  374,  375,  451,  441,  375,
			  375,  375,  634,  455,  456,  118,  457,  377,  371,  452,

			  452,  452,  458,  104,  104,  104,  459,  634,  377,  104,
			  379,  379,  379,  460,  461,  462,  463,  464,  634,  465,
			  466,  467,  468,  469,  269,  455,  456,  118,  457,  269,
			  470,  471,  472,  473,  458,  474,  475,  476,  459,  269,
			  477,  478,  479,  480,  484,  460,  461,  462,  463,  464,
			  269,  465,  466,  467,  468,  469,  481,  481,  481,  485,
			  482,  486,  470,  471,  472,  473,  487,  474,  475,  476,
			  488,  483,  477,  478,  479,  480,  484,  489,  490,  491,
			  492,  493,  494,  495,  496,  497,  498,  499,  500,  501,
			  634,  485,  634,  486,  436,  502,  502,  502,  487,  634,

			  212,  212,  488,   89,   89,  212,  634,  634,   89,  489,
			  490,  491,  492,  493,  494,  495,  496,  497,  498,  499,
			  500,  501,  446,  446,  446,  509,  509,  509,  634,  634,
			  510,  510,  510,  505,  514,  515,  508,  450,  450,  450,
			  506,  634,  516,  504,  371,  450,  450,  450,  634,  634,
			  104,  104,  517,  519,  520,  104,  518,  262,  521,  510,
			  510,  510,  522,  523,  524,  505,  514,  515,  508,  525,
			  511,  526,  506,  512,  516,  504,  371,  513,  527,  379,
			  379,  379,  104,  104,  517,  519,  520,  104,  518,  528,
			  521,  529,  530,  531,  522,  523,  524,  532,  533,  534,

			  537,  525,  538,  526,  539,  512,  540,  481,  481,  481,
			  527,  535,  541,  542,  543,  544,  545,  546,  547,  120,
			  548,  528,  483,  529,  530,  531,  549,  550,  634,  532,
			  533,  534,  537,  634,  538,  634,  539,  212,  540,  212,
			   89,  634,   89,  564,  541,  542,  543,  544,  545,  546,
			  547,  212,  548,  634,   89,  555,  634,  555,  549,  550,
			  556,  556,  556,  557,  557,  557,  565,  553,  552,  510,
			  510,  510,  560,  560,  560,  564,  566,  558,  567,  561,
			  568,  561,  569,  559,  562,  562,  562,  104,  262,  104,
			  560,  560,  560,  554,  570,  571,  572,  573,  565,  553,

			  552,  104,  574,  575,  563,  576,  577,  578,  566,  558,
			  567,  579,  568,  580,  569,  559,  581,  582,  583,  104,
			  584,  104,  585,  634,  634,  554,  570,  571,  572,  573,
			  556,  556,  556,  104,  574,  575,  563,  576,  577,  578,
			  634,  212,  599,  579,   89,  580,  634,  634,  581,  582,
			  583,  634,  584,  212,  585,  212,   89,  634,   89,  556,
			  556,  556,  590,  590,  590,  591,  634,  591,  600,  587,
			  592,  592,  592,  593,  599,  593,  558,  634,  594,  594,
			  594,  601,  602,  589,  595,  595,  595,  562,  562,  562,
			  603,  104,  562,  562,  562,  588,  604,  605,  596,  606,

			  600,  587,  609,  104,  597,  104,  597,  610,  558,  598,
			  598,  598,  611,  601,  602,  589,  607,  607,  607,  612,
			  613,  212,  603,  104,   89,  620,  634,  588,  604,  605,
			  596,  606,  634,  615,  609,  104,   89,  104,  616,  610,
			  558,   89,  634,  634,  611,  621,  608,  592,  592,  592,
			  634,  612,  613,  592,  592,  592,  634,  620,  614,  594,
			  594,  594,  594,  594,  594,  623,  447,  617,  617,  617,
			  624,  104,  558,  598,  598,  598,  625,  621,  608,  596,
			  618,  596,  618,  104,  634,  619,  619,  619,  104,  634,
			  614,  598,  598,  598,  607,  607,  607,  623,  626,  627,

			  628,   89,  624,  104,  629,  511,  630,  631,  625,  632,
			  633,  596,  634,  596,  634,  104,  619,  619,  619,  634,
			  104,  619,  619,  619,  622,  267,  267,  267,  634,  634,
			  634,  627,  628,  634,  634,  634,  629,  634,  630,  631,
			  634,  632,  633,  634,  634,  634,  634,  634,  104,  634,
			  634,  634,  634,  105,  634,  105,  622,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  127,  127,  127,  127,
			  127,  127,  127,  127,  127,  634,  634,  634,  634,  634,
			  104,   66,   66,   66,   66,   66,   66,   66,   66,   66,
			   66,   66,   66,   66,   66,   66,   70,   70,   70,   70,

			   70,   70,   70,   70,   70,   70,   70,   70,   70,   70,
			   70,   75,   75,   75,   75,   75,   75,   75,   75,   75,
			   75,   75,   75,   75,   75,   75,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   86,  634,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,  106,  634,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  175,  634,  175,  175,
			  175,  634,  175,  175,  175,  175,  175,  175,  175,  175,

			  175,  200,  200,  200,  200,  200,  200,  200,  200,  200,
			  200,  200,  200,  200,  200,  200,  204,  204,  204,  204,
			  204,  204,  204,  204,  204,  204,  204,  204,  204,  204,
			  204,  206,  206,  206,  206,  206,  206,  206,  206,  206,
			  206,  206,  206,  206,  206,  206,   88,  634,   88,   88,
			   88,   88,   88,   88,   88,   88,   88,   88,   88,   88,
			   88,   89,  634,   89,  634,   89,   89,   89,   89,   89,
			   89,   89,   89,   89,   89,   89,  235,  634,  235,  235,
			  235,  235,  235,  235,  235,  235,  235,  235,  235,  235,
			  235,  331,  634,  331,  331,  331,  331,  331,  331,  331,

			  331,  331,  331,  331,  331,  331,  536,  536,  536,  536,
			  536,  536,  536,  536,  536,  536,  536,  536,  536,  536,
			  536,  586,  634,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,   13,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,

			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634, yy_Dummy>>)
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
			    1,    1,    3,    4,   70,    3,    4,   70,    3,    4,

			    5,    5,    5,  551,    5,    6,    6,    6,  536,    6,
			    9,    9,    9,   10,   10,   10,   11,   11,   11,   12,
			   12,   12,   15,   15,   15,   16,   16,   16,   21,   27,
			   21,   11,   35,   35,   12,   29,  503,   15,   40,   27,
			   16,   28,   29,   28,   28,   28,   48,   30,   42,   30,
			   30,   30,   37,   37,   49,   52,    5,  502,   42,   51,
			   30,    6,   74,  483,   31,   74,   31,   31,   31,   32,
			   40,   32,   32,   32,  445,  438,   51,   31,   48,  377,
			   42,  376,   30,   78,   78,   78,   49,   52,    5,   30,
			   42,   51,   30,    6,   18,   18,  332,   18,   18,   81,

			   81,   81,   18,   18,  267,   18,   31,   18,   51,   31,
			   57,   32,  258,   18,   30,   18,   39,   18,   18,   47,
			   41,   39,   53,   39,   41,   47,   18,   41,   39,   39,
			   41,   18,   18,   41,   43,  257,   43,   53,   55,  256,
			  255,   18,   57,   55,   18,   18,   43,   18,   39,  254,
			   18,   47,   41,   39,   53,   39,   41,   47,   18,   41,
			   39,   39,   41,   18,   18,   41,   43,   44,   43,   53,
			   55,   44,   46,   18,   56,   55,   18,   18,   43,   46,
			   46,   50,   54,   58,   44,   46,   86,   89,   56,   86,
			  253,   50,   54,   50,  128,   54,  130,   50,  252,   44,

			   82,   82,   82,   44,   46,  251,   56,   84,   84,   84,
			  250,   46,   46,   50,   54,   58,   44,   46,  200,   89,
			   56,  200,   84,   50,   54,   50,  128,   54,  130,   50,
			   69,   69,   69,  249,   69,   90,   86,   69,   90,   69,
			   69,   69,   71,   71,   71,   91,   71,   69,   91,   88,
			   88,  248,   88,   69,   88,   69,  247,   88,   69,   69,
			   69,   69,  246,   69,   92,   69,  245,   92,   86,   69,
			   93,   69,  244,   93,   69,   69,   69,   69,   69,   69,
			  243,   94,  241,   93,   94,   90,  240,   95,   96,  103,
			   95,   96,  103,   97,   98,   91,   97,   98,   71,   99,

			  239,   94,   99,  100,   88,  102,  100,   95,  102,  238,
			  131,  101,  101,  101,   92,  101,  129,   90,  101,  129,
			   93,  237,  120,  120,  120,   96,  132,   91,  133,   97,
			   71,   94,   98,  112,  112,  112,   88,   95,   96,  103,
			   99,  100,  131,   97,   98,  134,   92,  112,  129,   99,
			  211,  129,   93,  100,  206,  102,  102,   96,  132,  135,
			  133,   97,  120,   94,   98,  101,  175,  101,  108,   95,
			   96,  103,   99,  100,  106,   97,   98,  134,  136,  112,
			  137,   99,  104,  104,  104,  100,  104,  102,  138,  104,
			  115,  135,  115,  115,  115,  139,  141,  101,  116,  139,

			  116,  116,  116,  142,   85,  117,  115,  117,  117,  117,
			  136,  116,  137,  143,  144,   83,  145,  143,  142,  146,
			  138,  148,  151,   75,  153,   66,  154,  139,  141,  155,
			  156,  139,  159,  160,  163,  142,  104,   64,  115,  204,
			  116,   60,  204,  116,   38,  143,  144,  117,  145,  143,
			  142,  146,  164,  148,  151,  149,  153,  149,  154,  149,
			   33,  155,  156,   13,  159,  160,  163,  165,  104,  107,
			  149,  152,  107,  149,  107,  107,  107,    8,  177,  177,
			  177,    7,  107,  152,  164,  177,    0,  149,  107,  149,
			  107,  149,  157,  107,  107,  107,  107,    0,  107,  165,

			  107,  157,  149,  152,  107,  149,  107,  166,  168,  107,
			  107,  107,  107,  107,  107,  152,  161,  162,  161,  169,
			  167,  162,  170,  171,  157,  167,  161,  172,  270,  161,
			  271,  161,  161,  157,    0,  220,  167,    0,  220,  166,
			  168,  183,  183,  183,  208,  208,  208,  274,  161,  162,
			  161,  169,  167,  162,  170,  171,    0,  167,  161,  172,
			  270,  161,  271,  161,  161,  203,  203,  203,  167,  203,
			  210,  210,  210,  214,  214,  214,  214,  222,  214,  274,
			  222,  214,  215,  215,  215,  220,    0,  224,  225,    0,
			  224,  225,  226,    0,  229,  226,  227,  229,  228,  227,

			  228,    0,    0,  228,  230,  230,  230,  232,  230,  275,
			  232,  230,  242,  242,  242,  225,  233,  220,  261,  233,
			  261,  203,    0,  261,  261,  261,    0,  222,  214,  277,
			  265,  226,  265,  265,  265,  229,  215,  224,  225,  227,
			    0,  275,  226,  265,  229,  278,  227,  225,    0,  264,
			  228,  264,    0,  203,  264,  264,  264,  232,  230,  222,
			  214,  277,    0,  226,    0,    0,  233,  229,  215,  224,
			  225,  227,  265,  279,  226,  265,  229,  278,  227,  260,
			  260,  260,  228,  263,  263,  263,  269,  269,  269,  232,
			  230,  280,  266,  260,  266,  266,  266,  263,  233,  268,

			  281,  268,  268,  268,  282,  279,  283,  284,  286,    0,
			  287,  288,  289,  290,  291,  292,  293,  294,  295,  296,
			  297,  298,  299,  280,  287,  260,  269,  291,  300,  263,
			  301,  302,  281,  303,  266,  305,  282,  306,  283,  284,
			  286,  268,  287,  288,  289,  290,  291,  292,  293,  294,
			  295,  296,  297,  298,  299,  307,  287,  309,  308,  291,
			  300,  308,  301,  302,  310,  303,  311,  305,  312,  306,
			  313,  314,  315,  316,  317,  318,  319,  320,  321,  322,
			  323,  325,  326,  327,  333,  333,  333,  307,  313,  309,
			  308,    0,  337,  308,  337,    0,  310,  337,  311,    0,

			  312,    0,  313,  314,  315,  316,  317,  318,  319,  320,
			  321,  322,  323,  325,  326,  327,  330,  330,  330,  330,
			  313,  338,  339,  340,  338,  339,  340,  342,    0,    0,
			  342,  350,  350,  350,  350,  367,  367,  367,  333,  368,
			  368,  368,  380,    0,  337,  369,  369,  369,  381,  367,
			    0,  340,  370,  370,  370,  371,  338,  371,    0,    0,
			  371,  371,  371,  372,  372,  372,  370,  373,  373,  373,
			  333,  338,  339,  340,  380,  367,  337,  342,    0,    0,
			  381,  367,  374,  340,  374,  374,  374,  375,  338,  375,
			  375,  375,    0,  382,  383,  374,  384,  378,  370,  378,

			  378,  378,  385,  338,  339,  340,  386,    0,  379,  342,
			  379,  379,  379,  387,  388,  389,  390,  391,    0,  392,
			  393,  394,  395,  396,  374,  382,  383,  374,  384,  375,
			  397,  399,  400,  401,  385,  402,  403,  404,  386,  378,
			  405,  407,  409,  411,  414,  387,  388,  389,  390,  391,
			  379,  392,  393,  394,  395,  396,  412,  412,  412,  415,
			  412,  416,  397,  399,  400,  401,  417,  402,  403,  404,
			  418,  412,  405,  407,  409,  411,  414,  419,  420,  421,
			  422,  423,  424,  425,  426,  429,  430,  431,  432,  433,
			    0,  415,    0,  416,  437,  437,  437,  437,  417,    0,

			  439,  441,  418,  439,  441,  443,    0,    0,  443,  419,
			  420,  421,  422,  423,  424,  425,  426,  429,  430,  431,
			  432,  433,  446,  446,  446,  447,  447,  447,    0,    0,
			  448,  448,  448,  441,  455,  456,  446,  449,  449,  449,
			  443,    0,  459,  439,  448,  450,  450,  450,    0,    0,
			  439,  441,  460,  461,  463,  443,  460,  451,  464,  451,
			  451,  451,  465,  466,  467,  441,  455,  456,  446,  468,
			  448,  470,  443,  451,  459,  439,  448,  452,  471,  452,
			  452,  452,  439,  441,  460,  461,  463,  443,  460,  472,
			  464,  473,  475,  476,  465,  466,  467,  477,  479,  480,

			  484,  468,  485,  470,  486,  451,  487,  481,  481,  481,
			  471,  481,  488,  489,  490,  491,  492,  494,  495,  452,
			  498,  472,  481,  473,  475,  476,  499,  501,    0,  477,
			  479,  480,  484,    0,  485,    0,  486,  504,  487,  505,
			  504,    0,  505,  515,  488,  489,  490,  491,  492,  494,
			  495,  506,  498,    0,  506,  508,    0,  508,  499,  501,
			  508,  508,  508,  509,  509,  509,  516,  505,  504,  510,
			  510,  510,  511,  511,  511,  515,  518,  509,  519,  512,
			  520,  512,  523,  510,  512,  512,  512,  504,  513,  505,
			  513,  513,  513,  506,  525,  526,  528,  529,  516,  505,

			  504,  506,  530,  531,  513,  532,  534,  537,  518,  509,
			  519,  538,  520,  540,  523,  510,  541,  543,  547,  504,
			  548,  505,  550,    0,    0,  506,  525,  526,  528,  529,
			  555,  555,  555,  506,  530,  531,  513,  532,  534,  537,
			    0,  552,  564,  538,  552,  540,    0,    0,  541,  543,
			  547,    0,  548,  553,  550,  554,  553,    0,  554,  556,
			  556,  556,  557,  557,  557,  558,    0,  558,  566,  552,
			  558,  558,  558,  559,  564,  559,  557,    0,  559,  559,
			  559,  568,  569,  554,  560,  560,  560,  561,  561,  561,
			  570,  552,  562,  562,  562,  553,  573,  576,  560,  577,

			  566,  552,  579,  553,  563,  554,  563,  580,  557,  563,
			  563,  563,  581,  568,  569,  554,  578,  578,  578,  583,
			  584,  587,  570,  552,  587,  599,    0,  553,  573,  576,
			  560,  577,    0,  588,  579,  553,  588,  554,  589,  580,
			  590,  589,    0,    0,  581,  605,  578,  591,  591,  591,
			    0,  583,  584,  592,  592,  592,    0,  599,  587,  593,
			  593,  593,  594,  594,  594,  608,  590,  595,  595,  595,
			  609,  587,  590,  597,  597,  597,  611,  605,  578,  617,
			  596,  595,  596,  588,    0,  596,  596,  596,  589,    0,
			  587,  598,  598,  598,  607,  607,  607,  608,  614,  622,

			  623,  614,  609,  587,  627,  617,  628,  629,  611,  630,
			  631,  617,    0,  595,    0,  588,  618,  618,  618,    0,
			  589,  619,  619,  619,  607,  651,  651,  651,    0,    0,
			    0,  622,  623,    0,    0,    0,  627,    0,  628,  629,
			    0,  630,  631,    0,    0,    0,    0,    0,  614,    0,
			    0,    0,    0,  641,    0,  641,  607,  641,  641,  641,
			  641,  641,  641,  641,  641,  641,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,    0,    0,    0,    0,    0,
			  614,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  636,  636,  636,  636,

			  636,  636,  636,  636,  636,  636,  636,  636,  636,  636,
			  636,  637,  637,  637,  637,  637,  637,  637,  637,  637,
			  637,  637,  637,  637,  637,  637,  638,  638,  638,  638,
			  638,  638,  638,  638,  638,  638,  638,  638,  638,  638,
			  638,  639,  639,  639,  639,  639,  639,  639,  639,  639,
			  639,  639,  639,  639,  639,  639,  640,    0,  640,  640,
			  640,  640,  640,  640,  640,  640,  640,  640,  640,  640,
			  640,  642,    0,  642,  642,  642,  642,  642,  642,  642,
			  642,  642,  642,  642,  642,  642,  644,    0,  644,  644,
			  644,    0,  644,  644,  644,  644,  644,  644,  644,  644,

			  644,  645,  645,  645,  645,  645,  645,  645,  645,  645,
			  645,  645,  645,  645,  645,  645,  646,  646,  646,  646,
			  646,  646,  646,  646,  646,  646,  646,  646,  646,  646,
			  646,  647,  647,  647,  647,  647,  647,  647,  647,  647,
			  647,  647,  647,  647,  647,  647,  648,    0,  648,  648,
			  648,  648,  648,  648,  648,  648,  648,  648,  648,  648,
			  648,  649,    0,  649,    0,  649,  649,  649,  649,  649,
			  649,  649,  649,  649,  649,  649,  650,    0,  650,  650,
			  650,  650,  650,  650,  650,  650,  650,  650,  650,  650,
			  650,  652,    0,  652,  652,  652,  652,  652,  652,  652,

			  652,  652,  652,  652,  652,  652,  653,  653,  653,  653,
			  653,  653,  653,  653,  653,  653,  653,  653,  653,  653,
			  653,  654,    0,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,

			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   89,   90,   98,  103,  578,  574,  108,
			  111,  114,  117,  563, 1836,  120,  123, 1836,  188,    0,
			 1836,  119, 1836, 1836, 1836, 1836, 1836,  112,  123,  116,
			  129,  146,  151,  534, 1836,  107, 1836,  126,  518,  180,
			  100,  183,  114,  193,  237,    0,  237,  181,  102,  110,
			  250,  129,  121,  188,  245,  195,  244,  173,  239, 1836,
			  484, 1836, 1836, 1836,  446, 1836,  519, 1836, 1836,  328,
			   91,  340, 1836, 1836,  159,  520, 1836, 1836,  181, 1836,
			 1836,  197,  298,  498,  305,  487,  280, 1836,  348,  231,
			  329,  339,  358,  364,  375,  381,  382,  387,  388,  393,

			  397,  409,  399,  383,  480,    0,  463,  563,  457, 1836,
			 1836, 1836,  413, 1836, 1836,  472,  480,  487, 1836,    0,
			  402, 1836, 1836, 1836, 1836, 1836, 1836,    0,  260,  378,
			  263,  362,  377,  379,  411,  429,  435,  446,  441,  464,
			    0,  448,  470,  468,  473,  486,  475,    0,  476,  522,
			    0,  482,  539,  491,  477,  481,  497,  560,    0,  485,
			  499,  583,  576,  487,  518,  517,  562,  587,  574,  572,
			  584,  589,  580, 1836, 1836,  460, 1836,  576, 1836, 1836,
			 1836, 1836, 1836,  621, 1836, 1836, 1836, 1836, 1836, 1836,
			 1836, 1836, 1836, 1836, 1836, 1836, 1836, 1836, 1836, 1836,

			  315, 1836, 1836,  663,  536, 1836,  451, 1836,  642, 1836,
			  668,  443, 1836, 1836,  672,  680, 1836, 1836, 1836, 1836,
			  629, 1836,  671, 1836,  681,  682,  686,  690,  694,  688,
			  702, 1836,  701,  710, 1836, 1836, 1836,  410,  398,  389,
			  375,  371,  692,  369,  361,  355,  351,  345,  340,  322,
			  299,  294,  287,  279,  238,  229,  228,  224,  201, 1836,
			  759,  703, 1836,  763,  734,  712,  774,  144,  781,  766,
			  585,  600,    0,    0,  609,  662,    0,  697,  697,  722,
			  761,  753,  754,  772,  773,    0,  758,  780,  777,  764,
			  764,  772,  774,  782,  779,  784,  774,  790,  787,  792,

			  783,  792,  797,  789,    0,  801,  783,  806,  826,  823,
			  830,  836,  818,  838,  824,  838,  843,  836,  832,  842,
			  836,  844,  833,  842,    0,  843,  849,  840,    0, 1836,
			  897,    0,  123,  882, 1836, 1836, 1836,  888,  915,  916,
			  917, 1836,  921, 1836, 1836, 1836, 1836, 1836, 1836, 1836,
			  912, 1836, 1836, 1836, 1836, 1836, 1836, 1836, 1836, 1836,
			 1836, 1836, 1836, 1836, 1836, 1836, 1836,  915,  919,  925,
			  932,  940,  943,  947,  964,  969,  121,  161,  979,  990,
			  893,  900,  957,  956,  956,  954,  972,  964,  980,  979,
			  969,  979,  972,  977,  974,  975,  989,  980,    0,  997,

			  994,  980,  982,  989, 1003,  993,    0, 1000,    0, 1007,
			    0, 1002, 1054,    0, 1006, 1009, 1023, 1031, 1023, 1035,
			 1040, 1029, 1039, 1027, 1050, 1036, 1039,    0,    0, 1051,
			 1051, 1037, 1047, 1059,    0,    0, 1836, 1075,  105, 1094,
			 1836, 1095, 1836, 1099, 1836,  163, 1102, 1105, 1110, 1117,
			 1125, 1139, 1159,    0,    0, 1091, 1104,    0,    0, 1095,
			 1118, 1110,    0, 1107, 1123, 1128, 1130, 1115, 1126,    0,
			 1124, 1135, 1155, 1153,    0, 1154, 1161, 1159,    0, 1144,
			 1165, 1205, 1836,  146, 1170, 1155, 1151, 1168, 1178, 1179,
			 1167, 1181, 1167,    0, 1168, 1188,    0,    0, 1182, 1192,

			    0, 1184,  138,   61, 1231, 1233, 1245, 1836, 1240, 1243,
			 1249, 1252, 1264, 1270,    0, 1193, 1217,    0, 1232, 1229,
			 1246,    0,    0, 1248,    0, 1264, 1261,    0, 1248, 1254,
			 1253, 1254, 1275,    0, 1257, 1836,  105, 1266, 1263,    0,
			 1270, 1273,    0, 1283,    0,    0,    0, 1269, 1277,    0,
			 1273,   37, 1335, 1347, 1349, 1310, 1339, 1342, 1350, 1358,
			 1364, 1367, 1372, 1389, 1293,    0, 1325,    0, 1348, 1349,
			 1349,    0,    0, 1360,    0,    0, 1354, 1365, 1414, 1358,
			 1373, 1380,    0, 1385, 1386,    0,    0, 1415, 1427, 1432,
			 1406, 1427, 1433, 1439, 1442, 1447, 1465, 1453, 1471, 1391,

			    0,    0,    0,    0,    0, 1396,    0, 1492, 1424, 1423,
			    0, 1442,    0,    0, 1492, 1836, 1836, 1445, 1496, 1501,
			    0,    0, 1458, 1470,    0,    0, 1836, 1474, 1458, 1459,
			 1461, 1462,    0, 1836, 1836, 1580, 1595, 1610, 1625, 1640,
			 1655, 1550, 1670, 1559, 1685, 1700, 1715, 1730, 1745, 1760,
			 1775, 1518, 1790, 1805, 1820, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  634,    1,  635,  635,  636,  636,  637,  637,  638,
			  638,  639,  639,  634,  634,  634,  634,  634,  640,  641,
			  634,  642,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  634,
			  634,  634,  634,  634,  634,  634,  644,  634,  634,  634,
			  645,  645,  634,  634,  646,  647,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  640,  634,  648,  649,
			  640,  640,  640,  640,  640,  640,  640,  640,  640,  640,

			  640,  640,  640,  640,  640,  641,  650,  650,  650,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  651,
			  634,  634,  634,  634,  634,  634,  634,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  634,  634,  644,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,

			  645,  634,  634,  645,  646,  634,  647,  634,  634,  634,
			  634,  652,  634,  634,  648,  649,  634,  634,  634,  634,
			  640,  634,  640,  634,  640,  640,  640,  640,  640,  640,
			  640,  634,  640,  640,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  651,  634,  634,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,

			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  634,
			  634,  652,  652,  649,  634,  634,  634,  640,  640,  640,
			  640,  634,  640,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  651,  634,  634,  634,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,

			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  634,  634,  652,  640,
			  634,  640,  634,  640,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  634,  634,  634,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,

			  643,  643,  634,  652,  640,  640,  640,  634,  634,  634,
			  634,  634,  634,  634,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  634,  653,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  652,  640,  640,  640,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  643,  643,  643,  643,
			  643,  643,  643,  643,  643,  643,  654,  640,  640,  640,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  643,

			  643,  643,  643,  643,  643,  643,  643,  634,  643,  643,
			  643,  643,  643,  643,  640,  634,  634,  634,  634,  634,
			  643,  643,  634,  643,  643,  643,  634,  634,  643,  634,
			  643,  634,  643,  634,    0,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   22,   22,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,
			   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,
			   55,   56,   57,   58,   59,   60,   61,   62,   63,   64,

			   65,   66,   67,   68,   69,   70,   71,   72,   73,   74,
			   75,   76,   77,   78,   79,   80,   81,   82,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,    1,    1,    1,
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
			    7,    8,    9,    3,    3,    3,    3,    3,    3,    3,
			    7,    7,    7,    7,    7,    7,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   11,   12,    3,    3,    3,    3,
			   13,    3,    7,    7,    7,    7,    7,    7,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   14,   15,    3,    3,
			    3,    3, yy_Dummy>>)
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
			  231,  231,  232,  233,  234,  235,  236,  237,  238,  239,
			  240,  241,  243,  244,  245,  246,  247,  248,  249,  250,
			  251,  253,  254,  255,  256,  257,  258,  259,  261,  262,
			  263,  265,  266,  267,  268,  269,  270,  271,  272,  274,
			  275,  276,  277,  278,  279,  280,  281,  282,  283,  284,
			  285,  286,  287,  288,  289,  290,  291,  292,  292,  293,
			  294,  295,  296,  297,  297,  298,  299,  300,  301,  302,
			  303,  304,  305,  306,  307,  308,  309,  310,  311,  312,

			  313,  314,  315,  316,  317,  318,  320,  321,  322,  322,
			  323,  324,  325,  326,  328,  330,  331,  333,  335,  337,
			  339,  340,  342,  343,  345,  346,  347,  348,  349,  350,
			  351,  352,  353,  354,  355,  357,  358,  360,  361,  362,
			  363,  364,  365,  366,  367,  368,  369,  370,  371,  372,
			  373,  374,  375,  376,  377,  378,  379,  380,  381,  382,
			  384,  385,  385,  386,  387,  387,  388,  389,  390,  391,
			  391,  392,  393,  395,  397,  398,  399,  401,  402,  403,
			  404,  405,  406,  407,  408,  409,  411,  412,  413,  414,
			  415,  416,  417,  418,  419,  420,  421,  422,  423,  424,

			  425,  426,  427,  429,  430,  432,  433,  434,  435,  436,
			  437,  438,  439,  440,  441,  442,  443,  444,  445,  446,
			  447,  448,  449,  450,  451,  453,  454,  455,  456,  458,
			  459,  459,  460,  461,  461,  463,  465,  467,  468,  469,
			  470,  471,  473,  474,  476,  478,  479,  480,  481,  482,
			  483,  484,  485,  486,  487,  488,  489,  490,  491,  492,
			  493,  494,  495,  496,  497,  498,  499,  500,  501,  501,
			  502,  503,  503,  503,  504,  505,  506,  506,  506,  507,
			  508,  509,  510,  511,  512,  513,  514,  515,  516,  517,
			  518,  519,  521,  522,  523,  524,  525,  526,  527,  529,

			  530,  531,  532,  533,  534,  535,  536,  538,  539,  541,
			  542,  544,  545,  547,  549,  550,  551,  552,  553,  554,
			  555,  556,  557,  558,  559,  560,  561,  562,  564,  566,
			  567,  568,  569,  570,  571,  573,  575,  576,  576,  577,
			  578,  580,  581,  583,  584,  586,  587,  588,  588,  589,
			  589,  590,  591,  592,  594,  596,  597,  598,  600,  602,
			  603,  604,  605,  607,  608,  609,  610,  611,  612,  613,
			  615,  616,  617,  618,  619,  621,  622,  623,  624,  626,
			  627,  628,  628,  629,  629,  630,  631,  632,  633,  634,
			  635,  636,  637,  638,  640,  641,  642,  644,  646,  647,

			  648,  650,  651,  651,  652,  653,  654,  655,  656,  656,
			  657,  658,  658,  658,  659,  661,  662,  663,  665,  666,
			  667,  668,  670,  672,  673,  675,  676,  677,  679,  680,
			  681,  682,  683,  684,  686,  687,  688,  688,  689,  690,
			  692,  693,  694,  696,  697,  699,  701,  703,  704,  705,
			  707,  708,  709,  710,  711,  712,  712,  713,  714,  714,
			  714,  715,  715,  716,  716,  717,  719,  720,  722,  723,
			  724,  725,  727,  729,  730,  732,  734,  735,  736,  737,
			  738,  739,  740,  742,  743,  744,  746,  748,  749,  750,
			  751,  752,  752,  753,  753,  754,  755,  755,  755,  756,

			  757,  759,  761,  763,  765,  767,  768,  770,  770,  771,
			  772,  774,  775,  777,  779,  780,  782,  784,  785,  785,
			  786,  788,  790,  790,  791,  793,  795,  797,  797,  798,
			  798,  799,  799,  801,  802,  802, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  175,  175,  177,  177,  208,  206,  207,    1,  206,
			  207,    1,  207,   36,  206,  207,  178,  206,  207,   41,
			  206,  207,   15,  206,  207,  145,  206,  207,   24,  206,
			  207,   25,  206,  207,   32,  206,  207,   30,  206,  207,
			    9,  206,  207,   31,  206,  207,   14,  206,  207,   33,
			  206,  207,  117,  206,  207,  117,  206,  207,  117,  206,
			  207,    8,  206,  207,    7,  206,  207,   19,  206,  207,
			   18,  206,  207,   20,  206,  207,   11,  206,  207,  115,
			  206,  207,  115,  206,  207,  115,  206,  207,  115,  206,
			  207,  115,  206,  207,  115,  206,  207,  115,  206,  207,

			  115,  206,  207,  115,  206,  207,  115,  206,  207,  115,
			  206,  207,  115,  206,  207,  115,  206,  207,  115,  206,
			  207,  115,  206,  207,  115,  206,  207,  115,  206,  207,
			  115,  206,  207,  115,  206,  207,  115,  206,  207,   28,
			  206,  207,  206,  207,   29,  206,  207,   34,  206,  207,
			   26,  206,  207,   27,  206,  207,   12,  206,  207,  179,
			  207,  205,  207,  203,  207,  204,  207,  175,  207,  175,
			  207,  174,  207,  173,  207,  175,  207,  177,  207,  176,
			  207,  171,  207,  171,  207,  170,  207,    6,  207,    5,
			    6,  207,    5,  207,    6,  207,    1,  178,  167,  178,

			  178,  178,  178,  178,  178,  178,  178,  178,  178,  178,
			  178,  178, -376,  178,  178,  178, -376,   41,  145,  145,
			  145,    2,   35,   10,  120,   39,   23,  120,  117,  117,
			  116,   16,   37,   21,   22,   38,   17,  115,  115,  115,
			  115,   46,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,   58,  115,  115,  115,  115,  115,  115,  115,   70,
			  115,  115,  115,   77,  115,  115,  115,  115,  115,  115,
			  115,  115,   90,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,   40,   13,
			  179,  203,  196,  194,  195,  197,  198,  199,  200,  180,

			  181,  182,  183,  184,  185,  186,  187,  188,  189,  190,
			  191,  192,  193,  175,  174,  173,  175,  175,  172,  173,
			  177,  176,  170,    5,    4,  168,  166,  168,  178, -376,
			 -376,  153,  168,  151,  168,  152,  168,  154,  168,  178,
			  147,  168,  178,  148,  168,  178,  178,  178,  178,  178,
			  178,  178, -169,  178,  178,  155,  168,  145,  121,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  122,  145,  120,  118,  120,  117,  117,  119,
			  117,  115,  115,   44,  115,   45,  115,  115,  115,   49,

			  115,  115,  115,  115,  115,  115,  115,  115,  115,   61,
			  115,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,   82,  115,  115,
			   85,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  110,  115,  115,  115,  115,  114,  115,  202,    4,
			    4,  156,  168,  149,  168,  150,  168,  178,  178,  178,
			  178,  163,  168,  178,  158,  168,  157,  168,  139,  137,
			  138,  140,  141,  146,  142,  143,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,

			  120,  120,  120,  120,  117,  117,  117,  117,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  115,   59,
			  115,  115,  115,  115,  115,  115,  115,   68,  115,  115,
			  115,  115,  115,  115,  115,  115,   78,  115,  115,   80,
			  115,  115,   83,  115,  115,   88,  115,   89,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  104,  115,  105,  115,  115,  115,  115,  115,
			  115,  112,  115,  113,  115,  201,    4,  178,  159,  168,
			  178,  162,  168,  178,  165,  168,  146,  120,  120,  120,
			  120,  117,   42,  115,   43,  115,  115,  115,   50,  115,

			   51,  115,  115,  115,  115,   56,  115,  115,  115,  115,
			  115,  115,  115,   66,  115,  115,  115,  115,  115,   73,
			  115,  115,  115,  115,   79,  115,  115,  115,   86,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  100,  115,
			  115,  115,  103,  115,  106,  115,  115,  115,  109,  115,
			  115,    4,  178,  178,  178,  144,  120,  120,  120,   47,
			  115,  115,  115,   53,  115,  115,  115,  115,   60,  115,
			   62,  115,  115,   64,  115,  115,  115,   69,  115,  115,
			  115,  115,  115,  115,   81,  115,  115,   87,  115,  115,
			   93,  115,  115,  115,   96,  115,  115,   98,  115,   99,

			  115,  101,  115,  115,  115,  108,  115,  115,    4,  178,
			  178,  178,  120,  120,  120,  120,  115,   52,  115,  115,
			   55,  115,  115,  115,  115,   67,  115,   71,  115,  115,
			   74,  115,   75,  115,  115,  115,  115,  115,  115,  115,
			   97,  115,  115,  115,  111,  115,    3,    4,  178,  178,
			  178,  120,  120,  120,  120,  120,  115,   54,  115,   57,
			  115,   63,  115,   65,  115,   72,  115,  115,   84,  115,
			  115,  115,   94,  115,  115,  102,  115,  107,  115,  178,
			  161,  168,  164,  168,  120,  120,   48,  115,   76,  115,
			  115,   92,  115,   95,  115,  160,  168,  115,  115,   91,

			  115,   91, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1836
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 634
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 635
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

	yyNb_rules: INTEGER is 207
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 208
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