indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ABS_INT_STORE

inherit
	INT_STORE

create
	make

feature{NONE} -- Initialization

	make is
			-- Creation
		do

		end

feature -- Implementation

	item: INTEGER

	set_item (a_value: INTEGER) is
		do
			item := a_value
		end

end
