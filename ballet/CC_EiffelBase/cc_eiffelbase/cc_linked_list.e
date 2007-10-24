indexing
	description: "Sequential, one-way linked lists"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

class
	CC_LINKED_LIST [G]

inherit
	CC_DYNAMIC_LIST [G]
		redefine
			before,
			after,
			readable,
			off,
			first,
			last,
			is_first,
			is_last,
			start,
			finish,
			move,
			go_i_th,
			put_left,
			wipe_out,
			merge_left,
			merge_right,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create an empty list.
		do
			before := True
		ensure
			is_before: before
			confined representation
		end

feature -- Access

	item: G is
			-- Current item.
		do
			Result := active.item
		end

	first: like item is
			-- Item at first position.
		do
			Result := first_element.item
		end

	last: like item is
			-- Item at last position.
		do
			Result := last_element.item
		end

	index: INTEGER is
			-- Index of current position.
		local
			p: CC_LINKED_LIST_CURSOR_POSITION [G]
		do
			if after then
				Result := count + 1
			elseif not before then
				p ?= cursor_position
				check
					p /= Void
				end
				from
					start; Result := 1
				until
					p.active = active
				loop
					forth
					Result := Result + 1
				end
--				go_to (p) not necessary because we stop at p
			end
		end

	cursor_position: CC_LINKED_LIST_CURSOR_POSITION [G] is
			-- Current cursor position.
		do
			create Result.make (active, after, before, Current)
		end

feature -- Measurement

	count: INTEGER
			-- Number of items.

feature -- Status report

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
			Result := not off
		end

	after: BOOLEAN
			-- Is there no valid cursor position to the right of cursor?

	before: BOOLEAN
			-- Is there no valid cursor position to the left of cursor?

	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := after or before
		end

	is_empty: BOOLEAN is
			-- Is structure empty?
		do
			Result := (count = 0)
		end

	is_first: BOOLEAN is
			-- Is cursor at first position?
		do
			Result := not after and not before and (active = first_element)
		end

	is_last: BOOLEAN is
			-- Is cursor at last position?
		do
			Result := not after and not before and
						(active /= Void) and then (active.right = Void)
		end

	valid_cursor_position (p: CC_CURSOR_POSITION): BOOLEAN is
			-- Can the cursor be moved to position `p'?
		local
			ll_c: like cursor_position
			temp, sought: like first_element
		do
			ll_c ?= p
			if ll_c /= Void then
				from
					temp := first_element
					sought := ll_c.active
					Result := ll_c.after or else ll_c.before
				until
					Result or else temp = Void
				loop
					Result := (temp = sought)
					temp := temp.right
				end
			end
		end

	is_full: BOOLEAN is False
		-- Is structured filled to capacity? (Answer: no.)

feature -- Cursor movement

	start is
			-- Move cursor to first position.
		do
			if first_element /= Void then
				active := first_element
				after := False
			else
				after := True
			end
			before := False
		ensure then
			empty_convention: is_empty implies after
		end

	finish is
			-- Move cursor to last position.
			-- (Go before if empty)
		local
			p: like first_element
		do
			if not is_empty then
				from
					p := active
				until
					p.right = Void
				loop
					p := p.right
				end
				active := p
				after := False
				before := False
			else
				before := True
				after := False
			end
		ensure then
			empty_convention: is_empty implies before
		end

	forth is
			-- Move cursor to next position.
		local
			old_active: like first_element
		do
			if before then
				before := False
				if is_empty then after := True end
			else
				old_active := active
				active := active.right
				if active = Void then
					active := old_active
					after := True
				end
			end
		end

	back is
			-- Move to previous item.
		do
			if is_empty then
				before := True
				after := False
			elseif after then
				after := False
			elseif is_first then
				before := True
			else
				active := previous
			end
		end

	move (i: INTEGER) is
			-- Move cursor `i' positions. The cursor
			-- may end up `off' if the offset is too big.
		local
			counter, new_index: INTEGER
			p: like first_element
		do
			if i > 0 then
				if before then
					before := False
					counter := 1
				end
				from
					p := active
				until
					(counter = i) or else (p = Void)
				loop
					active := p
					p := p.right
					counter := counter + 1
				end
				if p = Void then
					after := True
				else
					active := p
				end
			elseif i < 0 then
				new_index := index + i
				before := True
				after := False
				active := first_element
				if (new_index > 0) then
					move (new_index)
				end
			end
		ensure then
	 		moved_if_inbounds:
	 			((old index + i) >= 0 and
	 			(old index + i) <= (count + 1))
	 				implies index = (old index + i)
	 		before_set: (old index + i) <= 0 implies before
	 		after_set: (old index + i) >= (count + 1) implies after
		end

	go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th position.
		do
			if i = 0 then
				before := True
				after := False
				active := first_element
			elseif i = count + 1 then
				before := False
				after := True
				active := last_element
			else
				move (i - index)
			end
		end

	go_to (p: CC_CURSOR_POSITION) is
			-- Move cursor to position `p'.
		local
			ll_cursor_position: like cursor_position
		do
			ll_cursor_position ?= p
				check
					ll_cursor_position /= Void
				end
			after := ll_cursor_position.after
			before := ll_cursor_position.before
			if before then
				active := first_element
			elseif after then
				active := last_element
			else
				active := ll_cursor_position.active
			end
		end

