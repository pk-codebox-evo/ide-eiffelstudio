indexing

	description:
		"Dynamically modifiable circular chains";

	copyright: "See notice at end of class";
	names: dynamic_circular, ring, sequence;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class DYNAMIC_CIRCULAR [G] inherit

	CIRCULAR [G]
		undefine
			prune, prune_all
		end;

	DYNAMIC_CHAIN [G]
		undefine
			valid_cursor_index,
			search, first, last, 
			finish, start, move, go_i_th,
			off, exhausted
		redefine
			duplicate
		end;

	BASIC_ROUTINES
		export
			{NONE} all
		redefine
			copy, is_equal,
			consistent, setup
		end;

feature

   duplicate (n: INTEGER): like Current is
			-- Copy of sub-chain beginning at current position
			-- and having min (`n', `count') items,
			-- where `from_here' is the number of items
			-- at or to the right of current position.
		local
			pos: CURSOR;
			to_be_removed, counter: INTEGER
		do
			from
				Result := new_chain;
				pos := cursor;
				to_be_removed := min (count, n)
			until
				counter = to_be_removed
			loop
				Result.extend (item);
				forth;
				counter := counter + 1
			end;
			go_to (pos)
		end;

end -- class DYNAMIC_CIRCULAR


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
