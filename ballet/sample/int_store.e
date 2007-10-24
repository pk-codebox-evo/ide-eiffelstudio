 indexing
	description: "A boxed integer"
	author: "Bernd Schoeller"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INT_STORE

feature -- Access

	item: INTEGER is
			-- Integer value stored
		use
			uses_repr: repr
		deferred
		ensure
			item = 4 or item /= 4
		end

	added (x: INT_STORE): INTEGER is
			-- `x.item' and `item' added together, plus one
		require
			item >= 0
			x /= Void
		use
			uses_repr: repr
			uses_x_repr: x.repr
		do
			Result := item + x.item + 1
		ensure
			one: Result = item + x.item + 1
			two: Result >= x.item;
			three: (Result + 1).abs >= x.item.abs
		end

	test is
			-- Testing control structures
		local
			x: INTEGER
			y: INT_STORE
		do
			x := 1
			if x > 10 then
				x := x + 2
			elseif y = Current then
				x := x + 1
			else
				x := x - 1
			end
			check
				check_one: x >= 0
			end
			from
				x := 1
			until
				x > 100
			loop
				y := y
				x := x + 1
			end
		end

feature -- Settings

	set_item (a_valu: INTEGER) is
			-- Set `item' to `a_value'.
		require
			big: a_valu /= -4
			very_big: a_valu > -2
		modify
			modifies_repr: repr
		deferred
		ensure
			value_sett: item = a_valu
		end

feature -- Framing
	repr: FRAME is
		use
			own: repr
		do
		end

end
