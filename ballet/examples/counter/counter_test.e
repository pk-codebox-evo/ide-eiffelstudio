indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	COUNTER_TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			c1, c2: COUNTER
			v: INTEGER
		do
			create c1.make_zero
			create c2.make_zero
			c1.increment
			check
				c1: c1.value = 0
			end
			c2.increment
			c2.increment
			check
				c2.value = 2
			end
			c1.add(c2)
			check
				c1.value = 3
			end
		end

end -- class COUNTER_TEST
