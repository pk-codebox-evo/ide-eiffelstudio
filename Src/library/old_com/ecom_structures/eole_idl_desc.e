indexing

	description: "OLE IDLDESC structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_IDL_DESC

inherit
	EOLE_OBJECT_WITH_POINTER

feature -- Access

	idl_flags: INTEGER is
			-- Associated flags.
			-- See EOLE_IDL_FLAGS for `Result' value.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_idldesc_idl_flags (ole_ptr)
		end
	
feature {NONE} -- Externals

	ole2_idldesc_idl_flags (this: POINTER): INTEGER is
		external
			"C [macro %"idldesc.h%"](EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_idldesc_idl_flags"
		end
	
end -- class EOLE_IDL_DESC

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

