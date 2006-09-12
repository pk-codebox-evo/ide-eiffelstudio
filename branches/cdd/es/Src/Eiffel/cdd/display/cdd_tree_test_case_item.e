indexing
	description: "Objects that represent a test case within a tree structure"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TREE_TEST_CASE_ITEM

inherit
	CDD_TREE_ITEM [CDD_TEST_CASE]
		rename
			data as test_case
		redefine
			make
		end

	EB_CONSTANTS
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

	make (a_test_case: like test_case) is
			-- Set 'text', 'tooltip' and 'pixmap' of item.
		require else
			a_test_case_not_void: a_test_case /= Void
		local
			l_tooltip: STRING
		do
			Precursor (a_test_case)
			test_case.on_start_testing.extend (agent update_status)
			test_case.on_finish_testing.extend (agent update_status)
			update_status
			create l_tooltip.make_empty
			l_tooltip.append ("Class: " + a_test_case.target_class.name + "%N")
			l_tooltip.append ("Feature: " + a_test_case.feature_name + "%N")
			l_tooltip.append ("Exception: " + a_test_case.exception_tag + "%N")
			l_tooltip.append ("ID: " + a_test_case.id + "%N")
			l_tooltip.append ("Test class: " + a_test_case.test_class.name + "%N")
			set_tooltip (l_tooltip)
		ensure then
			text_set: text /= Void and not text.is_empty
			tooltip_set: tooltip /= Void and not tooltip.is_empty
		end

	update_status is
			--
		local
			l_text: STRING
		do
			create l_text.make_from_string (test_case.exception_tag)
			if test_case.is_tested or not test_case.was_tested then
				set_pixmap (pixmaps.icon_pixmaps.tool_warning_icon)
			else
				if test_case.passes then
					set_pixmap (pixmaps.icon_pixmaps.tool_feature_icon)
					l_text.append (": passes")
				else
					set_pixmap (pixmaps.icon_pixmaps.tool_error_icon)
					l_text.append (": fails")
				end
			end
			set_text (l_text)
		end


feature -- Element change

	add_test_case (a_tc: CDD_TEST_CASE) is
			-- Add 'a_tc' to tree structure
		require
			a_tc_not_void: a_tc /= Void
		local
			l_tool: CDD_TEST_SUITE_TOOL
		do
			l_tool := parent_tree.tool
			select_actions.extend (agent l_tool.on_select_test_case (Current))
		end

invariant
	test_case_not_void: test_case /= Void

end
