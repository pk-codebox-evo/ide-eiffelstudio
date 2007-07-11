indexing
	description: "Objects that represents a integer constant in the expression tree"
	author: "Raphael Mack"
	date: "$Date$"
	revision: "$Revision$"

class
	INT_CONSTANT

inherit
	EXPRESSION

create
	set_value

feature -- Access
	value: INTEGER

feature --
	set_value (v: INTEGER) is
			--  sets the value
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Visitor Pattern
	accept (visitor: EXPRESSION_VISITOR) is
		do
			visitor.process_int_constant (Current)
		end

end
