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
			l_result: like Current
		do
			l_result := Current + Current
		end

	infix "+" (other: like Current): like Current
			-- Fail with a postcondition violation.
		do

		ensure
			not_void: Result /= Void
		end

end
