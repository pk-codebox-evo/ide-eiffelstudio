indexing
	description: "Implemented `IEnumFeature' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IENUM_FEATURE_IMPL_PROXY

inherit
	IENUM_FEATURE_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_ienum_feature_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Access

	count: INTEGER is
			-- No description available.
		do
			Result := ccom_count (initializer)
		end

feature -- Basic Operations

	next (pp_ieiffel_feature_descriptor: CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]; pul_fetched: INTEGER_REF) is
			-- No description available.
			-- `pp_ieiffel_feature_descriptor' [out].  
			-- `pul_fetched' [out].  
		do
			ccom_next (initializer, pp_ieiffel_feature_descriptor, pul_fetched)
		end

	skip (ul_count: INTEGER) is
			-- No description available.
			-- `ul_count' [in].  
		do
			ccom_skip (initializer, ul_count)
		end

	reset is
			-- No description available.
		do
			ccom_reset (initializer)
		end

	clone1 (pp_ienum_feature: CELL [IENUM_FEATURE_INTERFACE]) is
			-- No description available.
			-- `pp_ienum_feature' [out].  
		do
			ccom_clone1 (initializer, pp_ienum_feature)
		end

	ith_item (ul_index: INTEGER; pp_ieiffel_feature_descriptor: CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]) is
			-- No description available.
			-- `ul_index' [in].  
			-- `pp_ieiffel_feature_descriptor' [out].  
		do
			ccom_ith_item (initializer, ul_index, pp_ieiffel_feature_descriptor)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_ienum_feature_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_next (cpp_obj: POINTER; pp_ieiffel_feature_descriptor: CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]; pul_fetched: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_EiffelComCompiler::IEnumFeature_impl_proxy %"ecom_EiffelComCompiler_IEnumFeature_impl_proxy.h%"](EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_skip (cpp_obj: POINTER; ul_count: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_EiffelComCompiler::IEnumFeature_impl_proxy %"ecom_EiffelComCompiler_IEnumFeature_impl_proxy.h%"](EIF_INTEGER)"
		end

	ccom_reset (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_EiffelComCompiler::IEnumFeature_impl_proxy %"ecom_EiffelComCompiler_IEnumFeature_impl_proxy.h%"]()"
		end

	ccom_clone1 (cpp_obj: POINTER; pp_ienum_feature: CELL [IENUM_FEATURE_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_EiffelComCompiler::IEnumFeature_impl_proxy %"ecom_EiffelComCompiler_IEnumFeature_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_ith_item (cpp_obj: POINTER; ul_index: INTEGER; pp_ieiffel_feature_descriptor: CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_EiffelComCompiler::IEnumFeature_impl_proxy %"ecom_EiffelComCompiler_IEnumFeature_impl_proxy.h%"](EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_count (cpp_obj: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [ecom_EiffelComCompiler::IEnumFeature_impl_proxy %"ecom_EiffelComCompiler_IEnumFeature_impl_proxy.h%"](): EIF_INTEGER"
		end

	ccom_delete_ienum_feature_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_EiffelComCompiler::IEnumFeature_impl_proxy %"ecom_EiffelComCompiler_IEnumFeature_impl_proxy.h%"]()"
		end

	ccom_create_ienum_feature_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_EiffelComCompiler::IEnumFeature_impl_proxy %"ecom_EiffelComCompiler_IEnumFeature_impl_proxy.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_EiffelComCompiler::IEnumFeature_impl_proxy %"ecom_EiffelComCompiler_IEnumFeature_impl_proxy.h%"]():EIF_POINTER"
		end

end -- IENUM_FEATURE_IMPL_PROXY

