indexing
	description: "Represents the outcome and log of a test case execution"
	author: "aleitner"
	date: "$Date$"
	revision: "$Revision$"

class CDD_TEST_EXECUTION_RESPONSE

inherit

	KL_SHARED_EXCEPTIONS
		redefine
			out
		end

create
	make

feature {NONE} -- Initialization

	make (a_setup_response: CDD_ROUTINE_INVOCATION_RESPONSE;
			a_test_response: CDD_ROUTINE_INVOCATION_RESPONSE;
			a_teardown_response: CDD_ROUTINE_INVOCATION_RESPONSE) is
					-- Create a new response.
		require
			a_test_response_good: (a_setup_response /= Void and then a_setup_response.is_normal) = (a_test_response /= Void)
			a_teardonwn_response_good: (a_test_response /= Void and then not a_test_response.is_bad) = (a_teardown_response /= Void)
		do
			setup_response := a_setup_response
			test_response := a_test_response
			teardown_response := a_teardown_response
		ensure
			setup_response_set: setup_response = a_setup_response
			test_response_set: test_response = a_test_response
			teardown_response_set: teardown_response = a_teardown_response
		end

feature {ANY} -- Status report

	is_pass: BOOLEAN is
			-- Did the implementation under test pass the test case?
		do
			Result := test_response /= Void and then test_response.is_normal
		end

	is_fail: BOOLEAN is
			-- Did the implementation under test fail the test case?
		do
			Result := test_response /= Void and then test_response.is_exceptional and not has_bad_context
		end

	is_unresolved: BOOLEAN is
			-- Is the test judgment unresolvable?
		do
			Result := not (is_fail or is_pass)
		end

	requires_maintenance: BOOLEAN is
			-- Does the test case need to be fixed?
		do
			Result := has_compile_error or has_bad_context or has_bad_communication
		end

	has_compile_error: BOOLEAN is
			-- Does the test case produce a compiler error?
		do
			Result := setup_response = Void
		end

	has_bad_context: BOOLEAN is
			-- Does the test case seem to have an invalid context?
			-- This is the case when
			-- 1) the precondition of the routine under test is violated
			-- 2) the invariant of the input data is violated (this is a complicated case)
			-- 3) the execution of `setup' raised an exception
			-- Note about 2) A naive definitoin of an invariant for the input data set
			-- would be that the invariant has to hold for all objects in the set.
			-- Due to the dependant delegate issue (invariant violation on callback)
			-- this definition is too simplistic. The defintion used for this implementation
			-- is that the invariant has to hold for all objects that were not target to
			-- an executing routine at the time of the failure. Such objects are marked
			-- with a flag in the test case.
		do
			Result := setup_response /= Void and then setup_response.is_exceptional
			if not Result then
				if test_response /= Void and then test_response.is_exceptional then
					Result := test_response.exception.trace_depth = 1 and then
								test_response.exception.exception_code = exceptions.precondition
				end
			end
		end

	has_bad_communication: BOOLEAN is
			-- Was the communication between master and client outside of its specification?
		do
			Result := setup_response /= Void and then (setup_response.is_bad or
				(setup_response.is_normal and then (test_response.is_bad or else teardown_response.is_bad)))
		end

	has_timeout: BOOLEAN
			-- Was the test case execution aborted due to a time-out?


	matches_original_outcome (an_original_outcome: CDD_ORIGINAL_OUTCOME): BOOLEAN is
			-- Does `Current' match `an_original_outcome'?
		require
			an_original_outcome_not_void: an_original_outcome /= Void
		local
			l_tag: STRING
		do
			if is_unresolved then
				Result := False
			elseif is_pass then
				Result := an_original_outcome.is_passing
			else
					-- The parser returns multiline values with a trailing new line. This has to be removed for comparison.
				l_tag := test_response.exception.exception_tag_name.twin
				l_tag.prune_all_trailing ('%N')
				Result := an_original_outcome.is_failing and then
							(test_response.exception.exception_code = an_original_outcome.exception_code) and then
							(test_response.exception.exception_recipient_name.is_equal (an_original_outcome.exception_recipient_name)) and then
-- TODO investigate "strange" breakpoint index of AUT_EXCEPTION		(test_response.exception.exception_break_point_slot = an_original_outcome.exception_break_point_slot) and then
							(test_response.exception.exception_class_name.is_equal (an_original_outcome.exception_class_name)) and then
							(l_tag.is_equal (an_original_outcome.exception_tag_name))
			end
		end

