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

	make (active_element: like active; after_status, before_status: BOOLEAN; a_linked_list: CC_LINKED_LIST [G]) is
			-- Create a cursor and set it up on `active_element'.
		do
			active := active_element
			after := after_status
			before := before_status
			linked_list := a_linked_list
		ensure
			confined representation
		end

feature {NONE} -- Implementation

	linked_list: CC_LINKED_LIST [G]
			-- The linked list for this cursor position.

feature {CC_LINKED_LIST} -- Implementation

	active: CC_LINKABLE [G]
			-- Current element in linked list

	after: BOOLEAN
			-- Is there no valid cursor position to the right of cursor?

	before: BOOLEAN
			-- Is there no valid cursor position to the right of cursor?

feature -- Model

	model: INTEGER is
			-- Model of a general linked list cursor position.
		do
			Result := linked_list.index
		end

invariant

	not_both: not (before and after)
	no_active_not_on: active = Void implies (before or after)
	-- TODO some model contracts???

end
