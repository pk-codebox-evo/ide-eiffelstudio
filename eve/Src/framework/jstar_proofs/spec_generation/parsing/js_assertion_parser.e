class JS_ASSERTION_PARSER
--class JS_PREDICATE_DEFINITION_PARSER

inherit
    YY_PARSER_SKELETON
        rename make as make_parser_skeleton end
    
    JS_SPEC_LEXER
    rename make as make_scanner end
    
create
    make

feature {NONE} -- Implementation

	yy_build_parser_tables is
			-- Build parser tables.
		do
			yytranslate := yytranslate_template
			yyr1 := yyr1_template
			yytypes1 := yytypes1_template
			yytypes2 := yytypes2_template
			yydefact := yydefact_template
			yydefgoto := yydefgoto_template
			yypact := yypact_template
			yypgoto := yypgoto_template
			yytable := yytable_template
			yycheck := yycheck_template
		end

	yy_create_value_stacks is
			-- Create value stacks.
		do
		end

	yy_init_value_stacks is
			-- Initialize value stacks.
		do
			yyvsp1 := -1
			yyvsp2 := -1
			yyvsp3 := -1
			yyvsp4 := -1
			yyvsp5 := -1
			yyvsp6 := -1
			yyvsp7 := -1
			yyvsp8 := -1
			yyvsp9 := -1
			yyvsp10 := -1
			yyvsp11 := -1
			yyvsp12 := -1
			yyvsp13 := -1
			yyvsp14 := -1
			yyvsp15 := -1
			yyvsp16 := -1
			yyvsp17 := -1
			yyvsp18 := -1
		end

	yy_clear_value_stacks is
			-- Clear objects in semantic value stacks so that
			-- they can be collected by the garbage collector.
		do
			if yyvs1 /= Void then
				yyvs1.clear_all
			end
			if yyvs2 /= Void then
				yyvs2.clear_all
			end
			if yyvs3 /= Void then
				yyvs3.clear_all
			end
			if yyvs4 /= Void then
				yyvs4.clear_all
			end
			if yyvs5 /= Void then
				yyvs5.clear_all
			end
			if yyvs6 /= Void then
				yyvs6.clear_all
			end
			if yyvs7 /= Void then
				yyvs7.clear_all
			end
			if yyvs8 /= Void then
				yyvs8.clear_all
			end
			if yyvs9 /= Void then
				yyvs9.clear_all
			end
			if yyvs10 /= Void then
				yyvs10.clear_all
			end
			if yyvs11 /= Void then
				yyvs11.clear_all
			end
			if yyvs12 /= Void then
				yyvs12.clear_all
			end
			if yyvs13 /= Void then
				yyvs13.clear_all
			end
			if yyvs14 /= Void then
				yyvs14.clear_all
			end
			if yyvs15 /= Void then
				yyvs15.clear_all
			end
			if yyvs16 /= Void then
				yyvs16.clear_all
			end
			if yyvs17 /= Void then
				yyvs17.clear_all
			end
			if yyvs18 /= Void then
				yyvs18.clear_all
			end
		end

	yy_push_last_value (yychar1: INTEGER) is
			-- Push semantic value associated with token `last_token'
			-- (with internal id `yychar1') on top of corresponding
			-- value stack.
		do
			inspect yytypes2.item (yychar1)
			when 1 then
				yyvsp1 := yyvsp1 + 1
				if yyvsp1 >= yyvsc1 then
					if yyvs1 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs1")
						end
						create yyspecial_routines1
						yyvsc1 := yyInitial_yyvs_size
						yyvs1 := yyspecial_routines1.make (yyvsc1)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs1")
						end
						yyvsc1 := yyvsc1 + yyInitial_yyvs_size
						yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
					end
				end
				yyvs1.put (last_any_value, yyvsp1)
			when 2 then
				yyvsp2 := yyvsp2 + 1
				if yyvsp2 >= yyvsc2 then
					if yyvs2 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs2")
						end
						create yyspecial_routines2
						yyvsc2 := yyInitial_yyvs_size
						yyvs2 := yyspecial_routines2.make (yyvsc2)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs2")
						end
						yyvsc2 := yyvsc2 + yyInitial_yyvs_size
						yyvs2 := yyspecial_routines2.resize (yyvs2, yyvsc2)
					end
				end
				yyvs2.put (last_string_value, yyvsp2)
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: not a token type: ")
					std.error.put_integer (yytypes2.item (yychar1))
					std.error.put_new_line
				end
				abort
			end
		end

	yy_push_error_value is
			-- Push semantic value associated with token 'error'
			-- on top of corresponding value stack.
		local
			yyval1: ANY
		do
			yyvsp1 := yyvsp1 + 1
			if yyvsp1 >= yyvsc1 then
				if yyvs1 = Void then
					debug ("GEYACC")
						std.error.put_line ("Create yyvs1")
					end
					create yyspecial_routines1
					yyvsc1 := yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.make (yyvsc1)
				else
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs1")
					end
					yyvsc1 := yyvsc1 + yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
				end
			end
			yyvs1.put (yyval1, yyvsp1)
		end

	yy_pop_last_value (yystate: INTEGER) is
			-- Pop semantic value from stack when in state `yystate'.
		local
			yy_type_id: INTEGER
		do
			yy_type_id := yytypes1.item (yystate)
			inspect yy_type_id
			when 1 then
				yyvsp1 := yyvsp1 - 1
			when 2 then
				yyvsp2 := yyvsp2 - 1
			when 3 then
				yyvsp3 := yyvsp3 - 1
			when 4 then
				yyvsp4 := yyvsp4 - 1
			when 5 then
				yyvsp5 := yyvsp5 - 1
			when 6 then
				yyvsp6 := yyvsp6 - 1
			when 7 then
				yyvsp7 := yyvsp7 - 1
			when 8 then
				yyvsp8 := yyvsp8 - 1
			when 9 then
				yyvsp9 := yyvsp9 - 1
			when 10 then
				yyvsp10 := yyvsp10 - 1
			when 11 then
				yyvsp11 := yyvsp11 - 1
			when 12 then
				yyvsp12 := yyvsp12 - 1
			when 13 then
				yyvsp13 := yyvsp13 - 1
			when 14 then
				yyvsp14 := yyvsp14 - 1
			when 15 then
				yyvsp15 := yyvsp15 - 1
			when 16 then
				yyvsp16 := yyvsp16 - 1
			when 17 then
				yyvsp17 := yyvsp17 - 1
			when 18 then
				yyvsp18 := yyvsp18 - 1
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown type id: ")
					std.error.put_integer (yy_type_id)
					std.error.put_new_line
				end
				abort
			end
		end

feature {NONE} -- Semantic actions

	yy_do_action (yy_act: INTEGER) is
			-- Execute semantic action.
		local
			yyval6: JS_ASSERTION_NODE
			yyval8: LINKED_LIST [JS_PURE_NODE]
			yyval7: JS_PURE_NODE
			yyval10: LINKED_LIST [JS_ARGUMENT_NODE]
			yyval9: JS_ARGUMENT_NODE
			yyval11: JS_VARIABLE_NODE
			yyval13: LINKED_LIST [JS_FLD_EQUALITY_NODE]
			yyval12: JS_FLD_EQUALITY_NODE
			yyval14: JS_TYPE_NODE
			yyval1: ANY
			yyval16: LINKED_LIST [JS_SPATIAL_NODE]
			yyval15: JS_SPATIAL_NODE
			yyval17: JS_COMBINE_NODE
			yyval18: JS_FIELD_SIG_NODE
		do
			inspect yy_act
when 1 then
--|#line 81 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 81")
end

create yyval6.make (yyvs8.item (yyvsp8), yyvs16.item (yyvsp16)); assertion := yyval6 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp6 := yyvsp6 + 1
	yyvsp8 := yyvsp8 -1
	yyvsp1 := yyvsp1 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyvs6.put (yyval6, yyvsp6)
end
when 2 then
--|#line 84 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 84")
end

create yyval8.make 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp8 := yyvsp8 + 1
	if yyvsp8 >= yyvsc8 then
		if yyvs8 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs8")
			end
			create yyspecial_routines8
			yyvsc8 := yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.make (yyvsc8)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs8")
			end
			yyvsc8 := yyvsc8 + yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.resize (yyvs8, yyvsc8)
		end
	end
	yyvs8.put (yyval8, yyvsp8)
end
when 3 then
--|#line 85 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 85")
end

yyval8 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs8.put (yyval8, yyvsp8)
end
when 4 then
--|#line 88 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 88")
end

create yyval8.make; yyval8.put_front (yyvs7.item (yyvsp7)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp8 := yyvsp8 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp8 >= yyvsc8 then
		if yyvs8 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs8")
			end
			create yyspecial_routines8
			yyvsc8 := yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.make (yyvsc8)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs8")
			end
			yyvsc8 := yyvsc8 + yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.resize (yyvs8, yyvsc8)
		end
	end
	yyvs8.put (yyval8, yyvsp8)
end
when 5 then
--|#line 89 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 89")
end

yyvs8.item (yyvsp8).put_front (yyvs7.item (yyvsp7)); yyval8 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -1
	yyvs8.put (yyval8, yyvsp8)
end
when 6 then
--|#line 92 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 92")
end

create {JS_PURE_PREDICATE_NODE} yyval7.make (yyvs2.item (yyvsp2), yyvs10.item (yyvsp10)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp7 := yyvsp7 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp10 := yyvsp10 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyvs7.put (yyval7, yyvsp7)
end
when 7 then
--|#line 93 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 93")
end

create {JS_PURE_EQUALITY_NODE} yyval7.make (yyvs9.item (yyvsp9 - 1), yyvs9.item (yyvsp9)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp7 := yyvsp7 + 1
	yyvsp9 := yyvsp9 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyvs7.put (yyval7, yyvsp7)
end
when 8 then
--|#line 94 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 94")
end

create {JS_PURE_INEQUALITY_NODE} yyval7.make (yyvs9.item (yyvsp9 - 1), yyvs9.item (yyvsp9)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp7 := yyvsp7 + 1
	yyvsp9 := yyvsp9 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyvs7.put (yyval7, yyvsp7)
end
when 9 then
--|#line 95 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 95")
end

create {JS_PURE_TYPE_JUDGEMENT_NODE} yyval7.make (yyvs9.item (yyvsp9), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp7 := yyvsp7 + 1
	yyvsp9 := yyvsp9 -1
	yyvsp1 := yyvsp1 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyvs7.put (yyval7, yyvsp7)
end
when 10 then
--|#line 98 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 98")
end

create yyval10.make 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp10 := yyvsp10 + 1
	if yyvsp10 >= yyvsc10 then
		if yyvs10 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs10")
			end
			create yyspecial_routines10
			yyvsc10 := yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.make (yyvsc10)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs10")
			end
			yyvsc10 := yyvsc10 + yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.resize (yyvs10, yyvsc10)
		end
	end
	yyvs10.put (yyval10, yyvsp10)
end
when 11 then
--|#line 99 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 99")
end

yyval10 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs10.put (yyval10, yyvsp10)
end
when 12 then
--|#line 102 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 102")
end

create yyval10.make; yyval10.put_front (yyvs9.item (yyvsp9)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp10 >= yyvsc10 then
		if yyvs10 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs10")
			end
			create yyspecial_routines10
			yyvsc10 := yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.make (yyvsc10)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs10")
			end
			yyvsc10 := yyvsc10 + yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.resize (yyvs10, yyvsc10)
		end
	end
	yyvs10.put (yyval10, yyvsp10)
end
when 13 then
--|#line 103 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 103")
end

yyvs10.item (yyvsp10).put_front (yyvs9.item (yyvsp9)); yyval10 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp9 := yyvsp9 -1
	yyvsp1 := yyvsp1 -1
	yyvs10.put (yyval10, yyvsp10)
end
when 14 then
--|#line 106 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 106")
end

create {JS_VARIABLE_AS_ARG_NODE} yyval9.make (yyvs11.item (yyvsp11)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp9 := yyvsp9 + 1
	yyvsp11 := yyvsp11 -1
	if yyvsp9 >= yyvsc9 then
		if yyvs9 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs9")
			end
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs9")
			end
			yyvsc9 := yyvsc9 + yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
		end
	end
	yyvs9.put (yyval9, yyvsp9)
end
when 15 then
--|#line 107 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 107")
end

create {JS_FUNCTION_TERM_AS_ARG_NODE} yyval9.make (yyvs2.item (yyvsp2), yyvs10.item (yyvsp10)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp9 := yyvsp9 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp10 := yyvsp10 -1
	if yyvsp9 >= yyvsc9 then
		if yyvs9 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs9")
			end
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs9")
			end
			yyvsc9 := yyvsc9 + yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
		end
	end
	yyvs9.put (yyval9, yyvsp9)
end
when 16 then
--|#line 108 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 108")
end

create {JS_INTEGER_AS_ARG_NODE} yyval9.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp9 := yyvsp9 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp9 >= yyvsc9 then
		if yyvs9 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs9")
			end
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs9")
			end
			yyvsc9 := yyvsc9 + yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
		end
	end
	yyvs9.put (yyval9, yyvsp9)
end
when 17 then
--|#line 110 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 110")
end

create {JS_FLD_EQ_LIST_AS_ARG_NODE} yyval9.make (yyvs13.item (yyvsp13)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp9 := yyvsp9 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp13 := yyvsp13 -1
	if yyvsp9 >= yyvsc9 then
		if yyvs9 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs9")
			end
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs9")
			end
			yyvsc9 := yyvsc9 + yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
		end
	end
	yyvs9.put (yyval9, yyvsp9)
end
when 18 then
--|#line 113 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 113")
end

create yyval11.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp11 := yyvsp11 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp11 >= yyvsc11 then
		if yyvs11 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs11")
			end
			create yyspecial_routines11
			yyvsc11 := yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.make (yyvsc11)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs11")
			end
			yyvsc11 := yyvsc11 + yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.resize (yyvs11, yyvsc11)
		end
	end
	yyvs11.put (yyval11, yyvsp11)
end
when 19 then
--|#line 114 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 114")
end

create yyval11.make ("?" + yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp11 := yyvsp11 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp11 >= yyvsc11 then
		if yyvs11 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs11")
			end
			create yyspecial_routines11
			yyvsc11 := yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.make (yyvsc11)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs11")
			end
			yyvsc11 := yyvsc11 + yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.resize (yyvs11, yyvsc11)
		end
	end
	yyvs11.put (yyval11, yyvsp11)
end
when 20 then
--|#line 117 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 117")
end

create yyval13.make; yyval13.put_front (yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp13 := yyvsp13 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp13 >= yyvsc13 then
		if yyvs13 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs13")
			end
			create yyspecial_routines13
			yyvsc13 := yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.make (yyvsc13)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs13")
			end
			yyvsc13 := yyvsc13 + yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.resize (yyvs13, yyvsc13)
		end
	end
	yyvs13.put (yyval13, yyvsp13)
end
when 21 then
--|#line 118 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 118")
end

yyvs13.item (yyvsp13).put_front (yyvs12.item (yyvsp12)); yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -1
	yyvs13.put (yyval13, yyvsp13)
end
when 22 then
--|#line 121 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 121")
end

create yyval12.make (yyvs2.item (yyvsp2), yyvs9.item (yyvsp9)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvsp9 := yyvsp9 -1
	if yyvsp12 >= yyvsc12 then
		if yyvs12 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs12")
			end
			create yyspecial_routines12
			yyvsc12 := yyInitial_yyvs_size
			yyvs12 := yyspecial_routines12.make (yyvsc12)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs12")
			end
			yyvsc12 := yyvsc12 + yyInitial_yyvs_size
			yyvs12 := yyspecial_routines12.resize (yyvs12, yyvsc12)
		end
	end
	yyvs12.put (yyval12, yyvsp12)
end
when 23 then
--|#line 124 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 124")
end

create yyval14.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp14 := yyvsp14 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp14 >= yyvsc14 then
		if yyvs14 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs14")
			end
			create yyspecial_routines14
			yyvsc14 := yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.make (yyvsc14)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs14")
			end
			yyvsc14 := yyvsc14 + yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.resize (yyvs14, yyvsc14)
		end
	end
	yyvs14.put (yyval14, yyvsp14)
end
when 24 then
--|#line 127 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 127")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 25 then
--|#line 128 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 128")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 26 then
--|#line 131 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 131")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyvs1.put (yyval1, yyvsp1)
end
when 27 then
--|#line 132 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 132")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp14 := yyvsp14 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 28 then
--|#line 135 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 135")
end

create yyval16.make 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp16 := yyvsp16 + 1
	if yyvsp16 >= yyvsc16 then
		if yyvs16 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs16")
			end
			create yyspecial_routines16
			yyvsc16 := yyInitial_yyvs_size
			yyvs16 := yyspecial_routines16.make (yyvsc16)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs16")
			end
			yyvsc16 := yyvsc16 + yyInitial_yyvs_size
			yyvs16 := yyspecial_routines16.resize (yyvs16, yyvsc16)
		end
	end
	yyvs16.put (yyval16, yyvsp16)
end
when 29 then
--|#line 136 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 136")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
when 30 then
--|#line 139 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 139")
end

create yyval16.make; yyval16.put_front (yyvs15.item (yyvsp15)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp16 := yyvsp16 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp16 >= yyvsc16 then
		if yyvs16 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs16")
			end
			create yyspecial_routines16
			yyvsc16 := yyInitial_yyvs_size
			yyvs16 := yyspecial_routines16.make (yyvsc16)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs16")
			end
			yyvsc16 := yyvsc16 + yyInitial_yyvs_size
			yyvs16 := yyspecial_routines16.resize (yyvs16, yyvsc16)
		end
	end
	yyvs16.put (yyval16, yyvsp16)
end
when 31 then
--|#line 140 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 140")
end

yyvs16.item (yyvsp16).put_front (yyvs15.item (yyvsp15)); yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp15 := yyvsp15 -1
	yyvsp1 := yyvsp1 -1
	yyvs16.put (yyval16, yyvsp16)
end
when 32 then
--|#line 143 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 143")
end

create {JS_SPATIAL_MAPSTO_NODE} yyval15.make (yyvs9.item (yyvsp9 - 1), yyvs18.item (yyvsp18), yyvs9.item (yyvsp9)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp15 := yyvsp15 + 1
	yyvsp9 := yyvsp9 -2
	yyvsp1 := yyvsp1 -2
	yyvsp18 := yyvsp18 -1
	if yyvsp15 >= yyvsc15 then
		if yyvs15 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs15")
			end
			create yyspecial_routines15
			yyvsc15 := yyInitial_yyvs_size
			yyvs15 := yyspecial_routines15.make (yyvsc15)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs15")
			end
			yyvsc15 := yyvsc15 + yyInitial_yyvs_size
			yyvs15 := yyspecial_routines15.resize (yyvs15, yyvsc15)
		end
	end
	yyvs15.put (yyval15, yyvsp15)
end
when 33 then
--|#line 144 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 144")
end

create {JS_SPATIAL_PRED_NODE} yyval15.make (yyvs2.item (yyvsp2), yyvs10.item (yyvsp10)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp15 := yyvsp15 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp10 := yyvsp10 -1
	if yyvsp15 >= yyvsc15 then
		if yyvs15 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs15")
			end
			create yyspecial_routines15
			yyvsc15 := yyInitial_yyvs_size
			yyvs15 := yyspecial_routines15.make (yyvsc15)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs15")
			end
			yyvsc15 := yyvsc15 + yyInitial_yyvs_size
			yyvs15 := yyspecial_routines15.resize (yyvs15, yyvsc15)
		end
	end
	yyvs15.put (yyval15, yyvsp15)
end
when 34 then
--|#line 145 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 145")
end

create {JS_SPATIAL_COMBINE_NODE} yyval15.make (yyvs17.item (yyvsp17)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp15 := yyvsp15 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp17 := yyvsp17 -1
	if yyvsp15 >= yyvsc15 then
		if yyvs15 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs15")
			end
			create yyspecial_routines15
			yyvsc15 := yyInitial_yyvs_size
			yyvs15 := yyspecial_routines15.make (yyvsc15)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs15")
			end
			yyvsc15 := yyvsc15 + yyInitial_yyvs_size
			yyvs15 := yyspecial_routines15.resize (yyvs15, yyvsc15)
		end
	end
	yyvs15.put (yyval15, yyvsp15)
end
when 35 then
--|#line 148 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 148")
end

create {JS_COMBINE_OROR_NODE} yyval17.make (yyvs6.item (yyvsp6 - 1), yyvs6.item (yyvsp6)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp17 := yyvsp17 + 1
	yyvsp6 := yyvsp6 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp17 >= yyvsc17 then
		if yyvs17 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs17")
			end
			create yyspecial_routines17
			yyvsc17 := yyInitial_yyvs_size
			yyvs17 := yyspecial_routines17.make (yyvsc17)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs17")
			end
			yyvsc17 := yyvsc17 + yyInitial_yyvs_size
			yyvs17 := yyspecial_routines17.resize (yyvs17, yyvsc17)
		end
	end
	yyvs17.put (yyval17, yyvsp17)
end
when 36 then
--|#line 149 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 149")
end

create {JS_COMBINE_WAND_NODE} yyval17.make (yyvs6.item (yyvsp6 - 1), yyvs6.item (yyvsp6)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp17 := yyvsp17 + 1
	yyvsp6 := yyvsp6 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp17 >= yyvsc17 then
		if yyvs17 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs17")
			end
			create yyspecial_routines17
			yyvsc17 := yyInitial_yyvs_size
			yyvs17 := yyspecial_routines17.make (yyvsc17)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs17")
			end
			yyvsc17 := yyvsc17 + yyInitial_yyvs_size
			yyvs17 := yyspecial_routines17.resize (yyvs17, yyvsc17)
		end
	end
	yyvs17.put (yyval17, yyvsp17)
end
when 37 then
--|#line 152 "parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'parser.y' at line 152")
end

create yyval18.make (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp18 := yyvsp18 + 1
	yyvsp1 := yyvsp1 -4
	yyvsp2 := yyvsp2 -2
	yyvsp14 := yyvsp14 -1
	if yyvsp18 >= yyvsc18 then
		if yyvs18 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs18")
			end
			create yyspecial_routines18
			yyvsc18 := yyInitial_yyvs_size
			yyvs18 := yyspecial_routines18.make (yyvsc18)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs18")
			end
			yyvsc18 := yyvsc18 + yyInitial_yyvs_size
			yyvs18 := yyspecial_routines18.resize (yyvs18, yyvsc18)
		end
	end
	yyvs18.put (yyval18, yyvsp18)
end
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_error_action (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			when 76 then
					-- End-of-file expected action.
				report_eof_expected_error
			else
					-- Default action.
				report_error ("parse error")
			end
		end

feature {NONE} -- Table templates

	yytranslate_template: SPECIAL [INTEGER] is
			-- Template for `yytranslate'
		once
			Result := yyfixed_array (<<
			    0,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    1,    2,    3,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER] is
			-- Template for `yyr1'
		once
			Result := yyfixed_array (<<
			    0,   26,   27,   27,   28,   28,   29,   29,   29,   29,
			   30,   30,   31,   31,   32,   32,   32,   32,   33,   33,
			   34,   34,   35,   36,   42,   42,   43,   43,   37,   37,
			   38,   38,   39,   39,   39,   40,   40,   41, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER] is
			-- Template for `yytypes1'
		once
			Result := yyfixed_array (<<
			    6,    1,    1,    2,    2,    8,    8,    7,    9,   11,
			    2,    2,   13,   12,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    2,   10,   10,    9,    1,    2,    9,
			   16,   16,   15,    8,    9,    2,   14,    9,    9,   13,
			    1,    1,    1,    6,   17,    1,    1,    1,    1,    1,
			   10,   10,    1,    1,    1,   10,    1,   18,   16,   14,
			    1,    1,    6,    6,    1,    2,    1,    1,    1,    1,
			    9,    1,    2,    1,   14,    1,    6,    1,    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER] is
			-- Template for `yytypes2'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    2,    2,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER] is
			-- Template for `yydefact'
		once
			Result := yyfixed_array (<<
			    2,    0,    0,   16,   18,    0,    3,    4,    0,   14,
			   19,    0,    0,   20,   10,   28,    0,    0,    0,    0,
			    0,   17,    0,   18,    0,   11,   12,    2,   18,    0,
			    1,   29,   30,    5,    7,   24,    9,    8,   22,   21,
			   10,   15,    0,    0,    0,   10,    0,    0,    0,   23,
			    0,   13,    2,    2,   34,    0,    0,    0,   31,   26,
			    0,   15,   36,   35,   33,    0,    0,    0,   25,    0,
			   32,   27,    0,    0,    0,   37,    0,    0,    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER] is
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			   43,    5,    6,    7,   24,   25,    8,    9,   12,   13,
			   59,   30,   31,   32,   44,   57,   49,   60, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER] is
			-- Template for `yypact'
		once
			Result := yyfixed_array (<<
			   11,   57,   49, -32768,   50,   48, -32768,   47,   33, -32768,
			 -32768,   52,   46,   38,    5,    0,   11,    5,   18,    5,
			    5, -32768,   49,   44,   35, -32768,   45,   11,   42,   40,
			 -32768, -32768,   30, -32768, -32768,   37, -32768, -32768, -32768, -32768,
			    5,    9,    5,  -17,   27,    5,   43,    0,   18, -32768,
			   26, -32768,   11,   11, -32768,   21,   34,   24, -32768,   36,
			   19, -32768, -32768, -32768,   28,   25,    5,   18, -32768,   23,
			 -32768, -32768,   22,   18,   17, -32768,    6,    3, -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER] is
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			    1, -32768,   53, -32768,  -26,   32,  -10, -32768,   51, -32768,
			  -18, -32768,   29, -32768, -32768, -32768, -32768,   -4, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER] is
			-- Template for `yytable'
		once
			Result := yyfixed_array (<<
			   36,   76,   53,   78,   26,   29,   77,   34,   52,   37,
			   38,   28,    3,    2,   50,   27,   23,    3,    2,   55,
			    1,   75,    4,    3,    2,    1,   -6,   -6,   73,   35,
			   26,    1,   26,   69,   72,   26,  -15,   29,   19,   18,
			   66,   68,   17,   67,   64,   65,   56,   47,   46,   61,
			   54,   48,   42,   62,   63,   74,   70,   45,   41,   40,
			   11,   20,   22,   71,   16,   14,   15,   21,   10,   33,
			    0,    0,    0,   39,   51,    0,   58, yyDummy>>)
		end

	yycheck_template: SPECIAL [INTEGER] is
			-- Template for `yycheck'
		once
			Result := yyfixed_array (<<
			   18,    0,   19,    0,   14,   15,    0,   17,   25,   19,
			   20,   11,   12,   13,   40,   15,   11,   12,   13,   45,
			   20,    4,   11,   12,   13,   20,   17,   18,    6,   11,
			   40,   20,   42,    8,   11,   45,    8,   47,    5,    6,
			   16,   22,    9,    7,   23,   11,    3,   17,    8,   23,
			   23,   14,    7,   52,   53,   73,   66,   15,   23,   15,
			   11,    9,   24,   67,   17,   15,   18,   21,   11,   16,
			   -1,   -1,   -1,   22,   42,   -1,   47, yyDummy>>)
		end

feature {NONE} -- Semantic value stacks

	yyvs1: SPECIAL [ANY]
			-- Stack for semantic values of type ANY

	yyvsc1: INTEGER
			-- Capacity of semantic value stack `yyvs1'

	yyvsp1: INTEGER
			-- Top of semantic value stack `yyvs1'

	yyspecial_routines1: KL_SPECIAL_ROUTINES [ANY]
			-- Routines that ought to be in SPECIAL [ANY]

	yyvs2: SPECIAL [STRING]
			-- Stack for semantic values of type STRING

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [STRING]
			-- Routines that ought to be in SPECIAL [STRING]

	yyvs3: SPECIAL [JS_PRED_DEF_NODE]
			-- Stack for semantic values of type JS_PRED_DEF_NODE

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [JS_PRED_DEF_NODE]
			-- Routines that ought to be in SPECIAL [JS_PRED_DEF_NODE]

	yyvs4: SPECIAL [JS_PARAM_NODE]
			-- Stack for semantic values of type JS_PARAM_NODE

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: KL_SPECIAL_ROUTINES [JS_PARAM_NODE]
			-- Routines that ought to be in SPECIAL [JS_PARAM_NODE]

	yyvs5: SPECIAL [LINKED_LIST [JS_PARAM_NODE]]
			-- Stack for semantic values of type LINKED_LIST [JS_PARAM_NODE]

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [LINKED_LIST [JS_PARAM_NODE]]
			-- Routines that ought to be in SPECIAL [LINKED_LIST [JS_PARAM_NODE]]

	yyvs6: SPECIAL [JS_ASSERTION_NODE]
			-- Stack for semantic values of type JS_ASSERTION_NODE

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [JS_ASSERTION_NODE]
			-- Routines that ought to be in SPECIAL [JS_ASSERTION_NODE]

	yyvs7: SPECIAL [JS_PURE_NODE]
			-- Stack for semantic values of type JS_PURE_NODE

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [JS_PURE_NODE]
			-- Routines that ought to be in SPECIAL [JS_PURE_NODE]

	yyvs8: SPECIAL [LINKED_LIST [JS_PURE_NODE]]
			-- Stack for semantic values of type LINKED_LIST [JS_PURE_NODE]

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [LINKED_LIST [JS_PURE_NODE]]
			-- Routines that ought to be in SPECIAL [LINKED_LIST [JS_PURE_NODE]]

	yyvs9: SPECIAL [JS_ARGUMENT_NODE]
			-- Stack for semantic values of type JS_ARGUMENT_NODE

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: KL_SPECIAL_ROUTINES [JS_ARGUMENT_NODE]
			-- Routines that ought to be in SPECIAL [JS_ARGUMENT_NODE]

	yyvs10: SPECIAL [LINKED_LIST [JS_ARGUMENT_NODE]]
			-- Stack for semantic values of type LINKED_LIST [JS_ARGUMENT_NODE]

	yyvsc10: INTEGER
			-- Capacity of semantic value stack `yyvs10'

	yyvsp10: INTEGER
			-- Top of semantic value stack `yyvs10'

	yyspecial_routines10: KL_SPECIAL_ROUTINES [LINKED_LIST [JS_ARGUMENT_NODE]]
			-- Routines that ought to be in SPECIAL [LINKED_LIST [JS_ARGUMENT_NODE]]

	yyvs11: SPECIAL [JS_VARIABLE_NODE]
			-- Stack for semantic values of type JS_VARIABLE_NODE

	yyvsc11: INTEGER
			-- Capacity of semantic value stack `yyvs11'

	yyvsp11: INTEGER
			-- Top of semantic value stack `yyvs11'

	yyspecial_routines11: KL_SPECIAL_ROUTINES [JS_VARIABLE_NODE]
			-- Routines that ought to be in SPECIAL [JS_VARIABLE_NODE]

	yyvs12: SPECIAL [JS_FLD_EQUALITY_NODE]
			-- Stack for semantic values of type JS_FLD_EQUALITY_NODE

	yyvsc12: INTEGER
			-- Capacity of semantic value stack `yyvs12'

	yyvsp12: INTEGER
			-- Top of semantic value stack `yyvs12'

	yyspecial_routines12: KL_SPECIAL_ROUTINES [JS_FLD_EQUALITY_NODE]
			-- Routines that ought to be in SPECIAL [JS_FLD_EQUALITY_NODE]

	yyvs13: SPECIAL [LINKED_LIST [JS_FLD_EQUALITY_NODE]]
			-- Stack for semantic values of type LINKED_LIST [JS_FLD_EQUALITY_NODE]

	yyvsc13: INTEGER
			-- Capacity of semantic value stack `yyvs13'

	yyvsp13: INTEGER
			-- Top of semantic value stack `yyvs13'

	yyspecial_routines13: KL_SPECIAL_ROUTINES [LINKED_LIST [JS_FLD_EQUALITY_NODE]]
			-- Routines that ought to be in SPECIAL [LINKED_LIST [JS_FLD_EQUALITY_NODE]]

	yyvs14: SPECIAL [JS_TYPE_NODE]
			-- Stack for semantic values of type JS_TYPE_NODE

	yyvsc14: INTEGER
			-- Capacity of semantic value stack `yyvs14'

	yyvsp14: INTEGER
			-- Top of semantic value stack `yyvs14'

	yyspecial_routines14: KL_SPECIAL_ROUTINES [JS_TYPE_NODE]
			-- Routines that ought to be in SPECIAL [JS_TYPE_NODE]

	yyvs15: SPECIAL [JS_SPATIAL_NODE]
			-- Stack for semantic values of type JS_SPATIAL_NODE

	yyvsc15: INTEGER
			-- Capacity of semantic value stack `yyvs15'

	yyvsp15: INTEGER
			-- Top of semantic value stack `yyvs15'

	yyspecial_routines15: KL_SPECIAL_ROUTINES [JS_SPATIAL_NODE]
			-- Routines that ought to be in SPECIAL [JS_SPATIAL_NODE]

	yyvs16: SPECIAL [LINKED_LIST [JS_SPATIAL_NODE]]
			-- Stack for semantic values of type LINKED_LIST [JS_SPATIAL_NODE]

	yyvsc16: INTEGER
			-- Capacity of semantic value stack `yyvs16'

	yyvsp16: INTEGER
			-- Top of semantic value stack `yyvs16'

	yyspecial_routines16: KL_SPECIAL_ROUTINES [LINKED_LIST [JS_SPATIAL_NODE]]
			-- Routines that ought to be in SPECIAL [LINKED_LIST [JS_SPATIAL_NODE]]

	yyvs17: SPECIAL [JS_COMBINE_NODE]
			-- Stack for semantic values of type JS_COMBINE_NODE

	yyvsc17: INTEGER
			-- Capacity of semantic value stack `yyvs17'

	yyvsp17: INTEGER
			-- Top of semantic value stack `yyvs17'

	yyspecial_routines17: KL_SPECIAL_ROUTINES [JS_COMBINE_NODE]
			-- Routines that ought to be in SPECIAL [JS_COMBINE_NODE]

	yyvs18: SPECIAL [JS_FIELD_SIG_NODE]
			-- Stack for semantic values of type JS_FIELD_SIG_NODE

	yyvsc18: INTEGER
			-- Capacity of semantic value stack `yyvs18'

	yyvsp18: INTEGER
			-- Top of semantic value stack `yyvs18'

	yyspecial_routines18: KL_SPECIAL_ROUTINES [JS_FIELD_SIG_NODE]
			-- Routines that ought to be in SPECIAL [JS_FIELD_SIG_NODE]

feature {NONE} -- Constants

	yyFinal: INTEGER is 78
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 26
			-- Number of tokens

	yyLast: INTEGER is 76
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 280
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 44
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features


-- User code

    make
        do
            make_scanner
            make_parser_skeleton
        end
    
        -- Only one of the following two attributes will be valid!!!
    assertion: JS_ASSERTION_NODE
    predicate_definition: JS_PRED_DEF_NODE
    
end