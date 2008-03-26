indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SOME_CLASS

create
	make

feature -- Initialize

	make (a_val: INTEGER; an_array: ARRAY[LINKED_LIST[BOOLEAN_REF]]; a_stack: STACK [DOUBLE]) is
			--
		do
			field := a_val
			field_array := an_array
			field_stack := a_stack
		ensure
			false_postcondition:  False
		end

feature -- Access

	field: INTEGER
	field_array: ARRAY[LINKED_LIST[BOOLEAN_REF]]
	field_stack: STACK [DOUBLE]

feature -- Basic operations

	set_field (a_val: INTEGER) is
			--
		require
			precondition: True
		do
			field := a_val
		ensure
			field_set: True
		end

invariant
	always_true: True

end
