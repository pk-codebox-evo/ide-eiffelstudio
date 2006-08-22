indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE_DISPLAYER

inherit

	EV_VERTICAL_BOX
		redefine
			initialize
		end

	CDD_SHARED_TEST_SUITE
		export
			{NONE} all
		undefine
			is_equal, default_create, copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, default_create, copy
		end

create
	make_with_tool

feature {NONE} -- Initialization

	make_with_tool (a_window: EB_DEVELOPMENT_WINDOW; a_tool: EB_CONTEXT_TOOL) is
			-- Initialize
		do
			default_create

			window := a_window

			test_suite.subscribe_new_test_case (agent add_test_case)

			create {DS_LINKED_LIST [CDD_GRID_CLASS_LINE]} displayed_classes.make
		end

	initialize is
			--
		do
			Precursor

			build_tool_bar
			create grid
			extend (grid)
		end




feature -- Access

	window: EB_DEVELOPMENT_WINDOW

feature -- Measurement

feature -- Status report


feature -- Status setting

	add_test_case (a_test_case: CDD_TEST_CASE) is
			-- Add Test Case
		require
			valid_test_case: a_test_case /= Void
		local
			rc: INTEGER
			row: EV_GRID_ROW
			a_item: EV_GRID_LABEL_ITEM
			class_line: CDD_GRID_CLASS_LINE
			test_case_line: CDD_GRID_TEST_CASE_LINE
		do
			from
				displayed_classes.start
			until
				displayed_classes.after or class_line /= Void
			loop
				if displayed_classes.item_for_iteration.dclass = a_test_case.dclass then
					class_line := displayed_classes.item_for_iteration
				end
				displayed_classes.forth
			end
			if class_line = Void then
				create class_line.make_with_class (a_test_case.dclass, grid)
				displayed_classes.put_last (class_line)
			end
			create test_case_line.make_with_test_case (a_test_case, class_line, grid)
		end


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

	displayed_classes: DS_LIST [CDD_GRID_CLASS_LINE]

	tool_bar: EV_TOOL_BAR

	run_tc_button: EV_TOOL_BAR_BUTTON

	run_all_tc_button: EV_TOOL_BAR_BUTTON

	del_tc_button: EV_TOOL_BAR_BUTTON

	build_tool_bar is
			--
		do
			create tool_bar
			create run_all_tc_button.make_with_text ("Run all test cases")
			run_all_tc_button.set_pixmap (pixmaps.icon_pixmaps.debug_run_icon)
			create run_tc_button.make_with_text ("Run test tase")
			run_tc_button.set_pixmap (pixmaps.icon_pixmaps.debug_run_icon)
			create del_tc_button.make_with_text ("Remove test case")
			del_tc_button.set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)
			tool_bar.extend (run_all_tc_button)
			tool_bar.extend (run_tc_button)
			tool_bar.extend (del_tc_button)
			extend (tool_bar)
			disable_item_expand (tool_bar)
		end

	grid: CDD_GRID


invariant
	invariant_clause: True -- Your invariant here

end
