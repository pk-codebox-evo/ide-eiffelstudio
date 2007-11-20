indexing
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	X_USER_CLIPFORMAT_RECORD

inherit
	ECOM_STRUCTURE
		redefine
			make
		end

create
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
			Result := ccom_x_user_clipformat_f_context (item)
		end

	u: X_USER_CLIPFORMAT_UNION is
			-- No description available.
		do
			Result := ccom_x_user_clipformat_u (item)
		ensure
			valid_u: Result.item /= default_pointer
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_x_user_clipformat
		end

feature -- Basic Operations

	set_f_context (a_f_context: INTEGER) is
			-- Set `f_context' with `a_f_context'.
		do
			ccom_x_user_clipformat_set_f_context (item, a_f_context)
		end

	set_u (a_u: X_USER_CLIPFORMAT_UNION) is
			-- Set `u' with `a_u'.
		require
			non_void_a_u: a_u /= Void
			valid_a_u: a_u.item /= default_pointer
		do
			ccom_x_user_clipformat_set_u (item, a_u.item)
		end

feature {NONE}  -- Externals

	c_size_of_x_user_clipformat: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library__userCLIPFORMAT_s.h%"]"
		alias
			"sizeof(ecom_control_library::_userCLIPFORMAT)"
		end

	ccom_x_user_clipformat_f_context (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userCLIPFORMAT_s_impl.h%"](ecom_control_library::_userCLIPFORMAT *):EIF_INTEGER"
		end

	ccom_x_user_clipformat_set_f_context (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userCLIPFORMAT_s_impl.h%"](ecom_control_library::_userCLIPFORMAT *, LONG)"
		end

	ccom_x_user_clipformat_u (a_pointer: POINTER): X_USER_CLIPFORMAT_UNION is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userCLIPFORMAT_s_impl.h%"](ecom_control_library::_userCLIPFORMAT *):EIF_REFERENCE"
		end

	ccom_x_user_clipformat_set_u (a_pointer: POINTER; arg2: POINTER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userCLIPFORMAT_s_impl.h%"](ecom_control_library::_userCLIPFORMAT *, ecom_control_library::__MIDL_IWinTypes_0001 *)"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- X_USER_CLIPFORMAT_RECORD

