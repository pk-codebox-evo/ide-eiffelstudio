indexing
	description: "Objects that represent a test case within a tree structure"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TREE_TEST_CASE_ITEM

inherit
	CDD_TREE_ITEM [CDD_TEST_CASE]
		rename
			data as test_case
		redefine
			make
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
			-- Set 'text', 'tooltip' and 'pixmap' of item.
		require else
			a_test_case_not_void: a_test_case /= Void
		do
			Precursor (a_test_case)
			set_text (test_case.test_class.name)
			set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)
		ensure then
			text_set: text /= Void
			tooltip_set: tooltip /= Void
			pixmap_set: pixmap /= Void
		end

invariant
	test_case_not_void: test_case /= Void

end
