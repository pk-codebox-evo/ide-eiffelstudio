class MAIN

inherit
	
	INTEGER_STORE_CLIENT
	
create

	make

feature -- Main

	a: INTEGER_STORE
	b: INTEGER_STORE
	
	make is
			-- Main routine, called when the program is executed.
		do
			create b.make (Void)
			create a.make (b)
			
			integer_stores_assign (a,b)
		end
end
