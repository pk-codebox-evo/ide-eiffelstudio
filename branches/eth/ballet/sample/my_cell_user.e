indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MY_CELL_USER

feature

	c: MY_CELL [STRING]

	cell_test is
			-- Test of `c'.
		local
			v: STRING
			i: INTEGER
		do
			create c
			c.set_item ("FOOBAR")
			v := c.item
			i := c.item.count
		end

end
