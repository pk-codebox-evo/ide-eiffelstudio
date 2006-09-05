indexing
	description: "Objects that represent a class within a tree structure"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TREE_CLASS_ITEM

inherit
	CDD_TREE_ITEM
		rename
			data as target_class
		redefine
			make,
			target_class
		end

	CDD_TREE_HELPER
		undefine
			default_create,
			is_equal,
			copy
		redefine
			data_type,
			item_type
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


feature -- Access

	target_class: EIFFEL_CLASS_I
			-- Class displayed in the item

feature -- Element change

	new_item (a_tc: CDD_TEST_CASE): CDD_TREE_TEST_CASE_ITEM is
			-- Create new tree item for displaying 'a_tc'.
		require else
			correct_class: a_tc.target_class = target_class
		do
			create Result.make (a_tc)
		end

feature {NONE} -- Implementation

	data_type: CDD_TEST_CASE
			-- Type anchor

	item_type: CDD_TREE_TEST_CASE_ITEM
			-- Type anchor

invariant
	target_class_not_void: target_class /= Void

end
