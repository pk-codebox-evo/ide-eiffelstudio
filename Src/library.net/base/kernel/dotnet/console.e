indexing

	description: "[
		Commonly used console input and output mechanisms. 
		This class may be used as ancestor by classes needing its facilities.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class CONSOLE inherit

	PLAIN_TEXT_FILE
		rename
			make_open_read as make_open_stdin,
			make_open_write as make_open_stdout
		export
			{NONE}
				all
			{ANY}
				separator, append, file_pointer, last_character, last_integer,
				last_real, last_string, last_double, file_readable,
				lastchar, lastint, lastreal, laststring, lastdouble,
				read_character, readchar, read_real, 
				read_line, read_stream, read_word, put_integer,
				put_boolean, put_real, put_double, put_string, put_character,
				put_new_line, new_line, readint, readreal, readline, readstream,
				readword, putint, putbool, putreal, putdouble, putstring, putchar,
			dispose
		redefine
			make_open_stdin, make_open_stdout, count, is_empty, exists,
			close, dispose, end_of_file, back, next_line,
			read_integer, read_double, readint, readdouble, read_character,
			readchar, flush
		end

create {STD_FILES}
	make_open_stdin, make_open_stdout, make_open_stderr

feature -- Initialization

	make_open_stdin (fn: STRING) is
			-- Create an unix standard input file.
		do
			make (fn)
			internal_sread := feature {SYSTEM_CONSOLE}.in
			set_read_mode
		end

	make_open_stdout (fn: STRING) is
			-- Create an unix standard output file.
		do
			make (fn)
			internal_swrite := feature {SYSTEM_CONSOLE}.out
			set_write_mode
		end

	make_open_stderr (fn: STRING) is
			-- Create an unix standard error file.
		do
			make (fn)
			internal_swrite := feature {SYSTEM_CONSOLE}.error
			set_write_mode
		end

feature -- Element change

	flush is
			-- Flush buffered data to disk.
			-- Note that there is no guarantee that the operating
			-- system will physically write the data to the disk.
			-- At least it will end up in the buffer cache,
			-- making the data visible to other processes.
		do
			if internal_swrite /= Void then
				internal_swrite.flush
			end
		end

feature -- Status report

	exists: BOOLEAN is
			-- Does file exist?
		do
			Result := True
		end

	end_of_file: BOOLEAN is False
			-- Has an EOF been detected?
			-- Always false for a console.

feature -- Input

	next_line is
			-- Move to next input line.
		local
			s: SYSTEM_STRING
		do
			s := feature {SYSTEM_CONSOLE}.read_line
		end

	read_integer is
			-- Read the ASCII representation of a new integer
			-- from file. Make result available in `last_integer'.
		do
			Precursor {PLAIN_TEXT_FILE}
			next_line
		end
		
	readint is
			-- Read the ASCII representation of a new integer
			-- from file. Make result available in `last_integer'.
		do
			read_integer
		end
		
	read_double is
			-- Read the ASCII representation of a new double
			-- from file. Make result available in `last_double'.
		do
			Precursor {PLAIN_TEXT_FILE}
			next_line
		end

	readdouble is
			-- Read the ASCII representation of a new double
			-- from file. Make result available in `last_double'.
		do
			read_double
		end

	read_character is
			-- Read a new character.
			-- Make result available in `last_character'.
		local
		  	a_code: INTEGER
		do
		  	a_code := reader.read
		  	if a_code = - 1 then
				internal_end_of_file := True
		  	else
				last_character := a_code.to_character
		  	end
		end

	readchar is
			-- Read a new character.
			-- Make result available in `last_character'.
		do
			read_character
		end

feature -- Cursor movement

	back is
			-- Not supported on console
		do
		end
		
feature -- Removal

	close is
			-- Do not close the streams.
		do
		end

	dispose is
			-- This is closed by the operating system at completion.
		do
		end

feature {NONE} -- Inapplicable

	count: INTEGER is 1
			-- Useless for CONSOLE class.
			--| `count' is non null not to invalidate invariant clauses.

	is_empty: BOOLEAN is False;
			-- Useless for CONSOLE class.
			--| `empty' is false not to invalidate invariant clauses.

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class CONSOLE


