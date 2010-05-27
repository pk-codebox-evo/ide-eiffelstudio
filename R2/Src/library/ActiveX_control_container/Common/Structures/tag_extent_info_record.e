note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	TAG_EXTENT_INFO_RECORD

inherit
	ECOM_STRUCTURE
		redefine
			make
		end

create
	make,
	make_from_pointer

feature {NONE}  -- Initialization

	make
			-- Make.
		do
			Precursor {ECOM_STRUCTURE}
		end

	make_from_pointer (a_pointer: POINTER)
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	cb: INTEGER
			-- No description available.
		do
			Result := ccom_tag_extent_info_cb (item)
		end

	dw_extent_mode: INTEGER
			-- No description available.
		do
			Result := ccom_tag_extent_info_dw_extent_mode (item)
		end

	sizel_proposed: TAG_SIZEL_RECORD
			-- No description available.
		do
			Result := ccom_tag_extent_info_sizel_proposed (item)
		ensure
			valid_sizel_proposed: Result.item /= default_pointer
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of structure
		do
			Result := c_size_of_tag_extent_info
		end

feature -- Basic Operations

	set_cb (a_cb: INTEGER)
			-- Set `cb' with `a_cb'.
		do
			ccom_tag_extent_info_set_cb (item, a_cb)
		end

	set_dw_extent_mode (a_dw_extent_mode: INTEGER)
			-- Set `dw_extent_mode' with `a_dw_extent_mode'.
		do
			ccom_tag_extent_info_set_dw_extent_mode (item, a_dw_extent_mode)
		end

	set_sizel_proposed (a_sizel_proposed: TAG_SIZEL_RECORD)
			-- Set `sizel_proposed' with `a_sizel_proposed'.
		require
			non_void_a_sizel_proposed: a_sizel_proposed /= Void
			valid_a_sizel_proposed: a_sizel_proposed.item /= default_pointer
		do
			ccom_tag_extent_info_set_sizel_proposed (item, a_sizel_proposed.item)
		end

feature {NONE}  -- Externals

	c_size_of_tag_extent_info: INTEGER
			-- Size of structure
		external
			"C [macro %"ecom_control_library_tagExtentInfo_s.h%"]"
		alias
			"sizeof(ecom_control_library::tagExtentInfo)"
		end

	ccom_tag_extent_info_cb (a_pointer: POINTER): INTEGER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagExtentInfo_s_impl.h%"](ecom_control_library::tagExtentInfo *):EIF_INTEGER"
		end

	ccom_tag_extent_info_set_cb (a_pointer: POINTER; arg2: INTEGER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagExtentInfo_s_impl.h%"](ecom_control_library::tagExtentInfo *, ULONG)"
		end

	ccom_tag_extent_info_dw_extent_mode (a_pointer: POINTER): INTEGER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagExtentInfo_s_impl.h%"](ecom_control_library::tagExtentInfo *):EIF_INTEGER"
		end

	ccom_tag_extent_info_set_dw_extent_mode (a_pointer: POINTER; arg2: INTEGER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagExtentInfo_s_impl.h%"](ecom_control_library::tagExtentInfo *, ULONG)"
		end

	ccom_tag_extent_info_sizel_proposed (a_pointer: POINTER): TAG_SIZEL_RECORD
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagExtentInfo_s_impl.h%"](ecom_control_library::tagExtentInfo *):EIF_REFERENCE"
		end

	ccom_tag_extent_info_set_sizel_proposed (a_pointer: POINTER; arg2: POINTER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagExtentInfo_s_impl.h%"](ecom_control_library::tagExtentInfo *, ecom_control_library::tagSIZEL *)"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- TAG_EXTENT_INFO_RECORD

