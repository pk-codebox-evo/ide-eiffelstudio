indexing
	description: "Text Metric Pitch and Family (TMPF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TMPF_CONSTANTS

feature -- Access

	Tmpf_fixed_pitch: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TMPF_FIXED_PITCH"
		end

	Tmpf_vector: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TMPF_VECTOR"
		end

	Tmpf_device: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TMPF_DEVICE"
		end

	Tmpf_truetype: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TMPF_TRUETYPE"
		end

end -- class WEL_TMPF_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

