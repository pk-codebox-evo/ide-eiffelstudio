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
			l_vec: VECTOR
			l_norm: DOUBLE
		do
			l_vec.set_x (1.2)
			l_vec.set_y (1.4)
			l_norm := l_vec.norm
		end

end
