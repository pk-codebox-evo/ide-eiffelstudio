-- Enlarged Creation

class CREATION_BL 

inherit

	CREATION_B
		redefine
			analyze, generate,
			last_all_in_result, find_assign_result,
			mark_last_instruction
		end;
	VOID_REGISTER
		redefine
			register, print_register,
			get_register
		end;
	
feature

	last_in_result: BOOLEAN;
			-- Is this the last creation in Result ?

	last_instruction: BOOLEAN;
			-- Is this instruction the last instruction ?

	last_all_in_result: BOOLEAN is
			-- Are all the function exit points an assignment to Result ?
		do
			Result := last_in_result;
		end;

	find_assign_result is
			-- Check whether this is an assignment to Result
		do
			last_in_result := target.is_result and
				not context.byte_code.is_once and
				not context.has_postcondition;
		ensure then
			last_in_result = target.is_result and
				not context.byte_code.is_once and
				not context.has_postcondition;
		end;

	mark_last_instruction is
			-- Signals this assignment is an exit point for the routine
		do
			last_instruction := not context.has_postcondition;
		end;

	register: REGISTRABLE;
			-- Where result is stored

	print_register is
			-- Print register
		do
			register.print_register;
		end;

	ref_type: REFERENCE_I is
			-- Dummy type for register creation
		once
			!!Result;
		end;

	get_register is
			-- Get a register
		local
			tmp_register: REGISTER;
		do
			!!tmp_register.make (ref_type);
			register := tmp_register;
		end;
		
	analyze is
			-- Analyze creation node
		local
			access_reg: ACCESS_REG_B;
		do
			target.set_register (No_register);
			target.analyze;
			target.free_register;
			info.analyze;
				-- A Result.Create often implies Result is used
			if target.is_result and not last_in_result then
				context.mark_result_used;
			end;
			if not target.is_predefined or
				(call /= Void and then call.message.used (target))
			then
				get_register;
			else
				register := target;
			end;
			if call /= Void then
				!!access_reg;
				access_reg.set_register (register);
				access_reg.set_type (target.type);
				call.set_target (access_reg);
				call.set_need_invariant (False);
				call.analyze;
				call.free_register;
			else
				free_register;
			end;
			if target.is_result and (not last_in_result or call /= Void) then
				context.mark_result_used;
			end;
		end;

	generate is
			-- Genrate the creation
		do
			if target.is_result and last_in_result then
					-- This is the generation of a last !!Result with a
					-- possible creation routine attached to it.
					-- NB: there is no need to call `generate_assignment' as
					-- the assignment is implicitely done by the "return".
				if call /= Void then
					generate_register_assignment;
					generate_creation;
					call.generate;
				end;
				context.byte_code.finish_compound;
				check
					compound_not_void: context.byte_code.compound /= Void
				end;
					-- Always separate a last return from body, if there is
					-- more than one instruction anyway and there is no creation
					-- routine called
				if last_instruction and
					(context.byte_code.compound.first /= Current
					or call /= Void)
				then
					generated_file.new_line;
				end;
				generated_file.putstring ("return ");
				if call /= Void then
					print_register;
					generated_file.putchar (';');
					generated_file.new_line;
				else
					generate_creation;
				end;
			else
				generate_register_assignment;
				generate_creation;
				if call /= Void then
					call.generate_creation_call;
				end;
					-- We had to get a regiser because RTAR evaluates its
					-- arguments more than once.
				if not target.is_predefined then
						-- Target is an attribute then
					generated_file.putstring ("RTAR(");
					print_register;
					generated_file.putstring (", ");
					context.Current_register.print_register_by_name;
					generated_file.putchar (')');
					generated_file.putchar (';');
					generated_file.new_line;
				end;
				generate_assignment;
			end;
		end;

	generate_register_assignment is
			-- Generate the register assignment left side
		do
			print_register;
			generated_file.putstring (" = ");
		end;

	generate_creation is
			-- Generate the creation in register
		do
			generated_file.putstring ("RTLN(");
			info.generate;
			generated_file.putstring (");");
			generated_file.new_line;
		end;

	generate_assignment is
			-- Generate the assignment in the target, in case we had to get
			-- a temporary register.
		do
			if register /= target then
				target.print_register;
				generated_file.putstring (" = ");
				print_register;
				generated_file.putchar (';');
				generated_file.new_line;
			end;
		end;

end
