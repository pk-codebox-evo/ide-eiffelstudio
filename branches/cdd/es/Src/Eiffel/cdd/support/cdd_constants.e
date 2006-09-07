indexing
	description: "Objects that ..."
	author: ""
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

feature -- Test case creation


feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
