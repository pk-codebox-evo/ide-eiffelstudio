indexing
	description: "Objects that represents a arithmetic expression"
	author: "Raphael Mack"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EXPRESSION

feature -- Visitor Pattern
	accept (visitor: EXPRESSION_VISITOR) is
			--
		require
			visitor_not_void: visitor /= Void
		deferred
		end
end