feature -- Element change

	put_front (v: like item) is
			-- Add `v' to beginning.
			-- Do not move cursor.
		local
			cell: like first_element
		do
			cell := new_cell (v)
			cell.put_right (first_element)
			first_element := cell
			if before or is_empty then
				active := cell
			end
			count := count + 1
		end

	put_end (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		do
			extend_end (v)
		end


	extend_end (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		local
			cell: like first_element
		do
			cell := new_cell (v)
			if is_empty then
				first_element := cell
				active := cell
			else
				last_element.put_right (cell)
				if after then active := cell end
			end
			count := count + 1
		end

	put_left (v: like item) is
			-- Add `v' to the left of cursor position.
			-- Do not move cursor.
		local
			cell: like first_element
		do
			if is_empty then
				put_front (v)
			elseif after then
				back
				put_right (v)
				move (2)
			else
				cell := new_cell (active.item)
				cell.put_right (active.right)
				active.put (v)
				active.put_right (cell)
				active := cell
				count := count + 1
			end
		ensure then
			previous_exists: previous /= Void
			item_inserted: previous.item = v
		end

	put_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		local
			cell: like first_element
		do
			cell := new_cell (v)
			check is_empty implies before end
			if before then
				cell.put_right (first_element)
				first_element := cell
				active := cell
			else
				cell.put_right (active.right)
				active.put_right (cell)
			end
			count := count + 1
		ensure then
			next_exists: next /= Void
			item_inserted: not old before implies next.item = v
			item_inserted_before: old before implies active.item = v
		end

	replace_item_with (v: like item) is
			-- Replace current item by `v'.
		do
			active.put (v)
		end

	merge_left (other: like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'.
		local
			other_first_element: like first_element
			other_last_element: like first_element
			cell: like first_element
			other_count: INTEGER
		do
			if not other.is_empty then
				other_first_element := other.first_element
				other_last_element := other.last_element
				other_count := other.count
					check
						other_first_element /= Void
						other_last_element /= Void
					end
				if is_empty then
					first_element := other_first_element
					active := first_element
				elseif is_first then
					cell := first_element
					other_last_element.put_right (cell)
					first_element := other_first_element
				else
					cell := previous
					if cell /= Void then
						cell.put_right (other_first_element)
					end
					other_last_element.put_right (active)
				end
				count := count + other_count
				other.wipe_out
			end
		end

	merge_right (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'.
		local
			other_first_element: like first_element
			other_last_element: like first_element
			other_count: INTEGER
		do
			if not other.is_empty then
				other_first_element := other.first_element
				other_last_element := other.last_element
				other_count := other.count
					check
						other_first_element /= Void
						other_last_element /= Void
					end
				if is_empty then
					first_element := other_first_element
					active := first_element
				else
					if not is_last then
						other_last_element.put_right (active.right)
					end
					active.put_right (other_first_element)
				end
				count := count + other_count
				other.wipe_out
			end
		end

feature -- Removal

	remove_item is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		local
			removed, successor: like first_element
		do
			removed := active
			if is_first then
				first_element := first_element.right
				active.forget_right
				active := first_element
				if count = 1 then
					check
						no_active: active = Void
					end
					after := True
				end
			elseif is_last then
				active := previous
				if active /= Void then
					active.forget_right
				end
				after := True
			else
				successor := active.right
				previous.put_right (successor)
				active.forget_right
				active := successor
			end
			count := count - 1
			cleanup_after_remove (removed)
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			move (- 2)
			remove_right
			forth
		end

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		local
			removed, successor: like first_element
		do
			if before then
				removed := first_element
				first_element := first_element.right
				active.forget_right
				active := first_element
			else
				successor := active.right
				removed := successor
				active.put_right (successor.right)
				successor.forget_right
			end
			count := count - 1
			cleanup_after_remove (removed)
		end

	wipe_out is
			-- Remove all items.
		do
			internal_wipe_out
		end

feature -- Duplication

	copy (other: like Current) is
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		local
			cursor: CC_LINKED_LIST_CURSOR_POSITION [G]
			obj_comparison: BOOLEAN
		do
			obj_comparison := other.object_comparison
			standard_copy (other)
			if not other.is_empty then
				internal_wipe_out
				cursor ?= other.cursor_position
				from
					other.start
				until
					other.off
				loop
					extend_end (other.item)
						-- For speeding up next insertion, we go
						-- to the end, that way `extend' does not
						-- need to traverse the list completely.
					finish
					other.forth
				end
				other.go_to (cursor)
			end
			object_comparison := obj_comparison
		ensure then
			models_are_equivalent: other.model.first |=| model.first
			confined representation
		end

