class BIN_POWER_B 

inherit
	NUM_BINARY_B
		rename
			Bc_power as operator_constant,
			il_power as il_operator_constant
		redefine
			print_register,
			generate_standard_il
		end

	SHARED_INCLUDE
		export
			{NONE} all
		end
		
	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature -- IL code generation

	generate_standard_il is
			-- Generate standard IL code for binary expression.
		do
			left.generate_il
			il_generator.convert_to_double
			right.generate_il
			il_generator.convert_to_double
			il_generator.generate_binary_operator (il_operator_constant)
		end

feature -- C code generation

	print_register is
			-- Print expression value
		local
			buf			: GENERATION_BUFFER
			power_nb	: INTEGER_CONSTANT
			power_value	: INTEGER
			done		: BOOLEAN
		do
			buf := buffer
			power_nb ?= right
			if power_nb /= Void then
				power_value := power_nb.value
				inspect
					power_value
				when 0 then
					done := True
					buf.putstring ("(EIF_DOUBLE) 1")
				when 1 then
					done := True
					buf.putstring ("(EIF_DOUBLE) (")
					left.print_register
					buf.putchar (')')
				when 2,3 then 
					done := True
					buf.putstring ("(EIF_DOUBLE) ((EIF_DOUBLE)")
					left.print_register
					buf.putstring (" * (EIF_DOUBLE) ")
					left.print_register
					if power_value = 3 then
						buf.putstring (" * (EIF_DOUBLE) ")
						left.print_register
					end
					buf.putchar (')')
				else
				end
			end

			if not done then
					-- No optimization could have been done, so we generate the
					-- call to `pow'.
				shared_include_queue.put (Names_heap.math_header_name_id)
				buf.putstring ("(EIF_DOUBLE) pow ((EIF_DOUBLE)");
				left.print_register;
				buf.putstring (",(EIF_DOUBLE)");
				right.print_register;
				buf.putchar (')');
			end
		end;

end
