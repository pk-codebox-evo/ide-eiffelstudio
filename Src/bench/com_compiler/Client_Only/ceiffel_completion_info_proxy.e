indexing
	description: " Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	CEIFFEL_COMPLETION_INFO_PROXY

inherit
	IEIFFEL_COMPLETION_INFO_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_ceiffel_completion_info_coclass_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	add_local (name: STRING; type: STRING) is
			-- Add a local variable used for solving member completion list
			-- `name' [in].  
			-- `type' [in].  
		do
			ccom_add_local (initializer, name, type)
		end

	add_argument (name: STRING; type: STRING) is
			-- Add an argument used for solving member completion list
			-- `name' [in].  
			-- `type' [in].  
		do
			ccom_add_argument (initializer, name, type)
		end

	target_features (target: STRING; feature_name: STRING; file_name: STRING; return_names: ECOM_VARIANT; return_signatures: ECOM_VARIANT; return_image_indexes: ECOM_VARIANT) is
			-- Features accessible from target.
			-- `target' [in].  
			-- `feature_name' [in].  
			-- `file_name' [in].  
			-- `return_names' [out].  
			-- `return_signatures' [out].  
			-- `return_image_indexes' [out].  
		do
			ccom_target_features (initializer, target, feature_name, file_name, return_names.item, return_signatures.item, return_image_indexes.item)
		end

	target_feature (target: STRING; feature_name: STRING; file_name: STRING): IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE is
			-- Feature information
			-- `target' [in].  
			-- `feature_name' [in].  
			-- `file_name' [in].  
		do
			Result := ccom_target_feature (initializer, target, feature_name, file_name)
		end

	flush_completion_features (a_file_name: STRING) is
			-- Flush temporary completion features for a specifi file
			-- `a_file_name' [in].  
		do
			ccom_flush_completion_features (initializer, a_file_name)
		end

	initialize_feature (a_name: STRING; a_arguments: ECOM_VARIANT; a_argument_types: ECOM_VARIANT; a_return_type: STRING; a_feature_type: INTEGER; a_file_name: STRING) is
			-- Initialize a feature for completion without compiltation
			-- `a_name' [in].  
			-- `a_arguments' [in].  
			-- `a_argument_types' [in].  
			-- `a_return_type' [in].  
			-- `a_feature_type' [in].  
			-- `a_file_name' [in].  
		do
			ccom_initialize_feature (initializer, a_name, a_arguments.item, a_argument_types.item, a_return_type, a_feature_type, a_file_name)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_ceiffel_completion_info_coclass(initializer)
		end

feature {NONE}  -- Externals

	ccom_add_local (cpp_obj: POINTER; name: STRING; type: STRING) is
			-- Add a local variable used for solving member completion list
		external
			"C++ [ecom_eiffel_compiler::CEiffelCompletionInfo %"ecom_eiffel_compiler_CEiffelCompletionInfo.h%"](EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_add_argument (cpp_obj: POINTER; name: STRING; type: STRING) is
			-- Add an argument used for solving member completion list
		external
			"C++ [ecom_eiffel_compiler::CEiffelCompletionInfo %"ecom_eiffel_compiler_CEiffelCompletionInfo.h%"](EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_target_features (cpp_obj: POINTER; target: STRING; feature_name: STRING; file_name: STRING; return_names: POINTER; return_signatures: POINTER; return_image_indexes: POINTER) is
			-- Features accessible from target.
		external
			"C++ [ecom_eiffel_compiler::CEiffelCompletionInfo %"ecom_eiffel_compiler_CEiffelCompletionInfo.h%"](EIF_OBJECT,EIF_OBJECT,EIF_OBJECT,VARIANT *,VARIANT *,VARIANT *)"
		end

	ccom_target_feature (cpp_obj: POINTER; target: STRING; feature_name: STRING; file_name: STRING): IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE is
			-- Feature information
		external
			"C++ [ecom_eiffel_compiler::CEiffelCompletionInfo %"ecom_eiffel_compiler_CEiffelCompletionInfo.h%"](EIF_OBJECT,EIF_OBJECT,EIF_OBJECT): EIF_REFERENCE"
		end

	ccom_flush_completion_features (cpp_obj: POINTER; a_file_name: STRING) is
			-- Flush temporary completion features for a specifi file
		external
			"C++ [ecom_eiffel_compiler::CEiffelCompletionInfo %"ecom_eiffel_compiler_CEiffelCompletionInfo.h%"](EIF_OBJECT)"
		end

	ccom_initialize_feature (cpp_obj: POINTER; a_name: STRING; a_arguments: POINTER; a_argument_types: POINTER; a_return_type: STRING; a_feature_type: INTEGER; a_file_name: STRING) is
			-- Initialize a feature for completion without compiltation
		external
			"C++ [ecom_eiffel_compiler::CEiffelCompletionInfo %"ecom_eiffel_compiler_CEiffelCompletionInfo.h%"](EIF_OBJECT,VARIANT *,VARIANT *,EIF_OBJECT,EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_delete_ceiffel_completion_info_coclass (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_eiffel_compiler::CEiffelCompletionInfo %"ecom_eiffel_compiler_CEiffelCompletionInfo.h%"]()"
		end

	ccom_create_ceiffel_completion_info_coclass_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_eiffel_compiler::CEiffelCompletionInfo %"ecom_eiffel_compiler_CEiffelCompletionInfo.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_eiffel_compiler::CEiffelCompletionInfo %"ecom_eiffel_compiler_CEiffelCompletionInfo.h%"]():EIF_POINTER"
		end

end -- CEIFFEL_COMPLETION_INFO_PROXY

