-- Eiffel class generated by the 2.3 to 3 translator.

class CONSTANT_I 

inherit

	FEATURE_I
		rename
			transfer_to as basic_transfer_to,
			check_types as old_check_types,
			access as feature_access,
			equiv as basic_equiv
		redefine
			melt, generate, is_once, in_pass3, redefinable, is_constant,
			set_type, type, can_be_inlined
		end;
	FEATURE_I
		redefine
			transfer_to, check_types, access, equiv,
			melt, generate, is_once, in_pass3, redefinable, is_constant,
			set_type, type, can_be_inlined
		select
			transfer_to, check_types, access, equiv
		end;
	SHARED_TYPE_I;
	BYTE_CONST;
	
feature 

	type: TYPE;
			-- Type of the constant

	value: VALUE_I;
			-- Constant value

	set_type (t: TYPE) is
			-- Assign `t' to `type'.
		do
			type := t
		end;

	set_value (v: VALUE_I) is
			-- Assign `v' to `value'.
		require
			good_argument: v /= Void
		do
			value := v;
		end;

	is_constant: BOOLEAN is True;
			-- Is the current feature a constant one ?

	redefinable: BOOLEAN is False;
			-- Is a constant redefinable ?

	in_pass3: BOOLEAN is
			-- Does a constant support the type check ?
		do
			-- Do nothing
		end;

	check_types (feat_tbl: FEATURE_TABLE) is
			-- Check Result and argument types 
		local
			actual_type: TYPE_A;	
			good_constant_type: BOOLEAN;
			vqmc: VQMC;
		do
			old_check_types (feat_tbl);
			actual_type := type.actual_type;
			if not value.valid_type (actual_type) then
				vqmc := value.vqmc;
				vqmc.set_class (written_class);
				vqmc.set_feature_name (feature_name);
				Error_handler.insert_error (vqmc);
			end;
		end;
		
feature -- Incrementality

	equiv (other: FEATURE_I): BOOLEAN is
			-- Is `other' equivalent to Current ?
		local
			other_constant: CONSTANT_I;
		do
			other_constant ?= other;
			if other_constant /= Void then
				Result :=   basic_equiv (other_constant)
							and then
							value.equiv (other_constant.value);
			end;
		end;
	
feature -- C code generation

	generate (class_type: CLASS_TYPE; file: INDENT_FILE) is
			-- Generate feature written in `class_type' in `file'.
		local
			type_i: TYPE_I;
			cl_type_i: CL_TYPE_I;
			internal_name: STRING;
		do
			if 	class_type.associated_class = written_class
				and then
				(	byte_context.workbench_mode
					or else
						-- Polymorphic function redefined as a constant
						-- or a constant string implies the generation
						-- of a C function.

-- FIXME: Constants are generated if they are used in the system
-- even if they are not called polymorphically.

-- This is done to generate the correct code for:
-- class CONST feature c: INTEGER is 1 end;
-- class P feature f: INTEGER is deferred end; end
-- class D inherit P; CONST rename c as f end; end;
-- class TEST p: P; make !D!p; p.f; end;

-- c must be generated even if it is an origin !!!

--					(	(is_once or else not is_origin)
--						and then
					(	System.is_used (Current)))
			then
				generate_header (file);
				type_i := type.actual_type.type_i;
				internal_name := Encoder.feature_name (class_type.id, body_id); 
					-- Generation of function's header
				type_i.c_type.generate (file);
				file.putstring (internal_name);
				file.putstring ("(Current)");
				file.new_line;
				file.putstring ("char *Current;");
				file.new_line;
					-- Function's body
				file.putchar ('{');
				file.new_line;
				file.indent;
					-- If constant is a string, it is the semantic of a once
				if is_once then
					file.putstring ("static int done = 0;");
					file.putstring ("static char *Result;");
					file.new_line;
					file.putstring ("if (done)");
					file.indent;
					file.putstring ("return Result;");
					file.exdent;
					file.new_line;
					file.putstring ("done = 1;");
					file.new_line;
					file.putstring ("Result = ");
-- FIXME double /real
					value.generate (file);
					file.putchar (';');
					file.new_line;
					file.putstring ("RTOC;");
					file.new_line;
					if byte_context.workbench_mode then
							-- Real body id to be stored in the id list of 
							-- already called once routines.
						file.putstring ("RTWO(");
						file.putint (real_body_id - 1);
						file.putstring (");");
						file.new_line
					end;
					file.putstring ("return Result;");
				else
					file.putstring ("return ");
-- FIXME double /real
					value.generate (file);
					file.putchar (';');
				end;
				file.new_line;
				file.exdent;
				file.putchar ('}');
				file.new_line;
				file.new_line;

			end;
		end;

	access (access_type: TYPE_I): ACCESS_B is
			-- Byte code access for constant
		local
			constant_b: CONSTANT_B;
		do
			if is_once then
					-- Cannot hardwire string constants, ever.
				Result := feature_access (access_type);
			else
					-- Constants are hardwired in final mode
				!!constant_b;
				constant_b.set_access (feature_access (access_type));
				constant_b.set_value (value);
				Result := constant_b;
			end;
		end;

feature -- Byte code generation

	melt (dispatch: DISPATCH_UNIT; exec: EXECUTION_UNIT) is
			-- Generate byte code for constant.
			-- [Remember there is no byte code tree for constant].
		local
			melted_feature: MELT_FEATURE;
			ba: BYTE_ARRAY;
			result_type: TYPE_I;
			static_type: INTEGER;
		do
			ba := Byte_array;
			ba.clear;
	
				-- Start	
			ba.append (Bc_start);
				-- Routine id
			ba.append_integer (rout_id_set.first);
				-- Meta-type of Result
			result_type := byte_context.real_type (type.actual_type.type_i);
			ba.append_integer (result_type.sk_value);
				-- Argument count
			ba.append_short_integer (0);
				-- Once mark
			if is_once then
				ba.append ('%/001/');
					-- Once not done
				ba.append ('%U');
					-- Real body id to be stored in the id list of 
					-- already called once routines.
				ba.append_integer (real_body_id - 1);
				ba.allocate_space (Reference_c_type);
			else
				ba.append ('%U');
			end;
				-- Local count
			ba.append_short_integer (0);
				-- No argument clone
			ba.append (Bc_no_clone_arg);
				-- Feature name
			ba.append_raw_string (feature_name);
				-- Type where the feature is written in
			static_type := byte_context.current_type.type_id - 1;
			ba.append_short_integer (static_type);
				-- No rescue
			ba.append ('%U');

				-- Access to attribute; Result := <attribute access>
			value.make_byte_code (ba);
			ba.append (Bc_rassign);
				
				-- End mark
			ba.append (Bc_null);
				
			melted_feature := ba.melted_feature;
			melted_feature.set_body_id (dispatch.real_body_id);
			if not System.freeze then
				Tmp_m_feature_server.put (melted_feature);
			end;

			Dispatch_table.mark_melted (dispatch);
			Execution_table.mark_melted (exec);
		end;

	is_once: BOOLEAN is
			-- is the constant (implemented like) a once function ?
		do
			Result := value.is_string or value.is_bit
		end;

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_CONSTANT_I;
		do
			!!rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_CONSTANT_I;
		do
			!!unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

	transfer_to (other: like Current) is
			-- Transfer datas form `other' into Current
		do
			basic_transfer_to (other);
			other.set_type (type);
			other.set_value (value);
		end;

feature -- Inlining

	can_be_inlined: BOOLEAN is False

end
