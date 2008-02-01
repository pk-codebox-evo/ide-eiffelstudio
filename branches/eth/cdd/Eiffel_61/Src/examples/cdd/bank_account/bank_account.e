indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BANK_ACCOUNT

inherit
	ANY
		redefine
			default_create
		end

feature -- Initalization

	default_create is
			-- Create new bank account with a balance of 300.
		do
			balance := 300
		end

feature -- Access

	balance: INTEGER
			-- Current balance of account

feature -- Basic operations

	deposit (an_amount: INTEGER) is
			-- Add `an_amount' money to `balance'.
		do
		ensure
			balance_increased: balance > old balance
			deposited: balance = old balance + an_amount
		end

	withdraw (an_amount: INTEGER) is
			-- Substract `an_amount' money from `balance'.
		do
		ensure
			balance_decreased: balance < old balance
			withdrawn: balance = old balance - an_amount
		end

invariant
	balance_not_negativ: balance >= 0

end
