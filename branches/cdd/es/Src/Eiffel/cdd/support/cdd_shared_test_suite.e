indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_SHARED_TEST_SUITE

feature -- Access

	test_suite: CDD_TEST_SUITE is
			--
		once
			create Result.make
		end


end
