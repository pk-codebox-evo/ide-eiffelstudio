indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TREE_CLUSTER_ITEM

inherit
	CDD_TREE_ITEM
		rename
			data as target_cluster
		redefine
			make, target_cluster, data_type
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
			--
		do
			Precursor (a_cluster)
			set_text (target_cluster.name)
			set_pixmap (pixmaps.icon_pixmaps.tool_clusters_icon)
		end


feature -- Access

	target_cluster: CONF_CLUSTER

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	new_item (a_class: like data_type): CDD_TREE_CLASS_ITEM is
			--
		do

		end


feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	data_type: EIFFEL_CLASS_I

invariant
	invariant_clause: True -- Your invariant here

end
