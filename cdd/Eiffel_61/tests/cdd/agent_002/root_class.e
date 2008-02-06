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
			l_procedure: PROCEDURE [ANY, TUPLE]
		do
			l_procedure := agent
				do
					bar
				end
			l_procedure.call (Void)
		end

	bar is
			-- Fail with postcondition violation.
		require
			precondition: True
		do

		ensure
			false_postcondition: False
		end

end
