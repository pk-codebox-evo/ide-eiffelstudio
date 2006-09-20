indexing
	description: "Objects that support CDD_INTERPRETER"

class
	CDD_INTERPRETER_SUPPORT

inherit
	EXECUTION_ENVIRONMENT

	EXCEPTIONS

feature

	run_test (a_test: CDD_SHARED_TESTING) is
			-- run 'a_test'
		do
			if not retried then
				io.put_string ("Testing ")
				io.put_string (a_test.generator)
				io.put_string ("...%N%T%T%T")
				a_test.test_feature
				io.put_string ("[PASSED]%N")
			else
				io.put_string ("[FAILED (" + exception.out + ")]%N")
				die (1)
			end
		rescue
			retried := True
			retry
		end

	retried: BOOLEAN


end -- Class CDD_INTERPRETER_SUPPORT
