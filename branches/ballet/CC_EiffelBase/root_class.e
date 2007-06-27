indexing
	description	: "System's root class aka Dump"
	author: "Marco Zietzling"
	copyright: "Copyright (c) 2007, Marco Zietzling"
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_CLASS

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			-- test cc_linked_list from CC_EiffelBase
			test_cc_linked_list

			-- test linked_list from EiffelBase
		end

feature -- Testing

	test_cc_linked_list is
			-- Test the linked list from the CC_EiffelBase library.
		local
			linked_list: CC_LINKED_LIST [INTEGER]
			second_linked_list : CC_LINKED_LIST [INTEGER]
		do
			create linked_list.make
			linked_list.put_front (4)
			linked_list.put_front (3)
			linked_list.put_front (2)
			linked_list.put_front (1)

			io.put_string ("List with some elements%N")
			print_cc_linked_list (linked_list)

			linked_list.start
			second_linked_list := linked_list.duplicate (3)

			io.put_string ("Duplicated list with three elements%N")
			print_cc_linked_list (second_linked_list)

			linked_list.append (second_linked_list)

			io.put_string ("Appended list%N")
			print_cc_linked_list (linked_list)
		end

	test_linked_list is
			-- Test the linked list from the EiffelBase library.
		local
			linked_list: LINKED_LIST [INTEGER]
			second_linked_list : LINKED_LIST [INTEGER]
		do
			create linked_list.make
		end

feature -- Printing

	print_cc_linked_list (a_list: CC_LINKED_LIST [INTEGER]) is
			-- Prints the contents of `a_list'
		do
			from
				a_list.start
			until
				a_list.off
			loop
				io.put_string (a_list.item.out + " ")
			end
		end

	print_linked_list (a_list: LINKED_LIST [INTEGER]) is
			-- Prints the contents of `a_list'
		do
			from
				a_list.start
			until
				a_list.off
			loop
				io.put_string (a_list.item.out + " ")
			end
		end

end -- class ROOT_CLASS
