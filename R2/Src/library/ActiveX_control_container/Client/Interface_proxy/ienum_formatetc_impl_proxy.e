note
	description: "Implemented `IEnumFORMATETC' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	IENUM_FORMATETC_IMPL_PROXY

inherit
	IENUM_FORMATETC_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_ienum_formatetc_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	next (celt: INTEGER; rgelt: ARRAY [TAG_FORMATETC_RECORD]; pcelt_fetched: INTEGER_REF)
			-- No description available.
			-- `celt' [in].  
			-- `rgelt' [out].  
			-- `pcelt_fetched' [out].  
		do
			ccom_next (initializer, celt, rgelt, pcelt_fetched)
		end

	skip (celt: INTEGER)
			-- No description available.
			-- `celt' [in].  
		do
			ccom_skip (initializer, celt)
		end

	reset
			-- No description available.
		do
			ccom_reset (initializer)
		end

	clone1 (ppenum: CELL [IENUM_FORMATETC_INTERFACE])
			-- No description available.
			-- `ppenum' [out].  
		do
			ccom_clone1 (initializer, ppenum)
		end

feature {NONE}  -- Implementation

	delete_wrapper
			-- Delete wrapper
		do
			ccom_delete_ienum_formatetc_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_next (cpp_obj: POINTER; celt: INTEGER; rgelt: ARRAY [TAG_FORMATETC_RECORD]; pcelt_fetched: INTEGER_REF)
			-- No description available.
		external
			"C++ [ecom_control_library::IEnumFORMATETC_impl_proxy %"ecom_control_library_IEnumFORMATETC_impl_proxy_s.h%"](EIF_INTEGER,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_skip (cpp_obj: POINTER; celt: INTEGER)
			-- No description available.
		external
			"C++ [ecom_control_library::IEnumFORMATETC_impl_proxy %"ecom_control_library_IEnumFORMATETC_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_reset (cpp_obj: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IEnumFORMATETC_impl_proxy %"ecom_control_library_IEnumFORMATETC_impl_proxy_s.h%"]()"
		end

	ccom_clone1 (cpp_obj: POINTER; ppenum: CELL [IENUM_FORMATETC_INTERFACE])
			-- No description available.
		external
			"C++ [ecom_control_library::IEnumFORMATETC_impl_proxy %"ecom_control_library_IEnumFORMATETC_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_delete_ienum_formatetc_impl_proxy (a_pointer: POINTER)
			-- Release resource
		external
			"C++ [delete ecom_control_library::IEnumFORMATETC_impl_proxy %"ecom_control_library_IEnumFORMATETC_impl_proxy_s.h%"]()"
		end

	ccom_create_ienum_formatetc_impl_proxy_from_pointer (a_pointer: POINTER): POINTER
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IEnumFORMATETC_impl_proxy %"ecom_control_library_IEnumFORMATETC_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER
			-- Item
		external
			"C++ [ecom_control_library::IEnumFORMATETC_impl_proxy %"ecom_control_library_IEnumFORMATETC_impl_proxy_s.h%"]():EIF_POINTER"
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




end -- IENUM_FORMATETC_IMPL_PROXY

