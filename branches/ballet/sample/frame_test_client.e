indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FRAME_TEST_CLIENT

feature
	test (a, b: FRAME_TEST) is
		require
			frame_not_intersected: a.representation.intersected (b.representation).is_empty
		do
			a.set_item (5)
			b.set_item (3)
			check
				a.item = 5
			end
		end

end
