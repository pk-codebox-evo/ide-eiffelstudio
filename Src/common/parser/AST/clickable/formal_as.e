indexing

	description: 
		"AST representation of a formal generic type.";
	date: "$Date$";
	revision: "$Revision$"

class FORMAL_AS

inherit

	TYPE
		rename
			position as text_position
		redefine
			simple_format
		end;
	BASIC_ROUTINES
		export
			{NONE}
				all
		end;
	CLICKABLE_AST
		redefine
			is_class
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			position := yacc_int_arg (0);
		end;

feature -- Properties

	position: INTEGER;
			-- Position of the formal parameter in the declaration
			-- array

	is_class: BOOLEAN is
			-- Does the Current AST represent a class?
		do
			Result := True
		end;

feature -- Output

	dump: STRING is
		do
			!!Result.make (12);
			Result.append ("Generic #");
			Result.append_integer (position);
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string (ctxt.formal_name (position))
		end;

feature {COMPILER_EXPORTER}

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		do
			position := i;
		end;

end -- class FORMAL_AS
