indexing
	description: "Implemented `IEiffelSystemBrowser' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_SYSTEM_BROWSER_IMPL_PROXY

inherit
	IEIFFEL_SYSTEM_BROWSER_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_ieiffel_system_browser_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Access

	system_classes: IENUM_EIFFEL_CLASS_INTERFACE is
			-- List of classes in system.
		do
			Result := ccom_system_classes (initializer)
		end

	class_count: INTEGER is
			-- Number of classes in system.
		do
			Result := ccom_class_count (initializer)
		end

	system_clusters: IENUM_CLUSTER_INTERFACE is
			-- List of system's clusters.
		do
			Result := ccom_system_clusters (initializer)
		end

	external_clusters: IENUM_CLUSTER_INTERFACE is
			-- List of system's external clusters.
		do
			Result := ccom_external_clusters (initializer)
		end

	cluster_count: INTEGER is
			-- Number of top-level clusters in system.
		do
			Result := ccom_cluster_count (initializer)
		end

feature -- Basic Operations

	cluster_descriptor (cluster_name: STRING): IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE is
			-- Cluster descriptor.
			-- `cluster_name' [in].  
		do
			Result := ccom_cluster_descriptor (initializer, cluster_name)
		end

	class_descriptor (class_name1: STRING): IEIFFEL_CLASS_DESCRIPTOR_INTERFACE is
			-- Class descriptor.
			-- `class_name1' [in].  
		do
			Result := ccom_class_descriptor (initializer, class_name1)
		end

	feature_descriptor (class_name1: STRING; feature_name: STRING): IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE is
			-- Feature descriptor.
			-- `class_name1' [in].  
			-- `feature_name' [in].  
		do
			Result := ccom_feature_descriptor (initializer, class_name1, feature_name)
		end

	search_classes (a_string: STRING; is_substring: BOOLEAN): IENUM_EIFFEL_CLASS_INTERFACE is
			-- Search classes with names matching `a_string'.
			-- `a_string' [in].  
			-- `is_substring' [in].  
		do
			Result := ccom_search_classes (initializer, a_string, is_substring)
		end

	search_features (a_string: STRING; is_substring: BOOLEAN): IENUM_FEATURE_INTERFACE is
			-- Search feature with names matching `a_string'.
			-- `a_string' [in].  
			-- `is_substring' [in].  
		do
			Result := ccom_search_features (initializer, a_string, is_substring)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_ieiffel_system_browser_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_system_classes (cpp_obj: POINTER): IENUM_EIFFEL_CLASS_INTERFACE is
			-- List of classes in system.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemBrowser_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_class_count (cpp_obj: POINTER): INTEGER is
			-- Number of classes in system.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemBrowser_impl_proxy.h%"](): EIF_INTEGER"
		end

	ccom_system_clusters (cpp_obj: POINTER): IENUM_CLUSTER_INTERFACE is
			-- List of system's clusters.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemBrowser_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_external_clusters (cpp_obj: POINTER): IENUM_CLUSTER_INTERFACE is
			-- List of system's external clusters.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemBrowser_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_cluster_count (cpp_obj: POINTER): INTEGER is
			-- Number of top-level clusters in system.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemBrowser_impl_proxy.h%"](): EIF_INTEGER"
		end

	ccom_cluster_descriptor (cpp_obj: POINTER; cluster_name: STRING): IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE is
			-- Cluster descriptor.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemBrowser_impl_proxy.h%"](EIF_OBJECT): EIF_REFERENCE"
		end

	ccom_class_descriptor (cpp_obj: POINTER; class_name1: STRING): IEIFFEL_CLASS_DESCRIPTOR_INTERFACE is
			-- Class descriptor.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemBrowser_impl_proxy.h%"](EIF_OBJECT): EIF_REFERENCE"
		end

	ccom_feature_descriptor (cpp_obj: POINTER; class_name1: STRING; feature_name: STRING): IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE is
			-- Feature descriptor.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemBrowser_impl_proxy.h%"](EIF_OBJECT,EIF_OBJECT): EIF_REFERENCE"
		end

	ccom_search_classes (cpp_obj: POINTER; a_string: STRING; is_substring: BOOLEAN): IENUM_EIFFEL_CLASS_INTERFACE is
			-- Search classes with names matching `a_string'.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemBrowser_impl_proxy.h%"](EIF_OBJECT,EIF_BOOLEAN): EIF_REFERENCE"
		end

	ccom_search_features (cpp_obj: POINTER; a_string: STRING; is_substring: BOOLEAN): IENUM_FEATURE_INTERFACE is
			-- Search feature with names matching `a_string'.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemBrowser_impl_proxy.h%"](EIF_OBJECT,EIF_BOOLEAN): EIF_REFERENCE"
		end

	ccom_delete_ieiffel_system_browser_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemBrowser_impl_proxy.h%"]()"
		end

	ccom_create_ieiffel_system_browser_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemBrowser_impl_proxy.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemBrowser_impl_proxy.h%"]():EIF_POINTER"
		end

end -- IEIFFEL_SYSTEM_BROWSER_IMPL_PROXY

