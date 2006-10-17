indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_ABSTRACT_TESTER

inherit

	CDD_CONSTANTS

	CONF_ACCESS

feature {NONE} -- Initialization

	make_with_manager (a_manager: like manager) is
			-- Assign `manager' with `a_manager'.
		require
			a_manager_not_void: a_manager /= Void
		do
			manager := a_manager
		ensure
			manager_set: manager = a_manager
		end

feature -- Access

	manager: CDD_MANAGER
			-- Test suite manager

	test_suite: CDD_TEST_SUITE is
			-- Test suite holding all test cases
		do
			Result := manager.test_suite
		ensure
			correct_test_suite: Result = manager.test_suite
		end

	test_case: CDD_TEST_CASE is
			-- Test case currently beeing tested
		require
			running: is_running
		deferred
		ensure
			valid_result: Result /= Void and then test_suite.test_cases.has (Result)
		end

feature -- Status report

	is_running: BOOLEAN is
			-- Are we currently running any tests?
		deferred
		end

feature -- Status setting

	stop is
			-- Stop current work and reset all settings.
		require
			running: is_running
		deferred
		end


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

	conf_factory: CONF_FACTORY is
			-- Shared factory for creating new root classes and targets
		once
			create Result
		end

invariant
	manager_not_void: manager /= Void

end
