indexing

	description: 
		"Error for invalid renaming.";
	date: "$Date$";
	revision: "$Revision $"

class VHRC

inherit

	FEATURE_NAME_ERROR
		redefine
			build_explain, is_defined
		end;

feature -- Properties

	parent: E_CLASS;
			-- Involved parent

	code: STRING is "VHRC";
			-- Error for unvalid renaming

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				parent /= Void
		ensure then	
			valid_parent: Result implies parent /= Void
		end;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Parent: ");
			parent.append_name (ow);
			ow.new_line;
		end;

feature {COMPILER_EXPORTER}

	set_parent (p: CLASS_C) is
		require
			valid_p: p /= Void
		do
			parent := p.e_class;
		end;

end -- class VHRC
