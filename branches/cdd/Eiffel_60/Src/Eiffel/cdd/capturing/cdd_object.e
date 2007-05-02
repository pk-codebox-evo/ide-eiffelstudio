indexing
	description: "Objects that represent an debugged object"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_OBJECT

feature -- Access

	identifier: STRING
			-- Identifier for later refering to the object within a test case
		deferred
		end

	is_addressable: BOOLEAN is
			-- Is `current' addressable?
		deferred
		end

end
