-- Enlarged node for external feature call in workbench mode

class EXTERNAL_BW 

inherit

	EXTERNAL_BL
		redefine
			check_dt_current, generate_access_on_type,
			need_invariant, set_need_invariant
		end

creation

	make
	
feature

	need_invariant: BOOLEAN;
			-- Does the call need an invariant check ?

	set_need_invariant (b: BOOLEAN) is
			-- Assign `b' to `need_invariant'.
		do
			need_invariant := b
		end;

	make is
		do
			need_invariant := True;
		end;

	check_dt_current (reg: REGISTRABLE) is
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			class_type: CL_TYPE_I;
			type_i: TYPE_I;
			cond: BOOLEAN;
			access: ACCESS_B;
			void_register: REGISTER;
		do
			type_i := context_type;
			class_type ?= type_i;
			cond := not (type_i.is_basic or else class_type = Void);
			if reg.is_current and cond then
				context.add_dt_current;
			end;
			if not reg.is_predefined and cond then
					-- BEWARE!! The function call is polymorphic hence we'll
					-- need to evaluate `reg' twice: once to get its dynamic
					-- type and once as a parameter for Current. Hence we
					-- must make sure it is not held in a No_register--RAM.
			 	access ?= reg;	  -- Cannot fail
				if access.register = No_register then
					access.set_register (void_register);
					access.get_register;
				end;
			end;
		end;

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate external call in a `typ' context
		local
			is_nested: BOOLEAN;
		do
			is_nested := not is_first;

			generated_file.putchar ('(');
			real_type (type).c_type.generate_function_cast (generated_file);
			if is_nested and need_invariant then
				generated_file.putstring ("RTVF(");
			else
				generated_file.putstring ("RTWF(");
			end;
			generated_file.putint (typ.associated_class_type.id - 1);
			generated_file.putstring (gc_comma);
			generated_file.putint (real_feature_id);
			generated_file.putstring (gc_comma);
			if not is_nested then
				if context.dt_current > 1 then
					generated_file.putstring (gc_dtype);
				else
					generated_file.putstring (gc_upper_dtype_lparan);
					context.Current_register.print_register_by_name;
					generated_file.putchar (')');
				end;
			elseif need_invariant then
				generated_file.putchar ('"');
				generated_file.putstring (feature_name);
				generated_file.putstring ("%", ");
				reg.print_register;
			else
				generated_file.putstring (gc_upper_dtype_lparan);
				reg.print_register;
				generated_file.putchar (')');
			end;
			generated_file.putstring ("))");
		end;

end
