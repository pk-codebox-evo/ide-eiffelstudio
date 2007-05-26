indexing
	description: "Objects that execute cdd test cases"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_CASE_EXECUTOR

inherit

	EXCEPTIONS
		export
			{NONE} all
		end

create
	make_with_test_case

feature {NONE} -- Initialization

	make_with_test_case (a_test_case: like test_case) is
			-- Initialize `test_case' and execute it.
		require
			a_test_case_not_void: a_test_case /= Void
		do
			test_case := a_test_case
		ensure
			test_case_set: test_case = a_test_case
		end

feature -- Access

	test_case: CDD_ABSTRACT_TEST_CASE
		-- Test case to be executed

	failed: BOOLEAN
		-- Did an exception occur while testing `test_case'?

	reason: INTEGER
		-- Reason of failure

	message: STRING
		-- Message saying what failed during execution

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

	execute is
			-- Run `test_case'.
		do
			set_up
			if not failed then
				run
			end
			if not failed then
				tear_down
			end
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	rescue_current_operation is
			-- Assign exception values to `message' and `reason'.
			-- Set `failed' to `True'.
		do
			failed := True
			if tag_name /= Void and then not tag_name.is_empty then
				create message.make_from_string (tag_name)
			else
				message := "no information available"
			end
			reason := exception
		end

	set_up is
			-- Set up `test_case'.
		do
			if not failed then
				test_case.set_up
			end
		rescue
			rescue_current_operation
			retry
		end

	run is
			-- Run `test_case'.
		do
			if not failed then
				--test_case.run
			end
		rescue
			rescue_current_operation
			retry
		end

	tear_down is
			-- Tear down `test_case'.
		do
			if not failed then
				test_case.tear_down
			end
		rescue
			rescue_current_operation
			retry
		end

invariant
	test_case_not_void: test_case /= Void
	failed_implies_message_not_empty: failed implies (message /= Void and then not message.is_empty)

end
