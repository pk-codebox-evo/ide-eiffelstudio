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
--|#line 32 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 32")
end
-- Ignore carriage return
when 2 then
--|#line 33 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 33")
end

					create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
					update_token_list
					
when 3 then
--|#line 37 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 37")
end

					if not in_comments then
						create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 4 then
--|#line 45 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 45")
end

					from i_ := 1 until i_ > text_count loop
						create {EDITOR_TOKEN_EOL} curr_token.make
						update_token_list
						i_ := i_ + 1
					end
					in_comments := False
					
when 5 then
--|#line 57 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 57")
end
 
						-- comments
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					in_comments := True	
					update_token_list					
				
when 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 then
--|#line 66 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 66")
end

						-- Symbols
					if not in_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36 then
--|#line 87 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 87")
end
 
						-- Operator Symbol
					if not in_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)					
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103 then
--|#line 117 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 117")
end

										-- Keyword
										if not in_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 104 then
--|#line 196 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 196")
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
--|#line 216 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 216")
end

										if not in_comments then
												create {EDITOR_TOKEN_TEXT} curr_token.make(text)											
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 106 then
--|#line 228 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 228")
end

										if not in_comments then
											create {EDITOR_TOKEN_TEXT} curr_token.make(text)										
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128 then
--|#line 242 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 242")
end

					if not in_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 129 then
--|#line 272 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 272")
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
--|#line 287 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 287")
end

					-- Character error. Catch-all rules (no backing up)
					if not in_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 132 then
