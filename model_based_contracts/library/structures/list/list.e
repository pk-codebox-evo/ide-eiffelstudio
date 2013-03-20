indexing

	description:
		"Sequential lists, without commitment to a particular representation"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	names: list, sequence;
	access: index, cursor, membership;
	contents: generic;
	model: sequence, index, extendible, prunable, full, object_comparison;
	date: "$Date$"
	revision: "$Revision$"

deferred class LIST [G] inherit

	CHAIN [G]
		export
			{ANY} remove
		redefine
			forth, is_equal
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does `other' contain the same elements?
		do
			if Current = other then
				Result := True
			else
				Result := (is_empty = other.is_empty) and
						(object_comparison = other.object_comparison) and
						(count = other.count)
				if Result and not is_empty then
					if
						{c1: CURSOR} cursor and then
						{c2: CURSOR} other.cursor
					then
						from
							start
							other.start
						until
							after or not Result
						loop
							if object_comparison then
								Result := equal (item, other.item)
							else
								Result := (item = other.item)
							end
							forth
							other.forth
						end
						go_to (c1)
						other.go_to (c2)
					else
						check
							cursors_exist: False
								-- Because every list contains a cursor object
						end
					end
				elseif is_empty and other.is_empty and
					object_comparison = other.object_comparison then
					Result := True
				end
			end
		ensure then
			indices_unchanged:
				index = old index and other.index = old other.index
			true_implies_same_size: Result implies count = other.count
		-- ensure then:
			definition_reference_comparison: not object_comparison implies Result = not other.object_comparison and (sequence |=| other.sequence)
			definition_object_comparison: object_comparison implies Result = other.object_comparison and other.sequence.count = sequence.count and sequence.set_for_all (agent (p: MML_PAIR [INTEGER, G]; s: MML_SEQUENCE [G]): BOOLEAN do Result := equal_elements (s.item (p.first), p.second) end (?, other.sequence))
		end

feature -- Status report

	after: BOOLEAN is
			-- Is there no valid cursor position to the right of cursor?
		do
			Result := (index = count + 1)
		end

	before: BOOLEAN is
			-- Is there no valid cursor position to the left of cursor?
		do
			Result := (index = 0)
		end

feature -- Cursor movement

	forth is
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		deferred
		ensure then
			moved_forth: index = old index + 1
		end

invariant

	before_definition: before = (index = 0)
	after_definition: after = (index = count + 1)

indexing
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







end -- class LIST



