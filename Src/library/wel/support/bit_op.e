indexing
	description: "Bit operations on integer (or, and not)."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BIT_OPERATIONS

feature -- Basic operations

	set_flag (flags, mask: INTEGER): INTEGER is
			-- Set the `mask' in `flags'
		do
			Result := c_set_flag (flags, mask)
		ensure
			flag_set: flag_set (Result, mask)
		end

	clear_flag (flags, mask: INTEGER): INTEGER is
			-- Clear the `mask' in `flags'
		do
			Result := c_clear_flag (flags, mask)
		ensure
			flag_unset: not flag_set (Result, mask)
		end

feature -- Status report

	flag_set (flags, mask: INTEGER): BOOLEAN is
			-- Is `mask' set in `flags'?
		do
			Result := c_flag_set (flags, mask)
		end

feature {NONE} -- Externals

	c_set_flag (flags, mask: INTEGER): INTEGER is
		external
			"C [macro <wel.h>]"
		end

	c_clear_flag (flags, mask: INTEGER): INTEGER is
		external
			"C [macro <wel.h>]"
		end

	c_flag_set (flags, mask: INTEGER): BOOLEAN is
		external
			"C [macro <wel.h>]"
		end

end -- class WEL_BIT_OPERATIONS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
