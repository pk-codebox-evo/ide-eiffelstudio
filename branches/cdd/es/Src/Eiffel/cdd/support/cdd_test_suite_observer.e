indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE_OBSERVER

inherit

	CDD_SHARED_TEST_SUITE


feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

	subscribe is
			--
		do
			test_suite.subscribe_observer (Current)
		end

	unsubscribe is
			--
		do
			test_suite.unsubscribe_observer (Current)
		end



feature -- Cursor movement

feature -- Status change

	on_enable_testing is
			--
		do
		end

	on_disable_testing is
			--
		do
		end

feature -- Element change

	on_add_test_case (a_tc: CDD_TEST_CASE) is
			--
		do
		end

	on_remove_test_case (a_tc: CDD_TEST_CASE) is
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
