indexing
	description: "A very simple counter class"
	author: "Bernd Schoeller"
	date: "$Date$"
	revision: "$Revision$"

class
	SIMPLE_COUNTER

create
	make

feature -- Access

	x: INTEGER
	y: INTEGER

feature

	make is
		do
			x := 1
		ensure
			init_ok: x = 1
		end

	incr is
			-- Increment
		do
			x := x + 1
		ensure
			incr_ok: x = old x + 1
		end

	decr is
			-- Decrement
		do
			x := x - 1
		ensure
			decr_ok: x = old x - 1
		end

	make_positive is
		do
			if x < 0 then
				x := 0
			end
		ensure
			positive: x >= 0
		end

	incr_twice is
		do
			incr
			incr
		ensure
			double_incr_ok: x = old x + 2
		end

	incr_n_times (i: INTEGER) is
			-- Increment by `i'.
		require
			i_not_neg: i >= 0
		local
			old_x: INTEGER
		do
			from
				old_x := x
			invariant
				loop_inv: x <= old_x + i
			until
				x >= old_x + i
			loop
				incr
			end
		ensure
			incr_ok: x = old x + i
		end

	add (other:SIMPLE_COUNTER) is
			-- Add the count of another simple counter.
		require
			not_void: other /= Void
			not_same: other /= Current
		do
			x := x + other.x
		ensure
			x_added: x = old x + other.x
		end

	move_to_zero is
			-- Move the counter one value closer to 0.
		do
			if x > 0 then
				x := x - 1
			elseif x < 0 then
				x := x + 1
			else
				x := 0
			end
		ensure
			close_to_zero: (x.abs < (old x.abs)) or (x = 0)
		end


	move_one (other:SIMPLE_COUNTER) is
			-- Add one count to `other'.
		require
			not_void: other /= Void
			not_same: other /= Current
		local
			tmp: INTEGER
		do
			tmp := x
			other.incr_n_times (1)
			x := tmp - 1
		ensure
			current_decr: x = old x - 1
			other_incr: other.x = old other.x + 1
		end
end
