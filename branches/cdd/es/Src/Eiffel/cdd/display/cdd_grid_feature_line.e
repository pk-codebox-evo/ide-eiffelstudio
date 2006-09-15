indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GRID_FEATURE_LINE

inherit
	CDD_GRID_LINE [E_FEATURE]
		rename
			row_data as eiffel_feature
		redefine
			make
		end

	CDD_GRID_HELPER [CDD_TEST_CASE, CDD_GRID_TEST_CASE_LINE]
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_row: like grid_row; a_feature: like eiffel_feature) is
			--
		do
			Precursor (a_row, a_feature)
			update_tokens
		end

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Access

	data_from_test_case (a_tc: CDD_TEST_CASE): CDD_TEST_CASE is
			--
		do
			Result := a_tc
		end

feature -- Element change

	add_row (a_tc: CDD_TEST_CASE) is
			--
		local
			i: INTEGER
		do
			i := grid.row_count + 1
			grid.insert_new_row_parented (i, grid_row)
			create last_added_row.make (grid.row (i), a_tc)
			update_tokens
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

	update_tokens is
			-- Update 'text' with new item count.
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

invariant
	invariant_clause: True -- Your invariant here

end
