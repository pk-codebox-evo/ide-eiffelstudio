indexing

	description: 
		"Error for a non-boolean expression.";
	date: "$Date$";
	revision: "$Revision $"

deferred class VWBE 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;
	
feature -- Properties

	code: STRING is "VWBE";
			-- Error code

	type: TYPE_A;

	where: STRING is
		deferred
		end;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string (where);
			ow.put_string ("%NExpression type: ");
			type.append_to (ow);
			ow.new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_type (t: TYPE_A) is
		do
			type := t;
		end;

end -- class VWBE
