indexing
	description : "scoop_test application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization
	make
		local
			x : separate APPLICATION
		do
			io.put_string ("Testy, yarrr %N")
		end
end
