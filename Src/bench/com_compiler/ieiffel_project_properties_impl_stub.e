indexing
	description: "Implemented `IEiffelProjectProperties' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_PROJECT_PROPERTIES_IMPL_STUB

inherit
	IEIFFEL_PROJECT_PROPERTIES_INTERFACE

	ECOM_STUB

feature -- Access

	system_name: STRING is
			-- System name.
		do
			-- Put Implementation here.
		end

	root_class_name: STRING is
			-- Root class name.
		do
			-- Put Implementation here.
		end

	creation_routine: STRING is
			-- Creation routine name.
		do
			-- Put Implementation here.
		end

	namespace_generation: INTEGER is
			-- Namespace generation for cluster
		do
			-- Put Implementation here.
		end

	default_namespace: STRING is
			-- Default namespace.
		do
			-- Put Implementation here.
		end

	project_type: INTEGER is
			-- Project type
		do
			-- Put Implementation here.
		end

	dot_net_naming_convention: BOOLEAN is
			-- .NET Naming convention
		do
			-- Put Implementation here.
		end

	generate_debug_info: BOOLEAN is
			-- Generate debug info?
		do
			-- Put Implementation here.
		end

	precompiled_library: STRING is
			-- Precompiled file.
		do
			-- Put Implementation here.
		end

	assertions: INTEGER is
			-- Project assertions
		do
			-- Put Implementation here.
		end

	clusters: IEIFFEL_SYSTEM_CLUSTERS_INTERFACE is
			-- Project Clusters.
		do
			-- Put Implementation here.
		end

	externals: IEIFFEL_SYSTEM_EXTERNALS_INTERFACE is
			-- Externals.
		do
			-- Put Implementation here.
		end

	assemblies: IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE is
			-- Assemblies.
		do
			-- Put Implementation here.
		end

	title: STRING is
			-- Project title.
		do
			-- Put Implementation here.
		end

	description: STRING is
			-- Project description.
		do
			-- Put Implementation here.
		end

	company: STRING is
			-- Project company.
		do
			-- Put Implementation here.
		end

	product: STRING is
			-- Product.
		do
			-- Put Implementation here.
		end

	version: STRING is
			-- Project version.
		do
			-- Put Implementation here.
		end

	trademark: STRING is
			-- Project trademark.
		do
			-- Put Implementation here.
		end

	copyright: STRING is
			-- Project copyright.
		do
			-- Put Implementation here.
		end

	culture: STRING is
			-- Asembly culture.
		do
			-- Put Implementation here.
		end

	key_file_name: STRING is
			-- Asembly signing key file name.
		do
			-- Put Implementation here.
		end

	working_directory: STRING is
			-- Project working directory
		do
			-- Put Implementation here.
		end

feature -- Basic Operations

	set_system_name (return_value: STRING) is
			-- System name.
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_root_class_name (return_value: STRING) is
			-- Root class name.
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_creation_routine (return_value: STRING) is
			-- Creation routine name.
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_namespace_generation (penu_cluster_namespace_generation: INTEGER) is
			-- Namespace generation for cluster
			-- `penu_cluster_namespace_generation' [in]. See ECOM_TAG_EIF_CLUSTER_NAMESPACE_GENERATION_ENUM for possible `penu_cluster_namespace_generation' values. 
		do
			-- Put Implementation here.
		end

	set_default_namespace (return_value: STRING) is
			-- Default namespace.
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_project_type (penum_project_type: INTEGER) is
			-- Project type
			-- `penum_project_type' [in]. See ECOM_TAG_EIF_PROJECT_TYPES_ENUM for possible `penum_project_type' values. 
		do
			-- Put Implementation here.
		end

	set_dot_net_naming_convention (pvb_naming_convention: BOOLEAN) is
			-- .NET Naming convention
			-- `pvb_naming_convention' [in].  
		do
			-- Put Implementation here.
		end

	set_generate_debug_info (return_value: BOOLEAN) is
			-- Generate debug info?
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_precompiled_library (return_value: STRING) is
			-- Precompiled file.
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_assertions (p_assertions: INTEGER) is
			-- Project assertions
			-- `p_assertions' [in].  
		do
			-- Put Implementation here.
		end

	set_title (return_value: STRING) is
			-- Project title.
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_description (return_value: STRING) is
			-- Project description.
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_company (return_value: STRING) is
			-- Project company.
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_product (return_value: STRING) is
			-- Product.
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_version (return_value: STRING) is
			-- Project version.
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_trademark (return_value: STRING) is
			-- Project trademark.
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_copyright (return_value: STRING) is
			-- Project copyright.
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_culture (return_value: STRING) is
			-- Asembly culture.
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_key_file_name (return_value: STRING) is
			-- Asembly signing key file name.
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	set_working_directory (pbstr_working_directory: STRING) is
			-- Project working directory
			-- `pbstr_working_directory' [in].  
		do
			-- Put Implementation here.
		end

	apply is
			-- Apply changes
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IEIFFEL_PROJECT_PROPERTIES_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub %"ecom_eiffel_compiler_IEiffelProjectProperties_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IEIFFEL_PROJECT_PROPERTIES_IMPL_STUB

