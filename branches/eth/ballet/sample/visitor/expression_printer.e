indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXPRESSION_PRINTER

inherit
	EXPRESSION_ITERATOR
		redefine
			make,
			process_int_constant,
			process_variable,
			process_addition
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do

		end

feature -- Access
	output: STRING

feature -- Visitor Pattern
	process_int_constant (node: INT_CONSTANT) is
			-- process node
		do
			output := node.value.out
		end

	process_addition (node: ADDITION) is
			-- process node
		local
			l, r: STRING
		do
			node.left.accept (Current)
			l := output
			node.right.accept (Current)
			r := output
			output := l
			output.append (" + ")
			output.append (r)
		end

	process_variable (node: VARIABLE) is
			-- process node
		do
			output := node.name.twin
		end
end
