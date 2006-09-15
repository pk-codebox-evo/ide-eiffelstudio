indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GRID_CLASS_LINE

inherit
	CDD_GRID_LINE [EIFFEL_CLASS_I]
		rename
			row_data as target_class
		redefine
			make
		end

	CDD_GRID_HELPER [E_FEATURE, CDD_GRID_FEATURE_LINE]
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_row: like grid_row; a_class: like target_class) is
			--
		local
			l_item: EB_GRID_CLASS_ITEM
		do
			Precursor (a_row, a_class)
			if target_class.is_compiled then
				create {EB_GRID_COMPILED_CLASS_ITEM} l_item.make (target_class.compiled_class, create {EB_GRID_FULL_CLASS_STYLE})
			else
				create {EB_GRID_NONCOMPILED_CLASS_ITEM} l_item.make (target_class, create {EB_GRID_JUST_NAME_NONCOMPILED_CLASS_STYLE})
			end
--			create l_item.make_with_text (target_class.name)
--			l_item.set_tooltip (target_class.name)
--			l_item.set_pixmap (pixmaps.icon_pixmaps.tool_class_icon)
			l_item.enable_pixmap
			--l_item.enabl
			grid_row.set_item (1, l_item)
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Access

	data_from_test_case (a_tc: CDD_TEST_CASE): E_FEATURE is
			--
		do
			Result := a_tc.feature_name
		end

feature -- Element change

	add_row (a_feature: E_FEATURE) is
			--
		local
			i: INTEGER
		do
			i := grid.row_count + 1
			grid.insert_new_row_parented (i, grid_row)
			create last_added_row.make (grid.row (i), a_feature)
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

	last_row: CDD_GRID_FEATURE_LINE

invariant
	invariant_clause: True -- Your invariant here

end
