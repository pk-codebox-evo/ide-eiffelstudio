indexing
	description: "Objects that display a class within a grid structure"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GRID_CLASS_LINE

inherit
	CDD_GRID_LINE [EIFFEL_CLASS_I]
		rename
			row_data as target_class
		redefine
			make_with_row
		end

	CDD_GRID_HELPER [E_FEATURE, CDD_GRID_FEATURE_LINE]
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make_with_row

feature {NONE} -- Initialization

	make_with_row (a_row: like grid_row; a_class: like target_class) is
			-- Set `grid_row' to `a_row' and `target_class' to `a_class'.
			-- Define first item of `grid_row' for displaying `target_class'.
		local
			l_item: EB_GRID_CLASS_ITEM
		do
			Precursor (a_row, a_class)
			if target_class.is_compiled then
				create {EB_GRID_COMPILED_CLASS_ITEM} l_item.make (target_class.compiled_class, create {EB_GRID_FULL_CLASS_STYLE})
			else
				create {EB_GRID_NONCOMPILED_CLASS_ITEM} l_item.make (target_class, create {EB_GRID_JUST_NAME_NONCOMPILED_CLASS_STYLE})
			end
			l_item.enable_pixmap
			grid_row.set_item (1, l_item)

			grid_row.select_actions.extend (agent do grid_row.disable_select end)
		end

feature -- Access

	data_from_test_case (a_tc: CDD_TEST_CASE): E_FEATURE is
			-- Attribute of `a_tc' displayed in sublines of `Current'.
		do
			Result := a_tc.feature_name
		end

feature {NONE} -- Element change

	create_new_line (a_row_index: INTEGER; a_feature: E_FEATURE) is
			-- Create a subline for displaying `a_class' with row at position `a_row_index'.
		do
			create last_created_line.make_with_row (grid.row (a_row_index), a_feature)
		end

end -- Class CDD_GRID_CLASS_LINE
