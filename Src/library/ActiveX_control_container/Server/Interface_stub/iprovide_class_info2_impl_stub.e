indexing
	description: "Implemented `IProvideClassInfo2' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IPROVIDE_CLASS_INFO2_IMPL_STUB

inherit
	IPROVIDE_CLASS_INFO2_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	get_class_info (pp_ti: CELL [ITYPE_INFO_2_INTERFACE]) is
			-- No description available.
			-- `pp_ti' [out].  
		do
			-- Put Implementation here.
		end

	get_guid (dw_guid_kind: INTEGER; p_guid: ECOM_GUID) is
			-- No description available.
			-- `dw_guid_kind' [in].  
			-- `p_guid' [out].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IPROVIDE_CLASS_INFO2_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IProvideClassInfo2_impl_stub %"ecom_control_library_IProvideClassInfo2_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IPROVIDE_CLASS_INFO2_IMPL_STUB

