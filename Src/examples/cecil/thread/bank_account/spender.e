indexing
	description: "Objects that debit money from %
	% a shared bank account"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SPENDER

inherit
	CUSTOMER
		rename 
			make_transaction as withdraw
		redefine
			withdraw
		end
	
create
	make

feature -- Execution


	withdraw (m: INTEGER) is
		do
			c_make_transaction (-m, c_account)
		end

	
end	-- class SPENDER

--|----------------------------------------------------------------
--| CECIL: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

