indexing
	description: "Objects that display test cases in a tree like structure"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TREE

inherit
	EV_TREE

	CDD_TREE_HELPER
		undefine
			default_create,
			is_equal,
			copy
		redefine
			data_type,
			item_type
		end

feature -- Transformation

	new_item (a_cluster: like data_type): CDD_TREE_CLUSTER_ITEM is
			-- Create new tree item for displaying 'a_cluster'.
		do
			create Result.make (a_cluster)
		end

feature {NONE} -- Implementation

	data_type: CONF_CLUSTER
			-- Type anchor

	item_type: CDD_TREE_CLUSTER_ITEM
			-- Type anchor


end
