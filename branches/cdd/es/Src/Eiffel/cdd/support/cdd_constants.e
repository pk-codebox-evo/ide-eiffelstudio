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

	cluster_name: STRING is "cdd_testing"

	target_name: STRING is "cdd_tester"

feature -- Test case creation

	test_cases_path: STRING is "/tests"

	


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
