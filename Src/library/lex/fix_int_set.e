--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Integer sets with a fixed number of possible elements

indexing

	date: "$Date$";
	revision: "$Revision$"

class FIX_INT_SET

inherit

	BOOL_STRING
		rename
			make as boolean_set_make,
			put as bool_string_put,
			print as out_print
		export
			{NFA} is_equal
		end

creation

	make

feature

	make (n: INTEGER) is
			-- Make set for at most n integers from 1 to n.
		require
			n_positive: n > 0
		do
			boolean_set_make (n);
			all_false
		ensure
			set_empty: empty
		end; -- make

	put (i: INTEGER) is
			-- Insert i in the set.
		require
			index_large_enough: 1 <= i;
			index_small_enough: i <= count
		do
			bool_string_put (true, i)
		ensure
			is_in_set: has (i)
		end; -- put

	remove (i: INTEGER) is
			-- Delete i from the set.
		require
			index_large_enough: 1 <= i;
			index_small_enough: i <= count
		do
			bool_string_put (false, i)
		ensure
			is_not_in_set: not has (i)
		end; -- remove

	has (i: INTEGER): BOOLEAN is
			-- Is i in the set?
		require
			index_large_enough: 1 <= i;
			index_small_enough: i <= count
		do
			Result := item (i)
		end; -- has

	empty: BOOLEAN is
			-- Is current set empty?
		do
			Result := bempty ($area, count) /= 0
		end; -- empty

	smallest: INTEGER is
			-- Smallest integer in set;
			-- count + 1 if set empty
		do
			Result := sma ($area, count)
		end; -- smallest

	largest: INTEGER is
			-- Largest integer in set;
			-- 0 if empty
		do
			Result := lar ($area, count)
		end; -- largest

	next (p: INTEGER): INTEGER is
			-- Next integer in Current following p;
			-- count + 1 if p equals to largest.
		require
			p_in_set: p >= 1 and p <= count
		do
			Result := nex ($area, count, p)
		end; -- next

	print is
			-- List Current.
		local
			i: INTEGER;
		do
			io.set_error_default;
			io.putstring (" FIX_INT_SET: ");
			from
				i := 1
			until
				i > count
			loop
				if has (i) then
					io.putint (i);
					io.putstring (" ");
				end;
				i := i +1
			end;
			io.new_line
		end; -- print

	to_c: ANY is
		do
			Result := area
		end -- to_c

feature {NONE} -- External features

	nex (a1: like area; size, pos: INTEGER): INTEGER is
		external
			"C"
		end; -- nex

	lar (a1: like area; size: INTEGER): INTEGER is
		external
			"C"
		end; -- lar

	sma (a1: like area; size: INTEGER): INTEGER is
		external
			"C"
		end; -- sma

	bempty (a1: like area; size: INTEGER): INTEGER is
		external
			"C"
		end -- bempty

invariant

	positive_size: count > 0

end -- class FIX_INT_SET
