indexing

	description:
		"Individual elements of lexical analysis";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TOKEN 

feature -- Access

	type: INTEGER;
			-- Type of the token

	line_number: INTEGER;
			-- Line number in the parsed text

	column_number: INTEGER;
			-- Column number in the parsed text

	keyword_code: INTEGER;
			-- Identification number if the token is a keyword

	string_value: STRING;
			-- The token's character string

	is_keyword (i: INTEGER): BOOLEAN is
			-- If the token is a keyword,
			-- is `i' its identification number?
		do
			Result := (i = keyword_code)
		end 

feature -- Status setting

	set (typ, lin, col, key: INTEGER; str: STRING) is
		-- Reset the contents of the token:
		-- type `type', line number `lin',
		-- column number `col', keyword value `key'.
		do
			type := typ;
			line_number := lin;
			column_number := col;
			keyword_code := key;
			if type = 0 then
				string_value := ""
			else
				string_value := str
			end
		end

feature -- Obsolete

	position_in_line:INTEGER is
		obsolete "Use ``column_number'' instead"
	do
		Result := column_number
	end

end -- class TOKEN
 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel 3,
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
