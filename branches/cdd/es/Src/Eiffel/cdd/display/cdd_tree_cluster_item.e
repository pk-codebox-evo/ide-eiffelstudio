indexing
	description: "Objects that represent a class within a tree structure"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TREE_CLUSTER_ITEM

inherit
	CDD_TREE_ITEM
		rename
			data as target_cluster
		redefine
			make,
			target_cluster,
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


feature -- Access

	target_cluster: CONF_CLUSTER
			-- Cluster displayed in the item

feature -- Element change

	new_item (a_class: like data_type): CDD_TREE_CLASS_ITEM is
			-- Create new tree item for displaying 'a_class'.
		require else
			correct_cluster: a_class.cluster = target_cluster
		do
			create Result.make (a_class)
		end

feature {NONE} -- Implementation

	data_type: EIFFEL_CLASS_I
			-- Type anchor

	item_type: CDD_TREE_CLASS_ITEM
			-- Type anchor

invariant
	target_cluster_not_void: target_cluster /= Void

end
