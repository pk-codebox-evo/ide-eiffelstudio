indexing

	description:
		"Any medium that can perform input and/or output";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class IO_MEDIUM 

inherit
	MEMORY
		export
		 {NONE} all
		redefine
			dispose
		end


feature -- Access

	name: STRING is
			-- Medium name
		deferred
		end;

feature -- Status report

	handle: INTEGER is
			-- Handle to medium
		require
			valid_handle: handle_available
		deferred
		end;

	handle_available: BOOLEAN is
			-- Is the handle available after class has been
			-- created?
		deferred
		end;

	is_plain_text: BOOLEAN is
			-- Is file reserved for text (character sequences)?
		do
		end

	last_character: CHARACTER;
			-- Last character read by `read_character'

	last_string: STRING;
			-- Last string read

	last_integer: INTEGER;
			-- Last integer read by `read_integer'

	last_real: REAL;
			-- Last real read by `read_real'

	last_double: DOUBLE;
			-- Last double read by `read_double'

	exists: BOOLEAN is
			-- Does medium exist?
		deferred
		end;

	is_open_read: BOOLEAN is
			-- Is this medium opened for input
		deferred
		end

	is_open_write: BOOLEAN is
			-- Is this medium opened for output
		deferred
		end

	is_readable: BOOLEAN is
			-- Is medium readable?
		require
			handle_exists: exists
		deferred
		end;

	is_executable: BOOLEAN is
			-- Is medium executable?
		require
			handle_exists: exists
		deferred
		end;

	is_writable: BOOLEAN is
			-- Is medium writable?
		require
			handle_exists: exists
		deferred
		end;

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		require
			handle_exists: exists
		deferred
		end;

	extendible: BOOLEAN is
			-- May new items be added?
		deferred
		end;

	is_closed: BOOLEAN is
			-- Is the I/O medium open
		deferred
		end;

feature -- Status setting

	close is
			-- Close medium.
		require
			medium_is_open: not is_closed;
		deferred
		end;

feature -- Removal

	dispose is
			-- Ensure this medium is closed when garbage collected.
		do
			if not is_closed then
				close;
			end;
		end;

feature -- Output 

	new_line is
			-- Write a new line character to medium
		require
			extendible: extendible
		deferred
		end;

	put_string, putstring (s: STRING) is
			-- Write `s' to medium.
		require
			extendible: extendible
			non_void: s /= Void
		deferred
		end;

	put_character, putchar (c: CHARACTER) is
			-- Write `c' to medium.
		require
			extendible: extendible
		deferred
		end;

	put_real, putreal (r: REAL) is
			-- Write `r' to medium.
		require
			extendible: extendible
		deferred
		end;

	put_integer, putint (i: INTEGER) is
			-- Write `i' to medium.
		require
			extendible: extendible
		deferred
		end;
	
	put_boolean, putbool (b: BOOLEAN) is
			-- Write `b' to medium.
		require
			extendible: extendible
		deferred
		end;
	
	put_double, putdouble (d: DOUBLE) is
			-- Write `d' to medium.
		require
			extendible: extendible
		deferred
		end;

feature -- Input 
	
	read_real, readreal is
			-- Read a new real.
			-- Make result available in `last_real'.
		require
			is_readable: readable
		deferred
		end;

	read_double, readdouble is
			-- Read a new double.
			-- Make result available in `last_double'.
		require
			is_readable: readable
		deferred
		end;

	read_character, readchar is
			-- Read a new character.
			-- Make result available in `last_character'.
		require
			is_readable: readable
		deferred
		end;

	read_integer, readint is
			-- Read a new integer.
			-- Make result available in `last_integer'.
		require
			is_readable: readable
		deferred
		end;

	read_stream, readstream (nb_char: INTEGER) is
			-- Read a string of at most `nb_char' bound characters
			-- or until end of medium is encountered.
			-- Make result available in `last_string'.
		require
			is_readable: readable
		deferred
		end;

	read_line, readline is
			-- Read characters until a new line or
			-- end of medium.
			-- Make result available in `last_string'.
		require
			is_readable: readable
		deferred
		end;
			
feature -- Obsolete

	lastchar: CHARACTER is
			-- Last character read by `read_character'
		do
			Result := last_character
		end;

	laststring: STRING is
			-- Last string read
		do
			Result := last_string
		end;

	lastint: INTEGER is
			-- Last integer read by `read_integer'
		do
			Result := last_integer
		end;

	lastreal: REAL is
			-- Last real read by `read_real'
		do
			Result := last_real
		end;

	lastdouble: DOUBLE is
			-- Last double read by `read_double'
		do
			Result := last_double
		end;

end -- class IO_MEDIUM

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
