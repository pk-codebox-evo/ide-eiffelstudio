indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_GRID_HELPER [reference G -> COMPARABLE, H -> CDD_GRID_LINE [G]]

feature -- Access

	last_appended_row: H

	data_from_test_case (a_tc: CDD_TEST_CASE): G is
			--
		require
			a_tc_not_void: a_tc /= Void
		deferred
		ensure
			not_void: Result /= Void
		end

	last_added_row: H

feature -- Element change

	add_test_case (a_tc: CDD_TEST_CASE) is
			--
		require
			a_tc_not_void: a_tc /= Void
		local
			l_data: G
		do
			l_data := data_from_test_case (a_tc)
			if last_added_row = Void or not last_added_row.row_data.is_equal (l_data) then
				add_row (l_data)
			end
			last_added_row.add_test_case (a_tc)
			if last_added_row.grid_row.is_expandable then
				last_added_row.grid_row.expand
			end
		end


	add_row (some_data: G) is
			--
		deferred
		end


end
