indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TUPLE_OBJECT

	inherit
		CDD_GENERIC_OBJECT
			rename
				make_generic as make_tuple
			redefine
				append_creation,
				append_assignment
			end

create
	make_tuple

feature -- Access

	append_creation (a_generator: CDD_TEST_CASE_PRINTER) is
			-- Eiffel code used to instantate a new
			-- object of type dynamic_class
		do
			a_generator.append_tuple_creation (Current)
		end

	append_assignment (a_generator: CDD_TEST_CASE_PRINTER) is
			-- Eiffel code for assigning values of object
		do
			a_generator.append_tuple_assignment (Current)
		end

end
