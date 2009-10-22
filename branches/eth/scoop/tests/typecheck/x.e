note
	description: "Summary description for {X}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	X

create
	make

feature
	make is
			-- Create X
		do

		end
	e : separate X is
		do
		end

	f : X is
		do
		end

	g (a : separate ANY) is
		do
			io.put_string ("Step 1 %N")
			io.put_string ("Step 2 %N")
		end

	h (a : ANY) is
 		do
		end
end
