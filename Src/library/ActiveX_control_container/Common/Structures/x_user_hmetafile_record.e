indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	X_USER_HMETAFILE_RECORD

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

	f_context: INTEGER is
			-- No description available.
		do
			Result := ccom_x_user_hmetafile_f_context (item)
		end

	u: X__MIDL_IWIN_TYPES_0004_UNION is
			-- No description available.
		do
			Result := ccom_x_user_hmetafile_u (item)
		ensure
			valid_u: Result.item /= default_pointer
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_x_user_hmetafile
		end

feature -- Basic Operations

	set_f_context (a_f_context: INTEGER) is
			-- Set `f_context' with `a_f_context'.
		do
			ccom_x_user_hmetafile_set_f_context (item, a_f_context)
		end

	set_u (a_u: X__MIDL_IWIN_TYPES_0004_UNION) is
			-- Set `u' with `a_u'.
		require
			non_void_a_u: a_u /= Void
			valid_a_u: a_u.item /= default_pointer
		do
			ccom_x_user_hmetafile_set_u (item, a_u.item)
		end

feature {NONE}  -- Externals

	c_size_of_x_user_hmetafile: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library__userHMETAFILE_s.h%"]"
		alias
			"sizeof(ecom_control_library::_userHMETAFILE)"
		end

	ccom_x_user_hmetafile_f_context (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userHMETAFILE_s_impl.h%"](ecom_control_library::_userHMETAFILE *):EIF_INTEGER"
		end

	ccom_x_user_hmetafile_set_f_context (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userHMETAFILE_s_impl.h%"](ecom_control_library::_userHMETAFILE *, LONG)"
		end

	ccom_x_user_hmetafile_u (a_pointer: POINTER): X__MIDL_IWIN_TYPES_0004_UNION is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userHMETAFILE_s_impl.h%"](ecom_control_library::_userHMETAFILE *):EIF_REFERENCE"
		end

	ccom_x_user_hmetafile_set_u (a_pointer: POINTER; arg2: POINTER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userHMETAFILE_s_impl.h%"](ecom_control_library::_userHMETAFILE *, ecom_control_library::__MIDL_IWinTypes_0004 *)"
		end

end -- X_USER_HMETAFILE_RECORD

