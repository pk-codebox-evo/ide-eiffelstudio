indexing

	description:
		"Interface with the Lexical Library classes";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class L_INTERFACE inherit

	METALEX
		rename
			make as metalex_make
		end

feature 

	build (doc: INPUT) is
			-- Create lexical analyzer and set `doc'
			-- to be the input document.
		require
			document_exists: doc /= Void
		do
			metalex_make;
			obtain_analyzer;
			make_analyzer;
			doc.set_lexical (analyzer)
		end -- build

feature {NONE}

	set_separator_type (type: INTEGER) is
			-- Make tokens of type `type' to be separators.
		do
			if analyzer = Void then
				!!analyzer.make
			end;
			analyzer.set_separator_type (type)
		end -- set_separator_type

feature 

	obtain_analyzer is
			-- Build lexical analyzer.
		deferred
		ensure
			analyzer /= Void
		end -- obtain_analyzer

end -- class L_INTERFACE
 

--|----------------------------------------------------------------
--| EiffelParse: library of reusable components for ISE Eiffel 3,
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
