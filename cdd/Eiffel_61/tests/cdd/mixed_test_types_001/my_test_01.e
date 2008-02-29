indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	cdd_id: "AECD33B6-81C5-410A-9196-D4FB4990B5CA"

class
	MY_TEST_01

inherit
	CDD_TEST_CASE

feature -- Access


	test_string_equal_1 is
			-- test something
		indexing
		 tag: "my_test"
		local
			a: STRING
			b: STRING
		do
			a := "Hello"
			b := "Hallo"

			assert_strings_equal("Equal Strings Must BE", a, b)
		end

	test_string_equal_2 is
			-- test something
		indexing
		 tag: "my_test"
		local
			a: STRING
			b: STRING
		do
			a := "Hello"
			b := "Hello"

			assert_strings_equal("Equal Strings Must BE", a, b)
		end

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

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
