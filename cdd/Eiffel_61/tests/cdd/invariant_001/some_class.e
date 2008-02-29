indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SOME_CLASS

create
	make

feature -- Initialize

	make is
			--
		do
			field := 10
		end

feature -- Access

	field: INTEGER

feature -- Basic operations

	set_field (a_val: INTEGER) is
			--
		require
			precondition: True
		do
			field := a_val
		ensure
			field_set: field = a_val
		end

invariant
	field_non_negative:  field >= 0

end
