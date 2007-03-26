indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MY_CELL[G]

feature -- Init

	make is
			-- Create Cell
		do

		end

feature -- Access

	item: G

feature -- Setting

	set_item (v:G) is
			-- Set item to `v'.
		do
			item := v
		ensure
			set: item = v
		end

end
