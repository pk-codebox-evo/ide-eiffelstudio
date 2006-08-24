indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE_TOOL

inherit

	CDD_TEST_SUITE_OBSERVER
		export
			{NONE} all
		redefine
			on_add_test_case,
			on_enable_testing
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_tool

feature {NONE} -- Initialization

	make_with_tool (a_window: EB_DEVELOPMENT_WINDOW; a_tool: EB_CONTEXT_TOOL) is
			-- Initialize
		do
			development_window := a_window
			initialize
			subscribe
			create {DS_LINKED_LIST [CDD_GRID_CLASS_LINE]} displayed_classes.make
		end

	initialize is
			--
		do
			create widget

			build_tool_bar
			create grid
			if not test_suite.is_testing_enabled then
				grid.disable_sensitive
			end
			widget.extend (grid)
		end




feature -- Access

	development_window: EB_DEVELOPMENT_WINDOW

	widget: EV_VERTICAL_BOX

feature -- Measurement

feature -- Status report


feature -- Status setting

	on_add_test_case (a_test_case: CDD_TEST_CASE) is
			-- Add Test Case
		local
			rc: INTEGER
			row: EV_GRID_ROW
			a_item: EV_GRID_LABEL_ITEM
			class_line: CDD_GRID_CLASS_LINE
			test_case_line: CDD_GRID_TEST_CASE_LINE
		do
		end

	on_enable_testing is
			--
		do
			enable_testing_btn.disable_sensitive
		end


	on_button_enable_testing (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			--
		do
			if test_suite.can_enable_testing then
				test_suite.enable_testing
			end
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

	enable_testing_btn: EV_TOOL_BAR_BUTTON

	run_tc_button: EV_TOOL_BAR_BUTTON

	run_all_tc_button: EV_TOOL_BAR_BUTTON

	del_tc_button: EV_TOOL_BAR_BUTTON

	build_tool_bar is
			--
		do
			create tool_bar
			create enable_testing_btn.make_with_text ("Enable Testing")
			enable_testing_btn.set_pixmap (pixmaps.icon_pixmaps.breakpoints_enable_icon)
			enable_testing_btn.pointer_button_press_actions.extend (agent on_button_enable_testing)
			create run_all_tc_button.make_with_text ("Run all test cases")
			run_all_tc_button.set_pixmap (pixmaps.icon_pixmaps.debug_run_icon)
			create run_tc_button.make_with_text ("Run test tase")
			run_tc_button.set_pixmap (pixmaps.icon_pixmaps.debug_run_icon)
			create del_tc_button.make_with_text ("Remove test case")
			del_tc_button.set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)
			if test_suite.is_testing_enabled then
				enable_testing_btn.disable_sensitive
			else
				run_all_tc_button.disable_sensitive
				run_tc_button.disable_sensitive
				del_tc_button.disable_sensitive
			end
			tool_bar.extend (run_all_tc_button)
			tool_bar.extend (run_tc_button)
			tool_bar.extend (del_tc_button)
			tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
			tool_bar.extend (enable_testing_btn)
			widget.extend (tool_bar)
			widget.disable_item_expand (tool_bar)
		end

	grid: CDD_GRID


invariant
	invariant_clause: True -- Your invariant here

end
