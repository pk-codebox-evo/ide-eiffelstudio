-- Byte code for conditional instruction

class IF_B 

inherit

	INSTR_B
		redefine
			analyze, generate, enlarge_tree,
			find_assign_result, last_all_in_result, make_byte_code
		end;
	VOID_REGISTER
		export
			{NONE} all
		end;
	
feature 

	condition: EXPR_B;
			-- Conditional expression

	compound: BYTE_LIST [BYTE_NODE];
			-- Main compound {list of INSTR_B}

	elsif_list: BYTE_LIST [BYTE_NODE];
			-- Alternatives {list of ELSIF_B}

	else_part: BYTE_LIST [BYTE_NODE];
			-- Default compound {list of INSTR_B}

	set_condition (c: like condition) is
			-- Assign `c' to `condition'.
		do
			condition := c;
		end;

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c;
		end;

	set_elsif_list (e: like elsif_list) is
			-- Assign `e' to `elsif_list'.
		do
			elsif_list := e;
		end;

	set_else_part (e: like elsif_list) is
			-- Assign `e' to `elsif_list'.
		do
			else_part := e;
		end;

	enlarge_tree is
			-- Enlarge the if construct
		do
			condition := condition.enlarged;
			if compound /= Void then
				compound.enlarge_tree;
			end;
			if elsif_list /= Void then
				elsif_list.enlarge_tree;
			end;
			if else_part /= Void then
				else_part.enlarge_tree;
			end;
		end;

	find_assign_result is
			-- Find all terminal assignments made to Result
		do
			if compound /= Void then
				compound.finish;
				compound.item.find_assign_result;
			end;
			if elsif_list /= Void then
				elsif_list.finish;
				elsif_list.item.find_assign_result;
			end;
			if else_part /= Void then
				else_part.finish;
				else_part.item.find_assign_result;
			end;
		end;

	last_all_in_result: BOOLEAN is
			-- Are all the exit points in the function assignments
			-- in a Result entity ?
		do
			if compound /= Void then
				compound.finish;
				Result := compound.item.last_all_in_result;
			end;
			if elsif_list /= Void and Result then
				from
					elsif_list.start;
				until
					elsif_list.offright or not Result
				loop
					Result := Result and elsif_list.item.last_all_in_result;
					elsif_list.forth;
				end;
			end;
			if else_part /= Void and Result then
				else_part.finish;
				Result := Result and else_part.item.last_all_in_result;
			else
					-- No else part, so we may continue.
					-- As this is the LAST compound statement, this
					-- means we are followed by an implicit return Result.
				Result := false;
			end;
			Result := Result and not context.has_postcondition;
		end;

	analyze is
			-- Builds a proper context (for C code).
		do
			context.init_propagation;
			condition.propagate (No_register);
			condition.analyze;
			condition.free_register;
			if compound /= Void then
				compound.analyze;
			end;
			if elsif_list /= Void then
				elsif_list.analyze;
			end;
			if else_part /= Void then
				else_part.analyze;
			end;
		end;

	generate is
			-- Generate C code in `generated_file'.
		do
				-- Outstanding of if..then..else..end
			generated_file.new_line;
			condition.generate;
			generated_file.putstring ("if (");
			condition.print_register;
			generated_file.putstring (") {");
			generated_file.new_line;
			if compound /= Void then
				generated_file.indent;
				compound.generate;
				generated_file.exdent;
			end;
			generated_file.putchar ('}');
			if elsif_list /= Void then
				elsif_list.generate;
			end;
			if else_part /= Void then
				generated_file.putstring (" else {");
				generated_file.new_line;
				generated_file.indent;
				else_part.generate;
				generated_file.exdent;
				generated_file.putchar ('}');
			end;
			generate_closing_brakets;
			generated_file.new_line;
				-- Leave one blank line after the construct
			generated_file.new_line;
		end;

	generate_closing_brakets is
			-- Generate one closing braket for each generated elsif
		local
			i: INTEGER;
		do
			if elsif_list /= Void then
				from
					i := elsif_list.count;
				until
					i = 0
				loop
					generated_file.putchar ('}');
					i := i - 1;
				end;
			end;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generates byte code for a conditional instruction.
		local
			elsif_clause: ELSIF_B;
			cmp: like COMPOUND;
			i, nb_jumps: INTEGER;
		do
				-- Generated byte code for condition
			condition.make_byte_code (ba);
				-- Generated a test
			ba.append (Bc_jmp_f);
				-- Deferred writing of the jump value
			ba.mark_forward;

			if compound /= Void then
					-- Generated byte code for first compound (if any).
				compound.make_byte_code (ba);
				ba.append (Bc_jmp);
				ba.mark_forward2;
				nb_jumps := nb_jumps + 1;
			end;
	
				-- Writes the relative jump value.
			ba.write_forward;

			if elsif_list /= Void then
					-- Generates byte code for alternatives
				from
					elsif_list.start
				until
					elsif_list.offright
				loop
					elsif_clause ?= elsif_list.item;
					
						-- Generate byte code for expression
					elsif_clause.expr.make_byte_code (ba);

						-- Test if false
					ba.append (Bc_jmp_f);
					ba.mark_forward;

					cmp:= elsif_clause.compound;
					if cmp /= Void then
							-- Generate alternative compound byte code
						cmp.make_byte_code (ba);
						ba.append (Bc_jmp);
						ba.mark_forward2;
						nb_jumps := nb_jumps + 1;
		            end;

					ba.write_forward;
				
					elsif_list.forth;
				end;
			end;
						
			if else_part /= Void then
					-- Generates byte code for default compound.
				else_part.make_byte_code (ba);
			end;

			from
					-- Generate jump values for unconditional jumps
					-- after the `nb_jumps' compounds encountered in the
					-- entire instruction.
				i := 1
			until
				i > nb_jumps
			loop
				ba.write_forward2;
				i := i + 1
			end;
		end;

end
