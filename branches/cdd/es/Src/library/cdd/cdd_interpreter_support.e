indexing
	description: "Objects that support CDD_INTERPRETER"

class
	CDD_INTERPRETER_SUPPORT

inherit
	EXECUTION_ENVIRONMENT

	EXCEPTIONS

feature

	run_test (a_test_case: CDD_SHARED_TESTING) is
			-- Run `a_test' and print results to console
		require
			a_test_case_not_void: a_test_case /= Void
		do
			io.put_string ("%N%NTesting ")
			io.put_string (a_test_case.generator)
			io.put_string ("%N")

			a_test_case.test_feature

			io.put_string ("%N[PASSED]")
		rescue
			io.put_string ("%N[FAILED]%N" + original_class_name)
			io.put_string ("." + original_recipient_name + ".")
			if tag_name = Void then
				io.put_string ("unknown")
			else
				io.put_string (tag_name)
			end
			die (exception)
		end

end -- Class CDD_INTERPRETER_SUPPORT
