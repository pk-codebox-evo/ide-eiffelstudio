indexing
	description: "default visitor implementation for EXPRESSIONS, which visits every node"
	author: "Raphael Mack"
	date: "$Date$"
	revision: "$Revision$"

class
	EXPRESSION_ITERATOR

inherit
	EXPRESSION_VISITOR

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do

		end
feature
	process_int_constant (node: INT_CONSTANT) is
			-- process node
		do
			-- noting to do in leaves
		end

	process_addition (node: ADDITION) is
			-- process node
		do
			node.left.accept (Current)
			node.left.accept (Current)
		end

	process_variable (node: VARIABLE) is
			-- process node
		do
			-- nothing to be done in leaves
		end

end
