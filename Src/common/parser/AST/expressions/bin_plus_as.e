indexing

	description: 
		"AST representation of binary `+' operation.";
	date: "$Date$";
	revision: "$Revision $"

class BIN_PLUS_AS

inherit

	ARITHMETIC_AS

feature -- Properties

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_plus";
		end;

end -- class BIN_PLUS_AS
