-- Warning for unknown free option

class VD32

inherit

	WARNING
		redefine
			build_explain
		end;

feature

	code: STRING is "VD32";
			-- Error code

	option_name: STRING;
			-- Option name

	set_option_name (s: STRING) is
			-- Assign `s' to `option_name'
		do
			option_name := s
		end;

	build_explain is
		do
			put_string ("Unknown option: ");
			put_string (option_name);
			new_line;
		end;

end
