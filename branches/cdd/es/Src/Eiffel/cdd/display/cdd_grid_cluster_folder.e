indexing
	description: "Objects that represent grid rows for displaying clusters"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GRID_CLUSTER_FOLDER

inherit
	CDD_GRID_LINE

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_cluster

feature {NONE} -- Initialization

	make_with_cluster (a_cluster: like target_cluster; a_grid: like grid; a_row: like row) is
			-- Set 'target_cluster' to 'a_cluster' and define items of 'a_row'
			-- to display the cluster properties in 'a_grid'.
		require
			valid_cluster: a_cluster /= Void
			valid_grid: a_grid /= Void
			valid_row: a_row /= Void and then a_row.parent = a_grid
		do
			target_cluster := a_cluster
			make (a_grid, a_row)
			set_text (grid.feature_column_index, target_cluster.name)
			set_pixmap (grid.feature_column_index, pixmaps.icon_pixmaps.tool_clusters_icon)
			row.ensure_expandable
		ensure
			target_cluster_set: target_cluster = a_cluster
		end


feature -- Access

	target_cluster: CONF_CLUSTER
			-- cluster displayed on 'row'


feature {NONE} -- Implementation

end
