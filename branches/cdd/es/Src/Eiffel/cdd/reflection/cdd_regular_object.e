indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_REGULAR_OBJECT

inherit
	CDD_COMPOSITE_OBJECT

create
	make_with_count


feature {NONE} -- Initialization

	make_with_count (dtype: like dynamic_class; attribute_count: INTEGER) is
			--
		do
			make (dtype)
			initialize_attributes (attribute_count)
		end

	initialize_attributes (count: INTEGER) is
			--
		do
			create attributes.make (count)
		end

feature -- Access

	attributes: HASH_TABLE [CDD_OBJECT, STRING]

feature -- Regeneration

	append_creation (a_generator: CDD_TEST_CASE_PRINTER) is
			-- Eiffel code used to instantate a new
			-- object of type dynamic_class
		do
			a_generator.append_regular_creation (Current)
		end

	append_assignment (a_generator: CDD_TEST_CASE_PRINTER) is
			-- Eiffel code for assigning values of object
		do
			a_generator.append_regular_assignment (Current)
		end

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	add_attribute (attr_name: STRING; value: CDD_OBJECT) is
			--
		do
			attributes.put (value, attr_name)
		end


feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature {NONE} -- Implementation

feature -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
