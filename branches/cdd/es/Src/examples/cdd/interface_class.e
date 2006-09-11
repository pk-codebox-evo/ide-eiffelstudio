indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTERFACE_CLASS


feature -- TDD features

	my_mult (a, b: INTEGER): INTEGER is
			--
		do
			Result := a * b
		ensure
			correct_result: Result = a * b
		end


end
