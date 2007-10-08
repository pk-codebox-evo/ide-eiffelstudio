indexing
	description: "[
			Objects that print root class for executing test cases. All test
			cases in system shall be created through this class.
		]"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_ROOT_CLASS_PRINTER

inherit

	CDD_CLASS_PRINTER

create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite) is
			-- Set `test_suite' to `a_test_suite'.
		require
			a_test_suite_not_void: a_test_suite /= Void
		do
			test_suite := a_test_suite
			internal_refresh_agent := agent print_root_class
			test_suite.refresh_actions.extend (internal_refresh_agent)
		ensure
			test_suite_set: test_suite = a_test_suite
		end

feature -- Access

	test_suite: CDD_TEST_SUITE
			-- Test suite containing test cases for root class

feature -- Measurement

feature -- Status report

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

	print_root_class is
			-- Print a new root class containing all test cases in `test_suite'.
		do

		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	internal_refresh_agent: PROCEDURE [like Current, TUPLE]

invariant
	test_suite_not_void: test_suite /= Void
	internal_refresh_agent_not_void: internal_refresh_agent /= Void
	subscribed: test_suite.refresh_actions.has (internal_refresh_agent)

end
