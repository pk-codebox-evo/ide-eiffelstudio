indexing
	description: "Finite structures whose items may be accessed sequentially, one-way"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_LINEAR [G]

inherit
	CC_TRAVERSABLE [G]
		redefine
			do_all,
			do_if,
			there_exists,
			for_all
		end

feature -- Access

	has (v: like item): BOOLEAN is
			-- Does structure include an occurrence of `v'?
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			old_index: INTEGER
		do
			old_index := index

			start
			if not off then
				search (v)
			end
			Result := not exhausted

			go_i_th (old_index) -- restore internal cursor position
		end

	index_of (v: like item; i: INTEGER): INTEGER is
			-- Index of `i'-th occurrence of `v'.
			-- 0 if none.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		require
			positive_occurrences: i > 0
		use
			use_own_representation: representation
		local
			occur, pos, old_index: INTEGER
		do
			old_index := index

			if object_comparison and v /= Void then
				from
					start
					pos := 1
				until
					exhausted or (occur = i)
				loop
					if item /= Void and then v.is_equal (item) then
						occur := occur + 1
					end
					forth
					pos := pos + 1
				end
			else
				from
					start
					pos := 1
				until
					exhausted or (occur = i)
				loop
					if item = v then
						occur := occur + 1
					end
					forth
					pos := pos + 1
				end
			end
			if occur = i then
				Result := pos - 1
			end

			go_i_th (old_index)
		ensure
			non_negative_result: Result >= 0
			-- TODO model contracts here!
		end

	search (v: like item) is
			-- Move to first position (at or after current
			-- position) where `item' and `v' are equal.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- If no such position ensure that `exhausted' will be true.
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		do
			if object_comparison and v /= Void then
				from
				until
					exhausted or else (item /= Void and then v.is_equal (item))
				loop
					forth
				end
			else
				from
				until
					exhausted or else v = item
				loop
					forth
				end
			end
		ensure
			object_found: (not exhausted and object_comparison)
				 implies equal (v, item)
			item_found: (not exhausted and not object_comparison)
				 implies v = item
			models_equal_before_after: model_sequence |=| old model_sequence
			confined representation
		end

	index: INTEGER is
			-- Index of current position
		use
			use_own_representation: representation
		deferred
		end

	occurrences (v: like item): INTEGER is
			-- Number of times `v' appears.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		use
			use_own_representation: representation
		local
			old_index: INTEGER
		do
			old_index := index

			from
				start
				search (v)
			until
				exhausted
			loop
				Result := Result + 1
				forth
				search (v)
			end

			go_i_th (old_index)
		ensure
			model_corresponds: Result = model_sequence.occurrences (v)
		end

feature -- Status report

	exhausted: BOOLEAN is
			-- Has structure been completely explored?
		use
			use_own_representation: representation
		do
			Result := off
		ensure
			exhausted_when_off: off implies Result
		end

	after: BOOLEAN is
			-- Is there no valid position to the right of current one?
		use
			use_own_representation: representation
		deferred
		ensure
			model_cursor_corresponds: Result = (model_cursor = count + 1)
		end

	off: BOOLEAN is
			-- Is there no current item?
		use
			use_own_representation: representation
		do
			Result := is_empty or after
		end

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within allowable bounds?
		use
			use_own_representation: representation
		do
			Result := 1 <= i and i <= count
		ensure
			valid_index_definition: Result = (1 <= i and i <= count)
		end

feature -- Cursor movement

	finish is
			-- Move to last position.
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
			model_cursor_corresponds: not is_empty implies (model_cursor = count)
			model_sequence_not_changed: model_sequence |=| old model_sequence
			confined representation
		end

	forth is
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		require
			not_after: not after
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
			-- moved_forth_before_end: (not after) implies index = old index + 1
			model_cursor_corresponds: (not after) implies (model_cursor = old model_cursor + 1)
			model_sequence_not_changed: model_sequence |=| old model_sequence
			confined representation
		end

	go_i_th (i: INTEGER) is
			-- Move internal cursor to `i'-th position. `i' must be a legal
			-- index position (1 <= i <= count)
		require
			valid_index: valid_index (i)
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		local
			position: INTEGER
		do
			from
				start
				position := 1
			until
				position = i
			loop
				forth
				position := position + 1
			end
		ensure
			position_expected: index = i
			model_cursor_corresponds: model_cursor = i
			model_sequence_not_changed: model_sequence |=| old model_sequence
			confined representation
		end

feature -- Iteration

	do_all (action: PROCEDURE [ANY, TUPLE [G]]) is
			-- Apply `action' to every item.
			-- Semantics not guaranteed if `action' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
		local
			t: TUPLE [G]
			cs: CURSOR_STRUCTURE [G]
			c: CURSOR
		do
			cs ?= Current
			if cs /= Void then
				c := cs.cursor
			end

			create t
			from
				start
			until
				after
			loop
				t.put (item, 1)
				action.call (t)
				forth
			end

			if cs /= Void then
				cs.go_to (c)
			end
		end

	do_if (action: PROCEDURE [ANY, TUPLE [G]]; test: FUNCTION [ANY, TUPLE [G], BOOLEAN]) is
			-- Apply `action' to every item that satisfies `test'.
			-- Semantics not guaranteed if `action' or `test' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
		local
			t: TUPLE [G]
			cs: CURSOR_STRUCTURE [G]
			c: CURSOR
		do
			cs ?= Current
			if cs /= Void then
				c := cs.cursor
			end

			create t
			from
				start
			until
				after
			loop
				t.put (item, 1)
				if test.item (t) then
					action.call (t)
				end
				forth
			end

			if cs /= Void then
				cs.go_to (c)
			end
		end

	there_exists (test: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN is
			-- Is `test' true for at least one item?
			-- Semantics not guaranteed if `test' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
		local
			cs: CURSOR_STRUCTURE [G]
			c: CURSOR
			t: TUPLE [G]
			old_index: INTEGER
		do
			old_index := index

			create t

			cs ?= Current
			if cs /= Void then
				c := cs.cursor
			end

			from
				start
			until
				after or Result
			loop
				t.put (item, 1)
				Result := test.item (t)
				forth
			end

			if cs /= Void then
				cs.go_to (c)
			end

			go_i_th (old_index)
		end

	for_all (test: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN is
			-- Is `test' true for all items?
			-- Semantics not guaranteed if `test' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
		local
			cs: CURSOR_STRUCTURE [G]
			c: CURSOR
			t: TUPLE [G]
			old_index: INTEGER
		do
			old_index := index

			create t

			cs ?= Current
			if cs /= Void then
				c := cs.cursor
			end

			from
				start
				Result := True
			until
				after or not Result
			loop
				t.put (item, 1)
				Result := test.item (t)
				forth
			end

			if cs /= Void then
				cs.go_to (c)
			end

			go_i_th (old_index)
		ensure then
			empty: is_empty implies Result
		end

feature -- Conversion

	linear_representation: CC_LINEAR [G] is
			-- Representation as a linear structure
		do
			Result := Current.twin
		ensure then
			result_corresponds: Result.model |=| model
		end

feature -- Model

	model_cursor: INTEGER is
			-- Model of a cursor for traversal
		do
			Result := index;
		end

invariant

	after_constraint: after implies off
	model_cursor_corresponds: model_cursor = index

	-- TODO additional constraint
	after_constraint_2: after implies exhausted

end
