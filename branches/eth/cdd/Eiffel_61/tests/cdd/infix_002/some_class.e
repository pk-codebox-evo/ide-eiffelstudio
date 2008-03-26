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

	make is
			--
		do
		end

feature -- Access


feature -- Basic operations

	infix "&bla2blub-bla" (a_root_class: ROOT_CLASS): STRING_8 is
			--
		do

		ensure
			false_postcondition: False
		end

invariant
	always_true: True

end
