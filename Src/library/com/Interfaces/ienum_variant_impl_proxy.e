indexing
	description: "Implemented `IEnumVARIANT' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IENUM_VARIANT_IMPL_PROXY

inherit
	IENUM_VARIANT_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_ienum_variant1_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	next (celt: INTEGER; rgvar: ARRAY [ECOM_VARIANT]; pcelt_fetched: INTEGER_REF) is
			-- No description available.
			-- `celt' [in].  
			-- `rgvar' [in].  
			-- `pcelt_fetched' [out].  
		do
			ccom_next (initializer, celt, rgvar, pcelt_fetched)
		end

	skip (celt: INTEGER) is
			-- No description available.
			-- `celt' [in].  
		do
			ccom_skip (initializer, celt)
		end

	reset is
			-- No description available.
		do
			ccom_reset (initializer)
		end

	clone1 (ppenum: CELL [IENUM_VARIANT_INTERFACE]) is
			-- No description available.
			-- `ppenum' [out].  
		do
			ccom_clone1 (initializer, ppenum)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_ienum_variant1_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_next (cpp_obj: POINTER; celt: INTEGER; rgvar: ARRAY [ECOM_VARIANT]; pcelt_fetched: INTEGER_REF) is
			-- No description available.
		external
			"C++ [IEnumVARIANT1_impl_proxy %"ecom_IEnumVARIANT1_impl_proxy.h%"](EIF_INTEGER,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_skip (cpp_obj: POINTER; celt: INTEGER) is
			-- No description available.
		external
			"C++ [IEnumVARIANT1_impl_proxy %"ecom_IEnumVARIANT1_impl_proxy.h%"](EIF_INTEGER)"
		end

	ccom_reset (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [IEnumVARIANT1_impl_proxy %"ecom_IEnumVARIANT1_impl_proxy.h%"]()"
		end

	ccom_clone1 (cpp_obj: POINTER; ppenum: CELL [IENUM_VARIANT_INTERFACE]) is
			-- No description available.
		external
			"C++ [IEnumVARIANT1_impl_proxy %"ecom_IEnumVARIANT1_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_delete_ienum_variant1_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete IEnumVARIANT1_impl_proxy %"ecom_IEnumVARIANT1_impl_proxy.h%"]()"
		end

	ccom_create_ienum_variant1_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new IEnumVARIANT1_impl_proxy %"ecom_IEnumVARIANT1_impl_proxy.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [IEnumVARIANT1_impl_proxy %"ecom_IEnumVARIANT1_impl_proxy.h%"]():EIF_POINTER"
		end

end -- IENUM_VARIANT_IMPL_PROXY

