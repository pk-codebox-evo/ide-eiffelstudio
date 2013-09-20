note
	description: "Represents an error when establishing a connection."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CONNECTION_ERROR

inherit

	PS_ERROR
	redefine
		description
	end

feature

	description: STRING = "Connection failed"
			-- A human-readable string containing an error description

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_connection_problem (Current)
		end

end
