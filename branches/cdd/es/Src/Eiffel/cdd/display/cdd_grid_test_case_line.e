indexing
	description: "Objects that display a test case within a grid structure"
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
			make_with_row,
			unattach
		end

create
	make_with_row

feature {NONE} -- Initialization

	make_with_row (a_row: like grid_row; a_test_case: like test_case) is
			-- Set `grid_row' to `a_row' and `test_case' to `a_test_case'.
			-- Define first item of `grid_row' for displaying `test_case'.
		local
			l_token_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_stone: CLASSI_STONE
			l_tool: CDD_TEST_SUITE_TOOL
		do
			Precursor (a_row, a_test_case)
			internal_update_agent := agent update_status
			test_case.on_start_testing.extend (internal_update_agent)
			test_case.on_finish_testing.extend (internal_update_agent)

			l_token_item := row_item (1)
			l_token_item.set_text (test_case.exception_tag)
			create l_stone.make (test_case.test_class)
			l_token_item.token_at_position (1).set_pebble (l_stone)

			update_status
			l_tool := grid_row.parent.tool
			internal_select_agent := agent l_tool.on_select_test_case (a_test_case)
			grid_row.select_actions.extend (internal_select_agent)
			internal_deselect_agent := agent l_tool.on_deselect
			grid_row.deselect_actions.extend (internal_deselect_agent)
		end

feature -- Element change

	add_test_case (a_tc: CDD_TEST_CASE) is
			-- Add `a_tc' to grid.
		do
			-- NOTE: nothing to do since test case is displayed by `Current'
		end

	remove_test_case (a_tc: CDD_TEST_CASE) is
			-- Remove `a_tc' from grid.
		do
			-- NOTE: nothing to do since test case is displayed by `Current'
		end

	unattach is
			-- Set `grid_row' to Void and prune agents from test case.
		do
			test_case.on_start_testing.prune (internal_update_agent)
			test_case.on_finish_testing.prune (internal_update_agent)
			grid_row.select_actions.prune (internal_select_agent)
			grid_row.deselect_actions.prune (internal_deselect_agent)
			Precursor
		end

feature {NONE} -- Implementation

	internal_select_agent, internal_deselect_agent, internal_update_agent: PROCEDURE [ANY, TUPLE]
			-- Procedure instances used for extending and removing.

	row_item (a_column: INTEGER): EB_GRID_EDITOR_TOKEN_ITEM is
			-- Item of `grid_row' at position `a_column'
			-- (Creates a new item if there is no item stored yet)
		do
			Result ?= grid_row.item (a_column)
			if Result = Void then
				create Result
				grid_row.set_item (a_column, Result)
			end
		end

	update_status is
			-- Update status item of `grid_row'.
		local
			l_token_item: EB_GRID_EDITOR_TOKEN_ITEM
		do
			l_token_item := row_item (2)
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

end -- Class CDD_GRID_TEST_CASE_LINE
