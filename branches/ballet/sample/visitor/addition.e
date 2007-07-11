indexing
	description: "Objects that represents an addition"
	author: "Raphael Mack"
	date: "$Date$"
	revision: "$Revision$"

class
	ADDITION

inherit
	EXPRESSION

create
	make

feature {NONE} -- Initialization

	make (l: EXPRESSION; r: EXPRESSION) is
			-- Initialize `Current' with children `l' and `r'
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			left := l
			right := r
		ensure
			left_set: left = l
			right_set: right = r
		end

feature -- Access
	left: EXPRESSION
	right: EXPRESSION

feature -- Visitor Pattern
	accept (visitor: EXPRESSION_VISITOR) is
			--
		do
			visitor.process_addition (Current)
		end

end
