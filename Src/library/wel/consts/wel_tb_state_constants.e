indexing
	description	: "Toolbar button state (TB_STATE...) constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_TB_STATE_CONSTANTS

feature -- Access

	Tbstate_checked: INTEGER is 1
			-- The button has the Tbstyle_checked style and is
			-- being pressed.

	Tbstate_enabled: INTEGER is 4
			-- The button accepts user input. A button not having
			-- this state does not accept user input and is grayed.

	Tbstate_hidden: INTEGER is 8
			-- The button is not visible and cannot receive user
			-- input.

	Tbstate_indeterminate: INTEGER is 16
			-- The button is grayed.

	Tbstate_pressed: INTEGER is 2
			-- The button is being pressed.

	Tbstate_wrap: INTEGER is 32
			-- A line break follows the button. The button must
			-- also have the Tbstate_enabled state.

end -- class WEL_TB_STATE_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

