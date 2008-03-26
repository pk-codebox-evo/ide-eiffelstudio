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
		local
			a: SOME_CLASS
		do
			create a.make
			io.put_string (#pf#&**$ a)
		end

end
