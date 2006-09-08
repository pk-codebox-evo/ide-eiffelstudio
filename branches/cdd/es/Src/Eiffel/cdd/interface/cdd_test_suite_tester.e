indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE_TESTER

inherit

	THREAD

	CDD_CONSTANTS

feature -- Access

	test_suite: CDD_TEST_SUITE

feature -- Execution

	execute is
			-- Start testing process
		require else
			can_execute: test_suite.can_be_tested
		do
			if ec_launcher = Void then
				create ec_launcher.make_with_target (test_suite.tester_target)
			end
			ec_launcher.launch (False, True)
		end


feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	set_test_suite (a_test_suite: like test_suite) is
			--
		require
			a_test_suite_not_void: a_test_suite /= Void
		do
			test_suite := a_test_suite
		ensure
			test_suite_set: test_suite = a_test_suite
		end


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

	ec_launcher: CDD_EC_LAUNCHER

invariant
	invariant_clause: True -- Your invariant here

end
