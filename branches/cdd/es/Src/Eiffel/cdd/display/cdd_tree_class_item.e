indexing
	description: "Objects that represent a class within a tree structure"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TREE_CLASS_ITEM

inherit
	CDD_TREE_ITEM [EIFFEL_CLASS_I]
		rename
			data as target_class
		redefine
			make
		end

	CDD_TREE_HELPER [STRING, CDD_TREE_FEATURE_ITEM]
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

	make (a_class: like target_class) is
			-- Set 'text', 'tooltip' and 'pixmap' of item.
		require else
			a_class_not_void: a_class /= Void
		do
			Precursor (a_class)
			set_text (target_class.name)
			set_tooltip (target_class.name)
			set_pixmap (pixmaps.icon_pixmaps.tool_class_icon)
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
		do
			locate_item (a_tc.feature_name)
			last_located_item.add_test_case (a_tc)
		end

	remove_test_case (a_tc: CDD_TEST_CASE) is
			-- Remove 'a_tc' from tree structure
		require
			a_tc_not_void: a_tc /= Void
		do
			locate_item (a_tc.feature_name)
			last_located_item.remove_test_case (a_tc)
			if last_located_item.is_empty then
				prune (last_located_item)
			end
		end

feature -- Element change

	new_item (a_name: STRING): CDD_TREE_FEATURE_ITEM is
			-- Create new tree item for displaying 'a_tc'.
		require else
			a_name_not_empty: not a_name.is_empty
		do
			create Result.make (a_name)
		end

invariant
	target_class_not_void: target_class /= Void

end
