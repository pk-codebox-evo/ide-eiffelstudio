note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	X_TAG_OLECMD_RECORD

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

	cmd_id: INTEGER
			-- No description available.
		do
			Result := ccom_x_tag_olecmd_cmd_id (item)
		end

	cmdf: INTEGER
			-- No description available.
		do
			Result := ccom_x_tag_olecmd_cmdf (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of structure
		do
			Result := c_size_of_x_tag_olecmd
		end

feature -- Basic Operations

	set_cmd_id (a_cmd_id: INTEGER)
			-- Set `cmd_id' with `a_cmd_id'.
		do
			ccom_x_tag_olecmd_set_cmd_id (item, a_cmd_id)
		end

	set_cmdf (a_cmdf: INTEGER)
			-- Set `cmdf' with `a_cmdf'.
		do
			ccom_x_tag_olecmd_set_cmdf (item, a_cmdf)
		end

feature {NONE}  -- Externals

	c_size_of_x_tag_olecmd: INTEGER
			-- Size of structure
		external
			"C [macro %"ecom_control_library__tagOLECMD_s.h%"]"
		alias
			"sizeof(ecom_control_library::_tagOLECMD)"
		end

	ccom_x_tag_olecmd_cmd_id (a_pointer: POINTER): INTEGER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__tagOLECMD_s_impl.h%"](ecom_control_library::_tagOLECMD *):EIF_INTEGER"
		end

	ccom_x_tag_olecmd_set_cmd_id (a_pointer: POINTER; arg2: INTEGER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__tagOLECMD_s_impl.h%"](ecom_control_library::_tagOLECMD *, ULONG)"
		end

	ccom_x_tag_olecmd_cmdf (a_pointer: POINTER): INTEGER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__tagOLECMD_s_impl.h%"](ecom_control_library::_tagOLECMD *):EIF_INTEGER"
		end

	ccom_x_tag_olecmd_set_cmdf (a_pointer: POINTER; arg2: INTEGER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__tagOLECMD_s_impl.h%"](ecom_control_library::_tagOLECMD *, ULONG)"
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




end -- X_TAG_OLECMD_RECORD

