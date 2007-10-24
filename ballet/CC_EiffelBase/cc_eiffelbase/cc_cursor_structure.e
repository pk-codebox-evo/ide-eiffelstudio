indexing
	description: "[
		Active structures, which always have a current position
		accessible through a cursor.
		]"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_CURSOR_STRUCTURE [G]

inherit
	CC_ACTIVE [G]

feature -- Access

	cursor_position: CC_CURSOR_POSITION is
			-- Current cursor position.
		use
			use_own_representation: representation
		deferred
		ensure
			cursor_not_void: Result /= Void
		end

feature -- Status report

	valid_cursor_position (p: CC_CURSOR_POSITION): BOOLEAN is
			-- Can the internal cursor be moved to position `p'?
		use
			use_own_representation: representation
		deferred
		end

feature -- Cursor movement

	go_to (p: CC_CURSOR_POSITION) is
			-- Move internal cursor to position `p'.
		require
			cursor_position_valid: valid_cursor_position (p)
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
			confined representation
		end

end
