indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GRID_CLUSTER_LINE

inherit
	CDD_GRID_LINE
		rename
			set_feature as set_cluster
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_cluster

feature {NONE} -- Initialization

	make_with_cluster (a_cluster: like target_cluster; a_grid: like grid; a_row: like row) is
			--
		require
			valid_cluster: a_cluster /= Void
			valid_grid: a_grid /= Void
			valid_row: a_row /= Void and then a_row.parent = a_grid
		do
			target_cluster := a_cluster
			make (a_grid, a_row)
			set_cluster (target_cluster.name, pixmaps.icon_pixmaps.tool_clusters_icon)
			row.ensure_expandable
		end


feature -- Access

	target_cluster: CONF_CLUSTER

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

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

invariant
	invariant_clause: True -- Your invariant here

end
