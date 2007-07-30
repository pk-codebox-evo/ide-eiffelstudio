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
		undefine
			prune,
			prune_all
		end

feature -- Status report

	extendible: BOOLEAN is
			-- May new items be added? (Answer: yes.)
		use
			use_own_representation: representation
		do
			Result := True
		end

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		use
			use_own_representation: representation
		do
			Result := True
		end

feature -- Element change

	put_front (v: like item) is
			-- Add `v' at beginning.
			-- Do not move cursor.
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
	 		new_count: count = old count + 1
			item_inserted: first = v
			model_corresponds: model.first.first = v
			model_corresponds: model.first.tail |=| old model.first
			confined representation
		end

	put_left (v: like item) is
			-- Add `v' to the left of cursor position.
			-- Do not move cursor.
		require
			extendible: extendible
			not_before: not before
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		local
			temp: like item
		do
			if is_empty then
				put_front (v)
			elseif after then
				back
				put_right (v)
				move (2)
			else
				temp := item
				replace_item_with (v)
				put_right (temp)
				forth
			end
		ensure
	 		new_count: count = old count + 1
	 		new_index: index = old index + 1
	 		model_corresponds: model.first |=| old model.first.extended_at (v, model.second - 1)
	 		confined representation
		end

	put_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		require
			extendible: extendible
			not_after: not after
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
	 		new_count: count = old count + 1
	 		same_index: index = old index
	 		model_corresponds: model.first |=| old model.first.extended_at (v, model.second + 1)
	 		confined representation
		end

	merge_left (other: like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'.
		require
			extendible: extendible
			not_before: not before
			other_exists: other /= Void
			not_current: other /= Current
		use
			use_own_representation: representation
			use_other_representation: other.representation
		modify
			modify_own_representation: representation
			modify_other_representation: other.representation
		do
			from
				other.start
			until
				other.is_empty
			loop
				put_left (other.item)
				other.remove_item
			end
		ensure
	 		new_count: count = old count + old other.count
	 		new_index: index = old index + old other.count
			other_is_empty: other.is_empty
			other_model_is_empty: other.model.first.is_empty
			--model_corresponds: model.first |=| old model.first.
			-- TODO no contracts about cursor
			-- is 'united' sufficient, because it is a sequence -> order important
			-- confined other.representation??? necessary???
			confined representation
		end

	merge_right (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'.
		require
			extendible: extendible
			not_after: not after
			other_exists: other /= Void
			not_current: other /= Current
		use
			use_own_representation: representation
			use_other_representation: other.representation
		modify
			modify_own_representation: representation
			modify_other_representation: other.representation
		do
			from
				other.finish
			until
				other.is_empty
			loop
				put_right (other.item)
				other.back
				other.remove_right
			end
		ensure
	 		new_count: count = old count + old other.count
	 		same_index: index = old index
			other_is_empty: other.is_empty
			other_model_is_empty: other.model.first.is_empty
			-- TODO see comment at 'merge_left'
			confined representation
		end

feature -- Removal

	prune (v: like item) is
			-- Remove first occurrence of `v', if any,
			-- after cursor position.
			-- If found, move cursor to right neighbor;
			-- if not, make structure `exhausted'.
		do
			search (v)
			if not exhausted then
				remove_item
			end
		end

	remove_item is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		deferred
		ensure then
			after_when_empty: is_empty implies after
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		require
			left_exists: index > 1
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
	 		new_count: count = old count - 1
	 		new_index: index = old index - 1
	 		model_corresponds: model.first |=| old model.first.pruned_at (model.second - 1)
	 		confined representation
		end

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		require
			right_exists: index < count
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
	 		new_count: count = old count - 1
	 		same_index: index = old index
	 		model_corresponds: model.first |=| old model.first.pruned_at (model.second + 1)
	 		confined representation
		end

	prune_all (v: like item) is
			-- Remove all occurrences of `v'.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- Leave structure `exhausted'.
		do
			from
				start
				search (v)
			until
				exhausted
			loop
				remove_item
				search (v)
			end
		ensure then
			is_exhausted: exhausted
		end

	wipe_out is
			-- Remove all items.
		do
			from
				start
			until
				is_empty
			loop
				remove_item
			end
			back
		ensure then
			is_before: before
		end

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-chain beginning at current position
			-- and having min (`n', `from_here') items,
			-- where `from_here' is the number of items
			-- at or to the right of current position.
		local
			old_cursor_position: CC_CURSOR_POSITION
			counter: INTEGER
		do
			from
				Result := new_dynamic_list
				if object_comparison then
					Result.compare_objects
				end
				old_cursor_position := cursor_position
			until
				(counter = n) or else exhausted
			loop
				Result.extend_end (item)
				forth
				counter := counter + 1
			end
			go_to (old_cursor_position)
		end

feature {CC_DYNAMIC_LIST} -- Implementation

	new_dynamic_list: like Current is
			-- A newly created instance of the same type.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
		use
			use_own_representation: representation
		deferred
		ensure
			result_exists: Result /= Void
		end

invariant

	extendible: extendible

end
