indexing
	description: "System Browser.  Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IEIFFEL_SYSTEM_BROWSER_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	system_classes_user_precondition: BOOLEAN is
			-- User-defined preconditions for `system_classes'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	class_count_user_precondition: BOOLEAN is
			-- User-defined preconditions for `class_count'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	system_clusters_user_precondition: BOOLEAN is
			-- User-defined preconditions for `system_clusters'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	external_clusters_user_precondition: BOOLEAN is
			-- User-defined preconditions for `external_clusters'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	cluster_count_user_precondition: BOOLEAN is
			-- User-defined preconditions for `cluster_count'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	cluster_descriptor_user_precondition (cluster_name: STRING): BOOLEAN is
			-- User-defined preconditions for `cluster_descriptor'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	class_descriptor_user_precondition (class_name1: STRING): BOOLEAN is
			-- User-defined preconditions for `class_descriptor'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	feature_descriptor_user_precondition (class_name1: STRING; feature_name: STRING): BOOLEAN is
			-- User-defined preconditions for `feature_descriptor'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	search_classes_user_precondition (a_string: STRING; is_substring: BOOLEAN): BOOLEAN is
			-- User-defined preconditions for `search_classes'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	search_features_user_precondition (a_string: STRING; is_substring: BOOLEAN): BOOLEAN is
			-- User-defined preconditions for `search_features'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	system_classes: IENUM_EIFFEL_CLASS_INTERFACE is
			-- List of classes in system.
		require
			system_classes_user_precondition: system_classes_user_precondition
		deferred

		end

	class_count: INTEGER is
			-- Number of classes in system.
		require
			class_count_user_precondition: class_count_user_precondition
		deferred

		end

	system_clusters: IENUM_CLUSTER_INTERFACE is
			-- List of system's clusters.
		require
			system_clusters_user_precondition: system_clusters_user_precondition
		deferred

		end

	external_clusters: IENUM_CLUSTER_INTERFACE is
			-- List of system's external clusters.
		require
			external_clusters_user_precondition: external_clusters_user_precondition
		deferred

		end

	cluster_count: INTEGER is
			-- Number of top-level clusters in system.
		require
			cluster_count_user_precondition: cluster_count_user_precondition
		deferred

		end

	cluster_descriptor (cluster_name: STRING): IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE is
			-- Cluster descriptor.
			-- `cluster_name' [in].  
		require
			cluster_descriptor_user_precondition: cluster_descriptor_user_precondition (cluster_name)
		deferred

		end

	class_descriptor (class_name1: STRING): IEIFFEL_CLASS_DESCRIPTOR_INTERFACE is
			-- Class descriptor.
			-- `class_name1' [in].  
		require
			class_descriptor_user_precondition: class_descriptor_user_precondition (class_name1)
		deferred

		end

	feature_descriptor (class_name1: STRING; feature_name: STRING): IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE is
			-- Feature descriptor.
			-- `class_name1' [in].  
			-- `feature_name' [in].  
		require
			feature_descriptor_user_precondition: feature_descriptor_user_precondition (class_name1, feature_name)
		deferred

		end

	search_classes (a_string: STRING; is_substring: BOOLEAN): IENUM_EIFFEL_CLASS_INTERFACE is
			-- Search classes with names matching `a_string'.
			-- `a_string' [in].  
			-- `is_substring' [in].  
		require
			search_classes_user_precondition: search_classes_user_precondition (a_string, is_substring)
		deferred

		end

	search_features (a_string: STRING; is_substring: BOOLEAN): IENUM_FEATURE_INTERFACE is
			-- Search feature with names matching `a_string'.
			-- `a_string' [in].  
			-- `is_substring' [in].  
		require
			search_features_user_precondition: search_features_user_precondition (a_string, is_substring)
		deferred

		end

end -- IEIFFEL_SYSTEM_BROWSER_INTERFACE

