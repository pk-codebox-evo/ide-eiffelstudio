indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_CASE

create
	make

feature {NONE} -- Initialization

	make (a_dclass: EIFFEL_CLASS_C; a_feature: E_FEATURE; a_class_name: STRING; a_file_name: STRING) is
			--
		do
			dclass := a_dclass
			e_feature := a_feature
			test_case_class_name := a_class_name
			file_name := a_file_name
		end


feature -- Access

	dclass: EIFFEL_CLASS_C

	e_feature: E_FEATURE

	test_case_class_name: STRING

	file_name: STRING

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
