indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BANK_ACCOUNT

feature -- Access

	balance: INTEGER

feature -- Basic operations

	deposit (an_amount: INTEGER) is
			--
		require
			--an_amount_positive: an_amount > 0
		do
			--balance := balance + an_amount
		ensure
			balance_increased: balance > old balance
			deposited: balance = old balance + an_amount
		end

	withdraw (an_amount: INTEGER) is
			--
		do
			balance := balance - an_amount
		ensure
			balance_decreased: balance < old balance
			withdrawn: balance = old balance - an_amount -- + an_amount
		end


feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	balance_not_negativ: balance >= 0

end
