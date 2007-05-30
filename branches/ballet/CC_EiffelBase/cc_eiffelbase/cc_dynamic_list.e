indexing
	description: "[
		Sequential, dynamically modifiable lists,
		without commitment to a particular representation
		]"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_DYNAMIC_LIST [G]

inherit
	CC_LIST [G]


---- TODO
----------------------------------------------- from dynamic chain
--feature -- Status report

--	extendible: BOOLEAN is True
--			-- May new items be added? (Answer: yes.)

--	prunable: BOOLEAN is
--			-- May items be removed? (Answer: yes.)
--		do
--			Result := True
--		end

--feature -- Element change

--	put_front (v: like item) is
--			-- Add `v' at beginning.
--			-- Do not move cursor.
--		deferred
--		ensure
--	 		new_count: count = old count + 1
--			item_inserted: first = v
--		end

--	put_left (v: like item) is
--			-- Add `v' to the left of cursor position.
--			-- Do not move cursor.
--		require
--			extendible: extendible
--			not_before: not before
--		deferred
--		ensure
--	 		new_count: count = old count + 1
--	 		new_index: index = old index + 1
--		end

--	put_right (v: like item) is
--			-- Add `v' to the right of cursor position.
--			-- Do not move cursor.
--		require
--			extendible: extendible
--			not_after: not after
--		deferred
--		ensure
--	 		new_count: count = old count + 1
--	 		same_index: index = old index
--		end

--	merge_left (other: like Current) is
--			-- Merge `other' into current structure before cursor
--			-- position. Do not move cursor. Empty `other'.
--		require
--			extendible: extendible
--			not_before: not before
--			other_exists: other /= Void
--			not_current: other /= Current
--		deferred
--		ensure
--	 		new_count: count = old count + old other.count
--	 		new_index: index = old index + old other.count
--			other_is_empty: other.is_empty
--		end

--	merge_right (other: like Current) is
--			-- Merge `other' into current structure after cursor
--			-- position. Do not move cursor. Empty `other'.
--		require
--			extendible: extendible
--			not_after: not after
--			other_exists: other /= Void
--			not_current: other /= Current
--		deferred
--		ensure
--	 		new_count: count = old count + old other.count
--	 		same_index: index = old index
--			other_is_empty: other.is_empty
--		end

--feature -- Removal

--	prune (v: like item) is
--			-- Remove first occurrence of `v', if any,
--			-- after cursor position.
--			-- If found, move cursor to right neighbor;
--			-- if not, make structure `exhausted'.
--		do
--			search (v)
--			if not exhausted then
--				remove
--			end
--		end

--	remove_left is
--			-- Remove item to the left of cursor position.
--			-- Do not move cursor.
--		require
--			left_exists: index > 1
--		deferred
--		ensure
--	 		new_count: count = old count - 1
--	 		new_index: index = old index - 1
--		end

--	remove_right is
--			-- Remove item to the right of cursor position.
--			-- Do not move cursor.
--		require
--			right_exists: index < count
--		deferred
--		ensure
--	 		new_count: count = old count - 1
--	 		same_index: index = old index
--		end

--	prune_all (v: like item) is
--			-- Remove all occurrences of `v'.
--			-- (Reference or object equality,
--			-- based on `object_comparison'.)
--			-- Leave structure `exhausted'.
--		do
--			from
--				start
--				search (v)
--			until
--				exhausted
--			loop
--				remove
--				search (v)
--			end
--		ensure then
--			is_exhausted: exhausted
--		end

--	wipe_out is
--			-- Remove all items.
--		do
--			from
--				start
--			until
--				is_empty
--			loop
--				remove
--			end
--		end

--feature -- Duplication

--	duplicate (n: INTEGER): like Current is
--			-- Copy of sub-chain beginning at current position
--			-- and having min (`n', `from_here') items,
--			-- where `from_here' is the number of items
--			-- at or to the right of current position.
--		local
--			pos: CURSOR
--			counter: INTEGER
--		do
--			from
--				Result := new_chain
--				if object_comparison then
--					Result.compare_objects
--				end
--				pos := cursor
--			until
--				(counter = n) or else exhausted
--			loop
--				Result.extend (item)
--				forth
--				counter := counter + 1
--			end
--			go_to (pos)
--		end

--feature {DYNAMIC_CHAIN} -- Implementation

--	new_chain: like Current is
--			-- A newly created instance of the same type.
--			-- This feature may be redefined in descendants so as to
--			-- produce an adequately allocated and initialized object.
--		deferred
--		ensure
--			result_exists: Result /= Void
--		end

--invariant

--	extendible: extendible


----------------------------------------------- from dynamic list
--feature -- Element change

--	put_left (v: like item) is
--			-- Add `v' to the left of cursor position.
--			-- Do not move cursor.
--		local
--			temp: like item
--		do
--			if is_empty then
--				put_front (v)
--			elseif after then
--				back
--				put_right (v)
--				move (2)
--			else
--				temp := item
--				replace (v)
--				put_right (temp)
--				forth
--			end
--		end

--	put_right (v: like item) is
--			-- Add `v' to the right of cursor position.
--			-- Do not move cursor.
--		deferred
--		end

--	merge_left (other: like Current) is
--			-- Merge `other' into current structure before cursor
--			-- position. Do not move cursor. Empty `other'.
--		do
--			from
--				other.start
--			until
--				other.is_empty
--			loop
--				put_left (other.item)
--				other.remove
--			end
--		end

--	merge_right (other: like Current) is
--			-- Merge `other' into current structure after cursor
--			-- position. Do not move cursor. Empty `other'.
--		do
--			from
--				other.finish
--			until
--				other.is_empty
--			loop
--				put_right (other.item)
--				other.back
--				other.remove_right
--			end
--		end

--feature -- Removal

--	remove is
--			-- Remove current item.
--			-- Move cursor to right neighbor
--			-- (or `after' if no right neighbor).
--		deferred
--		ensure then
--			after_when_empty: is_empty implies after
--		end

--	remove_left is
--			-- Remove item to the left of cursor position.
--			-- Do not move cursor.
--		deferred
--		end

--	remove_right is
--			-- Remove item to the right of cursor position.
--			-- Do not move cursor.
--		deferred
--		end

--	wipe_out is
--			-- Remove all items.
--		do
--			chain_wipe_out
--			back
--		ensure then
--			is_before: before
--		end


end
