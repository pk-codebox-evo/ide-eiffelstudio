indexing
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	TAG_CAUUID_RECORD

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

	c_elems: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_cauuid_c_elems (item)
		end

	p_elems: ECOM_GUID is
			-- No description available.
		do
			Result := ccom_tag_cauuid_p_elems (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_tag_cauuid
		end

feature -- Basic Operations

	set_c_elems (a_c_elems: INTEGER) is
			-- Set `c_elems' with `a_c_elems'.
		do
			ccom_tag_cauuid_set_c_elems (item, a_c_elems)
		end

	set_p_elems (a_p_elems: ECOM_GUID) is
			-- Set `p_elems' with `a_p_elems'.
		require
			non_void_a_p_elems: a_p_elems /= Void
			valid_a_p_elems: a_p_elems.item /= default_pointer
		do
			ccom_tag_cauuid_set_p_elems (item, a_p_elems.item)
		end

feature {NONE}  -- Externals

	c_size_of_tag_cauuid: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library_tagCAUUID_s.h%"]"
		alias
			"sizeof(ecom_control_library::tagCAUUID)"
		end

	ccom_tag_cauuid_c_elems (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCAUUID_s_impl.h%"](ecom_control_library::tagCAUUID *):EIF_INTEGER"
		end

	ccom_tag_cauuid_set_c_elems (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCAUUID_s_impl.h%"](ecom_control_library::tagCAUUID *, ULONG)"
		end

	ccom_tag_cauuid_p_elems (a_pointer: POINTER): ECOM_GUID is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCAUUID_s_impl.h%"](ecom_control_library::tagCAUUID *):EIF_REFERENCE"
		end

	ccom_tag_cauuid_set_p_elems (a_pointer: POINTER; arg2: POINTER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCAUUID_s_impl.h%"](ecom_control_library::tagCAUUID *, GUID *)"
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




end -- TAG_CAUUID_RECORD

