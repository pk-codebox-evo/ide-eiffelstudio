indexing
	description: "Objects that represent the state of objects during execution"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_OBJECT

feature -- Initialization

	make (a_type: like dynamic_type) is
			-- Create new reflection with object of type 'a_type'.
		require
			a_type_not_void: a_type /= Void
		do
			dynamic_type := a_type
			create type.make_from_string (dynamic_type.name)
		ensure
			correct_dynamic_type: dynamic_type = a_type
			type_set: type.is_equal (dynamic_type.name)
		end

feature -- Access

	dynamic_type: EIFFEL_CLASS_C
			-- Reflected objects type

	type: STRING
			-- Full type of the reflected object

	identifier: STRING is
			-- Identifier used for output
		deferred
		ensure
			result_not_empty: Result /= Void and then not Result.is_empty
		end

invariant
	dynamic_class_not_void: dynamic_type /= Void
	type_not_empty: type /= Void and then not type.is_empty

end
