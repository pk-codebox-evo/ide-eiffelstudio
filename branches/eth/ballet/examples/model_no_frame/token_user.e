indexing
	description: "A user of tokens and the dispenser"
	author: "Bernd Schoeller and others"
	date: "$Date$"
	revision: "$Revision$"

class
	TOKEN_USER

create
	make

feature -- Creation

	make is
			-- Initialization
		do
			create dispenser.make
		end

feature -- Access

	dispenser: TOKEN_DISPENSER

feature -- Proof target

	token1: TOKEN
	token2: TOKEN

	prove_me is
			-- Proof this feature.
		do
			dispenser.generate_token
			token1 := dispenser.last_token
			dispenser.generate_token
			token2 := dispenser.last_token
		ensure
			token1_from_dispenser: dispenser.has_generated (token1)
			token2_from_dispenser: dispenser.has_generated (token2)
		end

invariant
	dispenser_exists: dispenser /= Void
end
