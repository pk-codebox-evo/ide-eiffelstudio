indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_STRING_OBJECT

inherit
	CDD_COMPOSITE_OBJECT
		redefine
			append_creation,
			append_assignment
		end


create
	make_with_string

feature {NONE} -- Initialization

	make_with_string (a_class: CLASS_C; a_string: STRING) is
			-- Initialize `Current'.
		require else
			class_ot_type_string: a_class.name.is_equal ("STRING_8") or
				a_class.name.is_equal ("STRING_32")
		do
			make (a_class)
			representation := a_string
		end


feature -- Access

	representation: STRING


feature -- Regeneration

	append_creation (a_generator: CDD_TEST_CASE_PRINTER) is
			--
		do
			a_generator.append_string_creation (Current)
		end

	append_assignment (a_generator: CDD_TEST_CASE_PRINTER) is
			--
		do
			a_generator.append_string_assignment (Current)
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

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
