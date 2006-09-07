indexing
	description: "Objects that represent a class within a tree structure"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TREE_CLUSTER_ITEM

inherit
	CDD_TREE_ITEM [CONF_CLUSTER]
		rename
			data as target_cluster
		redefine
			make
		end

	CDD_TREE_HELPER [EIFFEL_CLASS_I, CDD_TREE_CLASS_ITEM]
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

	make (a_cluster: like target_cluster) is
			-- Set 'text', 'tooltip' and 'pixmap' of item.
		require else
			a_cluster_not_void: a_cluster /= Void
		do
			Precursor (a_cluster)
			set_text (target_cluster.name)
			set_tooltip (target_cluster.name)
			set_pixmap (pixmaps.icon_pixmaps.tool_clusters_icon)
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
			locate_item (a_tc.target_class)
			last_located_item.add_test_case (a_tc)
		end

	remove_test_case (a_tc: CDD_TEST_CASE) is
			-- Remove 'a_tc' from tree structure
		require
			a_tc_not_void: a_tc /= Void
		do
			locate_item (a_tc.target_class)
			last_located_item.remove_test_case (a_tc)
			if last_located_item.is_empty then
				prune (last_located_item)
			end
		end

feature -- Element change

	new_item (a_class: EIFFEL_CLASS_I): CDD_TREE_CLASS_ITEM is
			-- Create new tree item for displaying 'a_class'.
		require else
			correct_cluster: a_class.cluster = target_cluster
		do
			create Result.make (a_class)
		end


invariant
	target_cluster_not_void: target_cluster /= Void

end
