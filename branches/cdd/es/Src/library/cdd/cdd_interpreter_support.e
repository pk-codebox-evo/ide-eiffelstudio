indexing
	description: "Objects that support CDD_INTERPRETER"

class
	CDD_INTERPRETER_SUPPORT

inherit
	EXECUTION_ENVIRONMENT

feature

	run_test (a_test: CDD_SHARED_TESTING) is
			-- run 'a_test'
		do
			if not retried then
				a_test.test_feature
				io.put_string ("PASSED")
			else
				io.put_string ("FAILED")
			end
		rescue
			retried := True
			retry
		end

	retried: BOOLEAN


end -- Class CDD_INTERPRETER_SUPPORT