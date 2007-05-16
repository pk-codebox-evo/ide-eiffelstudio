indexing
	description: "Objects that represent reflections of other composite objects"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_COMPOSITE_OBJECT

inherit

	CDD_OBJECT
		rename
			identifier as address
		end

--	COMPARABLE
--		export
--			{NONE} all
--		undefine
--			is_equal
--		end

feature {NONE} -- Initialization

	make (a_type: like dynamic_type; an_address: like address) is
			-- Create reflection for object of type `a_type' and set `id' to `an_id'.
		require else
			a_type_not_void: a_type /= Void
			not_basic_type: not a_type.is_basic
			an_address_not_empty: an_address /= Void and then not an_address.is_empty
		do
			dynamic_type := a_type
			create type.make_from_string (dynamic_type.name)
			address := an_address
--			create identifier.make_from_string (a_type.name)
--			identifier.to_lower
--			identifier.append ("_id" + counter.item.out)
--			counter.set_item (counter.item + 1)
		end

feature -- Access

	address: STRING
			-- Identifier used for test case generation

	dynamic_type: EIFFEL_CLASS_C
			-- Class of the reflected object

	type: STRING
			-- Full type of the reflected object

	is_addressable: BOOLEAN is True
			-- Is `Current' addressable?

feature -- Output

	append_creation (a_printer: CDD_TEST_CASE_PRINTER) is
			-- Tells 'a_printer' to print a creation instruction for Current
		require
			a_printer_not_void: a_printer /= Void
		deferred
		end

	append_assignment (a_printer: CDD_TEST_CASE_PRINTER) is
			-- Tells 'a_printer' to print assignment instructions for Current
		require
			a_printer_not_void: a_printer /= Void
		deferred
		end

feature -- Comparision

--	infix "<" (other: like Current): BOOLEAN is
--			-- Is Current less than 'other'
--		require else
--			other_not_void: other /= Void
--		do
--			Result := identifier < other.identifier
--		end

feature {NONE} -- Implementation

--	counter: INTEGER_REF is
--			-- Counter for generating unique identifiers
--		once
--			create Result
--			Result.set_item (1)
--		ensure
--			not_void: Result /= Void
--		end

invariant
	dynamic_class_not_void: dynamic_type /= Void
	type_not_empty: type /= Void and then not type.is_empty

end
