indexing
	description: "Implemented `IEiffelSystemClusters' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_SYSTEM_CLUSTERS_IMPL_STUB

inherit
	IEIFFEL_SYSTEM_CLUSTERS_INTERFACE

	ECOM_STUB

feature -- Access

	cluster_tree: IENUM_CLUSTER_PROP_INTERFACE is
			-- Cluster tree.
		do
			-- Put Implementation here.
		end

	flat_clusters: IENUM_CLUSTER_PROP_INTERFACE is
			-- Cluster in a flat form.
		do
			-- Put Implementation here.
		end

feature -- Basic Operations

	store is
			-- Save changes.
		do
			-- Put Implementation here.
		end

	add_cluster (cluster_name: STRING; parent_name: STRING; cluster_path: STRING) is
			-- Add a cluster to the project.
			-- `cluster_name' [in].  
			-- `parent_name' [in].  
			-- `cluster_path' [in].  
		do
			-- Put Implementation here.
		end

	remove_cluster (cluster_name: STRING) is
			-- Remove a cluster from the project.
			-- `cluster_name' [in].  
		do
			-- Put Implementation here.
		end

	cluster_properties (cluster_name: STRING): IEIFFEL_CLUSTER_PROPERTIES_INTERFACE is
			-- Cluster properties.
			-- `cluster_name' [in].  
		do
			-- Put Implementation here.
		end

	cluster_properties_by_id (cluster_id: INTEGER): IEIFFEL_CLUSTER_PROPERTIES_INTERFACE is
			-- Cluster properties.
			-- `cluster_id' [in].  
		do
			-- Put Implementation here.
		end

	change_cluster_name (a_name: STRING; a_new_name: STRING) is
			-- Change cluster name.
			-- `a_name' [in].  
			-- `a_new_name' [in].  
		do
			-- Put Implementation here.
		end

	is_valid_name (cluster_name: STRING): BOOLEAN is
			-- Checks to see if a cluster name is valid
			-- `cluster_name' [in].  
		do
			-- Put Implementation here.
		end

	get_cluster_fullname (cluster_name: STRING): STRING is
			-- Retrieves a clusters full name from its name
			-- `cluster_name' [in].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IEIFFEL_SYSTEM_CLUSTERS_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_eiffel_compiler::IEiffelSystemClusters_impl_stub %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IEIFFEL_SYSTEM_CLUSTERS_IMPL_STUB

