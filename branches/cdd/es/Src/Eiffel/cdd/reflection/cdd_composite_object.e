indexing
	description: "Objects that represent reflections of other composite objects"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_COMPOSITE_OBJECT

inherit

	CDD_OBJECT
		redefine
			make
		end

	COMPARABLE
		export
			{NONE} all
		undefine
			is_equal
		end

feature {NONE} -- Initialization

	make (a_type: like dynamic_type) is
			-- Create reflection for object of type 'a_type'.
		require else
			a_type_not_void: a_type /= Void
			not_basic_type: not a_type.is_basic
		do
			Precursor (a_type)
			create identifier.make_from_string (a_type.name)
			identifier.to_lower
			identifier.append ("_id" + counter.item.out)
			counter.set_item (counter.item + 1)
		end

feature -- Access

	identifier: STRING
			-- identifier used for output

feature -- Output

	append_creation (a_printer: CDD_TEST_CASE_PRINTER) is
			-- tells 'a_printer' to print a creation instruction for Current
		require
			a_printer_not_void: a_printer /= Void
		deferred
		end

	append_assignment (a_printer: CDD_TEST_CASE_PRINTER) is
			-- tells 'a_printer' to print assignment instructions for Current
		require
			a_printer_not_void: a_printer /= Void
		deferred
		end

feature -- Comparision

	infix "<" (other: like Current): BOOLEAN is
			-- is Current less than 'other'
		require else
			other_not_void: other /= Void
		do
			Result := identifier < other.identifier
		end


feature {NONE} -- Implementation

	counter: INTEGER_REF is
			-- counter for generating unique identifiers
		once
			create Result
			Result.set_item (1)
		ensure
			not_void: Result /= Void
		end

invariant
	invariant_clause: True -- Your invariant here

end
