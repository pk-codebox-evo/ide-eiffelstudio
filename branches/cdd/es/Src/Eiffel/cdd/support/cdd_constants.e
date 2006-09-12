indexing
	description: "CDD constants"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_CONSTANTS

inherit
	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

feature -- Project

	tests_cluster_name: STRING is "cdd_tests"

	tester_cluster_name: STRING is "cdd_tester"

	tester_target_name: STRING is "cdd_tester"

end
