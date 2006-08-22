indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_SPECIAL_OBJECT

	inherit
		CDD_GENERIC_OBJECT
			rename
				make_generic as make_special
			redefine
				append_creation,
				append_assignment,
				add_attribute
			end


create
	make_special

feature -- Access

	append_creation (a_generator: CDD_TEST_CASE_PRINTER) is
			-- Eiffel code used to instantate a new
			-- object of type dynamic_class
		do
			a_generator.append_special_creation (Current)
		end

	append_assignment (a_generator: CDD_TEST_CASE_PRINTER) is
			-- Eiffel code for assigning values of object
		do
			a_generator.append_special_assignment (Current)
		end


feature

	add_attribute (a_name: STRING; a_value: CDD_OBJECT) is
			--
		require else
			a_name_numeric: a_name.is_integer
			a_name_valid_value: a_name.to_integer >= 0 and
				a_name.to_integer < attributes.count
			correct_type: a_value.type.is_equal (generic_type)
		do
			Precursor (a_name, a_value)
		end



end
