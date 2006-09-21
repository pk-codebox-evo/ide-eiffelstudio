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
			l_internal: INTERNAL
			tc: BUGGY_CLASS
			i: INTERFACE_CLASS
		do
			create i

			io.put_integer (i.my_mult (4, 3))

			create tc.make ("Hello")
			io.put_string (tc.buggy_feature ("World"))
		end


end -- class ROOT_CLASS
