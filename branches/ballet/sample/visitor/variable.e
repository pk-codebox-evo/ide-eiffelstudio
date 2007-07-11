indexing
	description: "Objects thatrepresents an integer variable"
	author: "Raphael Mack"
	date: "$Date$"
	revision: "$Revision$"

class
	VARIABLE

inherit
	EXPRESSION

create
	make

feature {NONE} -- Initialization

	make (n: STRING) is
			-- Initialize `Current'.
		require
			n_not_void: n /= Void
		do
			name := n
		ensure
			name_set: name = n
		end

feature -- Access

	name: STRING
		-- name of the variable

feature -- Visitor Pattern
	accept (visitor: EXPRESSION_VISITOR) is
			--
		do
			visitor.process_variable (Current)
		end
end
