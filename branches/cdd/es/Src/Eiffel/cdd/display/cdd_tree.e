indexing
	description: "Objects that display test cases in a tree like structure"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TREE

inherit
	EV_TREE

	CDD_TREE_HELPER [CONF_CLUSTER, CDD_TREE_CLUSTER_ITEM]
		undefine
			default_create,
			is_equal,
			copy
		end

feature -- Transformation

	new_item (a_cluster: CONF_CLUSTER): CDD_TREE_CLUSTER_ITEM is
			-- Create new tree item for displaying 'a_cluster'.
		do
			create Result.make (a_cluster)
		end



end
