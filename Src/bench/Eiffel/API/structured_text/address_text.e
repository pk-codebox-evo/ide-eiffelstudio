indexing

	description:
		"Text item to show the address of an object.";
	date: "$Date$";
	revision: "$Revision$"

class ADDRESS_TEXT

inherit
	BASIC_TEXT
		rename
			image as address,
			make as old_make
		redefine
			append_to
		end

creation
	make

feature -- Initialization

	make (addr: like address; eclass: E_CLASS) is
			-- Initialize Current with address is `addr' and
			-- `e_class' is `eclass'.
		do
			address := addr;
			e_class := eclass
		end;

feature -- Properties

	e_class: E_CLASS;
			-- Eiffel class of which object at `address' as an
			-- instantiation.

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append `address' to `text'.
		do
			text.process_address_text (Current)
		end;

end -- class ADDRESS_TEXT
