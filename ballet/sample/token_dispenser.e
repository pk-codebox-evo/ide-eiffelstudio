indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOKEN_DISPENSER

feature -- Access

	last_token: TOKEN

feature -- Creation

	generate_token is
			-- Generate a new token
		do
			create last_token.make
		ensure
			different_token: last_token /= old last_token
		end

end
