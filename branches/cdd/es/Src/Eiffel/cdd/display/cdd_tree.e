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

	CDD_TREE_HELPER [CONF_CLUSTER, CDD_TREE_CLUSTER_ITEM]
		undefine
			default_create,
			is_equal,
			copy
		end

feature -- Access

	selected_item: CDD_TREE_ITEM [COMPARABLE] is
			--Currently selected item at any level
			-- within tree hierarchy.
		do
			Result ?= Precursor
		ensure then
			not_void: Result /= Void
		end



feature -- Transformation

	new_item (a_cluster: CONF_CLUSTER): CDD_TREE_CLUSTER_ITEM is
			-- Create new tree item for displaying 'a_cluster'.
		do
			create Result.make (a_cluster)
		end



end
