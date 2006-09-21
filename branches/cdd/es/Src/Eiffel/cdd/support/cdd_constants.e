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

	tester_target_name: STRING is "cdd_tester"

	root_class_name: STRING is "CDD_INTERPRETER"

	root_class_feature_name: STRING is "make"

end
