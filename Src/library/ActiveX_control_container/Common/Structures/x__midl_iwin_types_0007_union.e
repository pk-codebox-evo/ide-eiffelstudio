indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	X__MIDL_IWIN_TYPES_0007_UNION

inherit
	ECOM_STRUCTURE
		redefine
			make
		end

creation
	make,
	make_from_pointer

feature {NONE}  -- Initialization

	make is
			-- Make.
		do
			Precursor {ECOM_STRUCTURE}
		end

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	h_remote: X_USER_BITMAP_RECORD is
			-- No description available.
		do
			Result := ccom_x__midl_iwin_types_0007_h_remote (item)
		end

	h_inproc: INTEGER is
			-- No description available.
		do
			Result := ccom_x__midl_iwin_types_0007_h_inproc (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_x__midl_iwin_types_0007
		end

feature -- Basic Operations

	set_h_remote (a_h_remote: X_USER_BITMAP_RECORD) is
			-- Set `h_remote' with `a_h_remote'.
		require
			non_void_a_h_remote: a_h_remote /= Void
			valid_a_h_remote: a_h_remote.item /= default_pointer
		do
			ccom_x__midl_iwin_types_0007_set_h_remote (item, a_h_remote.item)
		end

	set_h_inproc (a_h_inproc: INTEGER) is
			-- Set `h_inproc' with `a_h_inproc'.
		do
			ccom_x__midl_iwin_types_0007_set_h_inproc (item, a_h_inproc)
		end

feature {NONE}  -- Externals

	c_size_of_x__midl_iwin_types_0007: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library___MIDL_IWinTypes_0007_s.h%"]"
		alias
			"sizeof(ecom_control_library::__MIDL_IWinTypes_0007)"
		end

	ccom_x__midl_iwin_types_0007_h_remote (a_pointer: POINTER): X_USER_BITMAP_RECORD is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library___MIDL_IWinTypes_0007_s_impl.h%"](ecom_control_library::__MIDL_IWinTypes_0007 *):EIF_REFERENCE"
		end

	ccom_x__midl_iwin_types_0007_set_h_remote (a_pointer: POINTER; arg2: POINTER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library___MIDL_IWinTypes_0007_s_impl.h%"](ecom_control_library::__MIDL_IWinTypes_0007 *, ecom_control_library::_userBITMAP *)"
		end

	ccom_x__midl_iwin_types_0007_h_inproc (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library___MIDL_IWinTypes_0007_s_impl.h%"](ecom_control_library::__MIDL_IWinTypes_0007 *):EIF_INTEGER"
		end

	ccom_x__midl_iwin_types_0007_set_h_inproc (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library___MIDL_IWinTypes_0007_s_impl.h%"](ecom_control_library::__MIDL_IWinTypes_0007 *, LONG)"
		end

end -- X__MIDL_IWIN_TYPES_0007_UNION

