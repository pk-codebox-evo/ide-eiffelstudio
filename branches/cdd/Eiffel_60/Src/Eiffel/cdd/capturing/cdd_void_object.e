indexing
	description: "Objects that represent reflected Object, which value is Void"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_VOID_OBJECT

inherit
	CDD_OBJECT

feature -- Acess

	identifier: STRING is "Void"
			-- Identifier for `Current'

	is_addressable: BOOLEAN is True
			-- Is `Current' addressable?

end
