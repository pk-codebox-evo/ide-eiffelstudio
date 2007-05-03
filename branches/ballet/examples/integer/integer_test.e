indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			x := 3
			add_one
		end

	add_one is
		require
			x_positive: x >= 0
		do
			x := x + 2
			x := x - 2
		ensure
			x_positive: x >= 0
			x_increased: x = old x + 1
		end

	x: INTEGER

end -- class INTEGER_TEST
