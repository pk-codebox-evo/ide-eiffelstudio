indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ABS_INT_STORE

inherit
	INT_STORE
		redefine
			set_item,
			item,
			repr
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation
		require
			eee: 1 = 1
		modify
			fd: repr
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
		ensure then
			setet: item = a_value
		end

feature -- Framing
	repr: FRAME is
		do
--			create Result.make_from_ele (Current)
		end
end
