indexing
	description: "visitor for EXPRESSIONS"
	author: "Raphael Mack"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EXPRESSION_VISITOR

feature
	process_int_constant (node: INT_CONSTANT) is
			-- process node
		require
			a_node_not_void: node /= Void
		deferred
		end

	process_addition (node: ADDITION) is
			-- process node
		require
			a_node_not_void: node /= Void
		deferred
		end

	process_variable (node: VARIABLE) is
			-- process node
		require
			a_node_not_void: node /= Void
		deferred
		end

end
