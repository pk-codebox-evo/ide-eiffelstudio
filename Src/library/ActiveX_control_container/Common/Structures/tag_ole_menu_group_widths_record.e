indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	TAG_OLE_MENU_GROUP_WIDTHS_RECORD

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

	width: ARRAY [INTEGER] is
			-- No description available.
		do
			Result := ccom_tag_ole_menu_group_widths_width (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_tag_ole_menu_group_widths
		end

feature -- Basic Operations

	set_width (a_width: ARRAY [INTEGER]) is
			-- Set `width' with `a_width'.
		require
			non_void_a_width: a_width /= Void
		local
			any: ANY
		do
			any := a_width.to_c
			ccom_tag_ole_menu_group_widths_set_width (item, $any)
		end

feature {NONE}  -- Externals

	c_size_of_tag_ole_menu_group_widths: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library_tagOleMenuGroupWidths_s.h%"]"
		alias
			"sizeof(ecom_control_library::tagOleMenuGroupWidths)"
		end

	ccom_tag_ole_menu_group_widths_width (a_pointer: POINTER): ARRAY [INTEGER] is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagOleMenuGroupWidths_s_impl.h%"](ecom_control_library::tagOleMenuGroupWidths *):EIF_REFERENCE"
		end

	ccom_tag_ole_menu_group_widths_set_width (a_pointer: POINTER; arg2: POINTER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagOleMenuGroupWidths_s_impl.h%"](ecom_control_library::tagOleMenuGroupWidths *, EIF_POINTER)"
		end

end -- TAG_OLE_MENU_GROUP_WIDTHS_RECORD

