indexing
	description: "Common control Progress Bar Message (PBM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PBM_CONSTANTS

feature -- Access

	Pbm_getpos: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_GETPOS"
		end

	Pbm_getrange: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_GETRANGE"
		end

	Pbm_setrange: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_SETRANGE"
		end
		
	Pbm_setrange32: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_SETRANGE32"
		end

	Pbm_setpos: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_SETPOS"
		end

	Pbm_deltapos: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_DELTAPOS"
		end

	Pbm_setstep: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_SETSTEP"
		end

	Pbm_stepit: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_STEPIT"
		end

end -- class WEL_PBM_CONSTANTS

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

