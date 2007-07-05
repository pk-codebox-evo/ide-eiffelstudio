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
			uses_repr: representation
		do
			Result := x
		end

feature -- Settings

	set_item (a_value: INTEGER) is
			-- Set `item' to `a_value'.
		modify
			modifies_repr: representation
		do
			x := a_value
		ensure
			value_set: item = a_value
			confined_: representation.equals(old representation)
		end

feature -- Framing
	representation: FRAME is
		use
			own: representation
		do
--			create Result.make_from_element (Current)
		end

feature {}
	x: INTEGER
end
