indexing
	description: "Error object sent by the compiler to the workbench."
	date: "$Date$"
	revision: "$Revision$"

deferred class ERROR

inherit
	ANY

	EIFFEL_ENV
		export
			{NONE} all
		end

feature -- Properties 

	line: INTEGER
			-- Line number involved in error

	column: INTEGER
			-- Column number involved in error

	file_name: STRING is
			-- Path to file involved in error.
			-- Could be Void if not a file specific error.
		require
			has_associated_file: has_associated_file
		deferred
		ensure
			file_name_not_void: has_associated_file
		end
		
	code: STRING is
			-- Code error
		deferred
		ensure
			code_not_void: Result /= Void
		end

	subcode: INTEGER is
			-- Subcode of error. `0' if none.
		do
		end

	help_file_name: STRING is
			-- Associated file name where error explanation is located.
		do
			Result := code
		ensure
			help_file_name_not_void: Result /= Void
		end;

	Error_string: STRING is
		do
			Result := "Error"
		ensure
			error_string_not_void: Result /= Void
		end
		
	has_associated_file: BOOLEAN is
			-- Is current relative to a file?
		do
		end

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := True
		end
		
feature -- Set position

	set_location (a_location: LOCATION_AS) is
			-- Initialize `line' and `column' from `a_location'
		require
			a_location_not_void: a_location /= Void
		do
			line := a_location.line
			column := a_location.column
		ensure
			line_set: line = a_location.line
			column_set: column = a_location.column
		end
		
	set_position (l, c: INTEGER) is
			-- Set `line' and `column' with `l' and `c'.
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
		do
			line := l
			column := c
		ensure
			line_set: line = l
			column_set: column = c
		end

feature {NONE} -- Compute surrounding text around error

	previous_line, current_line, next_line: STRING
			-- Surrounding lines where error occurs.
			
	initialize_output is
			-- Set `previous_line', `current_line' and `next_line' with their proper values
			-- taken from file `file_name'.
		require
			file_name_not_void: file_name /= Void
		local
			file: PLAIN_TEXT_FILE
			nb: INTEGER
		do
			create file.make_open_read (file_name)
			from
				nb := 1
			until
				nb > line or else file.end_of_file
			loop
				if nb >= line - 1 then
					previous_line := current_line
				end
				file.read_line
				nb := nb + 1
				if nb >= line - 1 then
					current_line := file.last_string.twin
				end
			end
			if not file.end_of_file then
				file.read_line
				next_line := file.last_string.twin
			end
			file.close
		end

feature -- Output

	trace (st: STRUCTURED_TEXT) is
			-- Display full error message in `st'.
		require
			valid_st: st /= Void;
			is_defined: is_defined
		do
			print_error_message (st);
			build_explain (st);
		end;

	print_error_message (st: STRUCTURED_TEXT) is
			-- Display error in `st'.
		require
			valid_st: st /= Void
		do
			st.add_string (Error_string);
			st.add_string (" code: ");
			st.add_error (Current, code);
			if subcode /= 0 then
				st.add_char ('(');
				st.add_int (subcode);
				st.add_string (")");
				st.add_new_line
			else
				st.add_new_line;
			end;
			print_short_help (st);
		end;

	print_short_help (st: STRUCTURED_TEXT) is
			-- Display help in `st'.
		require
			valid_st: st /= Void
		local
			l_file_name: STRING;
			f_name: FILE_NAME;
			file: PLAIN_TEXT_FILE;
		do
			create f_name.make_from_string (help_path);
			f_name.extend ("short");
			f_name.set_file_name (help_file_name);
			l_file_name := f_name
			if subcode /= 0 then
				l_file_name.append_integer (subcode)
			end;
			create file.make (l_file_name);
			if file.exists then
				from
					file.open_read;
				until
					file.end_of_file
				loop
					file.read_line;
					st.add_string (file.last_string.twin)
					st.add_new_line;
				end;
				file.close;
			else
				st.add_new_line;
				st.add_string ("No help available for this error");
				st.add_new_line;
				st.add_string ("(cannot read file: ");
				st.add_string (l_file_name);
				st.add_string (")");
				st.add_new_line;
				st.add_new_line;
				st.add_string ("An error message should always be available.");
				st.add_new_line;
				st.add_string ("Please contact ISE.");
				st.add_new_line;
				st.add_new_line
			end;
		end;

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `error_window'.
		require
			valid_st: st /= Void
		deferred
		end;

invariant
	non_void_code: code /= Void
	non_void_error_message: error_string /= Void
	non_void_help_file_name: help_file_name /= Void
	
end -- class ERROR
