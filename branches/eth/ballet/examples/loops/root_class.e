indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_CLASS

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			x: INTEGER
			y: INTEGER
		do
			from
				-- this arithmetic progression cannot be proven (so far?)
				x := 1
				y := 1
			invariant
				sx: x <= 100
				closed_form: y = x * (x + 1) / 2
			variant
				100 - x
			until
				x = 100
			loop
				x := x + 1
				y := y + x
			end

			check
				yy: y = 5050
			end
		end

	test is
		local
			x: INTEGER
			y: INTEGER
		do
			from
				x := 0
				y := 0
			invariant
				l_inv: y = x * 2
			until
				x = 5
			loop
				x := x + 1
				y := y + 2
			end
			check
				xx: y = 10
			end
		end

end -- class ROOT_CLASS
