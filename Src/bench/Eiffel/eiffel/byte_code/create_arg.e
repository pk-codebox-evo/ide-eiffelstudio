-- Creation type like an argument.

class CREATE_ARG 

inherit

	CREATE_INFO
		redefine
			generate_cid, make_gen_type_byte_code
		end
	SHARED_GENERATION

feature 

	position: INTEGER;
			-- Position of the argument type to create in the argument
			-- list of the current treated feature

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		do
			position := i;
		end;

	analyze is
		do
			if is_generic then
				context.mark_current_used
			end
		end;

	generate is
			-- Generate creation type. Take the dynamic type of the argument
			-- if possible, otherwise take its static type.
		local
			cl_type_i: CL_TYPE_I;
			gen_type_i: GEN_TYPE_I;
			buffer: GENERATION_BUFFER;
		do
			buffer := context.buffer;
			cl_type_i := type_to_create;
			gen_type_i ?= cl_type_i;
			buffer.putstring ("RTCA(arg");
			buffer.putint (position);
			buffer.putstring (gc_comma);

			if gen_type_i /= Void then
				buffer.putstring ("typres");
			else
				buffer.putint (cl_type_i.type_id - 1);
			end
			buffer.putchar (')');
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an argument anchored type.
		local
			cl_type_i : CL_TYPE_I;
			gen_type  : GEN_TYPE_I
		do
			ba.append (Bc_carg);
			cl_type_i := type_to_create
			gen_type  ?= cl_type_i;

				-- Default creation type
			ba.append_short_integer (cl_type_i.type_id - 1);
				-- Generics (if any)
			if gen_type /= Void then
				ba.append_short_integer (context.current_type.generated_id (False))
				gen_type.make_gen_type_byte_code (ba, True);
			end
			ba.append_short_integer (-1);
				-- Argument position
			ba.append_short_integer (position);
		end;

feature -- Generic conformance

	generate_gen_type_conversion (node : BYTE_NODE) is

		local
			gen_type : GEN_TYPE_I
		do
			gen_type ?= type_to_create

			if gen_type /= Void then
				node.generate_gen_type_conversion (gen_type)
			end
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is

		do
			buffer.putint (-11)
			buffer.putstring (", RTCA(arg")
			buffer.putint (position)
			buffer.putstring (",-10), ")
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY) is

		do
			ba.append_short_integer (-11)
			ba.append_short_integer (position)
		end

	type_to_create : CL_TYPE_I is

		local
			type_i : TYPE_I;
		do
			type_i := context.byte_code.arguments.item (position);
			type_i := context.constrained_type (type_i);
			Result ?= context.instantiation_of (type_i);
		end;

feature -- Debug

	trace is
		do
			io.error.putstring (generator);
			io.error.putstring ("  ");
			io.error.putint (position);
			io.error.new_line;
		end


end
