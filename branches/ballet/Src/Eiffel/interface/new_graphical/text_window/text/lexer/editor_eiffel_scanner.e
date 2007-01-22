indexing
	description:"Scanners for Eiffel parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author:     "Arnaud PICHERY from an Eric Bezault model"
	date:       "$Date$"
	revision:   "$Revision$"

class EDITOR_EIFFEL_SCANNER

inherit

	EDITOR_SCANNER

	EDITOR_EIFFEL_SCANNER_SKELETON	

create
	make

feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= VERBATIM_STR1)
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
			inspect yy_act
when 1 then
--|#line 34 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 34")
end
-- Ignore carriage return
when 2 then
--|#line 35 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 35")
end

					create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
					update_token_list
					
when 3 then
--|#line 39 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 39")
end

					if not in_comments then
						create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 4 then
--|#line 47 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 47")
end

					from i_ := 1 until i_ > text_count loop
						create {EDITOR_TOKEN_EOL} curr_token.make
						update_token_list
						i_ := i_ + 1
					end
					in_comments := False
					
when 5 then
--|#line 59 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 59")
end
 
						-- comments
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					in_comments := True	
					update_token_list					
				
when 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 then
--|#line 68 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 68")
end

						-- Symbols
					if not in_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36 then
--|#line 89 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 89")
end
 
						-- Operator Symbol
					if not in_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)					
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103 then
--|#line 119 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 119")
end

										-- Keyword
										if not in_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 104 then
--|#line 198 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 198")
end

										if not in_comments then
											if is_current_group_valid then
												tmp_classes := current_group.class_by_name (text, True)
												if not tmp_classes.is_empty then
													create {EDITOR_TOKEN_CLASS} curr_token.make (text)
													curr_token.set_pebble (stone_of_class (tmp_classes.first))
												else
													create {EDITOR_TOKEN_TEXT} curr_token.make (text)
												end
											else
												create {EDITOR_TOKEN_TEXT} curr_token.make (text)
											end							
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 105 then
--|#line 218 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 218")
end

										if not in_comments then
												create {EDITOR_TOKEN_TEXT} curr_token.make(text)											
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 106 then
--|#line 230 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 230")
end

										if not in_comments then
											create {EDITOR_TOKEN_TEXT} curr_token.make(text)										
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128 then
--|#line 244 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 244")
end

					if not in_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 129 then
--|#line 274 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 274")
end

					if not in_comments then
						code_ := text_substring (4, text_count - 2).to_integer
						if code_ > {CHARACTER}.Max_value then
							-- Character error. Consedered as text.
							create {EDITOR_TOKEN_TEXT} curr_token.make(text)
						else
							create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
						end						
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 130, 131 then
--|#line 289 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 289")
end

					-- Character error. Catch-all rules (no backing up)
					if not in_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 132 then
--|#line 312 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 312")
end

 				if not in_comments then
						-- Verbatim string opener.
					create {EDITOR_TOKEN_STRING} curr_token.make(text)
					update_token_list
					in_verbatim_string := True
					start_of_verbatim_string := True
					set_start_condition (VERBATIM_STR1)
				else
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					update_token_list
				end
			
when 133 then
--|#line 326 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 326")
end

				if not in_comments then
						-- Verbatim string opener.
					create {EDITOR_TOKEN_STRING} curr_token.make(text)
					update_token_list
					in_verbatim_string := True
					start_of_verbatim_string := True
					set_start_condition (VERBATIM_STR1)
				else
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					update_token_list
				end				
			
