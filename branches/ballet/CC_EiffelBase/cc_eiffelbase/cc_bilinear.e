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
			off
		end

feature -- Status report

	off: BOOLEAN is
			-- Is there no current item?
		use
			use_own_representation: representation
		do
			Result := before or after
		end

	before: BOOLEAN is
			-- Is there no valid position to the left of current one?
		use
			use_own_representation: representation
		deferred
		end

feature -- Cursor movement

	back is
			-- Move to previous position.
		require
			not_before: not before
		modify
			modify_own_representation: representation
		deferred
		ensure then
			-- moved_forth_after_start: (not before) implies index = old index - 1
			models_equal_before_after: model_sequence |=| old model_sequence -- TODO nötig? wenn ja dann auch im linear und traversable
		end

feature -- Access

	search (v: like item) is
			-- Move to first position (at or after current
			-- position) where `item' and `v' are equal.
			-- If structure does not include `v' ensure that
			-- `exhausted' will be true.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
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
		end

invariant

	not_both: not (after and before)
	before_constraint: before implies off

end
