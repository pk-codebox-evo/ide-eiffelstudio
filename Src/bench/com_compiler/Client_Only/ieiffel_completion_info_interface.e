indexing
	description: "Eiffel Completion info. Eiffel language compiler library. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IEIFFEL_COMPLETION_INFO_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	add_local_user_precondition (bstr_name: STRING; bstr_type: STRING): BOOLEAN is
			-- User-defined preconditions for `add_local'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	add_argument_user_precondition (bstr_name: STRING; bstr_type: STRING): BOOLEAN is
			-- User-defined preconditions for `add_argument'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	target_features_user_precondition (bstr_target: STRING; bstr_feature_name: STRING; bstr_file_name: STRING; pvar_names: ECOM_VARIANT; pvar_signatures: ECOM_VARIANT; pvar_image_indexes: ECOM_VARIANT): BOOLEAN is
			-- User-defined preconditions for `target_features'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	target_feature_user_precondition (bstr_target: STRING; bstr_feature_name: STRING; bstr_file_name: STRING): BOOLEAN is
			-- User-defined preconditions for `target_feature'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	flush_completion_features_user_precondition (bstr_file_name: STRING): BOOLEAN is
			-- User-defined preconditions for `flush_completion_features'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	initialize_feature_user_precondition (bstr_name: STRING; var_arguments: ECOM_VARIANT; var_argument_types: ECOM_VARIANT; bstr_return_type: STRING; ul_feature_type: INTEGER; bstr_file_name: STRING): BOOLEAN is
			-- User-defined preconditions for `initialize_feature'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	add_local (bstr_name: STRING; bstr_type: STRING) is
			-- Add a local variable used for solving member completion list
			-- `bstr_name' [in].  
			-- `bstr_type' [in].  
		require
			add_local_user_precondition: add_local_user_precondition (bstr_name, bstr_type)
		deferred

		end

	add_argument (bstr_name: STRING; bstr_type: STRING) is
			-- Add an argument used for solving member completion list
			-- `bstr_name' [in].  
			-- `bstr_type' [in].  
		require
			add_argument_user_precondition: add_argument_user_precondition (bstr_name, bstr_type)
		deferred

		end

	target_features (bstr_target: STRING; bstr_feature_name: STRING; bstr_file_name: STRING; pvar_names: ECOM_VARIANT; pvar_signatures: ECOM_VARIANT; pvar_image_indexes: ECOM_VARIANT) is
			-- Features accessible from target.
			-- `bstr_target' [in].  
			-- `bstr_feature_name' [in].  
			-- `bstr_file_name' [in].  
			-- `pvar_names' [out].  
			-- `pvar_signatures' [out].  
			-- `pvar_image_indexes' [out].  
		require
			non_void_pvar_names: pvar_names /= Void
			valid_pvar_names: pvar_names.item /= default_pointer
			non_void_pvar_signatures: pvar_signatures /= Void
			valid_pvar_signatures: pvar_signatures.item /= default_pointer
			non_void_pvar_image_indexes: pvar_image_indexes /= Void
			valid_pvar_image_indexes: pvar_image_indexes.item /= default_pointer
			target_features_user_precondition: target_features_user_precondition (bstr_target, bstr_feature_name, bstr_file_name, pvar_names, pvar_signatures, pvar_image_indexes)
		deferred

		end

	target_feature (bstr_target: STRING; bstr_feature_name: STRING; bstr_file_name: STRING): IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE is
			-- Feature information
			-- `bstr_target' [in].  
			-- `bstr_feature_name' [in].  
			-- `bstr_file_name' [in].  
		require
			target_feature_user_precondition: target_feature_user_precondition (bstr_target, bstr_feature_name, bstr_file_name)
		deferred

		end

	flush_completion_features (bstr_file_name: STRING) is
			-- Flush temporary completion features for a specific file
			-- `bstr_file_name' [in].  
		require
			flush_completion_features_user_precondition: flush_completion_features_user_precondition (bstr_file_name)
		deferred

		end

	initialize_feature (bstr_name: STRING; var_arguments: ECOM_VARIANT; var_argument_types: ECOM_VARIANT; bstr_return_type: STRING; ul_feature_type: INTEGER; bstr_file_name: STRING) is
			-- Initialize a feature for completion without compiltation
			-- `bstr_name' [in].  
			-- `var_arguments' [in].  
			-- `var_argument_types' [in].  
			-- `bstr_return_type' [in].  
			-- `ul_feature_type' [in].  
			-- `bstr_file_name' [in].  
		require
			non_void_var_arguments: var_arguments /= Void
			valid_var_arguments: var_arguments.item /= default_pointer
			non_void_var_argument_types: var_argument_types /= Void
			valid_var_argument_types: var_argument_types.item /= default_pointer
			initialize_feature_user_precondition: initialize_feature_user_precondition (bstr_name, var_arguments, var_argument_types, bstr_return_type, ul_feature_type, bstr_file_name)
		deferred

		end

end -- IEIFFEL_COMPLETION_INFO_INTERFACE

