indexing
	description: "Linkable cells containing a reference to their right neighbor"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

class
	CC_LINKABLE [G]

inherit
	CC_CELL [G]
		export
			{CC_CELL, CC_LIST}
				put
			{CC_ANY}
				item
		end

feature -- Access

	right: like Current
			-- Right neighbor

feature {CC_CELL, CC_LIST} -- Implementation

	put_right (other: like Current) is
			-- Put `other' to the right of current cell.
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		do
			right := other
		ensure
			chained: right = other
			confined representation
		end

	forget_right is
			-- Remove right link.
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		do
			right := Void
		ensure
			not_chained: right = Void
			confined representation
		end

end
