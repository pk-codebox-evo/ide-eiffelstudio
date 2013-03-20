note
	description: "Lists with fixed maximum numbers of items, implemented by arrays"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	names: fixed, sequence;
	representation: array;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$"
	revision: "$Revision$"

class FIXED_LIST [G]

inherit
	ARRAYED_LIST [G]
		undefine
			resizable
		redefine
			extendible
		end

	FIXED [G]
		undefine
			copy, is_equal,
			full
		end

create
	make, make_filled

feature -- Status report

	extendible: BOOLEAN
			-- May new items be added?
		do
			Result := (count < capacity)
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end



