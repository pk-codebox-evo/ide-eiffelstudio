indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_CLASS

create
	make

feature -- Initialization

	make is
		do
			bar
		end

	bar is
			-- Fail with a postcondition violation.
		require
			precondition: True
		local
			l_stack: ARRAYED_STACK [REAL_64]
			l_list: LINKED_LIST [BOOLEAN_REF]
			l_array: ARRAY [LINKED_LIST [BOOLEAN_REF]]
		do
			create l_stack.make (5)
			l_stack.put (3.4445)
			l_stack.put (0.00004)

			create l_list.make
			create l_array.make (1, 15)
			l_array.put (l_list, 10)

			create some_class.make (-10, l_array, l_stack)
		ensure
			postcondition: True
		end

feature -- Access

	some_class: SOME_CLASS

invariant
	no_inv: True

end
