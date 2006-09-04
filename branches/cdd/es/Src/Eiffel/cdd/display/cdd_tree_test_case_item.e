indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TREE_TEST_CASE_ITEM

inherit
	CDD_TREE_ITEM
		rename
			data as test_case
		redefine
			make, test_case
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_test_case: like test_case) is
			--
		do
			Precursor (a_test_case)
			set_text (test_case.test_class.name)
			set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)
		end


feature -- Access

	test_case: CDD_TEST_CASE

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
