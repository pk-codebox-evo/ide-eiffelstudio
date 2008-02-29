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
			-- Fail with a precondition violation.
		require
			false_precondition: True
		do
			foo
		ensure
			postcondition: True
		end

	foo is
			-- Fail with a precondition violation.
		require
			false_precondition: True
		do
			foobar
		ensure
			postcondition: True
		end

	foobar is
			-- Fail with a precondition violation.
		require
			false_precondition: False
		do

		ensure
			postcondition: True
		end

end