--|#line 310 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 310")
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
--|#line 324 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 324")
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
--|#line 339 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 339")
end
-- Ignore carriage return
when 135 then
--|#line 340 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 340")
end

							-- Verbatim string closer, possibly.
						create {EDITOR_TOKEN_STRING} curr_token.make(text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 136 then
--|#line 349 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 349")
end

							-- Verbatim string closer, possibly.
						create {EDITOR_TOKEN_STRING} curr_token.make(text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 137 then
--|#line 358 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 358")
end

						create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
						update_token_list						
					
when 138 then
--|#line 363 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 363")
end
						
						create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
						update_token_list						
					
when 139 then
--|#line 368 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 368")
end

						from i_ := 1 until i_ > text_count loop
							create {EDITOR_TOKEN_EOL} curr_token.make
							update_token_list
							i_ := i_ + 1
						end						
					
when 140 then
--|#line 376 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 376")
end

						create {EDITOR_TOKEN_STRING} curr_token.make(text)
						update_token_list
					
when 141, 142 then
--|#line 382 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 382")
end

					-- Eiffel String
					if not in_comments then						
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 143 then
--|#line 395 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 395")
end

					-- Eiffel Bit
					if not in_comments then
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)						
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 144, 145 then
--|#line 407 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 407")
end

						-- Eiffel Integer
						if not in_comments then
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 146 then
--|#line 417 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 417")
end

							-- Eiffel Integer Error (considered as text)
						if not in_comments then
							create {EDITOR_TOKEN_TEXT} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 147 then
	yy_end := yy_end - 1
--|#line 429 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 429")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 148, 149 then
--|#line 430 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 430")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 150 then
	yy_end := yy_end - 1
--|#line 432 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 432")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 151, 152 then
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
						
when 153 then
--|#line 450 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 450")
end

					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
when 154 then
--|#line 458 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 458")
end

					-- Error (considered as text)
				if not in_comments then
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
				else
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
				end
				update_token_list
				
when 155 then
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
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   40,   41,   40,   40,
			   42,   43,   44,   45,   46,   40,   47,   48,   49,   50,
			   51,   52,   53,   40,   40,   54,   55,   56,   57,   58,
			   59,   60,   61,   62,   63,   64,   65,   66,   66,   67,
			   66,   66,   68,   69,   70,   71,   72,   66,   73,   74,
			   75,   76,   77,   78,   79,   66,   66,   80,   81,   83,
			   84,   85,   86,   83,   84,   85,   86,   95,   95,  104,

			   96,   96,  102,  103,  106,  108,  107,  107,  107,  105,
			  117,  118,  109,  119,  120,  110,  628,  111,  111,  112,
			  110,  144,  111,  111,  112,  122,  110,  113,  112,  112,
			  112,  145,  113,  122,  168,  531,  133,  186,  154,  173,
			  169,  122,  155,  524,   87,   97,  122,  621,   87,  114,
			  209,  209,  209,  146,  415,  156,  115,  127,  175,  113,
			  415,  115,  403,  147,  113,  127,  170,  115,  133,  187,
			  157,  173,  171,  127,  158,   88,  402,   98,  127,   88,
			  401,  114,  122,  122,  122,  204,  122,  159,  185,  209,
			  175,  122,  122,  122,  122,  122,  122,  123,  122,  122,

			  122,  122,  124,  122,  125,  122,  122,  122,  122,  126,
			  122,  122,  122,  122,  122,  122,  122,  205,  127,  400,
			  185,  122,  187,  127,  127,  127,  127,  127,  127,  128,
			  127,  127,  127,  127,  129,  127,  130,  127,  127,  127,
			  127,  131,  127,  127,  127,  127,  127,  127,  127,  122,
			  122,  122,  198,  205,  187,  207,  399,  199,  122,  122,
			  122,  122,  122,  122,  122,  122,  132,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,
			  122,  122,  122,  122,  198,  205,  122,  207,  122,  199,
			  127,  127,  127,  127,  127,  127,  127,  127,  133,  127,

			  127,  127,  127,  127,  127,  127,  127,  127,  127,  127,
			  127,  127,  127,  127,  127,  127,  134,  122,  127,  122,
			  135,  122,  148,  136,  149,  160,  137,  172,  122,  138,
			  122,  122,  161,  162,  150,  398,  174,  397,  163,  214,
			  184,  396,  214,   95,  221,  395,   96,  211,  139,  127,
			  394,  127,  140,  127,  151,  141,  152,  164,  142,  173,
			  127,  143,  127,  127,  165,  166,  153,  176,  175,  188,
			  167,  266,  185,  122,  122,  192,  122,  177,  272,  178,
			  200,  122,  146,  179,  189,  193,  196,  122,  122,  274,
			  128,  197,  147,  206,  201,  129,  393,  130,  276,  180,

			  392,  190,  131,  266,  391,  127,  127,  194,  127,  181,
			  272,  182,  202,  127,  146,  183,  191,  195,  198,  127,
			  127,  274,  128,  199,  147,  207,  203,  129,  139,  130,
			  276,  151,  140,  152,  131,  141,  157,  164,  142,  180,
			  158,  143,  170,  153,  165,  166,  190,  194,  171,  181,
			  167,  182,  202,  159,  278,  183,  212,  195,  213,  213,
			  139,  191,  390,  151,  140,  152,  203,  141,  157,  164,
			  142,  180,  158,  143,  170,  153,  165,  166,  190,  194,
			  171,  181,  167,  182,  202,  159,  278,  183,  213,  195,
			  217,  213,  213,  191,  213,  220,  215,   95,  203,  215,

			   96,  222,  389,  388,  211,  228,  267,  228,  228,  268,
			   95,  214,  386,   96,  385,  229,  384,  229,  229,  280,
			   95,  383,  382,   96,  254,  254,  254,  258,  258,  258,
			  269,  216,  110,  270,  260,  260,  261,  255,  269,  282,
			  259,  270,  215,  218,  113,   97,  110,  214,  261,  261,
			  261,  280,  377,  263,  263,  263,  122,  265,   97,  376,
			  375,  122,  269,  256,  122,  270,  273,   95,   97,  255,
			  378,  282,  259,  115,  219,  275,  113,   98,  215,  224,
			  231,  284,  225,  100,  100,  100,   92,  115,  127,  266,
			   98,  226,  264,  127,   91,   90,  127,  100,  274,  100,

			   98,  100,  100,  227,   89,  271,  100,  276,  100,  216,
			  122,  208,  100,  284,  100,  121,  116,  100,  100,  100,
			  100,  100,  100,  232,   93,   92,  233,  234,  235,  236,
			   95,  379,   91,   96,   96,  237,  277,  272,  286,  122,
			  122,  238,  127,  239,  281,  240,  241,  242,  243,  279,
			  244,  283,  245,  122,   90,  122,  246,  122,  247,  292,
			  122,  248,  249,  250,  251,  252,  253,   89,  278,  285,
			  286,  127,  127,  287,  289,  122,  282,  288,  290,  801,
			  122,  280,  297,  284,  122,  127,  298,  127,  293,  127,
			  303,  292,  127,  122,  291,  299,  295,  122,  122,  300,

			  301,  286,  122,  294,  302,  289,  289,  127,  305,  290,
			  290,  296,  127,  304,  299,  306,  127,  122,  300,  801,
			  295,  122,  304,  308,  801,  127,  292,  299,  295,  127,
			  127,  300,  302,  320,  127,  296,  302,  122,  801,  122,
			  306,  319,  801,  296,  307,  304,  309,  306,  310,  127,
			  311,  122,  314,  127,  315,  308,  316,  326,  325,  328,
			  321,  312,  323,  122,  313,  320,  122,  317,  122,  127,
			  318,  127,  322,  320,  324,  122,  308,  122,  314,  327,
			  315,  333,  316,  127,  314,  329,  315,  122,  316,  326,
			  326,  328,  323,  317,  323,  127,  318,  330,  127,  317,

			  127,  332,  318,  331,  324,  334,  324,  127,  122,  127,
			  335,  328,  336,  334,  122,  801,  801,  330,  351,  127,
			  214,   95,  352,  214,  381,  221,  801,  379,  211,  330,
			  378,  801,  122,  332,  354,  332,  356,  334,  801,  358,
			  127,  353,  336,  343,  336,  344,  127,  337,  122,  338,
			  351,  349,  122,  345,  352,  350,  346,  339,  347,  348,
			  340,  355,  341,  342,  127,  122,  354,  366,  356,  801,
			  122,  358,  365,  354,  369,  343,  122,  344,  368,  343,
			  127,  344,  357,  351,  127,  345,  370,  352,  346,  345,
			  347,  348,  346,  356,  347,  348,  359,  127,  122,  366,

			  362,  360,  127,  372,  366,  363,  370,  367,  127,  371,
			  368,  122,  361,  122,  358,  374,  364,  419,  370,  801,
			  373,  209,  209,  209,  212,  122,  213,  213,  362,  801,
			  127,  421,  362,  363,  801,  372,  801,  363,  801,  368,
			  801,  372,  801,  127,  364,  127,  122,  374,  364,  419,
			  122,  213,  374,  213,  213,  418,  213,  127,  217,  213,
			  209,  215,  801,  421,  215,  213,  222,  213,  220,  211,
			   95,  422,  228,  378,  228,  228,  801,   95,  127,  214,
			   96,  801,  127,  380,  380,  380,  229,  419,  229,  229,
			  420,   95,  423,  801,   96,  387,  387,  387,  122,  404,

			  404,  404,  405,  423,  405,  801,  214,  406,  406,  406,
			  215,  218,  255,  407,  407,  407,  408,  408,  408,  801,
			  214,  411,  421,  411,  423,   97,  412,  412,  412,  409,
			  127,  110,  122,  413,  413,  414,  425,  215,  256,   97,
			  801,  801,  219,  113,  255,  110,  427,  414,  414,  414,
			  424,  215,  416,  416,  416,  410,  122,   98,  417,  417,
			  417,  409,  429,  122,  127,  801,  122,  431,  425,  430,
			  433,   98,  115,  426,  122,  113,  435,  122,  427,  428,
			  122,  436,  425,  432,  437,  122,  115,  439,  127,  438,
			  122,  264,  434,  122,  429,  127,  441,  264,  127,  431,

			  446,  431,  433,  447,  122,  427,  127,  801,  435,  127,
			  449,  429,  127,  437,  122,  433,  437,  127,  451,  439,
			  444,  439,  127,  442,  435,  127,  440,  122,  441,  122,
			  454,  122,  447,  457,  445,  447,  127,  443,  450,  448,
			  122,  460,  449,  455,  452,  122,  127,  458,  456,  462,
			  451,  122,  444,  122,  459,  444,  466,  453,  441,  127,
			  122,  127,  454,  127,  122,  457,  445,  464,  461,  445,
			  451,  449,  127,  461,  463,  455,  454,  127,  465,  459,
			  457,  463,  467,  127,  469,  127,  459,  468,  467,  455,
			  470,  122,  127,  471,  122,  473,  127,  474,  122,  465,

			  461,  472,  475,  122,  477,  122,  463,  122,  478,  479,
			  465,  476,  122,  801,  467,  480,  469,  482,  481,  469,
			  483,  122,  471,  127,  484,  471,  127,  473,  122,  475,
			  127,  485,  487,  473,  475,  127,  477,  127,  486,  127,
			  479,  479,  122,  477,  127,  122,  488,  482,  489,  482,
			  483,  491,  483,  127,  122,  492,  485,  490,  122,  497,
			  127,  122,  499,  485,  487,  498,  494,  496,  500,  122,
			  487,  501,  502,  493,  127,  503,  122,  127,  489,  801,
			  489,  505,  507,  491,  495,  512,  127,  494,  506,  491,
			  127,  497,  122,  127,  499,  509,  511,  499,  494,  497,

			  501,  127,  122,  501,  503,  495,  122,  503,  127,  513,
			  510,  504,  122,  505,  507,  508,  495,  513,  514,  122,
			  507,  515,  517,  519,  127,  516,  122,  509,  511,  122,
			  122,  518,   95,   95,  127,  378,  378,  801,  127,  801,
			  535,  513,  511,  505,  127,  100,  801,  509,  801,  379,
			  515,  127,  378,  515,  517,  519,   95,  517,  127,  378,
			  801,  127,  127,  519,  521,  387,  387,  387,  100,  520,
			  520,  520,  535,  801,  100,  522,  522,  522,  406,  406,
			  406,  801,  523,  523,  523,  525,  525,  525,  255,  526,
			  526,  526,  527,  801,  527,  801,  801,  528,  528,  528,

			  537,  122,  409,  529,  529,  529,  412,  412,  412,  530,
			  530,  530,  534,  532,  256,  413,  413,  414,  539,  541,
			  255,  524,  533,  533,  533,  113,  543,  532,  410,  414,
			  414,  414,  537,  127,  409,  417,  417,  417,  538,  122,
			  122,  122,  801,  540,  535,  122,  545,  547,  531,  536,
			  539,  541,  544,  122,  264,  542,  122,  113,  543,  548,
			  549,  264,  551,  122,  546,  550,  553,  122,  264,  554,
			  539,  127,  127,  127,  264,  541,  555,  127,  545,  547,
			  122,  537,  557,  559,  545,  127,  561,  543,  127,  552,
			  563,  549,  549,  122,  551,  127,  547,  551,  553,  127,

			  122,  555,  556,  565,  122,  558,  564,  122,  555,  567,
			  122,  122,  127,  560,  557,  559,  562,  122,  561,  569,
			  568,  553,  563,  566,  122,  127,  570,  571,  573,  122,
			  575,  122,  127,  577,  557,  565,  127,  559,  565,  127,
			  579,  567,  127,  127,  572,  561,  574,  581,  563,  127,
			  578,  569,  569,  122,  122,  567,  127,  122,  571,  571,
			  573,  127,  575,  127,  122,  577,  576,  122,  583,  122,
			  582,  584,  579,  580,  122,  585,  573,  122,  575,  581,
			  586,  587,  579,  122,  590,  127,  127,  589,  591,  127,
			  592,  593,  122,  122,  595,  597,  127,  598,  577,  127,

			  583,  127,  583,  585,  588,  581,  127,  585,  122,  127,
			  122,  599,  587,  587,  596,  127,  591,  594,  122,  589,
			  591,  601,  593,  593,  127,  127,  595,  597,  122,  599,
			  600,  602,  603,  605,  607,  122,  589,  609,  606,  122,
			  127,  611,  127,  599,  122,  122,  597,  122,  608,  595,
			  127,  604,  610,  601,  122,  612,  613,  615,  122,  617,
			  127,  801,  601,  603,  603,  605,  607,  127,  619,  609,
			  607,  127,  122,  611,  618,  616,  127,  127,  122,  127,
			  609,  122,  122,  605,  611,  122,  127,  613,  613,  615,
			  127,  617,  122,  614,  801,  801,  522,  522,  522,  801,

			  619,  623,  623,  623,  127,  801,  619,  617,   95,  622,
			  127,  378,  801,  127,  127,  801,  801,  127,  801,  801,
			  100,  620,  620,  620,  127,  615,  624,  624,  624,  625,
			  625,  625,  626,  626,  626,  528,  528,  528,  122,  801,
			  524,  622,  627,  627,  627,  409,  629,  629,  629,  630,
			  630,  630,  631,  631,  631,  626,  626,  626,  633,  122,
			  417,  417,  417,  635,  634,  122,  122,  801,  632,  122,
			  127,  410,  637,  643,  122,  638,  640,  409,  636,  639,
			  641,  628,  122,  122,  645,  647,  646,  642,  531,  122,
			  648,  127,  644,  649,  122,  635,  635,  127,  127,  115,

			  632,  127,  651,  653,  637,  643,  127,  640,  640,  122,
			  637,  641,  641,  655,  127,  127,  645,  647,  647,  643,
			  652,  127,  649,  650,  645,  649,  127,  122,  122,  122,
			  122,  657,  654,  122,  651,  653,  659,  661,  658,  656,
			  660,  127,  662,  663,  122,  655,  122,  664,  665,  667,
			  666,  668,  653,  669,  122,  651,  122,  122,  671,  127,
			  127,  127,  127,  657,  655,  127,  673,  675,  659,  661,
			  659,  657,  661,  670,  663,  663,  127,  122,  127,  665,
			  665,  667,  667,  669,  122,  669,  127,  672,  127,  127,
			  671,  122,  676,  674,  677,  678,  679,  680,  673,  675,

			  681,  122,  682,  683,  122,  671,  122,  685,  686,  127,
			  687,  122,  122,  684,  689,  122,  127,  691,  693,  673,
			  122,  122,  688,  127,  677,  675,  677,  679,  679,  681,
			  694,  690,  681,  127,  683,  683,  127,  695,  127,  685,
			  687,  697,  687,  127,  127,  685,  689,  127,  692,  691,
			  693,  696,  127,  127,  689,  122,  122,  122,  699,  122,
			  703,  801,  695,  691,  698,  700,  801,  700,  801,  695,
			  701,  701,  701,  697,  701,  701,  701,  702,  702,  702,
			  693,  801,  801,  697,  801,  122,  256,  127,  127,  127,
			  699,  127,  703,  626,  626,  626,  699,  705,  705,  705,

			  706,  706,  706,  707,  707,  707,  704,  708,  708,  708,
			  709,  709,  709,  524,  710,  122,  710,  127,  715,  708,
			  708,  708,  712,  712,  712,  122,  714,  122,  717,  122,
			  719,  721,  122,  716,  122,  713,  628,  720,  704,  722,
			  718,  122,  723,  122,  122,  724,  531,  127,  725,  727,
			  715,  726,  122,  122,  729,  122,  801,  127,  715,  127,
			  717,  127,  719,  721,  127,  717,  127,  713,  122,  721,
			  731,  723,  719,  127,  723,  127,  127,  725,  728,  122,
			  725,  727,  733,  727,  127,  127,  729,  127,  122,  735,
			  732,  736,  122,  730,  737,  122,  122,  739,  122,  122,

			  127,  741,  731,  734,  122,  743,  745,  738,  740,  122,
			  729,  127,  122,  122,  733,  746,  747,  742,  744,  122,
			  127,  735,  733,  737,  127,  731,  737,  127,  127,  739,
			  127,  127,  122,  741,  122,  735,  127,  743,  745,  739,
			  741,  127,  122,  122,  127,  127,  749,  747,  747,  743,
			  745,  127,  122,  751,  748,  122,  122,  750,  753,  701,
			  701,  701,  801,  122,  127,  801,  127,  752,  701,  701,
			  701,  754,  754,  754,  127,  127,  801,  801,  749,  758,
			  758,  758,  801,  801,  127,  751,  749,  127,  127,  751,
			  753,  755,  801,  755,  760,  127,  756,  756,  756,  753,

			  757,  766,  757,  801,  801,  758,  758,  758,  759,  759,
			  759,  708,  708,  708,  761,  761,  761,  122,  628,  122,
			  410,  708,  708,  708,  765,  768,  760,  762,  762,  762,
			  763,  770,  763,  766,  801,  764,  764,  764,  767,  769,
			  760,  772,  122,  122,  122,  771,  122,  122,  773,  127,
			  122,  127,  774,  122,  122,  122,  766,  768,  776,  778,
			  775,  777,  122,  770,  780,  122,  410,  801,  779,  782,
			  768,  770,  760,  772,  127,  127,  127,  772,  127,  127,
			  774,  784,  127,  783,  774,  127,  127,  127,  122,  122,
			  776,  778,  776,  778,  127,  781,  780,  127,  785,  122,

			  780,  782,  122,  786,  787,  788,  122,  122,  122,  756,
			  756,  756,  801,  784,  801,  784,  789,  789,  789,  122,
			  127,  127,  758,  758,  758,  801,  801,  782,  801,  801,
			  786,  127,  801,  801,  127,  786,  788,  788,  127,  127,
			  127,  758,  758,  758,  790,  790,  790,  791,  122,  791,
			  122,  127,  792,  792,  792,  524,  707,  707,  707,  764,
			  764,  764,  122,  793,  793,  793,  122,  795,  122,  760,
			  801,  797,  122,  122,  798,  799,  122,  794,  122,  122,
			  127,  796,  127,  754,  754,  754,  792,  792,  792,  800,
			  800,  800,  122,  122,  127,  410,  801,  122,  127,  795,

			  127,  760,  531,  797,  127,  127,  799,  799,  127,  795,
			  127,  127,  801,  797,  761,  761,  761,  790,  790,  790,
			  801,  801,  524,  801,  127,  127,  801,  801,  628,  127,
			  127,  127,  127,  127,  127,  127,  127,  127,  127,  127,
			  127,  262,  262,  262,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  531,  801,  801,  628,   82,   82,   82,
			   82,   82,   82,   82,   82,   82,   82,   82,   82,   82,
			   82,   82,   82,   82,   82,   82,   82,   94,   94,  801,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   99,  801,  801,

			  801,  801,  801,  801,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,  100,  100,  801,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  101,  101,  801,
			  101,  101,  101,  101,  101,  101,  101,  101,  101,  101,
			  101,  101,  101,  101,  101,  101,  101,  210,  210,  801,
			  210,  210,  210,  801,  801,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  211,  801,  801,
			  211,  801,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  218,  218,  801,

			  218,  218,  218,  218,  218,  218,  218,  218,  218,  218,
			  218,  218,  218,  218,  218,  218,  218,  219,  219,  801,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  223,  223,  801,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  230,  230,  801,
			  230,  230,  230,  230,  230,  230,  230,  230,  230,  230,
			  230,  230,  230,  230,  230,  230,  230,  257,  257,  257,
			  257,  257,  257,  257,  257,  801,  257,  257,  257,  257,
			  257,  257,  257,  257,  257,  257,  257,  214,  214,  801,

			  214,  214,  214,  801,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  215,  215,  801,
			  215,  215,  215,  801,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  711,  711,  711,
			  711,  711,  711,  711,  711,  801,  711,  711,  711,  711,
			  711,  711,  711,  711,  711,  711,  711,    5,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,

			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801, yy_Dummy>>)
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
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    3,
			    3,    3,    3,    4,    4,    4,    4,   12,   15,   22,

			   12,   15,   16,   16,   23,   24,   23,   23,   23,   22,
			   30,   30,   24,   32,   32,   25,  790,   25,   25,   25,
			   26,   37,   26,   26,   26,   37,   27,   25,   27,   27,
			   27,   37,   26,   40,   42,  761,   61,   47,   39,   69,
			   42,   47,   39,  754,    3,   12,   39,  521,    4,   25,
			   58,   58,   58,   37,  415,   39,   25,   37,   70,   25,
			  262,   26,  253,   37,   26,   40,   42,   27,   61,   47,
			   39,   69,   42,   47,   39,    3,  252,   12,   39,    4,
			  251,   25,   34,   34,   34,   52,   52,   39,   72,   58,
			   70,   34,   34,   34,   34,   34,   34,   34,   34,   34,

			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   52,   52,  250,
			   72,   34,   73,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   35,
			   35,   35,   76,   78,   73,   79,  249,   76,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   76,   78,  122,   79,   35,   76,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,

			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   36,   36,  122,   38,
			   36,   43,   38,   36,   38,   41,   36,   43,   41,   36,
			   44,   46,   41,   41,   38,  248,   44,  247,   41,   87,
			   46,  246,   87,  100,   87,  245,  100,   87,   36,   36,
			  244,   38,   36,   43,   38,   36,   38,   41,   36,   43,
			   41,   36,   44,   46,   41,   41,   38,   45,   44,   48,
			   41,  128,   46,   48,   45,   49,   49,   45,  130,   45,
			   51,   50,   63,   45,   48,   49,   50,   53,   51,  131,
			   60,   50,   63,   53,   51,   60,  243,   60,  133,   45,

			  242,   48,   60,  128,  241,   48,   45,   49,   49,   45,
			  130,   45,   51,   50,   63,   45,   48,   49,   50,   53,
			   51,  131,   60,   50,   63,   53,   51,   60,   62,   60,
			  133,   64,   62,   64,   60,   62,   65,   67,   62,   71,
			   65,   62,   68,   64,   67,   67,   74,   75,   68,   71,
			   67,   71,   77,   65,  139,   71,   83,   75,   83,   83,
			   62,   74,  240,   64,   62,   64,   77,   62,   65,   67,
			   62,   71,   65,   62,   68,   64,   67,   67,   74,   75,
			   68,   71,   67,   71,   77,   65,  139,   71,   85,   75,
			   85,   85,   86,   74,   86,   86,   88,   94,   77,   88,

			   94,   88,  239,  238,   88,   97,  124,   97,   97,  124,
			   97,   83,  236,   97,  235,   98,  234,   98,   98,  140,
			   98,  233,  232,   98,  107,  107,  107,  110,  110,  110,
			  129,  216,  111,  129,  111,  111,  111,  107,  124,  141,
			  110,  124,   83,   85,  111,   94,  112,   86,  112,  112,
			  112,  140,  215,  115,  115,  115,  126,  123,   97,  214,
			  210,  123,  129,  107,  132,  129,  126,  223,   98,  107,
			  223,  141,  110,  111,   85,  132,  111,   94,   86,   96,
			  101,  142,   96,   96,   96,   96,   92,  112,  126,  123,
			   97,   96,  115,  123,   91,   90,  132,   96,  126,   96,

			   98,   96,   96,   96,   89,  125,   96,  132,   96,   84,
			  125,   55,   96,  142,   96,   33,   28,   96,   96,   96,
			   96,   96,   96,  102,   11,   10,  102,  102,  102,  102,
			  224,  225,    9,  224,  225,  102,  134,  125,  143,  136,
			  134,  102,  125,  102,  136,  102,  102,  102,  102,  135,
			  102,  137,  102,  145,    8,  137,  102,  135,  102,  151,
			  138,  102,  102,  102,  102,  102,  102,    7,  134,  138,
			  143,  136,  134,  144,  146,  150,  136,  144,  146,    5,
			  144,  135,  150,  137,  148,  145,  150,  137,  149,  135,
			  155,  151,  138,  149,  148,  153,  152,  154,  155,  153,

			  154,  138,  156,  149,  157,  144,  146,  150,  156,  144,
			  146,  152,  144,  158,  150,  159,  148,  160,  150,    0,
			  149,  163,  155,  165,    0,  149,  148,  153,  152,  154,
			  155,  153,  154,  170,  156,  149,  157,  161,    0,  168,
			  156,  168,    0,  152,  161,  158,  162,  159,  162,  160,
			  162,  162,  166,  163,  166,  165,  166,  173,  172,  175,
			  169,  162,  171,  172,  162,  170,  169,  166,  174,  161,
			  166,  168,  169,  168,  171,  176,  161,  179,  162,  174,
			  162,  178,  162,  162,  166,  176,  166,  178,  166,  173,
			  172,  175,  169,  162,  171,  172,  162,  180,  169,  166,

			  174,  181,  166,  177,  169,  182,  171,  176,  177,  179,
			  184,  174,  185,  178,  184,    0,    0,  176,  190,  178,
			  218,  227,  190,  218,  227,  218,    0,  378,  218,  180,
			  378,    0,  189,  181,  191,  177,  194,  182,    0,  195,
			  177,  189,  184,  187,  185,  187,  184,  186,  188,  186,
			  190,  188,  186,  187,  190,  188,  187,  186,  187,  187,
			  186,  192,  186,  186,  189,  192,  191,  199,  194,    0,
			  193,  195,  197,  189,  201,  187,  197,  187,  202,  186,
			  188,  186,  193,  188,  186,  187,  203,  188,  187,  186,
			  187,  187,  186,  192,  186,  186,  196,  192,  200,  199,

			  198,  196,  193,  205,  197,  198,  201,  200,  197,  204,
			  202,  206,  196,  204,  193,  207,  198,  266,  203,    0,
			  206,  209,  209,  209,  212,  268,  212,  212,  196,    0,
			  200,  269,  198,  196,    0,  205,    0,  198,    0,  200,
			    0,  204,    0,  206,  196,  204,  271,  207,  198,  266,
			  265,  213,  206,  213,  213,  265,  217,  268,  217,  217,
			  209,  219,    0,  269,  219,  220,  219,  220,  220,  219,
			  226,  273,  228,  226,  228,  228,    0,  228,  271,  212,
			  228,    0,  265,  226,  226,  226,  229,  265,  229,  229,
			  267,  229,  274,    0,  229,  237,  237,  237,  267,  254,

			  254,  254,  255,  273,  255,    0,  213,  255,  255,  255,
			  212,  217,  254,  256,  256,  256,  258,  258,  258,    0,
			  220,  259,  267,  259,  274,  228,  259,  259,  259,  258,
			  267,  260,  275,  260,  260,  260,  278,  213,  254,  229,
			    0,    0,  217,  260,  254,  261,  280,  261,  261,  261,
			  277,  220,  263,  263,  263,  258,  277,  228,  264,  264,
			  264,  258,  282,  279,  275,    0,  281,  284,  278,  283,
			  286,  229,  260,  279,  285,  260,  289,  283,  280,  281,
			  287,  288,  277,  285,  290,  288,  261,  292,  277,  291,
			  293,  263,  287,  291,  282,  279,  296,  264,  281,  284,

			  298,  283,  286,  300,  298,  279,  285,    0,  289,  283,
			  302,  281,  287,  288,  294,  285,  290,  288,  304,  292,
			  299,  291,  293,  297,  287,  291,  294,  303,  296,  301,
			  306,  297,  298,  308,  299,  300,  298,  297,  303,  301,
			  305,  310,  302,  306,  305,  307,  294,  309,  307,  311,
			  304,  309,  299,  311,  314,  297,  313,  305,  294,  303,
			  312,  301,  306,  297,  313,  308,  299,  312,  315,  297,
			  303,  301,  305,  310,  316,  306,  305,  307,  317,  309,
			  307,  311,  318,  309,  320,  311,  314,  319,  313,  305,
			  321,  319,  312,  323,  322,  324,  313,  325,  321,  312,

			  315,  322,  326,  327,  330,  329,  316,  331,  333,  334,
			  317,  329,  333,    0,  318,  335,  320,  336,  335,  319,
			  336,  335,  321,  319,  337,  323,  322,  324,  337,  325,
			  321,  343,  344,  322,  326,  327,  330,  329,  338,  331,
			  333,  334,  338,  329,  333,  340,  339,  335,  345,  336,
			  335,  346,  336,  335,  339,  341,  337,  340,  342,  348,
			  337,  341,  351,  343,  344,  349,  347,  342,  350,  349,
			  338,  352,  353,  341,  338,  354,  350,  340,  339,    0,
			  345,  356,  358,  346,  347,  361,  339,  341,  357,  340,
			  342,  348,  357,  341,  351,  362,  363,  349,  347,  342,

			  350,  349,  360,  352,  353,  341,  355,  354,  350,  364,
			  360,  355,  365,  356,  358,  359,  347,  361,  367,  359,
			  357,  368,  370,  372,  357,  369,  371,  362,  363,  373,
			  369,  371,  379,  620,  360,  379,  620,    0,  355,    0,
			  419,  364,  360,  355,  365,  620,    0,  359,    0,  381,
			  367,  359,  381,  368,  370,  372,  380,  369,  371,  380,
			    0,  373,  369,  371,  387,  387,  387,  387,  380,  380,
			  380,  380,  419,    0,  381,  404,  404,  404,  405,  405,
			  405,    0,  406,  406,  406,  407,  407,  407,  404,  408,
			  408,  408,  409,    0,  409,    0,    0,  409,  409,  409,

			  421,  418,  408,  410,  410,  410,  411,  411,  411,  412,
			  412,  412,  418,  413,  404,  413,  413,  413,  423,  425,
			  404,  406,  416,  416,  416,  413,  427,  414,  408,  414,
			  414,  414,  421,  418,  408,  417,  417,  417,  422,  420,
			  422,  424,    0,  424,  418,  426,  429,  431,  412,  420,
			  423,  425,  428,  430,  413,  426,  428,  413,  427,  432,
			  433,  416,  435,  432,  430,  434,  437,  434,  414,  438,
			  422,  420,  422,  424,  417,  424,  439,  426,  429,  431,
			  436,  420,  441,  444,  428,  430,  445,  426,  428,  436,
			  447,  432,  433,  440,  435,  432,  430,  434,  437,  434,

			  442,  438,  440,  449,  443,  442,  448,  446,  439,  451,
			  448,  450,  436,  443,  441,  444,  446,  452,  445,  455,
			  453,  436,  447,  450,  453,  440,  456,  457,  459,  458,
			  461,  460,  442,  463,  440,  449,  443,  442,  448,  446,
			  465,  451,  448,  450,  458,  443,  460,  467,  446,  452,
			  464,  455,  453,  468,  464,  450,  453,  462,  456,  457,
			  459,  458,  461,  460,  466,  463,  462,  470,  471,  472,
			  470,  474,  465,  466,  474,  475,  458,  476,  460,  467,
			  476,  477,  464,  478,  481,  468,  464,  482,  483,  462,
			  484,  485,  480,  484,  487,  489,  466,  490,  462,  470,

			  471,  472,  470,  474,  480,  466,  474,  475,  486,  476,
			  488,  491,  476,  477,  488,  478,  481,  486,  492,  482,
			  483,  494,  484,  485,  480,  484,  487,  489,  493,  490,
			  492,  493,  495,  497,  499,  496,  480,  501,  498,  500,
			  486,  503,  488,  491,  498,  502,  488,  504,  500,  486,
			  492,  496,  502,  494,  506,  508,  509,  511,  508,  513,
			  493,    0,  492,  493,  495,  497,  499,  496,  515,  501,
			  498,  500,  512,  503,  514,  512,  498,  502,  516,  504,
			  500,  510,  514,  496,  502,  518,  506,  508,  509,  511,
			  508,  513,  534,  510,    0,    0,  522,  522,  522,    0,

			  515,  523,  523,  523,  512,    0,  514,  512,  520,  522,
			  516,  520,    0,  510,  514,    0,    0,  518,    0,    0,
			  520,  520,  520,  520,  534,  510,  524,  524,  524,  525,
			  525,  525,  526,  526,  526,  527,  527,  527,  536,    0,
			  523,  522,  528,  528,  528,  526,  529,  529,  529,  530,
			  530,  530,  531,  531,  531,  532,  532,  532,  533,  538,
			  533,  533,  533,  539,  538,  540,  542,    0,  532,  544,
			  536,  526,  545,  549,  550,  546,  547,  526,  544,  546,
			  547,  528,  548,  552,  553,  555,  554,  548,  530,  554,
			  556,  538,  552,  557,  556,  539,  538,  540,  542,  533,

			  532,  544,  559,  561,  545,  549,  550,  546,  547,  560,
			  544,  546,  547,  563,  548,  552,  553,  555,  554,  548,
			  560,  554,  556,  558,  552,  557,  556,  562,  558,  564,
			  566,  567,  562,  568,  559,  561,  569,  571,  568,  566,
			  570,  560,  572,  573,  570,  563,  574,  576,  577,  579,
			  578,  580,  560,  581,  582,  558,  578,  584,  585,  562,
			  558,  564,  566,  567,  562,  568,  587,  589,  569,  571,
			  568,  566,  570,  584,  572,  573,  570,  590,  574,  576,
			  577,  579,  578,  580,  588,  581,  582,  586,  578,  584,
			  585,  586,  590,  588,  591,  592,  593,  594,  587,  589,

			  595,  594,  596,  597,  598,  584,  596,  599,  600,  590,
			  601,  602,  600,  598,  603,  604,  588,  607,  609,  586,
			  606,  610,  602,  586,  590,  588,  591,  592,  593,  594,
			  612,  606,  595,  594,  596,  597,  598,  613,  596,  599,
			  600,  615,  601,  602,  600,  598,  603,  604,  608,  607,
			  609,  614,  606,  610,  602,  614,  608,  616,  619,  618,
			  625,    0,  612,  606,  618,  622,    0,  622,    0,  613,
			  622,  622,  622,  615,  623,  623,  623,  624,  624,  624,
			  608,    0,    0,  614,    0,  634,  625,  614,  608,  616,
			  619,  618,  625,  626,  626,  626,  618,  627,  627,  627,

			  628,  628,  628,  629,  629,  629,  626,  630,  630,  630,
			  631,  631,  631,  623,  632,  636,  632,  634,  637,  632,
			  632,  632,  633,  633,  633,  638,  636,  639,  641,  642,
			  643,  645,  646,  639,  648,  633,  627,  644,  626,  650,
			  642,  644,  651,  650,  652,  654,  630,  636,  655,  657,
			  637,  656,  658,  654,  661,  656,    0,  638,  636,  639,
			  641,  642,  643,  645,  646,  639,  648,  633,  660,  644,
			  663,  650,  642,  644,  651,  650,  652,  654,  660,  664,
			  655,  657,  665,  656,  658,  654,  661,  656,  662,  667,
			  664,  668,  666,  662,  669,  670,  672,  673,  674,  668,

			  660,  675,  663,  666,  676,  679,  681,  672,  674,  682,
			  660,  664,  678,  680,  665,  684,  685,  678,  680,  684,
			  662,  667,  664,  668,  666,  662,  669,  670,  672,  673,
			  674,  668,  686,  675,  688,  666,  676,  679,  681,  672,
			  674,  682,  690,  692,  678,  680,  693,  684,  685,  678,
			  680,  684,  694,  695,  692,  696,  698,  694,  699,  700,
			  700,  700,    0,  714,  686,    0,  688,  698,  701,  701,
			  701,  702,  702,  702,  690,  692,    0,    0,  693,  705,
			  705,  705,    0,    0,  694,  695,  692,  696,  698,  694,
			  699,  703,    0,  703,  707,  714,  703,  703,  703,  698,

			  704,  717,  704,    0,    0,  704,  704,  704,  706,  706,
			  706,  708,  708,  708,  709,  709,  709,  718,  705,  716,
			  707,  710,  710,  710,  716,  721,  707,  712,  712,  712,
			  713,  723,  713,  717,    0,  713,  713,  713,  720,  722,
			  712,  725,  724,  720,  722,  724,  726,  728,  730,  718,
			  730,  716,  731,  732,  734,  736,  716,  721,  737,  739,
			  736,  738,  740,  723,  741,  738,  712,    0,  740,  743,
			  720,  722,  712,  725,  724,  720,  722,  724,  726,  728,
			  730,  745,  730,  744,  731,  732,  734,  736,  746,  744,
			  737,  739,  736,  738,  740,  742,  741,  738,  748,  742,

			  740,  743,  748,  749,  750,  751,  752,  765,  750,  755,
			  755,  755,    0,  745,    0,  744,  756,  756,  756,  767,
			  746,  744,  757,  757,  757,    0,    0,  742,    0,    0,
			  748,  742,    0,    0,  748,  749,  750,  751,  752,  765,
			  750,  758,  758,  758,  759,  759,  759,  760,  769,  760,
			  771,  767,  760,  760,  760,  756,  762,  762,  762,  763,
			  763,  763,  773,  764,  764,  764,  775,  776,  777,  762,
			    0,  780,  779,  781,  783,  784,  785,  775,  783,  787,
			  769,  779,  771,  789,  789,  789,  791,  791,  791,  792,
			  792,  792,  794,  796,  773,  762,    0,  798,  775,  776,

			  777,  762,  764,  780,  779,  781,  783,  784,  785,  775,
			  783,  787,    0,  779,  793,  793,  793,  800,  800,  800,
			    0,    0,  789,    0,  794,  796,    0,    0,  792,  798,
			  808,  808,  808,  808,  808,  808,  808,  808,  808,  808,
			  808,  815,  815,  815,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  793,    0,    0,  800,  802,  802,  802,
			  802,  802,  802,  802,  802,  802,  802,  802,  802,  802,
			  802,  802,  802,  802,  802,  802,  802,  803,  803,    0,
			  803,  803,  803,  803,  803,  803,  803,  803,  803,  803,
			  803,  803,  803,  803,  803,  803,  803,  804,    0,    0,

			    0,    0,    0,    0,  804,  804,  804,  804,  804,  804,
			  804,  804,  804,  804,  804,  804,  804,  805,  805,    0,
			  805,  805,  805,  805,  805,  805,  805,  805,  805,  805,
			  805,  805,  805,  805,  805,  805,  805,  806,  806,    0,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  807,  807,    0,
			  807,  807,  807,    0,    0,  807,  807,  807,  807,  807,
			  807,  807,  807,  807,  807,  807,  807,  809,    0,    0,
			  809,    0,  809,  809,  809,  809,  809,  809,  809,  809,
			  809,  809,  809,  809,  809,  809,  809,  810,  810,    0,

			  810,  810,  810,  810,  810,  810,  810,  810,  810,  810,
			  810,  810,  810,  810,  810,  810,  810,  811,  811,    0,
			  811,  811,  811,  811,  811,  811,  811,  811,  811,  811,
			  811,  811,  811,  811,  811,  811,  811,  812,  812,    0,
			  812,  812,  812,  812,  812,  812,  812,  812,  812,  812,
			  812,  812,  812,  812,  812,  812,  812,  813,  813,    0,
			  813,  813,  813,  813,  813,  813,  813,  813,  813,  813,
			  813,  813,  813,  813,  813,  813,  813,  814,  814,  814,
			  814,  814,  814,  814,  814,    0,  814,  814,  814,  814,
			  814,  814,  814,  814,  814,  814,  814,  816,  816,    0,

			  816,  816,  816,    0,  816,  816,  816,  816,  816,  816,
			  816,  816,  816,  816,  816,  816,  816,  817,  817,    0,
			  817,  817,  817,    0,  817,  817,  817,  817,  817,  817,
			  817,  817,  817,  817,  817,  817,  817,  818,  818,  818,
			  818,  818,  818,  818,  818,    0,  818,  818,  818,  818,
			  818,  818,  818,  818,  818,  818,  818,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,

			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   87,   91,  679, 2757,  665,  651,  628,
			  620,  618,   90,    0, 2757,   91,   92, 2757, 2757, 2757,
			 2757, 2757,   82,   86,   86,   97,  102,  108,  590, 2757,
			   85, 2757,   87,  589,  162,  229,  280,   88,  282,  109,
			   96,  291,   97,  284,  293,  337,  294,  104,  336,  339,
			  344,  351,  149,  350, 2757,  555, 2757, 2757,  130,    0,
			  355,   99,  392,  349,  391,  407,    0,  403,  405,   96,
			  115,  409,  142,  189,  413,  411,  210,  423,  217,  212,
			 2757, 2757,    0,  454,  606,  486,  490,  337,  494,  602,
			  592,  590,  581, 2757,  490, 2757,  572,  503,  513,    0,

			  336,  569,  616,    0, 2757, 2757, 2757,  504, 2757, 2757,
			  507,  514,  528, 2757,    0,  533, 2757, 2757, 2757, 2757,
			 2757, 2757,  249,  524,  469,  573,  519,    0,  338,  493,
			  346,  342,  527,  350,  603,  620,  602,  618,  623,  421,
			  490,  497,  548,  592,  643,  616,  644,    0,  647,  656,
			  638,  612,  664,  651,  660,  661,  665,  664,  684,  672,
			  680,  700,  714,  684,    0,  679,  720,    0,  702,  729,
			  694,  731,  726,  725,  731,  711,  738,  771,  750,  740,
			  750,  769,  774,    0,  777,  779,  815,  811,  811,  795,
			  778,  788,  828,  833,  803,  790,  864,  839,  868,  834,

			  861,  837,  832,  849,  876,  870,  874,  869, 2757,  901,
			  549,    0,  922,  949,  552,  545,  528,  954,  818,  959,
			  963,    0,    0,  560,  623,  624,  963,  814,  970,  984,
			 2757, 2757,  511,  510,  505,  503,  501,  975,  492,  491,
			  451,  393,  389,  385,  339,  334,  330,  326,  324,  245,
			  208,  169,  165,  151,  979,  987,  993, 2757,  996, 1006,
			 1013, 1027,  101, 1032, 1038,  913,  875,  961,  888,  902,
			    0,  909,    0,  934,  955,  995,    0, 1019, 1005, 1026,
			  999, 1029, 1012, 1040, 1038, 1037, 1024, 1043, 1048, 1027,
			 1051, 1056, 1054, 1053, 1077,    0, 1047, 1094, 1067, 1091,

			 1070, 1092, 1063, 1090, 1070, 1103, 1089, 1108, 1093, 1114,
			 1104, 1116, 1123, 1127, 1121, 1131, 1141, 1134, 1153, 1154,
			 1151, 1161, 1157, 1164, 1151, 1160, 1165, 1166,    0, 1168,
			 1161, 1170,    0, 1175, 1176, 1184, 1186, 1191, 1205, 1217,
			 1208, 1224, 1221, 1198, 1199, 1219, 1202, 1235, 1213, 1232,
			 1239, 1229, 1242, 1235, 1238, 1269, 1239, 1255, 1249, 1282,
			 1265, 1248, 1262, 1251, 1272, 1275,    0, 1281, 1284, 1293,
			 1290, 1289, 1281, 1292,    0, 2757, 2757, 2757,  820, 1325,
			 1349, 1342, 2757, 2757, 2757, 2757, 2757, 1345, 2757, 2757,
			 2757, 2757, 2757, 2757, 2757, 2757, 2757, 2757, 2757, 2757,

			 2757, 2757, 2757, 2757, 1355, 1358, 1362, 1365, 1369, 1377,
			 1383, 1386, 1389, 1395, 1409,   95, 1402, 1415, 1364, 1292,
			 1402, 1353, 1403, 1383, 1404, 1380, 1408, 1379, 1419, 1413,
			 1416, 1399, 1426, 1427, 1430, 1427, 1443, 1420, 1432, 1439,
			 1456, 1436, 1463, 1467, 1441, 1440, 1470, 1444, 1473, 1470,
			 1474, 1460, 1480, 1487,    0, 1486, 1489, 1490, 1492, 1476,
			 1494, 1478, 1520, 1487, 1517, 1507, 1527, 1501, 1516,    0,
			 1530, 1528, 1532,    0, 1537, 1541, 1540, 1541, 1546,    0,
			 1555, 1547, 1538, 1551, 1556, 1557, 1571, 1548, 1573, 1554,
			 1560, 1574, 1581, 1591, 1572, 1592, 1598, 1580, 1607, 1603,

			 1602, 1591, 1608, 1597, 1610,    0, 1617,    0, 1621, 1622,
			 1644, 1608, 1635, 1619, 1645, 1639, 1641,    0, 1648,    0,
			 1701,  136, 1676, 1681, 1706, 1709, 1712, 1715, 1722, 1726,
			 1729, 1732, 1735, 1740, 1655,    0, 1701,    0, 1722, 1721,
			 1728,    0, 1729,    0, 1732, 1726, 1742, 1743, 1745, 1731,
			 1737,    0, 1746, 1738, 1752, 1751, 1757, 1760, 1791, 1770,
			 1772, 1755, 1790, 1771, 1792,    0, 1793, 1785, 1796, 1794,
			 1807, 1804, 1805, 1806, 1809,    0, 1810, 1811, 1819, 1818,
			 1814, 1816, 1817,    0, 1820, 1805, 1854, 1833, 1847, 1821,
			 1840, 1842, 1858, 1859, 1864, 1867, 1869, 1870, 1867, 1861,

			 1875, 1877, 1874, 1866, 1878,    0, 1883, 1869, 1919, 1889,
			 1884,    0, 1893, 1900, 1918, 1908, 1920,    0, 1922, 1916,
			 1326, 2757, 1950, 1954, 1957, 1927, 1973, 1977, 1980, 1983,
			 1987, 1990, 1999, 2002, 1948,    0, 1978, 1970, 1988, 1990,
			    0, 1985, 1992, 1982, 2004, 1998, 1995,    0, 1997,    0,
			 2006, 2009, 2007,    0, 2016, 2019, 2018, 2016, 2015,    0,
			 2031, 2007, 2051, 2028, 2042, 2034, 2055, 2041, 2062, 2065,
			 2058,    0, 2059, 2049, 2061, 2054, 2067,    0, 2075, 2063,
			 2076, 2064, 2072,    0, 2082, 2083, 2095,    0, 2097,    0,
			 2105,    0, 2106, 2098, 2115, 2111, 2118,    0, 2119, 2110,

			 2139, 2148, 2151, 2176, 2185, 2159, 2188, 2161, 2191, 2194,
			 2201, 2757, 2207, 2215, 2126,    0, 2182, 2159, 2180,    0,
			 2206, 2193, 2207, 2199, 2205, 2201, 2209,    0, 2210,    0,
			 2213, 2217, 2216,    0, 2217,    0, 2218, 2216, 2228, 2226,
			 2225, 2221, 2262, 2236, 2252, 2250, 2251,    0, 2265, 2270,
			 2271, 2272, 2269,    0,   84, 2289, 2296, 2302, 2321, 2324,
			 2332,   76, 2336, 2339, 2343, 2270,    0, 2282,    0, 2311,
			    0, 2313,    0, 2325,    0, 2329, 2319, 2331,    0, 2335,
			 2325, 2336,    0, 2341, 2342, 2339,    0, 2342,    0, 2363,
			   57, 2366, 2369, 2394, 2355,    0, 2356,    0, 2360,    0,

			 2397, 2757, 2456, 2476, 2496, 2516, 2536, 2556, 2420, 2576,
			 2596, 2616, 2636, 2656, 2676, 2431, 2696, 2716, 2736, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  801,    1,  802,  802,  801,  801,  801,  801,  801,
			  801,  801,  803,  804,  801,  805,  806,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,  801,  801,  801,  801,  801,  807,
			  808,  808,  808,  808,  808,  808,  808,  808,  808,  808,
			  808,  808,  808,  808,  808,  808,  808,  808,  808,  808,
			  801,  801,  809,  801,  801,  809,  801,  810,  811,  801,
			  801,  801,  801,  801,  803,  801,  812,  803,  803,  804,

			  805,  813,  813,  813,  801,  801,  801,  801,  801,  801,
			  814,  801,  801,  801,  815,  801,  801,  801,  801,  801,
			  801,  801,   35,   35,   35,   35,   35,  808,  808,  808,
			  808,  808,   35,  808,   35,   35,   35,   35,   35,  808,
			  808,  808,  808,  808,   35,   35,  808,  808,   35,   35,
			   35,  808,  808,  808,   35,   35,   35,  808,  808,  808,
			   35,   35,   35,   35,  808,  808,  808,  808,   35,   35,
			  808,  808,   35,  808,   35,  808,   35,   35,   35,   35,
			  808,  808,  808,  808,   35,  808,   35,  808,   35,   35,
			  808,  808,   35,   35,  808,  808,   35,   35,  808,  808,

			   35,   35,  808,  808,   35,  808,   35,  808,  801,  801,
			  807,  809,  801,  801,  816,  817,  801,  809,  810,  811,
			  801,  809,  809,  812,  805,  805,  812,  812,  803,  803,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  815,  801,  801,   35,  808,   35,   35,  808,
			  808,   35,  808,   35,  808,   35,  808,   35,  808,   35,
			  808,   35,  808,   35,  808,   35,  808,   35,   35,  808,
			  808,   35,  808,   35,   35,  808,  808,   35,   35,  808,

			  808,   35,  808,   35,  808,   35,  808,   35,  808,   35,
			   35,   35,   35,   35,  808,  808,  808,  808,  808,   35,
			  808,   35,   35,  808,  808,   35,  808,   35,  808,   35,
			  808,   35,  808,   35,  808,   35,  808,   35,   35,   35,
			   35,   35,   35,  808,  808,  808,  808,  808,  808,   35,
			   35,  808,  808,   35,  808,   35,  808,   35,  808,   35,
			   35,   35,  808,  808,  808,   35,  808,   35,  808,   35,
			  808,   35,  808,   35,  808,  801,  801,  801,  812,  812,
			  812,  812,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,

			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  815,  801,  801,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,   35,  808,  808,   35,  808,   35,  808,
			   35,  808,   35,   35,  808,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,   35,  808,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,   35,  808,  808,   35,  808,   35,  808,

			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			  812,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  814,  801,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,

			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			  812,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  818,   35,  808,   35,  808,   35,   35,
			  808,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,

			  801,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,   35,  808,   35,  808,   35,  808,
			   35,  808,   35,  808,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,   35,  808,   35,  808,   35,
			  808,   35,  808,   35,  808,   35,  808,   35,  808,   35,
			  808,   35,  808,   35,  808,   35,  808,   35,  808,  801,
			  801,  801,  801,  801,   35,  808,   35,  808,   35,  808,

			  801,    0,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    5,    6,    7,    8,    9,   10,    8,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   22,   22,   23,   24,
			   25,   26,   27,   28,    8,   29,   30,   31,   32,   33,
			   34,   35,   36,   37,   38,   39,   40,   41,   42,   43,
			   44,   45,   46,   47,   48,   49,   50,   51,   52,   53,
			   54,   55,   56,   57,   58,   59,   60,   61,   62,   63,

			   64,   65,   66,   67,   68,   69,   70,   71,   72,   73,
			   74,   75,   76,   77,   78,   79,   80,   81,   82,   83,
			   84,   85,   86,   87,    8,   88,    1,    1,    1,    1,
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
			   10,   11,   12,    1,    1,    1,    1,    1,    1,   10,
			   10,   10,   10,   10,   10,   13,   13,   13,   13,   13,
			   13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
			   13,   13,   14,   15,   16,    1,    1,    1,    1,   17,
			    1,   10,   10,   10,   10,   10,   10,   13,   13,   13,
			   13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
			   13,   13,   13,   13,   18,   19,   20,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    2,    3,    4,    6,    9,   11,
			   14,   17,   20,   23,   26,   29,   32,   34,   37,   40,
			   43,   46,   49,   52,   55,   58,   62,   66,   70,   73,
			   76,   79,   82,   85,   87,   91,   95,   99,  103,  107,
			  111,  115,  119,  123,  127,  131,  135,  139,  143,  147,
			  151,  155,  159,  163,  167,  170,  172,  175,  178,  181,
			  183,  186,  189,  192,  195,  198,  201,  204,  207,  210,
			  213,  216,  219,  222,  225,  228,  231,  234,  237,  240,
			  243,  246,  249,  251,  253,  255,  258,  260,  262,  264,
			  265,  266,  267,  268,  269,  270,  271,  272,  275,  278,

			  279,  280,  281,  282,  283,  284,  285,  286,  288,  289,
			  290,  290,  292,  294,  295,  295,  296,  297,  298,  299,
			  300,  301,  302,  304,  306,  308,  310,  313,  314,  315,
			  316,  317,  319,  321,  322,  324,  326,  328,  330,  332,
			  333,  334,  335,  336,  337,  339,  342,  343,  345,  347,
			  349,  351,  352,  353,  354,  356,  358,  360,  361,  362,
			  363,  366,  368,  370,  373,  375,  376,  377,  379,  381,
			  383,  384,  385,  387,  388,  390,  391,  393,  395,  397,
			  400,  401,  402,  403,  405,  407,  408,  410,  411,  413,
			  415,  416,  417,  419,  421,  422,  423,  425,  427,  428,

			  429,  431,  433,  434,  435,  437,  438,  440,  441,  442,
			  443,  443,  444,  445,  445,  445,  445,  446,  448,  449,
			  450,  451,  453,  455,  455,  457,  459,  459,  459,  461,
			  463,  464,  466,  467,  468,  469,  470,  471,  472,  473,
			  474,  475,  476,  477,  478,  479,  480,  481,  482,  483,
			  484,  485,  486,  487,  488,  490,  490,  490,  491,  493,
			  494,  496,  498,  499,  501,  502,  504,  505,  507,  510,
			  511,  513,  516,  518,  520,  521,  524,  526,  528,  529,
			  531,  532,  534,  535,  537,  538,  540,  541,  543,  545,
			  546,  547,  549,  550,  553,  555,  557,  558,  560,  562,

			  563,  564,  566,  567,  569,  570,  572,  573,  575,  576,
			  578,  580,  582,  584,  586,  587,  588,  589,  590,  591,
			  593,  594,  596,  598,  599,  600,  602,  603,  606,  608,
			  610,  611,  614,  616,  618,  619,  621,  622,  624,  626,
			  628,  630,  632,  634,  635,  636,  637,  638,  639,  640,
			  642,  644,  645,  646,  648,  649,  651,  652,  654,  655,
			  657,  659,  661,  662,  663,  664,  667,  669,  671,  672,
			  674,  675,  677,  678,  681,  683,  684,  685,  686,  687,
			  688,  688,  689,  690,  691,  692,  693,  694,  695,  696,
			  697,  698,  699,  700,  701,  702,  703,  704,  705,  706,

			  707,  708,  709,  710,  711,  713,  713,  715,  715,  717,
			  717,  717,  717,  719,  721,  723,  723,  725,  727,  729,
			  730,  732,  733,  735,  736,  738,  739,  741,  742,  744,
			  745,  747,  748,  750,  751,  753,  754,  756,  757,  760,
			  762,  764,  765,  767,  769,  770,  771,  773,  774,  776,
			  777,  779,  780,  783,  785,  787,  788,  790,  791,  793,
			  794,  796,  797,  799,  800,  802,  803,  805,  806,  809,
			  811,  813,  814,  817,  819,  821,  822,  824,  825,  828,
			  830,  832,  834,  835,  836,  838,  839,  841,  842,  844,
			  845,  847,  848,  850,  852,  853,  854,  856,  857,  859,

			  860,  862,  863,  865,  866,  869,  871,  874,  876,  878,
			  879,  881,  882,  884,  885,  887,  888,  891,  893,  896,
			  898,  898,  899,  900,  902,  902,  902,  904,  904,  908,
			  908,  910,  910,  910,  912,  915,  917,  920,  922,  924,
			  925,  928,  930,  933,  935,  937,  938,  940,  941,  943,
			  944,  947,  949,  951,  952,  954,  955,  957,  958,  960,
			  961,  963,  964,  966,  967,  970,  972,  974,  975,  977,
			  978,  980,  981,  983,  984,  987,  989,  991,  992,  994,
			  995,  997,  998, 1001, 1003, 1005, 1006, 1008, 1009, 1011,
			 1012, 1014, 1015, 1017, 1018, 1020, 1021, 1023, 1024, 1026,

			 1027, 1029, 1030, 1032, 1033, 1036, 1038, 1040, 1041, 1043,
			 1044, 1047, 1049, 1051, 1052, 1054, 1055, 1058, 1060, 1062,
			 1063, 1063, 1064, 1064, 1066, 1066, 1067, 1068, 1072, 1072,
			 1072, 1074, 1074, 1075, 1075, 1078, 1080, 1082, 1083, 1086,
			 1088, 1090, 1091, 1093, 1094, 1096, 1097, 1100, 1102, 1105,
			 1107, 1109, 1110, 1113, 1115, 1117, 1118, 1120, 1121, 1124,
			 1126, 1128, 1129, 1131, 1132, 1134, 1135, 1137, 1138, 1140,
			 1141, 1144, 1146, 1148, 1149, 1151, 1152, 1155, 1157, 1159,
			 1160, 1162, 1163, 1166, 1168, 1170, 1171, 1174, 1176, 1179,
			 1181, 1184, 1186, 1188, 1189, 1191, 1192, 1195, 1197, 1199,

			 1200, 1200, 1201, 1201, 1201, 1201, 1205, 1205, 1206, 1207,
			 1207, 1207, 1208, 1209, 1210, 1213, 1215, 1217, 1218, 1221,
			 1223, 1225, 1226, 1228, 1229, 1231, 1232, 1235, 1237, 1240,
			 1242, 1244, 1245, 1248, 1250, 1253, 1255, 1257, 1258, 1260,
			 1261, 1263, 1264, 1266, 1267, 1269, 1270, 1273, 1275, 1277,
			 1278, 1280, 1281, 1284, 1286, 1287, 1287, 1288, 1288, 1290,
			 1290, 1290, 1291, 1292, 1292, 1293, 1296, 1298, 1301, 1303,
			 1306, 1308, 1311, 1313, 1316, 1318, 1320, 1321, 1324, 1326,
			 1328, 1329, 1332, 1334, 1336, 1337, 1340, 1342, 1345, 1347,
			 1348, 1350, 1350, 1352, 1353, 1356, 1358, 1361, 1363, 1366,

			 1368, 1370, 1370, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  140,  140,  156,  154,  155,    3,  154,  155,    4,
			  155,    1,  154,  155,    2,  154,  155,   10,  154,  155,
			  142,  154,  155,  106,  154,  155,   17,  154,  155,  142,
			  154,  155,  154,  155,   11,  154,  155,   12,  154,  155,
			   31,  154,  155,   30,  154,  155,    8,  154,  155,   29,
			  154,  155,    6,  154,  155,   32,  154,  155,  144,  146,
			  154,  155,  144,  146,  154,  155,  144,  146,  154,  155,
			    9,  154,  155,    7,  154,  155,   36,  154,  155,   34,
			  154,  155,   35,  154,  155,  154,  155,  104,  105,  154,
			  155,  104,  105,  154,  155,  104,  105,  154,  155,  104,

			  105,  154,  155,  104,  105,  154,  155,  104,  105,  154,
			  155,  104,  105,  154,  155,  104,  105,  154,  155,  104,
			  105,  154,  155,  104,  105,  154,  155,  104,  105,  154,
			  155,  104,  105,  154,  155,  104,  105,  154,  155,  104,
			  105,  154,  155,  104,  105,  154,  155,  104,  105,  154,
			  155,  104,  105,  154,  155,  104,  105,  154,  155,  104,
			  105,  154,  155,  104,  105,  154,  155,   15,  154,  155,
			  154,  155,   16,  154,  155,   33,  154,  155,  146,  154,
			  155,  154,  155,  105,  154,  155,  105,  154,  155,  105,
			  154,  155,  105,  154,  155,  105,  154,  155,  105,  154,

			  155,  105,  154,  155,  105,  154,  155,  105,  154,  155,
			  105,  154,  155,  105,  154,  155,  105,  154,  155,  105,
			  154,  155,  105,  154,  155,  105,  154,  155,  105,  154,
			  155,  105,  154,  155,  105,  154,  155,  105,  154,  155,
			  105,  154,  155,   13,  154,  155,   14,  154,  155,  140,
			  155,  138,  155,  139,  155,  134,  140,  155,  137,  155,
			  140,  155,  140,  155,    3,    4,    1,    2,   37,  142,
			  141,  141, -132,  142, -287, -133,  142, -288,  106,  142,
			  130,  130,  130,    5,   23,   24,  149,  152,   18,   20,
			  144,  146,  144,  146,  143,  146,   28,   25,   22,   21,

			   26,   27,  104,  105,  104,  105,  104,  105,  104,  105,
			   42,  104,  105,  105,  105,  105,  105,   42,  105,  104,
			  105,  105,  104,  105,  104,  105,  104,  105,  104,  105,
			  104,  105,  105,  105,  105,  105,  105,  104,  105,   53,
			  104,  105,  105,   53,  105,  104,  105,  104,  105,  104,
			  105,  105,  105,  105,  104,  105,  104,  105,  104,  105,
			  105,  105,  105,   65,  104,  105,  104,  105,  104,  105,
			   72,  104,  105,   65,  105,  105,  105,   72,  105,  104,
			  105,  104,  105,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  104,  105,  104,  105,   81,  104,  105,

			  105,  105,  105,   81,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  104,  105,  105,  105,  104,  105,  104,
			  105,  105,  105,  104,  105,  104,  105,  105,  105,  104,
			  105,  104,  105,  105,  105,  104,  105,  105,  104,  105,
			  105,   19,  146,  140,  138,  139,  134,  140,  140,  140,
			  137,  135,  140,  136,  140,  141,  142,  141,  142, -132,
			  142, -133,  142,  130,  107,  130,  130,  130,  130,  130,
			  130,  130,  130,  130,  130,  130,  130,  130,  130,  130,
			  130,  130,  130,  130,  130,  130,  130,  130,  149,  152,
			  147,  149,  152,  147,  144,  146,  144,  146,  145,  144,

			  146,  146,  104,  105,  105,  104,  105,   40,  104,  105,
			  105,   40,  105,   41,  104,  105,   41,  105,  104,  105,
			  105,   44,  104,  105,   44,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  104,  105,  105,  105,  104,  105,  105,
			   56,  104,  105,  104,  105,   56,  105,  105,  104,  105,
			  104,  105,  105,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,  104,  105,  105,  104,  105,  104,  105,
			  104,  105,  104,  105,  104,  105,  105,  105,  105,  105,
			  105,  104,  105,  105,  104,  105,  104,  105,  105,  105,

			  104,  105,  105,   77,  104,  105,   77,  105,  104,  105,
			  105,   79,  104,  105,   79,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  104,  105,  104,  105,  104,  105,
			  104,  105,  104,  105,  105,  105,  105,  105,  105,  105,
			  104,  105,  104,  105,  105,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  104,  105,  104,
			  105,  105,  105,  105,   96,  104,  105,   96,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  103,  104,
			  105,  103,  105,  153,  135,  136,  141,  141,  141,  124,
			  122,  123,  125,  126,  131,  127,  128,  108,  109,  110,

			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  149,  152,  149,  152,  149,  152,  148,  151,  144,
			  146,  144,  146,  144,  146,  144,  146,  104,  105,  105,
			  104,  105,  105,  104,  105,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,   54,  104,  105,
			   54,  105,  104,  105,  105,  104,  105,  104,  105,  105,
			  105,  104,  105,  105,  104,  105,  105,  104,  105,  105,
			   63,  104,  105,  104,  105,   63,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,  104,  105,  105,

			  104,  105,  105,  104,  105,  105,   73,  104,  105,   73,
			  105,  104,  105,  105,   75,  104,  105,   75,  105,  104,
			  105,  105,  104,  105,  105,   80,  104,  105,   80,  105,
			  104,  105,  104,  105,  105,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  104,  105,  105,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,  104,  105,  105,   94,  104,  105,   94,
			  105,   95,  104,  105,   95,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  101,  104,
			  105,  101,  105,  102,  104,  105,  102,  105,  131,  149,

			  149,  152,  149,  152,  148,  149,  151,  152,  148,  151,
			  144,  146,   38,  104,  105,   38,  105,   39,  104,  105,
			   39,  105,  104,  105,  105,   45,  104,  105,   45,  105,
			   46,  104,  105,   46,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,   51,  104,  105,   51,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,   61,  104,  105,
			   61,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,   68,  104,  105,   68,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,   74,  104,

			  105,   74,  105,  104,  105,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,   90,  104,  105,   90,  105,  104,  105,
			  105,  104,  105,  105,   93,  104,  105,   93,  105,  104,
			  105,  105,  104,  105,  105,   99,  104,  105,   99,  105,
			  104,  105,  105,  129,  149,  152,  152,  149,  148,  149,
			  151,  152,  148,  151,  147,   43,  104,  105,   43,  105,
			  104,  105,  105,   48,  104,  105,  104,  105,   48,  105,
			  105,  104,  105,  105,  104,  105,  105,   55,  104,  105,

			   55,  105,   57,  104,  105,   57,  105,  104,  105,  105,
			   59,  104,  105,   59,  105,  104,  105,  105,  104,  105,
			  105,   64,  104,  105,   64,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,   76,  104,  105,   76,  105,  104,  105,  105,  104,
			  105,  105,   83,  104,  105,   83,  105,  104,  105,  105,
			  104,  105,  105,   86,  104,  105,   86,  105,  104,  105,
			  105,   88,  104,  105,   88,  105,   89,  104,  105,   89,
			  105,   91,  104,  105,   91,  105,  104,  105,  105,  104,
			  105,  105,   98,  104,  105,   98,  105,  104,  105,  105,

			  149,  148,  149,  151,  152,  152,  148,  150,  152,  150,
			   47,  104,  105,   47,  105,  104,  105,  105,   50,  104,
			  105,   50,  105,  104,  105,  105,  104,  105,  105,  104,
			  105,  105,   62,  104,  105,   62,  105,   66,  104,  105,
			   66,  105,  104,  105,  105,   69,  104,  105,   69,  105,
			   70,  104,  105,   70,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,  104,  105,  105,
			   87,  104,  105,   87,  105,  104,  105,  105,  104,  105,
			  105,  100,  104,  105,  100,  105,  152,  152,  148,  149,
			  151,  152,  151,   49,  104,  105,   49,  105,   52,  104,

			  105,   52,  105,   58,  104,  105,   58,  105,   60,  104,
			  105,   60,  105,   67,  104,  105,   67,  105,  104,  105,
			  105,   78,  104,  105,   78,  105,  104,  105,  105,   85,
			  104,  105,   85,  105,  104,  105,  105,   92,  104,  105,
			   92,  105,   97,  104,  105,   97,  105,  152,  151,  152,
			  151,  152,  151,   71,  104,  105,   71,  105,   82,  104,
			  105,   82,  105,   84,  104,  105,   84,  105,  151,  152, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 2757
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 801
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 802
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

	yyNb_rules: INTEGER is 155
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 156
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