feature {ANY} -- Access

	setup_response: CDD_ROUTINE_INVOCATION_RESPONSE
			-- Response from test setup

	test_response: CDD_ROUTINE_INVOCATION_RESPONSE
			-- Response from actual test routine

	teardown_response: CDD_ROUTINE_INVOCATION_RESPONSE
			-- Response from test teardown

	text: STRING is
			-- Textual description of kind of outcome;
			-- I.e.: "pass", "fail", "unresolved"
		do
			if is_pass then
				Result := "pass"
			elseif is_fail then
				Result := "fail"
			elseif is_unresolved then
				Result := "unresolved"
			else
				check
					dead_end: False
				end
			end
		ensure
			text_not_void: Result /= Void
		end

feature -- Element change

	set_timeout is
			-- Set `has_timeout' to True.
		require
			requires_maintenance: requires_maintenance
		do
			has_timeout := True
		ensure
			has_timeout: has_timeout
		end

feature -- Output

	out: STRING is
			-- String representation of `Current'.
		do
			create Result.make_empty
			Result.append ("Conclusion:%N%T" + text.as_upper)
			if setup_response /= Void then
				Result.append ("%N%NSetup " + setup_response.out)
				if test_response /= Void then
					Result.append ("%NTest " + test_response.out)
					if teardown_response /= Void then
						Result.append ("%NTeardown " + teardown_response.out)
					end
				end
			end
			if requires_maintenance then
				Result.append ("%N%NRequires maintenance because of:%N%T")
				if has_timeout then
					Result.append ("time out")
				elseif has_bad_communication then
					Result.append ("bad communication")
				elseif has_bad_context then
					Result.append ("bad input")
				else
					Result.append ("compile error")
				end
			end
		end

	out_short: STRING is
			-- Short string representation of `Current'.
		do
			create Result.make_empty
			Result.append ("Conclusion:%N%T" + text.as_upper)
			if setup_response /= Void then
				Result.append ("%N%NSetup " + setup_response.out_short)
				if test_response /= Void then
					Result.append ("%NTest " + test_response.out_short)
					if teardown_response /= Void then
						Result.append ("%NTeardown " + teardown_response.out_short)
					end
				end
			end
			if requires_maintenance then
				Result.append ("%N%NRequires maintenance because of:%N%T")
				if has_timeout then
					Result.append ("time out")
				elseif has_bad_communication then
					Result.append ("bad communication")
				elseif has_bad_context then
					Result.append ("bad input")
				else
					Result.append ("compile error")
				end
			end
		end

	out_trace: STRING is
			-- Returns all stack traces of outcome if available.
		do
			Result := ""
			if setup_response.is_exceptional then
				Result.append ("[setup]%N")
				Result.append (setup_response.exception.exception_trace)
			end
			if test_response.is_exceptional then
				Result.append ("[test]%N")
				Result.append (test_response.exception.exception_trace)
			end
			if teardown_response.is_exceptional then
				Result.append ("[teardown]%N")
				Result.append (teardown_response.exception.exception_trace)
			end
		end

feature {NONE} -- Assertion helpers

	one_of (a: BOOLEAN; b: BOOLEAN; c: BOOLEAN): BOOLEAN
		-- Is exactly one out of the three variables `a', `b', `c' true?
		do
			Result := (a xor b xor c) and not (a and b and c)
		ensure
			definition: (a xor b xor c) and not (a and b and c)
		end

invariant

	setup_normal_equals_test_not_void: (setup_response /= Void and then setup_response.is_normal) = (test_response /= Void)
	test_normal_equals_teardown_not_void: (test_response /= Void and then not test_response.is_bad) = (teardown_response /= Void)
	unresolved_implies_maintenance: is_unresolved implies requires_maintenance
	one_of_fail_pass_unresolved: one_of (is_pass, is_fail, is_unresolved)
	maintenance_implies_one_error: requires_maintenance implies (one_of (has_compile_error, has_bad_context, has_bad_communication))
	not_requires_maintenance_implies_no_error: not requires_maintenance implies not (has_compile_error or has_bad_context or has_bad_communication)
	timeout_requires_bad_communication: (has_timeout implies has_bad_communication) and (not has_bad_communication implies not has_timeout)

end
