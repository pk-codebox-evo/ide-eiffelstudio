indexing
	description: "Implemented `_UndefineClause' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	X_UNDEFINE_CLAUSE_IMPL_PROXY

inherit
	X_UNDEFINE_CLAUSE_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_x_undefine_clause_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Access

	to_string: STRING is
			-- No description available.
		do
			Result := ccom_to_string (initializer)
		end

	get_hash_code: INTEGER is
			-- No description available.
		do
			Result := ccom_get_hash_code (initializer)
		end

	get_type: INTEGER is
			-- No description available.
		do
			Result := ccom_get_type (initializer)
		end

	source_name: STRING is
			-- No description available.
		do
			Result := ccom_source_name (initializer)
		end

	string_representation: STRING is
			-- No description available.
		do
			Result := ccom_string_representation (initializer)
		end

	eiffel_keyword: STRING is
			-- No description available.
		do
			Result := ccom_eiffel_keyword (initializer)
		end

	x_internal_source_name: STRING is
			-- No description available.
		do
			Result := ccom_x_internal_source_name (initializer)
		end

	undefine_keyword: STRING is
			-- No description available.
		do
			Result := ccom_undefine_keyword (initializer)
		end

feature -- Status Report

	last_error_code: INTEGER is
			-- Last error code.
		do
			Result := ccom_last_error_code (initializer)
		end

	last_error_description: STRING is
			-- Last error description.
		do
			Result := ccom_last_error_description (initializer)
		end

	last_error_help_file: STRING is
			-- Last error help file.
		do
			Result := ccom_last_error_help_file (initializer)
		end

	last_source_of_exception: STRING is
			-- Last source of exception.
		do
			Result := ccom_last_source_of_exception (initializer)
		end

feature -- Basic Operations

	equals (obj: POINTER_REF): BOOLEAN is
			-- No description available.
			-- `obj' [in].  
		do
			Result := ccom_equals (initializer, obj.item)
		end

	set_source_name (a_source_name: STRING) is
			-- No description available.
			-- `a_source_name' [in].  
		do
			ccom_set_source_name (initializer, a_source_name)
		end

	set__internal_source_name (p_ret_val: STRING) is
			-- No description available.
			-- `p_ret_val' [in].  
		do
			ccom_set__internal_source_name (initializer, p_ret_val)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_x_undefine_clause_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_to_string (cpp_obj: POINTER): STRING is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_equals (cpp_obj: POINTER; obj: POINTER): BOOLEAN is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"](VARIANT *): EIF_BOOLEAN"
		end

	ccom_get_hash_code (cpp_obj: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"](): EIF_INTEGER"
		end

	ccom_get_type (cpp_obj: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"](): EIF_INTEGER"
		end

	ccom_source_name (cpp_obj: POINTER): STRING is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_string_representation (cpp_obj: POINTER): STRING is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_eiffel_keyword (cpp_obj: POINTER): STRING is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_set_source_name (cpp_obj: POINTER; a_source_name: STRING) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_x_internal_source_name (cpp_obj: POINTER): STRING is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_set__internal_source_name (cpp_obj: POINTER; p_ret_val: STRING) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_undefine_keyword (cpp_obj: POINTER): STRING is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_delete_x_undefine_clause_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"]()"
		end

	ccom_create_x_undefine_clause_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"]():EIF_POINTER"
		end

	ccom_last_error_code (cpp_obj: POINTER): INTEGER is
			-- Last error code
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"]():EIF_INTEGER"
		end

	ccom_last_error_description (cpp_obj: POINTER): STRING is
			-- Last error description
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"]():EIF_REFERENCE"
		end

	ccom_last_error_help_file (cpp_obj: POINTER): STRING is
			-- Last error help file
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"]():EIF_REFERENCE"
		end

	ccom_last_source_of_exception (cpp_obj: POINTER): STRING is
			-- Last source of exception
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_UndefineClause_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__UndefineClause_impl_proxy.h%"]():EIF_REFERENCE"
		end

end -- X_UNDEFINE_CLAUSE_IMPL_PROXY

