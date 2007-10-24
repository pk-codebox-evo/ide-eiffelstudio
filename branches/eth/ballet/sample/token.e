indexing
	description: "Tokens"
	author: "Bernd Schoeller"
	date: "$Date$"
	revision: "$Revision$"

class
	TOKEN

create
	make, default_create

feature -- Creation

	make is
			-- Just a creation
		local
			x:TOKEN
		do
			x.make
		end

end