when 134 then
--|#line 341 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 341")
end
-- Ignore carriage return
when 135 then
--|#line 342 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 342")
end

							-- Verbatim string closer, possibly.
						create {EDITOR_TOKEN_STRING} curr_token.make(text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 136 then
--|#line 351 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 351")
end

							-- Verbatim string closer, possibly.
						create {EDITOR_TOKEN_STRING} curr_token.make(text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 137 then
--|#line 360 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 360")
end

						create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
						update_token_list						
					
when 138 then
--|#line 365 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 365")
end
						
						create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
						update_token_list						
					
when 139 then
--|#line 370 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 370")
end

						from i_ := 1 until i_ > text_count loop
							create {EDITOR_TOKEN_EOL} curr_token.make
							update_token_list
							i_ := i_ + 1
						end						
					
when 140 then
--|#line 378 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 378")
end

						create {EDITOR_TOKEN_STRING} curr_token.make(text)
						update_token_list
					
when 141, 142 then
--|#line 384 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 384")
end

					-- Eiffel String
					if not in_comments then						
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 143 then
--|#line 397 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 397")
end

					-- Eiffel Bit
					if not in_comments then
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)						
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 144, 145, 146, 147 then
--|#line 409 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 409")
end

						-- Eiffel Integer
						if not in_comments then
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 148 then
--|#line 421 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 421")
end

							-- Eiffel Integer Error (considered as text)
						if not in_comments then
							create {EDITOR_TOKEN_TEXT} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 149 then
	yy_end := yy_end - 1
--|#line 433 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 433")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 150, 151 then
--|#line 434 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 434")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 152 then
	yy_end := yy_end - 1
--|#line 436 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 436")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 153, 154 then
--|#line 437 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 437")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 155 then
--|#line 454 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 454")
end

					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
when 156 then
--|#line 462 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 462")
end

					-- Error (considered as text)
				if not in_comments then
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
				else
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
				end
				update_token_list
				
when 157 then
--|#line 0 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 0")
end
default_action
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER) is
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0, 1 then
--|#line 0 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 0")
end
terminate
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,   27,   28,   29,   30,   31,   32,   33,
			   34,   35,   36,   37,   38,   39,   40,   40,   41,   40,
			   40,   42,   40,   43,   44,   45,   40,   46,   47,   48,
			   49,   50,   51,   52,   40,   40,   53,   54,   55,   56,
			   57,   58,   59,   60,   61,   62,   63,   64,   65,   65,
			   66,   65,   65,   67,   68,   69,   70,   71,   65,   72,
			   73,   74,   75,   76,   77,   78,   65,   65,   79,   80,
			   82,   83,   84,   85,   82,   83,   84,   85,   94,   94,

			  103,   95,   95,  101,  102,  105,  107,  106,  106,  106,
			  106,  104,  633,  109,  108,  110,  110,  111,  111,  109,
			  123,  110,  110,  111,  111,  536,  112,  113,  118,  119,
			  134,  109,  116,  111,  111,  111,  111,  120,  121,  123,
			  183,  529,  149,  174,  150,  626,   86,   96,  114,  420,
			   86,  420,  128,  406,  151,  115,  205,  123,  112,  113,
			  215,  115,  134,  215,  116,  222,   94,   94,  212,   95,
			  381,  128,  183,  115,  152,  174,  153,   87,  405,   97,
			  114,   87,  123,  123,  123,  123,  154,  187,  206,  128,
			  404,  123,  123,  123,  123,  123,  123,  123,  124,  123,

			  123,  123,  123,  125,  123,  126,  123,  123,  123,  123,
			  127,  123,  123,  123,  123,  123,  123,  123,  403,  188,
			  263,  263,  123,  128,  128,  128,  128,  128,  128,  128,
			  129,  128,  128,  128,  128,  130,  128,  131,  128,  128,
			  128,  128,  132,  128,  128,  128,  128,  128,  128,  128,
			  123,  123,  123,  123,  264,  264,  264,  402,  401,  186,
			  123,  123,  123,  123,  123,  123,  123,  123,  133,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  210,  210,  210,  210,
			  123,  186,  128,  128,  128,  128,  128,  128,  128,  128,

			  134,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  128,  128,  135,  123,
			  145,  169,  136,  188,  123,  137,  210,  170,  138,  155,
			  146,  139,  161,  156,  123,  123,  123,  123,  123,  162,
			  163,  400,  173,  185,  207,  164,  157,  206,  399,  398,
			  140,  128,  147,  171,  141,  188,  128,  142,  397,  172,
			  143,  158,  148,  144,  165,  159,  128,  128,  128,  128,
			  128,  166,  167,  175,  174,  186,  208,  168,  160,  206,
			  123,  193,  123,  176,  189,  177,  178,  123,  123,  179,
			  201,  194,  197,  147,  152,  129,  153,  198,  123,  190,

			  130,  396,  131,  148,  202,  180,  154,  132,   94,  395,
			  394,   95,  128,  195,  128,  181,  191,  182,  183,  128,
			  128,  184,  203,  196,  199,  147,  152,  129,  153,  200,
			  128,  192,  130,  140,  131,  148,  204,  141,  154,  132,
			  142,  158,  165,  143,  180,  159,  144,  171,  191,  166,
			  167,  195,  199,  172,  181,  168,  182,  200,  160,  393,
			  184,  196,  208,  192,  213,  140,  214,  214,  214,  141,
			  218,  214,  142,  158,  165,  143,  180,  159,  144,  171,
			  191,  166,  167,  195,  199,  172,  181,  168,  182,  200,
			  160,  203,  184,  196,  208,  192,  214,   94,  214,  221,

			   95,  216,  123,  268,  216,  204,  223,  123,  229,  212,
			  229,  229,  269,   94,  215,  382,   95,  215,   95,  222,
			  215,  274,  212,  203,  219,  230,  123,  230,  230,   94,
			   94,  275,  384,   95,  128,  269,  392,  204,  391,  128,
			  255,  255,  255,  255,  269,  277,   96,  259,  259,  259,
			  259,  216,  215,  275,  256,  220,  389,  388,  128,  123,
			  279,  260,   96,  275,  266,  266,  266,  266,  109,  276,
			  261,  261,  262,  262,  123,  387,  386,  277,   97,   96,
			  257,  116,  385,  216,  225,  278,  256,  226,   99,   99,
			   99,  128,  279,  260,   97,  109,  227,  262,  262,  262,

			  262,  277,  217,   99,  267,   99,  128,   99,   99,  228,
			  115,   97,   99,  116,   99,  280,  380,  279,   99,  123,
			   99,  379,  378,   99,   99,   99,   99,   99,   99,  233,
			  232,   91,  234,  235,  236,  237,  382,  115,   90,  381,
			   89,  238,  270,  272,  123,  271,  273,  281,  239,  284,
			  240,  128,  241,  242,  243,  244,  282,  245,  286,  246,
			  281,  283,  123,  247,  123,  248,  285,  287,  249,  250,
			  251,  252,  253,  254,  272,  272,  128,  273,  273,  289,
			  123,  285,  123,  292,  295,  123,   88,  293,  283,  288,
			  287,  298,  281,  283,  128,  294,  128,  290,  285,  287,

			  305,  291,  123,  296,  123,  307,  299,  123,  123,  300,
			  304,  289,  128,  301,  128,  292,  295,  128,  297,  293,
			  302,  289,  306,  298,  303,  123,  309,  295,  123,  292,
			  123,  308,  305,  293,  128,  298,  128,  307,  299,  128,
			  128,  302,  305,  123,  123,  303,  311,  217,  323,  329,
			  299,  310,  302,  209,  307,  326,  303,  128,  309,  123,
			  128,  322,  128,  309,  312,  324,  313,  327,  314,  123,
			  317,  123,  318,  123,  319,  128,  128,  325,  311,  315,
			  323,  329,  316,  311,  328,  320,  122,  326,  321,  332,
			  336,  128,  123,  323,  123,  123,  317,  326,  318,  327,

			  319,  128,  317,  128,  318,  128,  319,  334,  123,  327,
			  331,  320,  333,  123,  321,  335,  329,  320,  330,  337,
			  321,  333,  337,  339,  128,  338,  128,  128,  117,  123,
			   94,  123,   92,  381,  352,   91,   90,  357,  353,  335,
			  128,   89,  331,   88,  333,  128,  806,  335,  354,  358,
			  331,  337,  355,  123,  359,  339,  123,  339,  346,  806,
			  347,  128,  340,  128,  341,  356,  354,  123,  348,  357,
			  355,  349,  342,  350,  351,  343,  361,  344,  345,  123,
			  354,  359,  362,  369,  355,  128,  359,  363,  128,  368,
			  346,  360,  347,  123,  346,  372,  347,  357,  364,  128,

			  348,  371,  373,  349,  348,  350,  351,  349,  361,  350,
			  351,  128,  365,  123,  365,  369,  374,  366,  375,  366,
			  123,  369,  370,  361,  377,  128,  123,  373,  367,  213,
			  367,  214,  214,  371,  373,  376,  210,  210,  210,  210,
			  214,  806,  214,  214,  365,  128,  806,  424,  375,  366,
			  375,  806,  128,  806,  371,  806,  377,  806,  128,  214,
			  367,  218,  214,  216,  806,  806,  216,  377,  223,  123,
			  214,  212,  214,  221,   94,  806,  210,  381,  229,  424,
			  229,  229,  426,   94,  806,  215,   95,  383,  383,  383,
			  383,  390,  390,  390,  390,  230,  215,  230,  230,  806,

			   94,  128,  123,   95,  407,  407,  407,  407,  410,  410,
			  410,  410,  263,  263,  426,  219,  216,  408,  256,  408,
			  806,  806,  409,  409,  409,  409,  215,  216,  411,  411,
			  411,  411,   96,  414,  128,  414,  806,  806,  415,  415,
			  415,  415,  412,  806,  257,  806,  220,  427,  428,   96,
			  256,  806,  418,  264,  264,  264,  109,  216,  416,  416,
			  417,  417,  123,  425,   97,  123,  806,  423,  413,  116,
			  806,  123,  430,  109,  412,  417,  417,  417,  417,  428,
			  428,   97,  421,  421,  421,  421,  422,  422,  422,  422,
			  806,  432,  123,  419,  128,  426,  429,  128,  115,  424,

			  123,  116,  123,  128,  430,  433,  434,  436,  435,  123,
			  431,  438,  440,  123,  442,  115,  123,  441,  437,  444,
			  123,  123,  267,  432,  128,  439,  267,  443,  430,  446,
			  806,  123,  128,  452,  128,  123,  806,  434,  434,  436,
			  436,  128,  432,  438,  440,  128,  442,  445,  128,  442,
			  438,  444,  128,  128,  447,  449,  451,  440,  454,  444,
			  123,  446,  123,  128,  123,  452,  123,  128,  448,  450,
			  456,  459,  123,  462,  453,  123,  457,  455,  461,  446,
			  465,  463,  806,  464,  460,  123,  449,  449,  452,  458,
			  454,  467,  128,  466,  128,  123,  128,  468,  128,  470,

			  450,  450,  456,  459,  128,  462,  454,  128,  459,  456,
			  462,  123,  466,  464,  471,  464,  460,  128,  469,  472,
			  473,  460,  123,  468,  123,  466,  474,  128,  475,  468,
			  123,  470,  476,  478,  123,  123,  123,  477,  480,  123,
			  481,  479,  482,  128,  123,  483,  472,  484,  806,  806,
			  470,  472,  474,  489,  128,  491,  128,  123,  474,  123,
			  476,  490,  128,  492,  476,  478,  128,  128,  128,  478,
			  480,  128,  482,  480,  482,  485,  128,  484,  486,  484,
			  487,  123,  493,  488,  123,  490,  497,  492,  123,  128,
			  123,  128,  123,  490,  494,  492,  495,  501,  496,  499,

			  502,  503,  504,  505,  498,  123,  506,  487,  507,  508,
			  488,  123,  487,  128,  494,  488,  128,  500,  499,  510,
			  128,  511,  128,  512,  128,  123,  494,  517,  496,  502,
			  496,  499,  502,  504,  504,  506,  500,  128,  506,  123,
			  508,  508,  513,  128,  509,  514,  123,  516,  123,  500,
			  518,  510,  123,  512,  519,  512,  515,  128,  520,  518,
			  521,  522,  123,  524,  123,  123,  806,  523,  806,  263,
			  263,  128,  806,  806,  514,  806,  510,  514,  128,  516,
			  128,  806,  518,  806,  128,  806,  520,  806,  516,  806,
			  520,  540,  522,  522,  128,  524,  128,  128,   94,  524,

			  382,  381,  806,  381,  526,  390,  390,  390,  390,  418,
			   99,  525,  525,  525,  525,  527,  527,  527,  527,  409,
			  409,  409,  409,  540,  806,  806,   99,  806,  542,  256,
			  528,  528,  528,  528,  530,  530,  530,  530,  531,  531,
			  531,  531,  532,  806,  532,  806,  806,  533,  533,  533,
			  533,  806,  412,  806,  806,  257,  534,  534,  534,  534,
			  542,  256,  415,  415,  415,  415,  535,  535,  535,  535,
			  529,  544,  537,  123,  416,  416,  417,  417,  413,  264,
			  264,  264,  806,  541,  412,  116,  537,  806,  417,  417,
			  417,  417,  538,  538,  538,  538,  422,  422,  422,  422,

			  806,  123,  546,  544,  806,  128,  536,  543,  123,  123,
			  545,  123,  539,  548,  267,  542,  549,  116,  550,  419,
			  123,  547,  552,  553,  123,  554,  556,  123,  267,  555,
			  558,  123,  267,  128,  546,  551,  267,  123,  559,  544,
			  128,  128,  546,  128,  540,  548,  557,  560,  550,  562,
			  550,  123,  128,  548,  552,  554,  128,  554,  556,  128,
			  561,  556,  558,  128,  123,  564,  123,  552,  566,  128,
			  560,  563,  568,  565,  570,  123,  569,  123,  558,  560,
			  123,  562,  572,  128,  567,  123,  573,  574,  575,  571,
			  123,  576,  562,  578,  806,  123,  128,  564,  128,  580,

			  566,  582,  584,  564,  568,  566,  570,  128,  570,  128,
			  577,  123,  128,  586,  572,  123,  568,  128,  574,  574,
			  576,  572,  128,  576,  581,  578,  579,  128,  583,  123,
			  123,  580,  123,  582,  584,  588,  123,  123,  585,  587,
			  590,  123,  578,  128,  589,  586,  123,  128,  591,  592,
			  595,  123,  594,  123,  596,  598,  582,  600,  580,  602,
			  584,  128,  128,  597,  128,  593,  123,  588,  128,  128,
			  586,  588,  590,  128,  603,  604,  590,  606,  128,  123,
			  592,  592,  596,  128,  594,  128,  596,  598,  599,  600,
			  123,  602,  123,  123,  601,  598,  607,  594,  128,  608,

			  123,  610,  611,  612,  605,  123,  604,  604,  123,  606,
			  614,  128,  123,  616,  613,  123,  609,  123,  617,  615,
			  600,  123,  128,  618,  128,  128,  602,  123,  608,  620,
			  622,  608,  128,  610,  612,  612,  606,  128,  123,  619,
			  128,  621,  614,  624,  128,  616,  614,  128,  610,  128,
			  618,  616,  623,  128,  123,  618,  123,  123,  123,  128,
			  123,  620,  622,  806,   94,  806,  806,  381,  806,   94,
			  128,  620,  381,  622,  640,  624,   99,  625,  625,  625,
			  625,   99,  806,  806,  624,  806,  128,  806,  128,  128,
			  128,  806,  128,  527,  527,  527,  527,  628,  628,  628,

			  628,  629,  629,  629,  629,  806,  640,  627,  630,  630,
			  630,  630,  631,  631,  631,  631,  533,  533,  533,  533,
			  632,  632,  632,  632,  806,  123,  412,  634,  634,  634,
			  634,  635,  635,  635,  635,  123,  642,  529,  806,  627,
			  636,  636,  636,  636,  123,  631,  631,  631,  631,  639,
			  648,  638,  413,  422,  422,  422,  422,  128,  412,  637,
			  633,  806,  643,  123,  123,  645,  644,  128,  642,  646,
			  123,  536,  641,  650,  123,  647,  128,  651,  652,  654,
			  123,  640,  648,  649,  653,  655,  656,  658,  123,  123,
			  123,  637,  660,  115,  645,  128,  128,  645,  646,  123,

			  657,  646,  128,  123,  642,  650,  128,  648,  659,  652,
			  652,  654,  128,  662,  123,  650,  654,  656,  656,  658,
			  128,  128,  128,  661,  660,  123,  664,  666,  667,  665,
			  663,  128,  658,  123,  668,  128,  123,  669,  670,  672,
			  660,  671,  673,  674,  123,  662,  128,  123,  675,  676,
			  678,  123,  123,  680,  123,  662,  682,  128,  664,  666,
			  668,  666,  664,  679,  683,  128,  668,  677,  128,  670,
			  670,  672,  123,  672,  674,  674,  128,  684,  686,  128,
			  676,  676,  678,  128,  128,  680,  128,  681,  682,  685,
			  687,  688,  123,  123,  123,  680,  684,  690,  691,  678,

			  692,  689,  123,  123,  128,  694,  123,  123,  696,  684,
			  686,  698,  697,  123,  693,  699,  700,  702,  695,  682,
			  123,  686,  688,  688,  128,  128,  128,  701,  123,  690,
			  692,  123,  692,  690,  128,  128,  123,  694,  128,  128,
			  696,  703,  704,  698,  698,  128,  694,  700,  700,  702,
			  696,  806,  128,  706,  706,  706,  706,  708,  123,  702,
			  128,  806,  806,  128,  705,  806,  705,  806,  128,  706,
			  706,  706,  706,  704,  704,  707,  707,  707,  707,  710,
			  710,  710,  710,  257,  631,  631,  631,  631,  806,  708,
			  128,  806,  720,  529,  711,  711,  711,  711,  709,  712,

			  712,  712,  712,  713,  713,  713,  713,  714,  714,  714,
			  714,  717,  717,  717,  717,  715,  123,  715,  123,  633,
			  713,  713,  713,  713,  720,  718,  123,  719,  722,  123,
			  709,  724,  721,  725,  726,  123,  123,  123,  727,  728,
			  723,  123,  123,  536,  729,  730,  732,  731,  128,  123,
			  128,  123,  123,  806,  734,  806,  736,  718,  128,  720,
			  722,  128,  738,  724,  722,  726,  726,  128,  128,  128,
			  728,  728,  724,  128,  128,  123,  730,  730,  732,  732,
			  123,  128,  123,  128,  128,  733,  734,  735,  736,  123,
			  740,  737,  742,  741,  738,  123,  744,  123,  123,  746,

			  739,  123,  123,  748,  123,  123,  743,  128,  745,  747,
			  749,  750,  128,  123,  128,  752,  751,  734,  123,  736,
			  123,  128,  740,  738,  742,  742,  123,  128,  744,  128,
			  128,  746,  740,  128,  128,  748,  128,  128,  744,  123,
			  746,  748,  750,  750,  123,  128,  754,  752,  752,  123,
			  128,  756,  128,  123,  755,  753,  123,  758,  128,  706,
			  706,  706,  706,  706,  706,  706,  706,  757,  806,  123,
			  806,  128,  759,  759,  759,  759,  128,  806,  754,  806,
			  806,  128,  806,  756,  806,  128,  756,  754,  128,  758,
			  760,  765,  760,  806,  806,  761,  761,  761,  761,  758,

			  762,  128,  762,  806,  806,  763,  763,  763,  763,  763,
			  763,  763,  763,  764,  764,  764,  764,  413,  713,  713,
			  713,  713,  771,  765,  766,  766,  766,  766,  713,  713,
			  713,  713,  767,  767,  767,  767,  768,  123,  768,  773,
			  806,  769,  769,  769,  769,  123,  765,  772,  774,  633,
			  770,  775,  123,  123,  771,  123,  777,  123,  776,  123,
			  778,  779,  123,  123,  123,  123,  781,  806,  783,  128,
			  780,  773,  413,  785,  787,  123,  806,  128,  765,  773,
			  775,  784,  771,  775,  128,  128,  789,  128,  777,  128,
			  777,  128,  779,  779,  128,  128,  128,  128,  781,  782,

			  783,  123,  781,  123,  786,  785,  787,  128,  123,  788,
			  790,  791,  792,  785,  123,  123,  123,  793,  789,  123,
			  761,  761,  761,  761,  794,  794,  794,  794,  806,  806,
			  806,  783,  806,  128,  123,  128,  787,  123,  806,  806,
			  128,  789,  791,  791,  793,  806,  128,  128,  128,  793,
			  806,  128,  763,  763,  763,  763,  763,  763,  763,  763,
			  795,  795,  795,  795,  529,  796,  128,  796,  123,  128,
			  797,  797,  797,  797,  712,  712,  712,  712,  769,  769,
			  769,  769,  798,  798,  798,  798,  123,  123,  765,  800,
			  806,  123,  123,  802,  123,  123,  804,  803,  123,  123,

			  128,  123,  799,  801,  759,  759,  759,  759,  797,  797,
			  797,  797,  806,  123,  413,  123,  123,  806,  128,  128,
			  765,  800,  536,  128,  128,  802,  128,  128,  804,  804,
			  128,  128,  806,  128,  800,  802,  805,  805,  805,  805,
			  766,  766,  766,  766,  529,  128,  806,  128,  128,  795,
			  795,  795,  795,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  265,  265,  265,  265,  806,
			  806,  806,  806,  806,  806,  806,  633,  806,  806,  806,
			  536,  806,  806,  806,  806,  806,  806,  806,  806,  633,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,

			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   93,   93,  806,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   98,  806,  806,  806,  806,  806,  806,   98,
			   98,   98,   98,   98,   98,   98,   98,   98,   98,   98,
			   98,   98,   98,   99,   99,  806,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,  100,  100,  806,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  211,  211,  806,  211,  211,

			  211,  806,  806,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  212,  806,  806,  212,
			  806,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  219,  219,  806,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  220,  220,
			  806,  220,  220,  220,  220,  220,  220,  220,  220,  220,
			  220,  220,  220,  220,  220,  220,  220,  220,  220,  224,
			  224,  806,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,

			  231,  231,  806,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  258,  258,  258,  258,  258,  258,  258,  258,  806,
			  258,  258,  258,  258,  258,  258,  258,  258,  258,  258,
			  258,  258,  215,  215,  806,  215,  215,  215,  806,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  216,  216,  806,  216,  216,  216,  806,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  716,  716,  716,  716,  716,  716,
			  716,  716,  806,  716,  716,  716,  716,  716,  716,  716,

			  716,  716,  716,  716,  716,    5,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806, yy_Dummy>>)
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
			    3,    3,    3,    3,    4,    4,    4,    4,   12,   15,

			   22,   12,   15,   16,   16,   23,   24,   23,   23,   23,
			   23,   22,  795,   25,   24,   25,   25,   25,   25,   26,
			   40,   26,   26,   26,   26,  766,   25,   25,   30,   30,
			   60,   27,   26,   27,   27,   27,   27,   32,   32,   38,
			   68,  759,   38,   69,   38,  526,    3,   12,   25,  420,
			    4,  265,   40,  254,   38,   25,   51,   51,   25,   25,
			   86,   26,   60,   86,   26,   86,   99,  224,   86,   99,
			  224,   38,   68,   27,   38,   69,   38,    3,  253,   12,
			   25,    4,   34,   34,   34,   34,   38,   46,   51,   51,
			  252,   46,   34,   34,   34,   34,   34,   34,   34,   34,

			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,  251,   46,
			  112,  112,   34,   46,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   35,   35,   35,   35,  113,  113,  113,  250,  249,   71,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   57,   57,   57,   57,
			   35,   71,   35,   35,   35,   35,   35,   35,   35,   35,

			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   36,   36,
			   37,   42,   36,   72,   37,   36,   57,   42,   36,   39,
			   37,   36,   41,   39,   45,   41,   43,   39,   52,   41,
			   41,  248,   43,   45,   52,   41,   39,   77,  247,  246,
			   36,   36,   37,   42,   36,   72,   37,   36,  245,   42,
			   36,   39,   37,   36,   41,   39,   45,   41,   43,   39,
			   52,   41,   41,   44,   43,   45,   52,   41,   39,   77,
			   44,   48,   48,   44,   47,   44,   44,   49,   47,   44,
			   50,   48,   49,   62,   63,   59,   63,   49,   50,   47,

			   59,  244,   59,   62,   50,   44,   63,   59,  225,  243,
			  242,  225,   44,   48,   48,   44,   47,   44,   44,   49,
			   47,   44,   50,   48,   49,   62,   63,   59,   63,   49,
			   50,   47,   59,   61,   59,   62,   50,   61,   63,   59,
			   61,   64,   66,   61,   70,   64,   61,   67,   73,   66,
			   66,   74,   75,   67,   70,   66,   70,   75,   64,  241,
			   70,   74,   78,   73,   82,   61,   82,   82,   84,   61,
			   84,   84,   61,   64,   66,   61,   70,   64,   61,   67,
			   73,   66,   66,   74,   75,   67,   70,   66,   70,   75,
			   64,   76,   70,   74,   78,   73,   85,   93,   85,   85,

			   93,   87,  123,  124,   87,   76,   87,  124,   96,   87,
			   96,   96,  129,   96,  219,  226,   96,  219,  226,  219,
			   82,  126,  219,   76,   84,   97,  126,   97,   97,  228,
			   97,  131,  228,   97,  123,  124,  240,   76,  239,  124,
			  106,  106,  106,  106,  129,  132,   93,  109,  109,  109,
			  109,   82,   85,  126,  106,   84,  237,  236,  126,  127,
			  134,  109,   96,  131,  115,  115,  115,  115,  110,  127,
			  110,  110,  110,  110,  133,  235,  234,  132,   93,   97,
			  106,  110,  233,   85,   95,  133,  106,   95,   95,   95,
			   95,  127,  134,  109,   96,  111,   95,  111,  111,  111,

			  111,  127,  217,   95,  115,   95,  133,   95,   95,   95,
			  110,   97,   95,  110,   95,  135,  216,  133,   95,  135,
			   95,  215,  211,   95,   95,   95,   95,   95,   95,  101,
			  100,   91,  101,  101,  101,  101,  381,  111,   90,  381,
			   89,  101,  125,  130,  137,  125,  130,  135,  101,  137,
			  101,  135,  101,  101,  101,  101,  136,  101,  138,  101,
			  140,  141,  138,  101,  136,  101,  142,  143,  101,  101,
			  101,  101,  101,  101,  125,  130,  137,  125,  130,  144,
			  139,  137,  146,  147,  152,  149,   88,  147,  136,  139,
			  138,  153,  140,  141,  138,  149,  136,  145,  142,  143,

			  158,  145,  151,  150,  145,  159,  153,  155,  150,  151,
			  155,  144,  139,  151,  146,  147,  152,  149,  150,  147,
			  154,  139,  156,  153,  154,  157,  160,  149,  161,  145,
			  156,  157,  158,  145,  151,  150,  145,  159,  153,  155,
			  150,  151,  155,  164,  162,  151,  166,   83,  171,  174,
			  150,  162,  154,   54,  156,  172,  154,  157,  160,  169,
			  161,  169,  156,  157,  163,  170,  163,  172,  163,  163,
			  167,  170,  167,  173,  167,  164,  162,  170,  166,  163,
			  171,  174,  163,  162,  173,  167,   33,  172,  167,  176,
			  178,  169,  179,  169,  176,  178,  163,  170,  163,  172,

			  163,  163,  167,  170,  167,  173,  167,  177,  175,  170,
			  180,  163,  181,  177,  163,  182,  173,  167,  175,  183,
			  167,  176,  178,  186,  179,  185,  176,  178,   28,  185,
			  382,  189,   11,  382,  189,   10,    9,  192,  189,  177,
			  175,    8,  180,    7,  181,  177,    5,  182,  191,  193,
			  175,  183,  191,  193,  195,  186,  190,  185,  188,    0,
			  188,  185,  187,  189,  187,  190,  189,  187,  188,  192,
			  189,  188,  187,  188,  188,  187,  196,  187,  187,  194,
			  191,  193,  197,  200,  191,  193,  195,  197,  190,  198,
			  188,  194,  188,  198,  187,  202,  187,  190,  197,  187,

			  188,  203,  204,  188,  187,  188,  188,  187,  196,  187,
			  187,  194,  199,  201,  197,  200,  205,  199,  206,  197,
			  205,  198,  201,  194,  208,  198,  207,  202,  199,  213,
			  197,  213,  213,  203,  204,  207,  210,  210,  210,  210,
			  214,    0,  214,  214,  199,  201,    0,  269,  205,  199,
			  206,    0,  205,    0,  201,    0,  208,    0,  207,  218,
			  199,  218,  218,  220,    0,    0,  220,  207,  220,  271,
			  221,  220,  221,  221,  227,    0,  210,  227,  229,  269,
			  229,  229,  272,  229,    0,  213,  229,  227,  227,  227,
			  227,  238,  238,  238,  238,  230,  214,  230,  230,    0,

			  230,  271,  274,  230,  255,  255,  255,  255,  257,  257,
			  257,  257,  263,  263,  272,  218,  213,  256,  255,  256,
			    0,    0,  256,  256,  256,  256,  221,  214,  259,  259,
			  259,  259,  229,  260,  274,  260,    0,    0,  260,  260,
			  260,  260,  259,    0,  255,    0,  218,  276,  277,  230,
			  255,    0,  263,  264,  264,  264,  261,  221,  261,  261,
			  261,  261,  268,  270,  229,  278,    0,  268,  259,  261,
			    0,  270,  281,  262,  259,  262,  262,  262,  262,  276,
			  277,  230,  266,  266,  266,  266,  267,  267,  267,  267,
			    0,  283,  284,  264,  268,  270,  280,  278,  261,  268,

			  282,  261,  280,  270,  281,  284,  285,  287,  286,  288,
			  282,  289,  292,  290,  293,  262,  286,  291,  288,  295,
			  296,  291,  266,  283,  284,  290,  267,  294,  280,  299,
			    0,  294,  282,  303,  280,  297,    0,  284,  285,  287,
			  286,  288,  282,  289,  292,  290,  293,  297,  286,  291,
			  288,  295,  296,  291,  300,  302,  301,  290,  305,  294,
			  301,  299,  300,  294,  304,  303,  306,  297,  300,  302,
			  307,  309,  308,  311,  304,  310,  308,  306,  310,  297,
			  313,  312,    0,  317,  309,  312,  300,  302,  301,  308,
			  305,  314,  301,  318,  300,  314,  304,  319,  306,  320,

			  300,  302,  307,  309,  308,  311,  304,  310,  308,  306,
			  310,  315,  313,  312,  316,  317,  309,  312,  315,  321,
			  322,  308,  316,  314,  322,  318,  323,  314,  324,  319,
			  325,  320,  326,  327,  328,  330,  324,  325,  331,  332,
			  334,  330,  335,  315,  334,  336,  316,  337,    0,    0,
			  315,  321,  322,  340,  316,  341,  322,  340,  323,  341,
			  324,  346,  325,  347,  326,  327,  328,  330,  324,  325,
			  331,  332,  334,  330,  335,  338,  334,  336,  338,  337,
			  339,  338,  342,  339,  343,  340,  344,  341,  345,  340,
			  342,  341,  344,  346,  348,  347,  343,  345,  349,  350,

			  351,  352,  354,  353,  344,  352,  355,  338,  356,  357,
			  338,  353,  339,  338,  342,  339,  343,  350,  344,  359,
			  345,  360,  342,  361,  344,  360,  348,  364,  343,  345,
			  349,  350,  351,  352,  354,  353,  344,  352,  355,  358,
			  356,  357,  362,  353,  358,  365,  362,  366,  363,  350,
			  367,  359,  368,  360,  370,  361,  363,  360,  371,  364,
			  372,  373,  374,  375,  376,  372,    0,  374,    0,  418,
			  418,  358,    0,    0,  362,    0,  358,  365,  362,  366,
			  363,    0,  367,    0,  368,    0,  370,    0,  363,    0,
			  371,  424,  372,  373,  374,  375,  376,  372,  383,  374,

			  384,  383,    0,  384,  390,  390,  390,  390,  390,  418,
			  383,  383,  383,  383,  383,  407,  407,  407,  407,  408,
			  408,  408,  408,  424,    0,    0,  384,    0,  426,  407,
			  409,  409,  409,  409,  410,  410,  410,  410,  411,  411,
			  411,  411,  412,    0,  412,    0,    0,  412,  412,  412,
			  412,    0,  411,    0,    0,  407,  413,  413,  413,  413,
			  426,  407,  414,  414,  414,  414,  415,  415,  415,  415,
			  409,  428,  416,  425,  416,  416,  416,  416,  411,  419,
			  419,  419,    0,  425,  411,  416,  417,    0,  417,  417,
			  417,  417,  421,  421,  421,  421,  422,  422,  422,  422,

			    0,  423,  430,  428,    0,  425,  415,  427,  429,  427,
			  429,  431,  423,  432,  416,  425,  433,  416,  434,  419,
			  433,  431,  436,  437,  435,  438,  440,  437,  417,  439,
			  442,  439,  421,  423,  430,  435,  422,  441,  443,  427,
			  429,  427,  429,  431,  423,  432,  441,  444,  433,  446,
			  434,  445,  433,  431,  436,  437,  435,  438,  440,  437,
			  445,  439,  442,  439,  448,  449,  447,  435,  450,  441,
			  443,  447,  452,  448,  454,  451,  453,  455,  441,  444,
			  453,  446,  456,  445,  451,  457,  458,  460,  461,  455,
			  458,  462,  445,  464,    0,  463,  448,  449,  447,  466,

			  450,  468,  470,  447,  452,  448,  454,  451,  453,  455,
			  463,  465,  453,  472,  456,  467,  451,  457,  458,  460,
			  461,  455,  458,  462,  467,  464,  465,  463,  469,  471,
			  473,  466,  469,  468,  470,  476,  475,  477,  471,  475,
			  480,  479,  463,  465,  479,  472,  481,  467,  483,  484,
			  486,  483,  487,  485,  488,  490,  467,  492,  465,  494,
			  469,  471,  473,  489,  469,  485,  489,  476,  475,  477,
			  471,  475,  480,  479,  495,  496,  479,  499,  481,  491,
			  483,  484,  486,  483,  487,  485,  488,  490,  491,  492,
			  493,  494,  497,  498,  493,  489,  498,  485,  489,  500,

			  501,  502,  503,  504,  497,  505,  495,  496,  503,  499,
			  506,  491,  507,  508,  505,  509,  501,  511,  513,  507,
			  491,  513,  493,  514,  497,  498,  493,  515,  498,  516,
			  518,  500,  501,  502,  503,  504,  497,  505,  517,  515,
			  503,  517,  506,  520,  507,  508,  505,  509,  501,  511,
			  513,  507,  519,  513,  521,  514,  523,  539,  541,  515,
			  519,  516,  518,    0,  525,    0,    0,  525,    0,  625,
			  517,  515,  625,  517,  544,  520,  525,  525,  525,  525,
			  525,  625,    0,    0,  519,    0,  521,    0,  523,  539,
			  541,    0,  519,  527,  527,  527,  527,  528,  528,  528,

			  528,  529,  529,  529,  529,    0,  544,  527,  530,  530,
			  530,  530,  531,  531,  531,  531,  532,  532,  532,  532,
			  533,  533,  533,  533,    0,  545,  531,  534,  534,  534,
			  534,  535,  535,  535,  535,  547,  550,  528,    0,  527,
			  536,  536,  536,  536,  543,  537,  537,  537,  537,  543,
			  554,  538,  531,  538,  538,  538,  538,  545,  531,  537,
			  533,    0,  551,  549,  555,  552,  551,  547,  550,  552,
			  553,  535,  549,  558,  557,  553,  543,  559,  560,  562,
			  559,  543,  554,  557,  561,  563,  564,  566,  561,  565,
			  563,  537,  568,  538,  551,  549,  555,  552,  551,  569,

			  565,  552,  553,  567,  549,  558,  557,  553,  567,  559,
			  560,  562,  559,  572,  571,  557,  561,  563,  564,  566,
			  561,  565,  563,  571,  568,  573,  574,  576,  577,  575,
			  573,  569,  565,  575,  578,  567,  579,  581,  582,  584,
			  567,  583,  585,  586,  587,  572,  571,  583,  589,  590,
			  592,  591,  589,  594,  593,  571,  596,  573,  574,  576,
			  577,  575,  573,  593,  597,  575,  578,  591,  579,  581,
			  582,  584,  595,  583,  585,  586,  587,  598,  600,  583,
			  589,  590,  592,  591,  589,  594,  593,  595,  596,  599,
			  601,  602,  603,  599,  601,  593,  597,  604,  605,  591,

			  606,  603,  605,  607,  595,  608,  609,  611,  612,  598,
			  600,  614,  613,  615,  607,  617,  618,  620,  611,  595,
			  613,  599,  601,  602,  603,  599,  601,  619,  621,  604,
			  605,  619,  606,  603,  605,  607,  623,  608,  609,  611,
			  612,  623,  624,  614,  613,  615,  607,  617,  618,  620,
			  611,    0,  613,  628,  628,  628,  628,  630,  639,  619,
			  621,    0,    0,  619,  627,    0,  627,    0,  623,  627,
			  627,  627,  627,  623,  624,  629,  629,  629,  629,  632,
			  632,  632,  632,  630,  631,  631,  631,  631,    0,  630,
			  639,    0,  642,  628,  633,  633,  633,  633,  631,  634,

			  634,  634,  634,  635,  635,  635,  635,  636,  636,  636,
			  636,  638,  638,  638,  638,  637,  641,  637,  643,  632,
			  637,  637,  637,  637,  642,  638,  644,  641,  646,  647,
			  631,  648,  644,  649,  650,  651,  653,  649,  655,  656,
			  647,  657,  655,  635,  659,  660,  662,  661,  641,  663,
			  643,  661,  659,    0,  666,    0,  668,  638,  644,  641,
			  646,  647,  670,  648,  644,  649,  650,  651,  653,  649,
			  655,  656,  647,  657,  655,  665,  659,  660,  662,  661,
			  669,  663,  667,  661,  659,  665,  666,  667,  668,  671,
			  672,  669,  674,  673,  670,  675,  676,  677,  679,  680,

			  671,  673,  681,  684,  683,  685,  675,  665,  679,  683,
			  685,  686,  669,  687,  667,  690,  689,  665,  691,  667,
			  689,  671,  672,  669,  674,  673,  693,  675,  676,  677,
			  679,  680,  671,  673,  681,  684,  683,  685,  675,  695,
			  679,  683,  685,  686,  697,  687,  698,  690,  689,  699,
			  691,  700,  689,  701,  699,  697,  703,  704,  693,  705,
			  705,  705,  705,  706,  706,  706,  706,  703,    0,  719,
			    0,  695,  707,  707,  707,  707,  697,    0,  698,    0,
			    0,  699,    0,  700,    0,  701,  699,  697,  703,  704,
			  708,  712,  708,    0,    0,  708,  708,  708,  708,  703,

			  709,  719,  709,    0,    0,  709,  709,  709,  709,  710,
			  710,  710,  710,  711,  711,  711,  711,  712,  713,  713,
			  713,  713,  722,  712,  714,  714,  714,  714,  715,  715,
			  715,  715,  717,  717,  717,  717,  718,  723,  718,  726,
			    0,  718,  718,  718,  718,  721,  717,  725,  727,  710,
			  721,  728,  725,  727,  722,  729,  730,  731,  729,  733,
			  735,  736,  735,  737,  739,  741,  742,    0,  744,  723,
			  741,  726,  717,  746,  748,  745,    0,  721,  717,  725,
			  727,  745,  721,  728,  725,  727,  750,  729,  730,  731,
			  729,  733,  735,  736,  735,  737,  739,  741,  742,  743,

			  744,  751,  741,  743,  747,  746,  748,  745,  747,  749,
			  753,  754,  755,  745,  753,  749,  755,  756,  750,  757,
			  760,  760,  760,  760,  761,  761,  761,  761,    0,    0,
			    0,  743,    0,  751,  770,  743,  747,  772,    0,    0,
			  747,  749,  753,  754,  755,    0,  753,  749,  755,  756,
			    0,  757,  762,  762,  762,  762,  763,  763,  763,  763,
			  764,  764,  764,  764,  761,  765,  770,  765,  774,  772,
			  765,  765,  765,  765,  767,  767,  767,  767,  768,  768,
			  768,  768,  769,  769,  769,  769,  776,  778,  767,  781,
			    0,  780,  782,  785,  784,  786,  789,  788,  790,  792,

			  774,  788,  780,  784,  794,  794,  794,  794,  796,  796,
			  796,  796,    0,  799,  767,  801,  803,    0,  776,  778,
			  767,  781,  769,  780,  782,  785,  784,  786,  789,  788,
			  790,  792,    0,  788,  780,  784,  797,  797,  797,  797,
			  798,  798,  798,  798,  794,  799,    0,  801,  803,  805,
			  805,  805,  805,  813,  813,  813,  813,  813,  813,  813,
			  813,  813,  813,  813,  813,  820,  820,  820,  820,    0,
			    0,    0,    0,    0,    0,    0,  797,    0,    0,    0,
			  798,    0,    0,    0,    0,    0,    0,    0,    0,  805,
			  807,  807,  807,  807,  807,  807,  807,  807,  807,  807,

			  807,  807,  807,  807,  807,  807,  807,  807,  807,  807,
			  807,  808,  808,    0,  808,  808,  808,  808,  808,  808,
			  808,  808,  808,  808,  808,  808,  808,  808,  808,  808,
			  808,  808,  809,    0,    0,    0,    0,    0,    0,  809,
			  809,  809,  809,  809,  809,  809,  809,  809,  809,  809,
			  809,  809,  809,  810,  810,    0,  810,  810,  810,  810,
			  810,  810,  810,  810,  810,  810,  810,  810,  810,  810,
			  810,  810,  810,  810,  811,  811,    0,  811,  811,  811,
			  811,  811,  811,  811,  811,  811,  811,  811,  811,  811,
			  811,  811,  811,  811,  811,  812,  812,    0,  812,  812,

			  812,    0,    0,  812,  812,  812,  812,  812,  812,  812,
			  812,  812,  812,  812,  812,  812,  814,    0,    0,  814,
			    0,  814,  814,  814,  814,  814,  814,  814,  814,  814,
			  814,  814,  814,  814,  814,  814,  814,  815,  815,    0,
			  815,  815,  815,  815,  815,  815,  815,  815,  815,  815,
			  815,  815,  815,  815,  815,  815,  815,  815,  816,  816,
			    0,  816,  816,  816,  816,  816,  816,  816,  816,  816,
			  816,  816,  816,  816,  816,  816,  816,  816,  816,  817,
			  817,    0,  817,  817,  817,  817,  817,  817,  817,  817,
			  817,  817,  817,  817,  817,  817,  817,  817,  817,  817,

			  818,  818,    0,  818,  818,  818,  818,  818,  818,  818,
			  818,  818,  818,  818,  818,  818,  818,  818,  818,  818,
			  818,  819,  819,  819,  819,  819,  819,  819,  819,    0,
			  819,  819,  819,  819,  819,  819,  819,  819,  819,  819,
			  819,  819,  821,  821,    0,  821,  821,  821,    0,  821,
			  821,  821,  821,  821,  821,  821,  821,  821,  821,  821,
			  821,  821,  821,  822,  822,    0,  822,  822,  822,    0,
			  822,  822,  822,  822,  822,  822,  822,  822,  822,  822,
			  822,  822,  822,  822,  823,  823,  823,  823,  823,  823,
			  823,  823,    0,  823,  823,  823,  823,  823,  823,  823,

			  823,  823,  823,  823,  823,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   88,   92,  846, 2905,  841,  838,  832,
			  830,  826,   91,    0, 2905,   92,   93, 2905, 2905, 2905,
			 2905, 2905,   83,   87,   87,   95,  101,  113,  801, 2905,
			  102, 2905,  110,  759,  162,  230,  281,  286,  101,  299,
			   82,  297,  283,  298,  342,  296,  153,  350,  344,  349,
			  360,  119,  300, 2905,  696, 2905, 2905,  266,    0,  359,
			   92,  396,  359,  353,  411,    0,  407,  409,   96,   99,
			  413,  212,  289,  414,  414,  409,  461,  310,  418, 2905,
			 2905,    0,  462,  744,  466,  494,  158,  499,  684,  637,
			  634,  626, 2905,  490, 2905,  577,  506,  523,    0,  159,

			  619,  622,    0, 2905, 2905, 2905,  520, 2905, 2905,  527,
			  550,  577,  200,  234,    0,  544, 2905, 2905, 2905, 2905,
			 2905, 2905, 2905,  464,  469,  604,  488,  521,    0,  478,
			  605,  498,  497,  536,  511,  581,  626,  606,  624,  642,
			  626,  631,  623,  633,  632,  666,  644,  652,    0,  647,
			  670,  664,  636,  658,  675,  669,  692,  687,  659,  675,
			  682,  690,  706,  731,  705,    0,  701,  737,    0,  721,
			  733,  708,  723,  735,  700,  770,  756,  775,  757,  754,
			  762,  779,  783,  786,    0,  791,  789,  829,  825,  793,
			  818,  807,  790,  815,  841,  820,  826,  849,  855,  879,

			  849,  875,  857,  854,  864,  882,  884,  888,  877, 2905,
			  916,  611,    0,  927,  938,  614,  609,  599,  957,  512,
			  961,  968,    0,    0,  160,  401,  508,  967,  522,  976,
			  993, 2905, 2905,  571,  565,  564,  546,  545,  971,  527,
			  525,  448,  399,  398,  390,  347,  338,  337,  330,  247,
			  246,  207,  179,  167,  142,  984, 1002,  988, 2905, 1008,
			 1018, 1038, 1055,  992, 1033,   91, 1062, 1066, 1024,  904,
			 1033,  931,  952,    0,  964,    0, 1009, 1010, 1027,    0,
			 1064, 1040, 1062, 1043, 1054, 1055, 1078, 1077, 1071, 1064,
			 1075, 1083, 1062, 1080, 1093, 1085, 1082, 1097,    0, 1079,

			 1124, 1122, 1125, 1099, 1126, 1110, 1128, 1121, 1134, 1129,
			 1137, 1132, 1147, 1142, 1157, 1173, 1184, 1149, 1155, 1163,
			 1154, 1189, 1186, 1192, 1198, 1192, 1202, 1188, 1196,    0,
			 1197, 1194, 1201,    0, 1206, 1208, 1207, 1209, 1243, 1248,
			 1219, 1221, 1252, 1246, 1254, 1250, 1227, 1229, 1264, 1248,
			 1267, 1253, 1267, 1273, 1268, 1276, 1270, 1271, 1301, 1276,
			 1287, 1289, 1308, 1310, 1289, 1311, 1301, 1312, 1314,    0,
			 1316, 1320, 1327, 1328, 1324, 1320, 1326,    0, 2905, 2905,
			 2905,  629,  823, 1391, 1393, 2905, 2905, 2905, 2905, 2905,
			 1385, 2905, 2905, 2905, 2905, 2905, 2905, 2905, 2905, 2905,

			 2905, 2905, 2905, 2905, 2905, 2905, 2905, 1395, 1399, 1410,
			 1414, 1418, 1427, 1436, 1442, 1446, 1454, 1468, 1349, 1459,
			   89, 1472, 1476, 1463, 1342, 1435, 1380, 1471, 1435, 1470,
			 1462, 1473, 1465, 1482, 1484, 1486, 1473, 1489, 1491, 1493,
			 1490, 1499, 1483, 1500, 1509, 1513, 1502, 1528, 1526, 1522,
			 1521, 1537, 1525, 1542, 1540, 1539, 1532, 1547, 1552,    0,
			 1553, 1550, 1553, 1557, 1540, 1573, 1546, 1577, 1554, 1594,
			 1568, 1591, 1566, 1592,    0, 1598, 1594, 1599,    0, 1603,
			 1599, 1608,    0, 1613, 1614, 1615, 1612, 1602, 1616, 1628,
			 1620, 1641, 1610, 1652, 1617, 1636, 1637, 1654, 1655, 1627,

			 1658, 1662, 1647, 1670, 1671, 1667, 1663, 1674, 1668, 1677,
			    0, 1679,    0, 1683, 1688, 1689, 1679, 1700, 1689, 1722,
			 1713, 1716,    0, 1718,    0, 1757,  134, 1773, 1777, 1781,
			 1788, 1792, 1796, 1800, 1807, 1811, 1820, 1825, 1833, 1719,
			    0, 1720,    0, 1806, 1731, 1787,    0, 1797,    0, 1825,
			 1789, 1828, 1831, 1832, 1807, 1826,    0, 1836, 1826, 1842,
			 1843, 1850, 1845, 1852, 1853, 1851, 1838, 1865, 1849, 1861,
			    0, 1876, 1866, 1887, 1883, 1895, 1893, 1890, 1896, 1898,
			    0, 1899, 1900, 1909, 1907, 1904, 1905, 1906,    0, 1914,
			 1915, 1913, 1896, 1916, 1906, 1934, 1903, 1926, 1939, 1955,

			 1944, 1956, 1957, 1954, 1950, 1964, 1966, 1965, 1956, 1968,
			    0, 1969, 1959, 1982, 1981, 1975,    0, 1977, 1978, 1993,
			 1983, 1990,    0, 1998, 1999, 1762, 2905, 2049, 2033, 2055,
			 2023, 2064, 2059, 2074, 2079, 2083, 2087, 2100, 2091, 2020,
			    0, 2078, 2043, 2080, 2088,    0, 2084, 2091, 2082, 2099,
			 2100, 2097,    0, 2098,    0, 2104, 2105, 2103,    0, 2114,
			 2115, 2113, 2112, 2111,    0, 2137, 2106, 2144, 2113, 2142,
			 2113, 2151, 2141, 2163, 2162, 2157, 2147, 2159,    0, 2160,
			 2151, 2164,    0, 2166, 2160, 2167, 2168, 2175,    0, 2182,
			 2181, 2180,    0, 2188,    0, 2201,    0, 2206, 2197, 2211,

			 2208, 2215,    0, 2218, 2208, 2239, 2243, 2252, 2275, 2285,
			 2289, 2293, 2257, 2298, 2304, 2308, 2905, 2312, 2321, 2231,
			    0, 2307, 2279, 2299,    0, 2314, 2306, 2315, 2318, 2317,
			 2315, 2319,    0, 2321,    0, 2324, 2325, 2325,    0, 2326,
			    0, 2327, 2323, 2365, 2334, 2337, 2329, 2370, 2340, 2377,
			 2354, 2363,    0, 2376, 2377, 2378, 2383, 2381,    0,   81,
			 2400, 2404, 2432, 2436, 2440, 2450,   65, 2454, 2458, 2462,
			 2396,    0, 2399,    0, 2430,    0, 2448,    0, 2449,    0,
			 2453, 2440, 2454,    0, 2456, 2446, 2457,    0, 2463, 2462,
			 2460,    0, 2461,    0, 2484,   52, 2488, 2516, 2520, 2475,

			    0, 2477,    0, 2478,    0, 2529, 2905, 2589, 2610, 2631,
			 2652, 2673, 2694, 2543, 2715, 2736, 2757, 2778, 2799, 2820,
			 2555, 2841, 2862, 2883, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  806,    1,  807,  807,  806,  806,  806,  806,  806,
			  806,  806,  808,  809,  806,  810,  811,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,  806,  806,  806,  806,  806,  812,  813,
			  813,  813,  813,  813,  813,  813,  813,  813,  813,  813,
			  813,  813,  813,  813,  813,  813,  813,  813,  813,  806,
			  806,  814,  806,  806,  814,  806,  815,  816,  806,  806,
			  806,  806,  806,  808,  806,  817,  808,  808,  809,  810,

			  818,  818,  818,  806,  806,  806,  806,  806,  806,  819,
			  806,  806,  806,  806,  820,  806,  806,  806,  806,  806,
			  806,  806,  806,   35,   35,   35,   35,   35,  813,  813,
			  813,  813,  813,   35,  813,   35,   35,   35,   35,   35,
			  813,  813,  813,  813,  813,   35,   35,  813,  813,   35,
			   35,   35,  813,  813,  813,   35,   35,   35,  813,  813,
			  813,   35,   35,   35,   35,  813,  813,  813,  813,   35,
			   35,  813,  813,   35,  813,   35,   35,   35,   35,   35,
			  813,  813,  813,  813,  813,   35,  813,   35,  813,   35,
			   35,  813,  813,   35,   35,  813,  813,   35,   35,  813,

			  813,   35,   35,  813,  813,   35,  813,   35,  813,  806,
			  806,  812,  814,  806,  806,  821,  822,  806,  814,  815,
			  816,  806,  814,  814,  817,  810,  810,  817,  817,  808,
			  808,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  820,  806,  806,   35,  813,
			   35,   35,  813,  813,   35,  813,   35,  813,   35,  813,
			   35,  813,   35,  813,   35,  813,   35,  813,   35,  813,
			   35,   35,  813,  813,   35,  813,   35,   35,  813,  813,

			   35,   35,  813,  813,   35,  813,   35,  813,   35,  813,
			   35,  813,   35,   35,   35,   35,   35,  813,  813,  813,
			  813,  813,   35,  813,   35,   35,  813,  813,   35,  813,
			   35,  813,   35,  813,   35,  813,   35,  813,   35,  813,
			   35,   35,   35,   35,   35,   35,  813,  813,  813,  813,
			  813,  813,   35,   35,  813,  813,   35,  813,   35,  813,
			   35,  813,   35,   35,   35,  813,  813,  813,   35,  813,
			   35,  813,   35,  813,   35,  813,   35,  813,  806,  806,
			  806,  817,  817,  817,  817,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,

			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  820,  806,  806,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,   35,  813,
			  813,   35,  813,   35,  813,   35,  813,   35,   35,  813,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,   35,  813,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,   35,  813,

			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,  817,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  819,  806,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,

			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,  817,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  823,   35,
			  813,   35,  813,   35,   35,  813,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,

			  813,   35,  813,   35,  813,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,   35,
			  813,   35,  813,   35,  813,   35,  813,   35,  813,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			   35,  813,   35,  813,   35,  813,   35,  813,   35,  813,
			   35,  813,   35,  813,   35,  813,   35,  813,   35,  813,
			   35,  813,   35,  813,  806,  806,  806,  806,  806,   35,

			  813,   35,  813,   35,  813,  806,    0,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    5,    6,    7,    8,    9,   10,    8,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   23,   23,   24,   25,
			   26,   27,   28,   29,    8,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,
			   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,
			   55,   56,   57,   58,   59,   60,   61,   62,   63,   64,

			   65,   66,   67,   68,   69,   70,   71,   72,   73,   74,
			   75,   76,   77,   78,   79,   80,   81,   82,   83,   84,
			   85,   86,   87,   88,    8,   89,    1,    1,    1,    1,
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
			    0,    1,    2,    3,    4,    5,    1,    6,    1,    1,
			    7,    8,    1,    1,    1,    1,    1,    1,    9,    1,
			   10,   11,   12,   13,    1,    1,    1,    1,    1,    1,
			   10,   10,   10,   10,   10,   10,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
			   14,   14,   14,   15,   16,   17,    1,    1,    1,    1,
			   18,    1,   10,   10,   10,   10,   10,   10,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   19,   20,   21,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    2,    3,    4,    6,    9,   11,
			   14,   17,   20,   23,   26,   29,   32,   34,   37,   40,
			   43,   46,   49,   52,   55,   58,   62,   66,   70,   73,
			   76,   79,   82,   85,   87,   91,   95,   99,  103,  107,
			  111,  115,  119,  123,  127,  131,  135,  139,  143,  147,
			  151,  155,  159,  163,  166,  168,  171,  174,  177,  179,
			  182,  185,  188,  191,  194,  197,  200,  203,  206,  209,
			  212,  215,  218,  221,  224,  227,  230,  233,  236,  239,
			  242,  245,  247,  249,  251,  254,  256,  258,  260,  261,
			  262,  263,  264,  265,  266,  267,  268,  271,  274,  275,

			  276,  277,  278,  279,  280,  281,  282,  284,  285,  286,
			  286,  288,  290,  291,  291,  291,  292,  293,  294,  295,
			  296,  297,  298,  299,  301,  303,  305,  307,  310,  311,
			  312,  313,  314,  316,  318,  319,  321,  323,  325,  327,
			  329,  330,  331,  332,  333,  334,  336,  339,  340,  342,
			  344,  346,  348,  349,  350,  351,  353,  355,  357,  358,
			  359,  360,  363,  365,  367,  370,  372,  373,  374,  376,
			  378,  380,  381,  382,  384,  385,  387,  389,  391,  393,
			  396,  397,  398,  399,  400,  402,  404,  405,  407,  408,
			  410,  412,  413,  414,  416,  418,  419,  420,  422,  424,

			  425,  426,  428,  430,  431,  432,  434,  435,  437,  438,
			  439,  440,  440,  441,  442,  442,  442,  442,  443,  445,
			  446,  447,  448,  450,  452,  452,  454,  456,  456,  456,
			  458,  460,  461,  463,  464,  465,  466,  467,  468,  469,
			  470,  471,  472,  473,  474,  475,  476,  477,  478,  479,
			  480,  481,  482,  483,  484,  485,  487,  487,  487,  488,
			  490,  491,  493,  495,  496,  497,  498,  500,  501,  503,
			  504,  506,  509,  510,  512,  515,  517,  519,  520,  523,
			  525,  527,  528,  530,  531,  533,  534,  536,  537,  539,
			  540,  542,  544,  545,  546,  548,  549,  552,  554,  556,

			  557,  559,  561,  562,  563,  565,  566,  568,  569,  571,
			  572,  574,  575,  577,  579,  581,  583,  585,  586,  587,
			  588,  589,  590,  592,  593,  595,  597,  598,  599,  602,
			  604,  606,  607,  610,  612,  614,  615,  617,  618,  620,
			  621,  623,  625,  627,  629,  631,  633,  634,  635,  636,
			  637,  638,  639,  641,  643,  644,  645,  647,  648,  650,
			  651,  653,  654,  656,  658,  660,  661,  662,  663,  666,
			  668,  670,  671,  673,  674,  676,  677,  680,  682,  683,
			  684,  685,  686,  687,  687,  688,  689,  690,  691,  692,
			  693,  694,  695,  696,  697,  698,  699,  700,  701,  702,

			  703,  704,  705,  706,  707,  708,  709,  710,  712,  712,
			  714,  714,  716,  716,  716,  716,  718,  720,  722,  722,
			  722,  722,  724,  726,  728,  729,  731,  732,  734,  735,
			  737,  738,  740,  741,  743,  744,  746,  747,  749,  750,
			  752,  753,  755,  756,  759,  761,  763,  764,  766,  768,
			  769,  770,  772,  773,  775,  776,  778,  779,  782,  784,
			  786,  787,  789,  790,  792,  793,  795,  796,  798,  799,
			  801,  802,  804,  805,  808,  810,  812,  813,  816,  818,
			  820,  821,  824,  826,  828,  829,  831,  833,  834,  835,
			  837,  838,  840,  841,  843,  844,  846,  847,  849,  851,

			  852,  853,  855,  856,  858,  859,  861,  862,  864,  865,
			  868,  870,  873,  875,  877,  878,  880,  881,  883,  884,
			  886,  887,  890,  892,  895,  897,  897,  898,  899,  901,
			  901,  901,  903,  903,  907,  907,  909,  909,  909,  911,
			  914,  916,  919,  921,  923,  924,  927,  929,  932,  934,
			  936,  937,  939,  940,  942,  943,  946,  948,  950,  951,
			  953,  954,  956,  957,  959,  960,  962,  963,  965,  966,
			  969,  971,  973,  974,  976,  977,  979,  980,  982,  983,
			  986,  988,  990,  991,  993,  994,  996,  997, 1000, 1002,
			 1004, 1005, 1007, 1008, 1010, 1011, 1013, 1014, 1016, 1017,

			 1019, 1020, 1022, 1023, 1025, 1026, 1028, 1029, 1031, 1032,
			 1035, 1037, 1039, 1040, 1042, 1043, 1046, 1048, 1050, 1051,
			 1053, 1054, 1057, 1059, 1061, 1062, 1062, 1063, 1063, 1065,
			 1065, 1066, 1067, 1071, 1071, 1071, 1073, 1073, 1074, 1074,
			 1077, 1079, 1081, 1082, 1085, 1087, 1089, 1090, 1092, 1093,
			 1095, 1096, 1099, 1101, 1104, 1106, 1108, 1109, 1112, 1114,
			 1116, 1117, 1119, 1120, 1123, 1125, 1127, 1128, 1130, 1131,
			 1133, 1134, 1136, 1137, 1139, 1140, 1142, 1143, 1146, 1148,
			 1150, 1151, 1154, 1156, 1158, 1159, 1161, 1162, 1165, 1167,
			 1169, 1170, 1173, 1175, 1178, 1180, 1183, 1185, 1187, 1188,

			 1190, 1191, 1194, 1196, 1198, 1199, 1199, 1200, 1200, 1200,
			 1200, 1204, 1204, 1205, 1206, 1206, 1206, 1207, 1208, 1209,
			 1212, 1214, 1216, 1217, 1220, 1222, 1224, 1225, 1227, 1228,
			 1230, 1231, 1234, 1236, 1239, 1241, 1243, 1244, 1247, 1249,
			 1252, 1254, 1256, 1257, 1259, 1260, 1262, 1263, 1265, 1266,
			 1268, 1269, 1272, 1274, 1276, 1277, 1279, 1280, 1283, 1285,
			 1286, 1286, 1287, 1287, 1289, 1289, 1289, 1290, 1291, 1291,
			 1292, 1295, 1297, 1300, 1302, 1305, 1307, 1310, 1312, 1315,
			 1317, 1319, 1320, 1323, 1325, 1327, 1328, 1331, 1333, 1335,
			 1336, 1339, 1341, 1344, 1346, 1347, 1349, 1349, 1351, 1352,

			 1355, 1357, 1360, 1362, 1365, 1367, 1369, 1369, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  140,  140,  158,  156,  157,    3,  156,  157,    4,
			  157,    1,  156,  157,    2,  156,  157,   10,  156,  157,
			  142,  156,  157,  106,  156,  157,   17,  156,  157,  142,
			  156,  157,  156,  157,   11,  156,  157,   12,  156,  157,
			   31,  156,  157,   30,  156,  157,    8,  156,  157,   29,
			  156,  157,    6,  156,  157,   32,  156,  157,  144,  148,
			  156,  157,  144,  148,  156,  157,  144,  148,  156,  157,
			    9,  156,  157,    7,  156,  157,   36,  156,  157,   34,
			  156,  157,   35,  156,  157,  156,  157,  104,  105,  156,
			  157,  104,  105,  156,  157,  104,  105,  156,  157,  104,

			  105,  156,  157,  104,  105,  156,  157,  104,  105,  156,
			  157,  104,  105,  156,  157,  104,  105,  156,  157,  104,
			  105,  156,  157,  104,  105,  156,  157,  104,  105,  156,
			  157,  104,  105,  156,  157,  104,  105,  156,  157,  104,
			  105,  156,  157,  104,  105,  156,  157,  104,  105,  156,
			  157,  104,  105,  156,  157,  104,  105,  156,  157,  104,
			  105,  156,  157,   15,  156,  157,  156,  157,   16,  156,
			  157,   33,  156,  157,  148,  156,  157,  156,  157,  105,
			  156,  157,  105,  156,  157,  105,  156,  157,  105,  156,
			  157,  105,  156,  157,  105,  156,  157,  105,  156,  157,

			  105,  156,  157,  105,  156,  157,  105,  156,  157,  105,
			  156,  157,  105,  156,  157,  105,  156,  157,  105,  156,
			  157,  105,  156,  157,  105,  156,  157,  105,  156,  157,
			  105,  156,  157,  105,  156,  157,  105,  156,  157,   13,
			  156,  157,   14,  156,  157,  140,  157,  138,  157,  139,
			  157,  134,  140,  157,  137,  157,  140,  157,  140,  157,
			    3,    4,    1,    2,   37,  142,  141,  141, -132,  142,
			 -289, -133,  142, -290,  106,  142,  130,  130,  130,    5,
			   23,   24,  151,  154,   18,   20,  144,  148,  144,  148,
			  143,  148,  143,   28,   25,   22,   21,   26,   27,  104,

			  105,  104,  105,  104,  105,  104,  105,   42,  104,  105,
			  105,  105,  105,  105,   42,  105,  104,  105,  105,  104,
			  105,  104,  105,  104,  105,  104,  105,  104,  105,  105,
			  105,  105,  105,  105,  104,  105,   53,  104,  105,  105,
			   53,  105,  104,  105,  104,  105,  104,  105,  105,  105,
			  105,  104,  105,  104,  105,  104,  105,  105,  105,  105,
			   65,  104,  105,  104,  105,  104,  105,   72,  104,  105,
			   65,  105,  105,  105,   72,  105,  104,  105,  104,  105,
			  105,  105,  104,  105,  105,  104,  105,  104,  105,  104,
			  105,  104,  105,   81,  104,  105,  105,  105,  105,  105,

			   81,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  104,  105,  105,  105,  104,  105,  104,  105,  105,  105,
			  104,  105,  104,  105,  105,  105,  104,  105,  104,  105,
			  105,  105,  104,  105,  105,  104,  105,  105,   19,  148,
			  140,  138,  139,  134,  140,  140,  140,  137,  135,  140,
			  136,  140,  141,  142,  141,  142, -132,  142, -133,  142,
			  130,  107,  130,  130,  130,  130,  130,  130,  130,  130,
			  130,  130,  130,  130,  130,  130,  130,  130,  130,  130,
			  130,  130,  130,  130,  130,  151,  154,  149,  151,  154,
			  149,  144,  148,  144,  148,  147,  146,  145,  144,  148,

			  148,  104,  105,  105,  104,  105,   40,  104,  105,  105,
			   40,  105,   41,  104,  105,   41,  105,  104,  105,  105,
			   44,  104,  105,   44,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  104,  105,  105,  105,  104,  105,  105,   56,
			  104,  105,  104,  105,   56,  105,  105,  104,  105,  104,
			  105,  105,  105,  104,  105,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  104,  105,  104,
			  105,  104,  105,  104,  105,  105,  105,  105,  105,  105,
			  104,  105,  105,  104,  105,  104,  105,  105,  105,   77,

			  104,  105,   77,  105,  104,  105,  105,   79,  104,  105,
			   79,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  104,  105,  104,  105,  104,  105,  104,
			  105,  104,  105,  105,  105,  105,  105,  105,  105,  104,
			  105,  104,  105,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  104,  105,  104,  105,
			  105,  105,  105,   99,  104,  105,   99,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,  103,  104,  105,
			  103,  105,  155,  135,  136,  141,  141,  141,  124,  122,
			  123,  125,  126,  131,  127,  128,  108,  109,  110,  111,

			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  151,  154,  151,  154,  151,  154,  150,  153,  144,  148,
			  144,  148,  144,  148,  144,  148,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,  104,  105,  105,   54,  104,  105,   54,
			  105,  104,  105,  105,  104,  105,  104,  105,  105,  105,
			  104,  105,  105,  104,  105,  105,  104,  105,  105,   63,
			  104,  105,  104,  105,   63,  105,  105,  104,  105,  105,
			  104,  105,  105,  104,  105,  105,  104,  105,  105,  104,

			  105,  105,  104,  105,  105,   73,  104,  105,   73,  105,
			  104,  105,  105,   75,  104,  105,   75,  105,  104,  105,
			  105,   80,  104,  105,   80,  105,  104,  105,  105,  104,
			  105,  104,  105,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,  104,  105,  104,
			  105,  105,  105,  104,  105,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,   94,  104,  105,   94,  105,
			   95,  104,  105,   95,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,  101,  104,  105,
			  101,  105,  102,  104,  105,  102,  105,  131,  151,  151,

			  154,  151,  154,  150,  151,  153,  154,  150,  153,  144,
			  148,   38,  104,  105,   38,  105,   39,  104,  105,   39,
			  105,  104,  105,  105,   45,  104,  105,   45,  105,   46,
			  104,  105,   46,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,   51,  104,  105,   51,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,  104,  105,  105,   61,  104,  105,   61,
			  105,  104,  105,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,   68,  104,  105,   68,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,   74,  104,  105,

			   74,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,  104,  105,  105,  104,  105,  105,  104,
			  105,  105,   90,  104,  105,   90,  105,  104,  105,  105,
			  104,  105,  105,   93,  104,  105,   93,  105,  104,  105,
			  105,  104,  105,  105,   98,  104,  105,   98,  105,  104,
			  105,  105,  129,  151,  154,  154,  151,  150,  151,  153,
			  154,  150,  153,  149,   43,  104,  105,   43,  105,  104,
			  105,  105,   48,  104,  105,  104,  105,   48,  105,  105,
			  104,  105,  105,  104,  105,  105,   55,  104,  105,   55,

			  105,   57,  104,  105,   57,  105,  104,  105,  105,   59,
			  104,  105,   59,  105,  104,  105,  105,  104,  105,  105,
			   64,  104,  105,   64,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,   76,  104,  105,   76,  105,  104,  105,
			  105,   83,  104,  105,   83,  105,  104,  105,  105,  104,
			  105,  105,   86,  104,  105,   86,  105,  104,  105,  105,
			   88,  104,  105,   88,  105,   89,  104,  105,   89,  105,
			   91,  104,  105,   91,  105,  104,  105,  105,  104,  105,
			  105,   97,  104,  105,   97,  105,  104,  105,  105,  151,

			  150,  151,  153,  154,  154,  150,  152,  154,  152,   47,
			  104,  105,   47,  105,  104,  105,  105,   50,  104,  105,
			   50,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,   62,  104,  105,   62,  105,   66,  104,  105,   66,
			  105,  104,  105,  105,   69,  104,  105,   69,  105,   70,
			  104,  105,   70,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,  104,  105,  105,  104,  105,  105,   87,
			  104,  105,   87,  105,  104,  105,  105,  104,  105,  105,
			  100,  104,  105,  100,  105,  154,  154,  150,  151,  153,
			  154,  153,   49,  104,  105,   49,  105,   52,  104,  105,

			   52,  105,   58,  104,  105,   58,  105,   60,  104,  105,
			   60,  105,   67,  104,  105,   67,  105,  104,  105,  105,
			   78,  104,  105,   78,  105,  104,  105,  105,   85,  104,
			  105,   85,  105,  104,  105,  105,   92,  104,  105,   92,
			  105,   96,  104,  105,   96,  105,  154,  153,  154,  153,
			  154,  153,   71,  104,  105,   71,  105,   82,  104,  105,
			   82,  105,   84,  104,  105,   84,  105,  153,  154, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 2905
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 806
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 807
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

	yyNb_rules: INTEGER is 157
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 158
			-- End of buffer rule code

	yyLine_used: BOOLEAN is false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
	VERBATIM_STR1: INTEGER is 1
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

end -- EDITOR_EIFFEL_SCANNER
