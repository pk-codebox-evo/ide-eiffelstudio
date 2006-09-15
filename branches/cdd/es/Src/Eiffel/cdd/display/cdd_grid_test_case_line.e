indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GRID_TEST_CASE_LINE

inherit
	CDD_GRID_LINE [CDD_TEST_CASE]
		rename
			row_data as test_case
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_row: like grid_row; a_test_case: like test_case) is
			--
		local
			l_token_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_stone: CLASSI_STONE
		do
			Precursor (a_row, a_test_case)
			test_case.on_start_testing.extend (agent update_status)
			test_case.on_finish_testing.extend (agent update_status)

			l_token_item := item (1)
			l_token_item.set_text (test_case.exception_tag)
			create l_stone.make (test_case.test_class)
			l_token_item.token_at_position (1).set_pebble (l_stone)

			update_status
		end

feature -- Access

	item (a_column: INTEGER): EB_GRID_EDITOR_TOKEN_ITEM is
			--
		do
			Result ?= grid_row.item (a_column)
			if Result = Void then
				create Result
				grid_row.set_item (a_column, Result)
			end
		end


feature -- Measurement

feature -- Status report		


feature -- Status setting

	update_status is
			--
		local
			l_token_item: EB_GRID_EDITOR_TOKEN_ITEM
		do
			l_token_item := item (2)
			if test_case.is_tested then
				l_token_item.set_text ("Testing...")
			elseif not test_case.was_tested then
				l_token_item.set_text ("Not tested yet")
			else
				if test_case.passes then
					l_token_item.set_text ("Ok")
				else
					l_token_item.set_text ("Fails")
				end
			end
			l_token_item.redraw
		end


feature -- Cursor movement

feature -- Element change

	add_test_case (a_tc: CDD_TEST_CASE) is
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

invariant
	invariant_clause: True -- Your invariant here

end
