indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	X_USER_BITMAP_RECORD

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

	bm_type: INTEGER is
			-- No description available.
		do
			Result := ccom_x_user_bitmap_bm_type (item)
		end

	bm_width: INTEGER is
			-- No description available.
		do
			Result := ccom_x_user_bitmap_bm_width (item)
		end

	bm_height: INTEGER is
			-- No description available.
		do
			Result := ccom_x_user_bitmap_bm_height (item)
		end

	bm_width_bytes: INTEGER is
			-- No description available.
		do
			Result := ccom_x_user_bitmap_bm_width_bytes (item)
		end

	bm_planes: INTEGER is
			-- No description available.
		do
			Result := ccom_x_user_bitmap_bm_planes (item)
		end

	bm_bits_pixel: INTEGER is
			-- No description available.
		do
			Result := ccom_x_user_bitmap_bm_bits_pixel (item)
		end

	cb_size: INTEGER is
			-- No description available.
		do
			Result := ccom_x_user_bitmap_cb_size (item)
		end

	p_buffer: CHARACTER_REF is
			-- No description available.
		do
			Result := ccom_x_user_bitmap_p_buffer (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_x_user_bitmap
		end

feature -- Basic Operations

	set_bm_type (a_bm_type: INTEGER) is
			-- Set `bm_type' with `a_bm_type'.
		do
			ccom_x_user_bitmap_set_bm_type (item, a_bm_type)
		end

	set_bm_width (a_bm_width: INTEGER) is
			-- Set `bm_width' with `a_bm_width'.
		do
			ccom_x_user_bitmap_set_bm_width (item, a_bm_width)
		end

	set_bm_height (a_bm_height: INTEGER) is
			-- Set `bm_height' with `a_bm_height'.
		do
			ccom_x_user_bitmap_set_bm_height (item, a_bm_height)
		end

	set_bm_width_bytes (a_bm_width_bytes: INTEGER) is
			-- Set `bm_width_bytes' with `a_bm_width_bytes'.
		do
			ccom_x_user_bitmap_set_bm_width_bytes (item, a_bm_width_bytes)
		end

	set_bm_planes (a_bm_planes: INTEGER) is
			-- Set `bm_planes' with `a_bm_planes'.
		do
			ccom_x_user_bitmap_set_bm_planes (item, a_bm_planes)
		end

	set_bm_bits_pixel (a_bm_bits_pixel: INTEGER) is
			-- Set `bm_bits_pixel' with `a_bm_bits_pixel'.
		do
			ccom_x_user_bitmap_set_bm_bits_pixel (item, a_bm_bits_pixel)
		end

	set_cb_size (a_cb_size: INTEGER) is
			-- Set `cb_size' with `a_cb_size'.
		do
			ccom_x_user_bitmap_set_cb_size (item, a_cb_size)
		end

	set_p_buffer (a_p_buffer: CHARACTER_REF) is
			-- Set `p_buffer' with `a_p_buffer'.
		require
			non_void_a_p_buffer: a_p_buffer /= Void
		do
			ccom_x_user_bitmap_set_p_buffer (item, a_p_buffer)
		end

feature {NONE}  -- Externals

	c_size_of_x_user_bitmap: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library__userBITMAP_s.h%"]"
		alias
			"sizeof(ecom_control_library::_userBITMAP)"
		end

	ccom_x_user_bitmap_bm_type (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *):EIF_INTEGER"
		end

	ccom_x_user_bitmap_set_bm_type (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *, LONG)"
		end

	ccom_x_user_bitmap_bm_width (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *):EIF_INTEGER"
		end

	ccom_x_user_bitmap_set_bm_width (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *, LONG)"
		end

	ccom_x_user_bitmap_bm_height (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *):EIF_INTEGER"
		end

	ccom_x_user_bitmap_set_bm_height (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *, LONG)"
		end

	ccom_x_user_bitmap_bm_width_bytes (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *):EIF_INTEGER"
		end

	ccom_x_user_bitmap_set_bm_width_bytes (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *, LONG)"
		end

	ccom_x_user_bitmap_bm_planes (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *):EIF_INTEGER"
		end

	ccom_x_user_bitmap_set_bm_planes (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *, USHORT)"
		end

	ccom_x_user_bitmap_bm_bits_pixel (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *):EIF_INTEGER"
		end

	ccom_x_user_bitmap_set_bm_bits_pixel (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *, USHORT)"
		end

	ccom_x_user_bitmap_cb_size (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *):EIF_INTEGER"
		end

	ccom_x_user_bitmap_set_cb_size (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *, ULONG)"
		end

	ccom_x_user_bitmap_p_buffer (a_pointer: POINTER): CHARACTER_REF is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *):EIF_REFERENCE"
		end

	ccom_x_user_bitmap_set_p_buffer (a_pointer: POINTER; arg2: CHARACTER_REF) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__userBITMAP_s_impl.h%"](ecom_control_library::_userBITMAP *, EIF_OBJECT)"
		end

end -- X_USER_BITMAP_RECORD

