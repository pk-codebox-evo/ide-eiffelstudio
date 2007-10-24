class BANK_ACCOUNT

create

	make

feature -- Initialization

	balance: INTEGER

	make is
			-- Initializaition routine.
		do
			balance := 0
		ensure
			balance_initialized: balance = 0
		end

	deposit (an_amount: INTEGER) is
			-- Deposit `an_amount' on the account.
		require
			amount_positive: an_amount >= 0
		do
			balance := balance + an_amount
		ensure
			balance_increased: balance = old balance + an_amount
		end

	withdraw (an_amount: INTEGER) is
			-- Withdraw `an_amount' from the account.
		require
			amount_positive: an_amount >= 0
			amount_not_too_large: an_amount <= balance
		do
			balance := balance - an_amount
		ensure
			balance_decreased: balance = old balance - an_amount
		end

	transfer (other_account: BANK_ACCOUNT; an_amount: INTEGER) is
			-- Transfer money from `Current' to `other_account'.
		require
			other_not_void: other_account /= Void
			amount_positive: an_amount >= 0
			amount_not_too_large: an_amount <= balance
		do
			withdraw (an_amount)
			other_account.deposit (an_amount)
		ensure
			balance_decreased: balance = old balance - an_amount
			other_balance_increased: other_account.balance = old other_account.balance + an_amount
		end

invariant
	balance_not_negative: balance >= 0
end
