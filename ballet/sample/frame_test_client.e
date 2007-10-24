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
			frame_not_intersected: a.representation.is_disjoint_from (b.representation)
			a_not_void: a /= Void
			b_not_void: b /= Void
		do
			a.set_item (5)
			b.set_item (3)
			check
				second_value_set: b.item = 3
				first_value_set: a.item = 5
			end
		end

end
