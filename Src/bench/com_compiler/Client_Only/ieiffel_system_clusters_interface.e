indexing
	description: "Eiffel System Clusters.  Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IEIFFEL_SYSTEM_CLUSTERS_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	cluster_tree_user_precondition: BOOLEAN is
			-- User-defined preconditions for `cluster_tree'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	flat_clusters_user_precondition: BOOLEAN is
			-- User-defined preconditions for `flat_clusters'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	store_user_precondition: BOOLEAN is
			-- User-defined preconditions for `store'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	add_cluster_user_precondition (cluster_name: STRING; parent_name: STRING; cluster_path: STRING): BOOLEAN is
			-- User-defined preconditions for `add_cluster'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	remove_cluster_user_precondition (cluster_name: STRING): BOOLEAN is
			-- User-defined preconditions for `remove_cluster'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	cluster_properties_user_precondition (cluster_name: STRING): BOOLEAN is
			-- User-defined preconditions for `cluster_properties'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	cluster_properties_by_id_user_precondition (cluster_id: INTEGER): BOOLEAN is
			-- User-defined preconditions for `cluster_properties_by_id'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	change_cluster_name_user_precondition (a_name: STRING; a_new_name: STRING): BOOLEAN is
			-- User-defined preconditions for `change_cluster_name'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	is_valid_name_user_precondition (cluster_name: STRING): BOOLEAN is
			-- User-defined preconditions for `is_valid_name'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_cluster_fullname_user_precondition (cluster_name: STRING): BOOLEAN is
			-- User-defined preconditions for `get_cluster_fullname'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	cluster_tree: IENUM_CLUSTER_PROP_INTERFACE is
			-- Cluster tree.
		require
			cluster_tree_user_precondition: cluster_tree_user_precondition
		deferred

		end

	flat_clusters: IENUM_CLUSTER_PROP_INTERFACE is
			-- Cluster in a flat form.
		require
			flat_clusters_user_precondition: flat_clusters_user_precondition
		deferred

		end

	store is
			-- Save changes.
		require
			store_user_precondition: store_user_precondition
		deferred

		end

	add_cluster (cluster_name: STRING; parent_name: STRING; cluster_path: STRING) is
			-- Add a cluster to the project.
			-- `cluster_name' [in].  
			-- `parent_name' [in].  
			-- `cluster_path' [in].  
		require
			add_cluster_user_precondition: add_cluster_user_precondition (cluster_name, parent_name, cluster_path)
		deferred

		end

	remove_cluster (cluster_name: STRING) is
			-- Remove a cluster from the project.
			-- `cluster_name' [in].  
		require
			remove_cluster_user_precondition: remove_cluster_user_precondition (cluster_name)
		deferred

		end

	cluster_properties (cluster_name: STRING): IEIFFEL_CLUSTER_PROPERTIES_INTERFACE is
			-- Cluster properties.
			-- `cluster_name' [in].  
		require
			cluster_properties_user_precondition: cluster_properties_user_precondition (cluster_name)
		deferred

		end

	cluster_properties_by_id (cluster_id: INTEGER): IEIFFEL_CLUSTER_PROPERTIES_INTERFACE is
			-- Cluster properties.
			-- `cluster_id' [in].  
		require
			cluster_properties_by_id_user_precondition: cluster_properties_by_id_user_precondition (cluster_id)
		deferred

		end

	change_cluster_name (a_name: STRING; a_new_name: STRING) is
			-- Change cluster name.
			-- `a_name' [in].  
			-- `a_new_name' [in].  
		require
			change_cluster_name_user_precondition: change_cluster_name_user_precondition (a_name, a_new_name)
		deferred

		end

	is_valid_name (cluster_name: STRING): BOOLEAN is
			-- Checks to see if a cluster name is valid
			-- `cluster_name' [in].  
		require
			is_valid_name_user_precondition: is_valid_name_user_precondition (cluster_name)
		deferred

		end

	get_cluster_fullname (cluster_name: STRING): STRING is
			-- Retrieves a clusters full name from its name
			-- `cluster_name' [in].  
		require
			get_cluster_fullname_user_precondition: get_cluster_fullname_user_precondition (cluster_name)
		deferred

		end

end -- IEIFFEL_SYSTEM_CLUSTERS_INTERFACE

