indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BUGGY_CLASS

create
	make

feature

	make (a_name: STRING) is
		require
			a_name_not_empty: a_name /= Void and then not a_name.is_empty
		do
			name := a_name
			other_name := "String for a second name"
			age := 3.5
			array_attr := <<"1th Array Element", "2nd Array Element">>
			tuple_attr := [666, "Evil"]
		end

	name: STRING

	other_name: STRING

	age: DOUBLE

	array_attr: ARRAY [STRING]

	tuple_attr: TUPLE [INTEGER, STRING]

	buggy_feature (an_append: STRING): STRING is
		require
			an_append_not_empty: an_append /= Void and then not an_append.is_empty
		do
			create Result.make_from_string (name)
			Result.append("?" + an_append)
		ensure
			correct_append: Result.is_equal (name + an_append)
		end




feature {NONE} -- Implementation

invariant
	name_not_empty: name /= Void and then not name.is_empty

end
