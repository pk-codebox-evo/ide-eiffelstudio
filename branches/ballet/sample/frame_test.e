indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FRAME_TEST

creation
	set_item

feature -- Access

	item: INTEGER is
			-- Integer value stored
		use
			uses_repr: repr
			uses2: repr1
		do
			Result := x
		end

feature -- Settings

	set_item (a_value: INTEGER) is
			-- Set `item' to `a_value'.
		modify
			modifies_repr: repr
		do
			x := a_value
		ensure
			value_set: item = a_value
			not_zero: item /= 0
		end

feature -- Framing
	repr: FRAME is
		use
			own: repr
		do

		end

	repr1: FRAME is
		use
			own: repr1
		do

		end

feature {}
	x: INTEGER
end
