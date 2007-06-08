indexing
	description: "Cursors for linked lists"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

class
	CC_LINKED_LIST_CURSOR_POSITION [G]

inherit
	CC_CURSOR_POSITION

create
	make

feature {NONE} -- Initialization

	make (active_element: like active; aft, bef: BOOLEAN) is
			-- Create a cursor and set it up on `active_element'.
		do
			active := active_element
			after := aft
			before := bef
		ensure
			confined representation
		end

feature {CC_LINKED_LIST} -- Implementation

	active: CC_LINKABLE [G]
			-- Current element in linked list

	after: BOOLEAN
			-- Is there no valid cursor position to the right of cursor?

	before: BOOLEAN
			-- Is there no valid cursor position to the right of cursor?

-- TODO maybe redefine the model or representation

invariant
	not_both: not (before and after)
	no_active_not_on: active = Void implies (before or after)

	-- TODO
end
