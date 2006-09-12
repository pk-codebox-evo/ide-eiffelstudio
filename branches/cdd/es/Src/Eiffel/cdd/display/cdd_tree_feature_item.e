indexing
	description: "Objects that represent a feature name within a tree structure"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TREE_FEATURE_ITEM

inherit
	CDD_TREE_ITEM [STRING]
		rename
			data as feature_name
		redefine
			make
		end

	CDD_TREE_HELPER [CDD_TEST_CASE, CDD_TREE_TEST_CASE_ITEM]
		undefine
			default_create,
			is_equal,
			copy
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

	make (a_name: like feature_name) is
			-- Set 'text', 'tooltip' and 'pixmap' of item.
		require else
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			Precursor (a_name)
			set_text (feature_name)
			set_tooltip (feature_name)
			set_pixmap (pixmaps.icon_pixmaps.tool_feature_icon)
		ensure then
			text_set: text /= Void
			tooltip_set: tooltip /= Void
			pixmap_set: pixmap /= Void
		end

feature -- Element change

	add_test_case (a_tc: CDD_TEST_CASE) is
			-- Add 'a_tc' to tree structure
		require
			a_tc_not_void: a_tc /= Void
		local
			l_tree: CDD_TREE
		do
			locate_item (a_tc)
			last_located_item.add_test_case (a_tc)
			update_text
		end

	remove_test_case (a_tc: CDD_TEST_CASE) is
			-- Remove 'a_tc' from tree structure
		require
			a_tc_not_void: a_tc /= Void
		do
			locate_item (a_tc)
			prune (last_located_item)
			update_text
		end

feature -- Element change

	new_item (a_tc: CDD_TEST_CASE): CDD_TREE_TEST_CASE_ITEM is
			-- Create new tree item for displaying 'a_tc'.
		require else
			correct_feature: a_tc.feature_name.is_equal (feature_name)
		do
			create Result.make (a_tc)
		end

feature {NONE} -- Implementation

	update_text is
			-- Update 'text' with new item count.
		do
			set_text (feature_name + " (" + count.out + ")")
		end


end

