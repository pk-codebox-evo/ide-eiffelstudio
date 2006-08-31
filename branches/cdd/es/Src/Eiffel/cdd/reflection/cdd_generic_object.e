indexing
	description: "Objects that represent reflections of generic objects"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GENERIC_OBJECT

inherit

	CDD_REGULAR_OBJECT
		redefine
			type
		end

create
	make_generic

feature {NONE} -- Initialization

	make_generic (a_type: like dynamic_type; a_count: INTEGER; a_gen_type: STRING) is
			-- Create reflection for generic object of type 'a_type' with generic parameter 'a_gen_type'
			-- 'a_count' is number of attributes 'a_type' has defined
		require
			a_type_not_void: a_type /= Void
			a_gen_type_not_empty: a_gen_type /= Void and then not a_gen_type.is_empty
		do
			make_with_count (a_type, a_count)
			generic_type := a_gen_type
		ensure
			generic_type_set: generic_type = a_gen_type
		end


feature -- Access

	type: STRING is
			-- full type of the reflected object
		do
			Result := Precursor
			Result.append ("[" + generic_type + "]")
		end


	generic_type: STRING
			-- generic parameter of the objects type


invariant
	generic_type_not_empty: generic_type /= Void and then not generic_type.is_empty

end
