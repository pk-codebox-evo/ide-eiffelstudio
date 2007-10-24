indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_CLASS

create
	make

feature -- Initialization

	a: INT_STORE
	b: INT_STORE
	t: TOKEN_DISPENSER
	v: VISITOR_TEST

	ft: FRAME_TEST
	ftc: FRAME_TEST_CLIENT

	c: SIMPLE_COUNTER
	m: MY_CELL[ANY]
	mt: MY_CELL_USER
	r: RAMACK_TEST

	create_structure is
			-- Create the object structure.
		local
			abs_store: ABS_INT_STORE
			rel_store: REL_INT_STORE
		do
			create ft.set_item(5)
			create abs_store.make
			create rel_store.make (abs_store)
			a := abs_store
			b := rel_store
		ensure
			a_not_void: a /= Void
			b_not_void: b /= Void
		end

	make is
			-- Creation procedure.
		local
			e1, e2: EXPRESSION
		do
			e1 := create {ADDITION}.make (
					create {ADDITION}.make (create {INT_CONSTANT}.set_value (3), create {INT_CONSTANT}.set_value (4)),
					create {VARIABLE}.make ("a"))

			e2 := create {ADDITION}.make (
					create {ADDITION}.make (create {INT_CONSTANT}.set_value (3), create {INT_CONSTANT}.set_value (4)),
					create {VARIABLE}.make ("a"))

			create v
			v.test (e1, e2)
--			create_structure
--			b.set_item (11)
--			a.set_item (22)

--			print ("Item of A: " + a.item.out + "%N")
--			print ("Item of B: " + b.item.out + "%N")
		end

	copy_item (x,y: INT_STORE) is
			-- Copy value of `x' to `y'.
		do
			make
			copy_item (x,y)
			x.set_item (y.item)
		ensure
			values_copied: x.item = y.item
		end


end -- class ROOT_CLASS
