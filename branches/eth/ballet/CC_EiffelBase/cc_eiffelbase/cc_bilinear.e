indexing
	description: "Structures that may be traversed forward and backward"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_BILINEAR [G]

inherit
	CC_LINEAR [G]
		rename
			search as linear_search
		export
			{NONE}
				linear_search
		redefine
			off,
			go_i_th
		end

feature -- Status report

	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := before or after
		end

	before: BOOLEAN is
			-- Is there no valid position to the left of current one?
		use
			use_own_representation: representation
		deferred
		ensure
			model_cursor_corresponds: Result = (model_cursor = 0)
		end

feature -- Cursor movement

	back is
			-- Move to previous position.
		require
			not_before: not before
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
			-- moved_forth_after_start: (not before) implies index = old index - 1
			model_cursor_corresponds: model_cursor = old model_cursor - 1
			model_sequence_not_changed: model_sequence |=| old model_sequence
			confined representation
		end

	go_i_th (i: INTEGER) is
			-- Move internal cursor to `i'-th position. `i' must be a legal
			-- index position (1 <= i <= count)
		local
			difference: INTEGER
		do
			if (i > index) then
				-- i is bigger than current index -> move forward
				from
					difference := i - index
				until
					difference = 0
				loop
					forth
					difference := difference - 1
				end
			else
				-- i is smaller than current index -> move backward
				from
					difference := index - i
				until
					difference = 0
				loop
					back
					difference := difference - 1
				end
			end
		end

feature -- Access

	search (v: like item) is
			-- Move to first position (at or after current
			-- position) where `item' and `v' are equal.
			-- If structure does not include `v' ensure that
			-- `exhausted' will be true.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		do
			-- TODO delete: das ist nötig, da in bilienar das before eingeführt wurde.
			-- deshalb checken ob man before ist und erst dann suchen
			if before and not is_empty then
				forth
			end
			linear_search (v)
		ensure
			models_equal_before_after: model_sequence |=| old model_sequence
			confined representation
		end

invariant

	not_both: not (after and before)
	before_constraint: before implies off

end
