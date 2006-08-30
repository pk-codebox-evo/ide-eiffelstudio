indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_SHARED_FACTORY


feature -- Factories


	test_case_factory: CDD_TEST_CASE_FACTORY is
			--
		once
			create Result
		end


end
