-- Enlarged byte code for "or else"

class
	B_OR_ELSE_BL 

inherit
	B_OR_ELSE_B
		redefine
			propagate, free_register, print_register, generate, analyze,
			register, set_register, c_type
		end;

feature 

	register: REGISTRABLE;
			-- Where result of expression should be stored

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r'
		do
			register := r;
		end;

	c_type: BOOLEAN_I is
			-- Type is boolean
		once
			create Result;
		end;

	free_register is
			-- Free register used by expression
		do
			if has_call then
				register.free_register
			else
				Precursor {B_OR_ELSE_B};
			end;
		end;

	print_register is
			-- Print value of the expression
		do
			if has_call then
				register.print_register;
			else
				Precursor {B_OR_ELSE_B};
			end;
		end;

	propagate (r: REGISTRABLE) is
			-- Propagate register `r' throughout the expression
		do
			if has_call then
				if
					not context.propagated
					and (register = Void)
					and r /= No_register
					and then not used (r)
				then
					register := r;
					context.set_propagated;
				end;
			else
				Precursor {B_OR_ELSE_B} (r);
			end;
		end;

	analyze is
			-- Analyze expression
		do
			if has_call then
				get_register;
				context.init_propagation;
				left.propagate (No_register);
				context.init_propagation;
				right.propagate (No_register);
				left.analyze;
				left.free_register;
				right.analyze;
				right.free_register;
			else
				Precursor {B_OR_ELSE_B};
			end;
		end;

	generate is
			-- Generate expression
		local
			buf: GENERATION_BUFFER
		do
			if has_call then
					-- Initialize value to true
				register.print_register;
				buf := buffer
				buf.put_string (" = '\01';");
				buf.put_new_line;
					-- Test first value. If it is true, then the whole
					-- expression is true and the right handside is not evaled.
				left.generate;
				buf.put_string ("if (!");
					-- If the register for left is void. then we need to
					-- enclose in parenthesis.
				if (left.register = Void or left.register = No_register) and
					not left.is_simple_expr
				then
					buf.put_character ('(');
					left.print_register;
					buf.put_character (')');
				else
					left.print_register;
				end;
				buf.put_string (") {");
				buf.put_new_line;
					-- Left handside was false. Value of the expression is the
					-- value of the right handside.
				buf.indent;
				right.generate;
				register.print_register;
				buf.put_string (" = ");
				right.print_register;
				buf.put_character (';');
				buf.put_new_line;
				buf.exdent;
				buf.put_character ('}');
				buf.put_new_line;
			else
				Precursor {B_OR_ELSE_B};
			end;
		end;

end
