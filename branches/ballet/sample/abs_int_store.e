indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ABS_INT_STORE

inherit
	INT_STORE

create
	make

feature{NONE} -- Initialization

	make is
			-- Creation
		modify
			repr
		do
			item := 0
		ensure
			init: item = 0
		end

feature -- Implementation

	item: INTEGER

	set_item (a_value: INTEGER) is
		do
			item := a_value
		end

feature -- Framing
	repr: FRAME is
		do
			create Result.make_from_element (Current)
		end
end
