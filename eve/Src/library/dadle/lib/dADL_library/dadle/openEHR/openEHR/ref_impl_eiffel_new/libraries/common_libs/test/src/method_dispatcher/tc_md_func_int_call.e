indexing
	component:   "openEHR Reusable Libraries"
	description: "Test case for call to integer-returning function"
	keywords:    "test, method dispatcher"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2004 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/common_libs/test/src/method_dispatcher/tc_md_func_int_call.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class TC_MD_FUNC_INT_CALL

inherit
	SHARED_TEST_ENV
	TEST_CASE
		redefine
			check_result
		end

creation
	make

feature -- Initialisation

	make(arg:ANY) is
		do
		end

feature -- Access

	title:STRING is "Function call - FUNC <STRING> : INTEGER"

feature -- testing

	execute is
		local
			arg, feat_name:STRING
			call_result:INTEGER
		do
			feat_name := "occurrences"
			arg := "4 - list"

			-- print out old list
			io.put_string("Initial list contents:%N" + print_list(string_list))

			io.put_string("Verifying %"string_list." + feat_name + " is valid: " + 
				method_dispatcher.is_valid_feature(string_list.generating_type, feat_name).out + "%N")

			io.put_string("Dispatching %"string_list." + feat_name + "(" + arg + ")%"%N")
			call_result := method_dispatcher.dispatch_integer_function(string_list, feat_name, arg)

			io.put_string("Result: " + call_result.out + "%N")

			-- do direct call and compare
			io.put_string("Result using direct call: " + string_list.occurrences(arg).out + "%N")
		end

	check_result is
		do
		end

end
