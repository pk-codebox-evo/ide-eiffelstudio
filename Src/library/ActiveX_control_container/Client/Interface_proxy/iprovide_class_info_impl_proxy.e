indexing
	description: "Implemented `IProvideClassInfo' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IPROVIDE_CLASS_INFO_IMPL_PROXY

inherit
	IPROVIDE_CLASS_INFO_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_iprovide_class_info_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	get_class_info (pp_ti: CELL [ITYPE_INFO_2_INTERFACE]) is
			-- No description available.
			-- `pp_ti' [out].  
		do
			ccom_get_class_info (initializer, pp_ti)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_iprovide_class_info_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_get_class_info (cpp_obj: POINTER; pp_ti: CELL [ITYPE_INFO_2_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IProvideClassInfo_impl_proxy %"ecom_control_library_IProvideClassInfo_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_delete_iprovide_class_info_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IProvideClassInfo_impl_proxy %"ecom_control_library_IProvideClassInfo_impl_proxy_s.h%"]()"
		end

	ccom_create_iprovide_class_info_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IProvideClassInfo_impl_proxy %"ecom_control_library_IProvideClassInfo_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IProvideClassInfo_impl_proxy %"ecom_control_library_IProvideClassInfo_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IPROVIDE_CLASS_INFO_IMPL_PROXY

