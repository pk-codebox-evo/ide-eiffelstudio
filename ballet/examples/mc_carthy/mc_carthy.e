indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	MC_CARTHY

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			l: INTEGER
		do
			l := mc_91 (10)
			check
				good: l = 91
			end
		end

	mc_91 (n: INTEGER): INTEGER is
		do
			if n > 100 then
				Result := n - 10
			else
				Result := mc_91 (mc_91 (n + 11))
			end
		ensure
			result_91: n <= 100 implies Result = 91
			big_n: n > 100 implies Result = n - 10
		end

end -- class MC_CARTHY
