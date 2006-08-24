indexing
	description: "Objects that ..."
	author: ""
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

	make (a_class: like dynamic_class) is
			--
		do
			Precursor (a_class)
			create identifier.make_from_string (type)
			identifier.to_lower
			identifier.append ("_ID" + counter.item.out)
			counter.set_item (counter.item + 1)
		end

feature -- Access

	identifier: STRING

	full_type: STRING is
			-- in case generic
		do
			Result := type
		end

feature -- Regeneration

	append_creation (a_generator: CDD_TEST_CASE_PRINTER) is
			-- Eiffel code used to instantate a new
			-- object of type dynamic_class
		deferred
		end

	append_assignment (a_generator: CDD_TEST_CASE_PRINTER) is
			-- Eiffel code for assigning values of object
		deferred
		end

feature -- Comparision

	infix "<" (other: like Current): BOOLEAN is
			--
		do
			Result := identifier < other.identifier
		end


feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	counter: INTEGER_REF is
		once
			create Result
			Result.set_item (1)
		end

invariant
	invariant_clause: True -- Your invariant here

end
