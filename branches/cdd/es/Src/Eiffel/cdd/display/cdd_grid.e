indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GRID

inherit
	ES_GRID
		redefine
			initialize
		end

	CDD_GRID_HELPER [CONF_CLUSTER, CDD_GRID_CLUSTER_LINE]
		undefine
			default_create,
			is_equal,
			copy
		end

	EV_LAYOUT_CONSTANTS
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

	make is
		local
			l_col: EV_GRID_COLUMN
		do
			default_create

			set_column_count_to (2)
			l_col := column (1)
			l_col.set_title ("Test Case")
			l_col.set_width (300)
			set_auto_resizing_column (1, True)
			l_col := column (2)
			l_col.set_title ("Status")

			enable_single_row_selection
			enable_default_tree_navigation_behavior (True, False, True, True)
		end

	initialize is
			--
		do
			Precursor {ES_GRID}

			enable_tree
			enable_row_height_fixed
		end

feature -- Access

	data_from_test_case (a_tc: CDD_TEST_CASE): CONF_CLUSTER is
			--
		do
			Result := a_tc.target_cluster
		end


feature -- Measurement

feature -- Status report

feature -- Status setting



feature -- Cursor movement

feature -- Element change

	add_row (a_cluster: CONF_CLUSTER) is
			--
		local
			i: INTEGER
		do
			i := row_count + 1
			insert_new_row (i)
			create last_added_row.make (row (i), a_cluster)
		end

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature {NONE} -- Implementation

	last_row: CDD_GRID_CLUSTER_LINE
			-- last row which was appended to 'Current'


feature {CDD_GRID_LINE} -- Status report

	expanded_clusters: DS_LINKED_LIST [STRING]
			-- Names of clusters which were expanded before last store

	expanded_classes: DS_LINKED_LIST [STRING]
			-- Names of classes which were expanded before last store

	expanded_features: DS_LINKED_LIST [STRING]
			-- Names of features which were expanded before last store



invariant
	invariant_clause: True -- Your invariant here

end
