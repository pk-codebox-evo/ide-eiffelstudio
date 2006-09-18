indexing
	description: "Objects that display a eiffel feature within a grid structure"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GRID_FEATURE_LINE

inherit
	CDD_GRID_LINE [E_FEATURE]
		rename
			row_data as eiffel_feature
		redefine
			make_with_row
		end

	CDD_GRID_HELPER [CDD_TEST_CASE, CDD_GRID_TEST_CASE_LINE]
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make_with_row

feature {NONE} -- Initialization

	make_with_row (a_row: like grid_row; a_feature: like eiffel_feature) is
			-- Set `grid_row' to `a_row' and `eiffel_feature' to `a_feature'.
			-- Define first item of `grid_row' for displaying `eiffel_feature'.
		do
			Precursor (a_row, a_feature)
			update_tokens

			grid_row.select_actions.extend (agent do grid_row.disable_select end)
		end

feature -- Access

	data_from_test_case (a_tc: CDD_TEST_CASE): CDD_TEST_CASE is
			-- Attribute of `a_tc' displayed in sublines of `Current'.
			-- NOTE: Returns `a_tc' since sublines are leaves of the tree structure
		do
			Result := a_tc
		end

feature {NONE} -- Element change

	create_new_line (a_row_index: INTEGER; a_test_case: CDD_TEST_CASE) is
			-- Create a subline for displaying `a_test_case' with row at position `a_row_index'.
		do
			create last_created_line.make_with_row (grid.row (a_row_index), a_test_case)
			update_tokens
		end

feature {NONE} -- Implementation

	update_tokens is
			-- Update `text' with new item count.
		local
			l_token_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_writer: EB_EDITOR_TOKEN_GENERATOR
			l_text: STRING
		do
			l_token_item ?= grid_row.item (1)
			if l_token_item = Void then
				create l_token_item
				l_token_item.set_pixmap (pixmaps.icon_pixmaps.tool_feature_icon)
				grid_row.set_item (1, l_token_item)
			end
			l_writer := l_token_item.token_writer
			l_writer.new_line
			l_writer.process_feature_text (eiffel_feature.name, eiffel_feature, False)
			l_text := " (" + grid_row.subrow_count_recursive.out + ")"
			l_writer.process_basic_text (l_text)
			l_token_item.set_text_with_tokens (l_writer.last_line.content)
		end

end -- Class CDD_GRID_FEATURE_LINE
