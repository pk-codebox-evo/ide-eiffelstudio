indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GRID_CLUSTER_LINE

inherit
	CDD_GRID_LINE [CONF_CLUSTER]
		rename
			row_data as target_cluster
		redefine
			make
		end

	CDD_GRID_HELPER [EIFFEL_CLASS_I, CDD_GRID_CLASS_LINE]
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_row: like grid_row; a_cluster: like target_cluster) is
			--
		local
			l_cluster_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_cluster: CLUSTER_I
		do
			Precursor (a_row, a_cluster)
			create l_cluster_item.make_with_text (target_cluster.name)
			l_cluster_item.set_pixmap (pixmaps.icon_pixmaps.tool_clusters_icon)
			l_cluster_item.token_writer.new_line

			l_cluster ?= target_cluster
			l_cluster_item.token_writer.process_cluster_name_text (target_cluster.name, l_cluster, False)


			l_cluster_item.set_text_with_tokens (l_cluster_item.token_writer.last_line.content)

--			create l_item.make_with_text (target_cluster.name)
--			l_item.set_tooltip (target_cluster.name)
--			l_item.set_pixmap (pixmaps.icon_pixmaps.tool_clusters_icon)
			grid_row.set_item (1, l_cluster_item)
		end

feature -- Access

	data_from_test_case (a_tc: CDD_TEST_CASE): EIFFEL_CLASS_I is
			--
		do
			Result := a_tc.target_class
		end

feature -- Element change

	add_row (a_class: EIFFEL_CLASS_I) is
			--
		local
			i: INTEGER
		do
			i := grid.row_count + 1
			grid.insert_new_row_parented (i, grid_row)
			create last_added_row.make (grid.row (i), a_class)
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

	last_row: CDD_GRID_CLASS_LINE

invariant
	invariant_clause: True -- Your invariant here

end