feature {CC_LINKED_LIST} -- Implementation

	new_dynamic_list: like Current is
			-- A newly created instance of the same type.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
		do
			create Result.make
		end

	new_cell (v: like item): like first_element is
			-- A newly created instance of the same type as `first_element'.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
		use
			use_own_representation: representation
		do
			create Result
			Result.put (v)
		ensure
			result_exists: Result /= Void
		end

	previous: like first_element is
			-- Element left of cursor
		use
			use_own_representation: representation
		local
			p: like first_element
		do
			if after then
				Result := active
			elseif not (is_first or before) then
				from
					p := first_element
				until
					p.right = active
				loop
					p := p.right
				end
				Result := p
			end
		end

	next: like first_element is
			-- Element right of cursor
		use
			use_own_representation: representation
		do
			if before then
				Result := active
			elseif active /= Void then
				Result := active.right
			end
		end

	active: like first_element
			-- Element at cursor position

	first_element: CC_LINKABLE [like item]
			-- Head of list

	last_element: like first_element is
			-- Tail of list
		use
			use_own_representation: representation
		local
			p: like first_element
		do
			if not is_empty then
				from
					Result := active
					p := active.right
				until
					p = Void
				loop
					Result := p
					p := p.right
				end
			end
		end

	cleanup_after_remove (v: like first_element) is
			-- Clean-up a just removed cell.
		require
			non_void_cell: v /= Void
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
			-- TODO not true - we modify not current.representation but 'v'
		do
		ensure
			confined representation
		end

feature {NONE} -- Implementation

	frozen internal_wipe_out is
			-- Remove all items.
			--| Used by `copy' instead of `wipe_out' to ensure that it
			--| will behave consistently even in descendants that
			--| redefine `wipe_out'.
		require
			prunable
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		do
			active := Void
			first_element := Void
			before := True
			after := False
			count := 0
		ensure
			wiped_out: is_empty
			is_before: before
			model_corresponds: model.first.is_empty
			confined representation
		end
feature -- Model

	model_indexable: MML_RELATION [INTEGER, G] is
			-- Model for an indexable data structure.
		local
			old_position: like cursor_position
		do
			create {MML_DEFAULT_RELATION [INTEGER, G]} Result.make_empty
			old_position := cursor_position

			from
				start
			until
				off
			loop
				Result := Result.extended_by_pair (index, item)
				forth
			end

			go_to (old_position)
		end

feature -- Framing

	representation: FRAME is
			-- Representation of a general linked list
		local
			old_position: like cursor_position
		do
			create Result.make_empty
			Result := Result.extended (Current)
			old_position := cursor_position

			from
				start
			until
				off
			loop
				Result := Result.extended(active)
				forth
			end

			go_to (old_position)
		end

invariant

	prunable: prunable
	empty_constraint: is_empty implies ((first_element = Void) and (active = Void))
	not_void_unless_empty: (active = Void) implies is_empty
	before_constraint: before implies (active = first_element)
	after_constraint: after implies (active = last_element)

	-- TODO add some more
	item_equals_cell_model_item: not is_empty implies (item = active.item)

end
