class INLINED_RESULT_B

inherit
	RESULT_B
		redefine
			enlarged, propagate, analyze, generate,
			free_register, print_register, type,
			Current_register, is_result
		end

feature

	enlarged: INLINED_RESULT_B is
		do
			Result := Current
		end

	is_result: BOOLEAN is
		do
		end

feature -- Register and code generation

	Current_register: INLINED_CURRENT_B is
		once
			!!Result
		end

	propagate (r: REGISTRABLE) is
			-- Do nothing
		do
		end;

	analyze is
			-- Do nothing
		do
		end;

	generate is
			-- Do nothing
		do
		end;

	free_register is
			-- Do nothing
		do
		end;

	print_register is
		do
			System.inliner.inlined_feature.result_reg.print_register
		end;

feature

	type: TYPE_I is
		do
			Result := System.inliner.inlined_feature.type
		end

end
