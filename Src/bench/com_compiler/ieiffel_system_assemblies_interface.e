indexing
	description: "Eiffel System Assemblies.  Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	store_user_precondition: BOOLEAN is
			-- User-defined preconditions for `store'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	add_assembly_user_precondition (assembly_prefix: STRING; cluster_name: STRING; a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING): BOOLEAN is
			-- User-defined preconditions for `add_assembly'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	remove_assembly_user_precondition (assembly_identifier: STRING): BOOLEAN is
			-- User-defined preconditions for `remove_assembly'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	assembly_properties_user_precondition (cluster_name: STRING): BOOLEAN is
			-- User-defined preconditions for `assembly_properties'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	is_valid_cluster_name_user_precondition (cluster_name: STRING): BOOLEAN is
			-- User-defined preconditions for `is_valid_cluster_name'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	contains_assembly_user_precondition (cluster_name: STRING): BOOLEAN is
			-- User-defined preconditions for `contains_assembly'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	contains_signed_assembly_user_precondition (a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING): BOOLEAN is
			-- User-defined preconditions for `contains_signed_assembly'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	contains_unsigned_assembly_user_precondition (a_path: STRING): BOOLEAN is
			-- User-defined preconditions for `contains_unsigned_assembly'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	cluster_name_from_signed_assembly_user_precondition (a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING): BOOLEAN is
			-- User-defined preconditions for `cluster_name_from_signed_assembly'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	cluster_name_from_unsigned_assembly_user_precondition (a_path: STRING): BOOLEAN is
			-- User-defined preconditions for `cluster_name_from_unsigned_assembly'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	is_valid_prefix_user_precondition (assembly_prefix: STRING): BOOLEAN is
			-- User-defined preconditions for `is_valid_prefix'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	is_prefix_allocated_user_precondition (assembly_prefix: STRING): BOOLEAN is
			-- User-defined preconditions for `is_prefix_allocated'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	assemblies_user_precondition: BOOLEAN is
			-- User-defined preconditions for `assemblies'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	store is
			-- Save changes.
		require
			store_user_precondition: store_user_precondition
		deferred

		end

	add_assembly (assembly_prefix: STRING; cluster_name: STRING; a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING) is
			-- Add a signed assembly to the project.
			-- `assembly_prefix' [in].  
			-- `cluster_name' [in].  
			-- `a_name' [in].  
			-- `a_version' [in].  
			-- `a_culture' [in].  
			-- `a_publickey' [in].  
		require
			add_assembly_user_precondition: add_assembly_user_precondition (assembly_prefix, cluster_name, a_name, a_version, a_culture, a_publickey)
		deferred

		end

	remove_assembly (assembly_identifier: STRING) is
			-- Remove an assembly from the project.
			-- `assembly_identifier' [in].  
		require
			remove_assembly_user_precondition: remove_assembly_user_precondition (assembly_identifier)
		deferred

		end

	assembly_properties (cluster_name: STRING): IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE is
			-- Assembly properties.
			-- `cluster_name' [in].  
		require
			assembly_properties_user_precondition: assembly_properties_user_precondition (cluster_name)
		deferred

		end

	is_valid_cluster_name (cluster_name: STRING): BOOLEAN is
			-- Checks to see if a assembly cluster name is valid
			-- `cluster_name' [in].  
		require
			is_valid_cluster_name_user_precondition: is_valid_cluster_name_user_precondition (cluster_name)
		deferred

		end

	contains_assembly (cluster_name: STRING): BOOLEAN is
			-- Checks to see if a assembly cluster name has already been added to the project
			-- `cluster_name' [in].  
		require
			contains_assembly_user_precondition: contains_assembly_user_precondition (cluster_name)
		deferred

		end

	contains_signed_assembly (a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING): BOOLEAN is
			-- Checks to see if a signed assembly has already been added to the project
			-- `a_name' [in].  
			-- `a_version' [in].  
			-- `a_culture' [in].  
			-- `a_publickey' [in].  
		require
			contains_signed_assembly_user_precondition: contains_signed_assembly_user_precondition (a_name, a_version, a_culture, a_publickey)
		deferred

		end

	contains_unsigned_assembly (a_path: STRING): BOOLEAN is
			-- Checks to see if a unsigned assembly has already been added to the project
			-- `a_path' [in].  
		require
			contains_unsigned_assembly_user_precondition: contains_unsigned_assembly_user_precondition (a_path)
		deferred

		end

	cluster_name_from_signed_assembly (a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING): STRING is
			-- Retrieves the cluster name for a signed assembly in the project
			-- `a_name' [in].  
			-- `a_version' [in].  
			-- `a_culture' [in].  
			-- `a_publickey' [in].  
		require
			cluster_name_from_signed_assembly_user_precondition: cluster_name_from_signed_assembly_user_precondition (a_name, a_version, a_culture, a_publickey)
		deferred

		end

	cluster_name_from_unsigned_assembly (a_path: STRING): STRING is
			-- Retrieves the cluster name for a unsigned assembly in the project
			-- `a_path' [in].  
		require
			cluster_name_from_unsigned_assembly_user_precondition: cluster_name_from_unsigned_assembly_user_precondition (a_path)
		deferred

		end

	is_valid_prefix (assembly_prefix: STRING): BOOLEAN is
			-- Is 'prefix' a valid assembly prefix
			-- `assembly_prefix' [in].  
		require
			is_valid_prefix_user_precondition: is_valid_prefix_user_precondition (assembly_prefix)
		deferred

		end

	is_prefix_allocated (assembly_prefix: STRING): BOOLEAN is
			-- Has the 'prefix' already been allocated to another assembly
			-- `assembly_prefix' [in].  
		require
			is_prefix_allocated_user_precondition: is_prefix_allocated_user_precondition (assembly_prefix)
		deferred

		end

	assemblies: IENUM_ASSEMBLY_INTERFACE is
			-- Returns all of the assemblies in an enumerator
		require
			assemblies_user_precondition: assemblies_user_precondition
		deferred

		end

end -- IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE

