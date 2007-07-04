indexing
	description	: "System's root - provides some test cases for the new CC_EiffelBase Library"
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
			io.put_string ("Testing CC_LINKED_LIST%N")
			test_cc_linked_list

			-- test linked_list from EiffelBase
			io.put_string ("Testing LINKED_LIST%N")
		end

feature -- Testing

	test_cc_linked_list is
			-- Test the linked list from the CC_EiffelBase library.
		local
			linked_list: CC_LINKED_LIST [INTEGER]
			second_linked_list : CC_LINKED_LIST [INTEGER]
			counter: INTEGER
		do
			create linked_list.make

			from
				counter := 0
			until
--				counter > 1000000
				counter > 2
			loop
				linked_list.put_at_end (counter)
				counter := counter + 1
			end

			io.put_string ("List with some elements%N")
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
				a_list.forth
			end
			io.put_new_line
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
				a_list.forth
			end
			io.put_new_line
		end

end -- class ROOT_CLASS
