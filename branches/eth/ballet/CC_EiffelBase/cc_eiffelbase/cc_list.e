indexing
	description: "Sequential lists, without commitment to a particular representation"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_LIST [G]

inherit

	CC_SEQUENCE [G]
		rename
			occurrences as occurrences_sequence
		export
			{NONE}
				occurrences_sequence
		undefine
			valid_index
		redefine
			has,
			index_of,
			off,
			is_equal,
			append
		select
			model_container,
			prune_all
		end

	CC_INDEXABLE [G]
		rename
			model as model_indexable,
			prune_all as prune_all_indexable,
			item as i_th alias "[]",
			put as put_i_th
		export
			{NONE}
				model_indexable,
				prune_all_indexable
		redefine
			is_equal
		end

	CC_CURSOR_STRUCTURE [G]
		rename
			model as model_cursor_structure,
			extend as extend_end,
			put as put_end
		export
			{NONE}
				model_cursor_structure
		undefine
			prune_all
		redefine
			is_equal
		end

feature -- Access

	first: like item is
			-- Item at first position
		local
			old_position: CC_CURSOR_POSITION
		do
			old_position := cursor_position
			start
			Result := item
			go_to (old_position)
		end

	last: like item is
			-- Item at last position
		local
			old_position: CC_CURSOR_POSITION
		do
			old_position := cursor_position
			finish
			Result := item
			go_to (old_position)
		end

	has (v: like item): BOOLEAN is
			-- Does list include `v'?
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			old_position: CC_CURSOR_POSITION
		do
			old_position := cursor_position

			start
			if not off then
				search (v)
			end
			Result := not exhausted

			go_to (old_position)
		end

	index_of (v: like item; i: INTEGER): INTEGER is
			-- Index of `i'-th occurrence of item identical to `v'.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- 0 if none.
		local
			old_position: CC_CURSOR_POSITION
		do
			old_position := cursor_position

			-- TODO ist das performant genug??? sonst halt nochmal code kopieren
			Result := linear_representation.index_of (v, i)

			go_to (old_position)
		end

	i_th alias "[]", infix "@" (i: INTEGER): like item is
			-- Item at `i'-th position.
		local
			old_position: CC_CURSOR_POSITION
		do
			old_position := cursor_position
			go_i_th (i)
			Result := item
			go_to (old_position)
		end

feature -- Measurement

	occurrences (v: like item): INTEGER is
			-- Number of times `v' appears.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		use
			use_own_representation: representation
		local
			old_position: CC_CURSOR_POSITION
		do
			old_position := cursor_position
			Result := occurrences_sequence (v)
			go_to (old_position)
		ensure
			model_corresponds: Result = model.first.occurrences (v)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does `other' contain the same elements?
		use
			use_own_representation: representation
		local
			old_position_1, old_position_2: CC_CURSOR_POSITION
		do
			if Current = other then
				Result := True
			else
				Result := (is_empty = other.is_empty) and
						(object_comparison = other.object_comparison) and
						(count = other.count)
				if Result and not is_empty then
					old_position_1 ?= cursor_position
					old_position_2 ?= other.cursor_position
					check
						cursors_exist: old_position_1 /= Void and old_position_2 /= Void
							-- Because every list contains a cursor object
					end

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
					go_to (old_position_1)
					other.go_to (old_position_2)
				elseif is_empty and other.is_empty and
					object_comparison = other.object_comparison then
					Result := True
				end
			end
		ensure then
			indices_unchanged:
				index = old index and other.index = old other.index
			true_implies_same_size: Result implies count = other.count
			models_are_equal: Result = (model |=| other.model)
		end

feature -- Cursor movement

	start is
			-- Move cursor to first position.
			-- (No effect if empty)
		do
			if not is_empty then
				go_i_th (1)
			end
		ensure then
			at_first: not is_empty implies is_first
		end

	finish is
			-- Move cursor to last position.
			-- (No effect if empty)
		do
			if not is_empty then
				go_i_th (count)
			end
		ensure then
			at_last: not is_empty implies is_last
		end

	move (i: INTEGER) is
			-- Move cursor `i' positions. The cursor
			-- may end up `off' if the absolute value of `i'
			-- is too big.
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		local
			counter, pos, final: INTEGER
		do
			if i > 0 then
				from
				until
					(counter = i) or else off
				loop
					forth
					counter := counter + 1
				end
			elseif i < 0 then
				final := index + i
				if final <= 0 then
					start
					back
				else
					from
						start
						pos := 1
					until
						pos = final
					loop
						forth
						pos := pos + 1
					end
				end
			end
		ensure
			too_far_right: (old index + i > count) implies exhausted
			too_far_left: (old index + i < 1) implies exhausted
			expected_index: (not exhausted) implies (index = old index + i)
			model_sequence_not_changed: model_sequence |=| old model_sequence
			confined representation
		end

 feature -- Status report

	is_first: BOOLEAN is
			-- Is cursor at first position?
		use
			use_own_representation: representation
		do
			Result := not is_empty and (index = 1)
		ensure
			valid_position: Result implies not is_empty
			model_cursor_corresponds: Result = (model_cursor = 1)
		end

	is_last: BOOLEAN is
			-- Is cursor at last position?
		use
			use_own_representation: representation
		do
			Result := not is_empty and (index = count)
		ensure
			valid_position: Result implies not is_empty
			model_cursor_corresponds: Result = (model_cursor = count)
		end

	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := (index = 0) or (index = count + 1)
		end


	valid_cursor_index (i: INTEGER): BOOLEAN is
			-- Is `i' correctly bounded for cursor movement?
		use
			use_own_representation: representation
		do
			Result := (i >= 0) and (i <= count + 1)
		ensure
			valid_cursor_index_definition: Result = ((i >= 0) and (i <= count + 1))
		end

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

feature -- Element change

	put_i_th (v: like item; i: INTEGER) is
			-- Put `v' at `i'-th position.
		local
			old_position: CC_CURSOR_POSITION
		do
			old_position := cursor_position
			go_i_th (i)
			replace_item_with (v)
			go_to (old_position)
		end

	append (s: CC_SEQUENCE [G]) is
			-- Append a copy of `s'.
		local
			l: like s
			old_position: CC_CURSOR_POSITION
		do
			if s = Current then
				l := s.twin
			else
				l := s
			end

			from
				old_position := cursor_position
				l.start
			until
				l.exhausted
			loop
				extend_end (l.item) -- TODO extend???
				finish
				l.forth
			end
			go_to (old_position)
		end

feature -- Transformation

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		require
			not_off: not off
			valid_index: valid_index (i)
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		local
			old_item, new_item: like item
			old_position: CC_CURSOR_POSITION
		do
			old_position := cursor_position
			old_item := item
			go_i_th (i)
			new_item := item
			replace_item_with (old_item)
			go_to (old_position)
			replace_item_with (new_item)
		ensure
	 		swapped_to_item: item = old i_th (i)
	 		swapped_from_item: i_th (i) = old item
	 		model_corresponds_to: model_sequence.item (i) = old model_sequence.item (model_cursor)
	 		model_corresponds_from: model_sequence.item (model_cursor) = old model_sequence.item (i)
	 		confined representation
		end

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-list beginning at current position
			-- and having min (`n', `from_here') items,
			-- where `from_here' is the number of items
			-- at or to the right of current position.
		require
			not_off_unless_after: off implies after
			valid_subchain: n >= 0
		use
			use_own_representation: representation
		deferred
		ensure
			-- TODO add model contracts - difficult because of finite number of copied elements
		end

invariant

	non_negative_index: index >= 0
	index_small_enough: index <= count + 1
	off_definition: off = ((index = 0) or (index = count + 1))
	isfirst_definition: is_first = ((not is_empty) and (index = 1))
	islast_definition: is_last = ((not is_empty) and (index = count))
	item_corresponds_to_index: (not off) implies (item = i_th (index))
	before_definition: before = (index = 0)
	after_definition: after = (index = count + 1)

end
