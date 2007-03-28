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
			-- Creation procedure.
		do
			--| Add your code here
		end

feature -- DUMP

	foo is
			-- test bla
		use
			-- FRAME expr
		modify
			-- FRAME expr
		local
			gobo_linked_list: DS_LINKED_LIST [INTEGER]
			eiffelBase_linked_list: LINKED_LIST [INTEGER]
			repr: MML_SET [ANY]
		do
			create gobo_linked_list.make
			create eiffelbase_linked_list.make
		ensure
			confined bla -- FRAME expr
		end


end -- class ROOT_CLASS
