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
		do
			foo
		ensure
			false_postcondition: True
		end

	foo is
			--
		require
			blabla: True
		do
			create some_class.make
			some_class.set_field (-10)
		ensure
			bla: True
		end

feature -- Access

	some_class: SOME_CLASS

invariant
	no_inv: True

end
