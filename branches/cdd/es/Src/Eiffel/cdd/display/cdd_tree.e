indexing
	description: "Objects that display test cases in a tree like structure"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TREE

inherit
	EV_TREE
		redefine
			selected_item
		end

	EV_LAYOUT_CONSTANTS
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end

	CDD_TREE_HELPER [CONF_CLUSTER, CDD_TREE_CLUSTER_ITEM]
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make_with_tool

feature -- Initialization

	make_with_tool (a_tool: like tool) is
			-- Set 'tool' to 'a_tool' and initialize tree
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
			default_create
			set_minimum_width (dialog_unit_to_pixels (500))
		ensure
			tool_set: tool = a_tool
			initialized: is_initialized
		end


feature -- Access

	tool: CDD_TEST_SUITE_TOOL
			-- Tool which contains 'Current'

	selected_item: CDD_TREE_ITEM [COMPARABLE] is
			-- Currently selected item at any level
			-- within tree hierarchy.
		do
			Result ?= Precursor
		ensure then
			not_void: Result /= Void
		end

feature -- Element change

	add_test_case (a_tc: CDD_TEST_CASE) is
			-- Add 'a_tc' to tree structure
		require
			a_tc_not_void: a_tc /= Void
		do
			locate_item (a_tc.target_cluster)
			last_located_item.add_test_case (a_tc)
		ensure
			not_empty: not is_empty
		end

	remove_test_case (a_tc: CDD_TEST_CASE) is
			-- Remove 'a_tc' from tree structure
		require
			a_tc_not_void: a_tc /= Void
		do
			locate_item (a_tc.target_cluster)
			last_located_item.remove_test_case (a_tc)
			if last_located_item.is_empty then
				prune (last_located_item)
			end
		end



feature -- Transformation

	new_item (a_cluster: CONF_CLUSTER): CDD_TREE_CLUSTER_ITEM is
			-- Create new tree item for displaying 'a_cluster'.
		do
			create Result.make (a_cluster)
		end

end
