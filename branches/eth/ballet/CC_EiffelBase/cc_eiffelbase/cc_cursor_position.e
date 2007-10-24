indexing
	description: "Cursor position for remembering positions in arbitrary data structures"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_CURSOR_POSITION

inherit
	CC_ANY

feature -- Model

	model: INTEGER is
			-- Model of a general cursor position.
		use
			use_own_representation: representation
		deferred
		ensure
			result_not_void: Result /= Void
		end

feature -- Framing

	representation: FRAME is
			-- Representation of a general cursor position.
		use
			use_own_representation: representation
		do
			create Result.make_empty
			Result := Result.extended (Current)
		ensure
			result_not_void: Result /= Void
		end

end
