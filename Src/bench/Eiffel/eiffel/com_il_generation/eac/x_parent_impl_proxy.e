indexing
	description: "Implemented `_Parent' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	X_PARENT_IMPL_PROXY

inherit
	X_PARENT_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_x_parent_impl_proxy_from_pointer(cpp_obj)
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

	rename_clauses: ECOM_INTERFACE is
			-- No description available.
		do
			Result := ccom_rename_clauses (initializer)
		end

	export_clauses: ECOM_INTERFACE is
			-- No description available.
		do
			Result := ccom_export_clauses (initializer)
		end

	name: STRING is
			-- No description available.
		do
			Result := ccom_name (initializer)
		end

	select_clauses: ECOM_INTERFACE is
			-- No description available.
		do
			Result := ccom_select_clauses (initializer)
		end

	redefine_clauses: ECOM_INTERFACE is
			-- No description available.
		do
			Result := ccom_redefine_clauses (initializer)
		end

	undefine_clauses: ECOM_INTERFACE is
			-- No description available.
		do
			Result := ccom_undefine_clauses (initializer)
		end

	x_internal_rename_clauses: ECOM_INTERFACE is
			-- No description available.
		do
			Result := ccom_x_internal_rename_clauses (initializer)
		end

	x_internal_export_clauses: ECOM_INTERFACE is
			-- No description available.
		do
			Result := ccom_x_internal_export_clauses (initializer)
		end

	x_internal_name: STRING is
			-- No description available.
		do
			Result := ccom_x_internal_name (initializer)
		end

	x_internal_select_clauses: ECOM_INTERFACE is
			-- No description available.
		do
			Result := ccom_x_internal_select_clauses (initializer)
		end

	x_internal_redefine_clauses: ECOM_INTERFACE is
			-- No description available.
		do
			Result := ccom_x_internal_redefine_clauses (initializer)
		end

	x_internal_undefine_clauses: ECOM_INTERFACE is
			-- No description available.
		do
			Result := ccom_x_internal_undefine_clauses (initializer)
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

	add_select_clause (a_clause: X_SELECT_CLAUSE_INTERFACE) is
			-- No description available.
			-- `a_clause' [in].  
		local
			a_clause_item: POINTER
			a_stub: ECOM_STUB
		do
			if a_clause /= Void then
				if (a_clause.item = default_pointer) then
					a_stub ?= a_clause
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				a_clause_item := a_clause.item
			end
			ccom_add_select_clause (initializer, a_clause_item)
		end

	set_redefine_clauses (a_list: ECOM_INTERFACE) is
			-- No description available.
			-- `a_list' [in].  
		local
			a_list_item: POINTER
			a_stub: ECOM_STUB
		do
			if a_list /= Void then
				if (a_list.item = default_pointer) then
					a_stub ?= a_list
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				a_list_item := a_list.item
			end
			ccom_set_redefine_clauses (initializer, a_list_item)
		end

	set_undefine_clauses (a_list: ECOM_INTERFACE) is
			-- No description available.
			-- `a_list' [in].  
		local
			a_list_item: POINTER
			a_stub: ECOM_STUB
		do
			if a_list /= Void then
				if (a_list.item = default_pointer) then
					a_stub ?= a_list
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				a_list_item := a_list.item
			end
			ccom_set_undefine_clauses (initializer, a_list_item)
		end

	set_export_clauses (a_list: ECOM_INTERFACE) is
			-- No description available.
			-- `a_list' [in].  
		local
			a_list_item: POINTER
			a_stub: ECOM_STUB
		do
			if a_list /= Void then
				if (a_list.item = default_pointer) then
					a_stub ?= a_list
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				a_list_item := a_list.item
			end
			ccom_set_export_clauses (initializer, a_list_item)
		end

	set_name (a_name: STRING) is
			-- No description available.
			-- `a_name' [in].  
		do
			ccom_set_name (initializer, a_name)
		end

	set_rename_clauses (a_list: ECOM_INTERFACE) is
			-- No description available.
			-- `a_list' [in].  
		local
			a_list_item: POINTER
			a_stub: ECOM_STUB
		do
			if a_list /= Void then
				if (a_list.item = default_pointer) then
					a_stub ?= a_list
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				a_list_item := a_list.item
			end
			ccom_set_rename_clauses (initializer, a_list_item)
		end

	add_undefine_clause (a_clause: X_UNDEFINE_CLAUSE_INTERFACE) is
			-- No description available.
			-- `a_clause' [in].  
		local
			a_clause_item: POINTER
			a_stub: ECOM_STUB
		do
			if a_clause /= Void then
				if (a_clause.item = default_pointer) then
					a_stub ?= a_clause
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				a_clause_item := a_clause.item
			end
			ccom_add_undefine_clause (initializer, a_clause_item)
		end

	add_export_clause (a_clause: X_EXPORT_CLAUSE_INTERFACE) is
			-- No description available.
			-- `a_clause' [in].  
		local
			a_clause_item: POINTER
			a_stub: ECOM_STUB
		do
			if a_clause /= Void then
				if (a_clause.item = default_pointer) then
					a_stub ?= a_clause
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				a_clause_item := a_clause.item
			end
			ccom_add_export_clause (initializer, a_clause_item)
		end

	add_redefine_clause (a_clause: X_REDEFINE_CLAUSE_INTERFACE) is
			-- No description available.
			-- `a_clause' [in].  
		local
			a_clause_item: POINTER
			a_stub: ECOM_STUB
		do
			if a_clause /= Void then
				if (a_clause.item = default_pointer) then
					a_stub ?= a_clause
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				a_clause_item := a_clause.item
			end
			ccom_add_redefine_clause (initializer, a_clause_item)
		end

	add_rename_clause (a_clause: X_RENAME_CLAUSE_INTERFACE) is
			-- No description available.
			-- `a_clause' [in].  
		local
			a_clause_item: POINTER
			a_stub: ECOM_STUB
		do
			if a_clause /= Void then
				if (a_clause.item = default_pointer) then
					a_stub ?= a_clause
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				a_clause_item := a_clause.item
			end
			ccom_add_rename_clause (initializer, a_clause_item)
		end

	make1 (a_name: STRING) is
			-- No description available.
			-- `a_name' [in].  
		do
			ccom_make1 (initializer, a_name)
		end

	set_select_clauses (a_list: ECOM_INTERFACE) is
			-- No description available.
			-- `a_list' [in].  
		local
			a_list_item: POINTER
			a_stub: ECOM_STUB
		do
			if a_list /= Void then
				if (a_list.item = default_pointer) then
					a_stub ?= a_list
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				a_list_item := a_list.item
			end
			ccom_set_select_clauses (initializer, a_list_item)
		end

	set_ref__internal_rename_clauses (p_ret_val: ECOM_INTERFACE) is
			-- No description available.
			-- `p_ret_val' [in].  
		local
			p_ret_val_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_ret_val /= Void then
				if (p_ret_val.item = default_pointer) then
					a_stub ?= p_ret_val
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_ret_val_item := p_ret_val.item
			end
			ccom_set_ref__internal_rename_clauses (initializer, p_ret_val_item)
		end

	set_ref__internal_export_clauses (p_ret_val: ECOM_INTERFACE) is
			-- No description available.
			-- `p_ret_val' [in].  
		local
			p_ret_val_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_ret_val /= Void then
				if (p_ret_val.item = default_pointer) then
					a_stub ?= p_ret_val
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_ret_val_item := p_ret_val.item
			end
			ccom_set_ref__internal_export_clauses (initializer, p_ret_val_item)
		end

	set__internal_name (p_ret_val: STRING) is
			-- No description available.
			-- `p_ret_val' [in].  
		do
			ccom_set__internal_name (initializer, p_ret_val)
		end

	set_ref__internal_select_clauses (p_ret_val: ECOM_INTERFACE) is
			-- No description available.
			-- `p_ret_val' [in].  
		local
			p_ret_val_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_ret_val /= Void then
				if (p_ret_val.item = default_pointer) then
					a_stub ?= p_ret_val
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_ret_val_item := p_ret_val.item
			end
			ccom_set_ref__internal_select_clauses (initializer, p_ret_val_item)
		end

	set_ref__internal_redefine_clauses (p_ret_val: ECOM_INTERFACE) is
			-- No description available.
			-- `p_ret_val' [in].  
		local
			p_ret_val_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_ret_val /= Void then
				if (p_ret_val.item = default_pointer) then
					a_stub ?= p_ret_val
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_ret_val_item := p_ret_val.item
			end
			ccom_set_ref__internal_redefine_clauses (initializer, p_ret_val_item)
		end

	set_ref__internal_undefine_clauses (p_ret_val: ECOM_INTERFACE) is
			-- No description available.
			-- `p_ret_val' [in].  
		local
			p_ret_val_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_ret_val /= Void then
				if (p_ret_val.item = default_pointer) then
					a_stub ?= p_ret_val
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_ret_val_item := p_ret_val.item
			end
			ccom_set_ref__internal_undefine_clauses (initializer, p_ret_val_item)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_x_parent_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_to_string (cpp_obj: POINTER): STRING is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_equals (cpp_obj: POINTER; obj: POINTER): BOOLEAN is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](VARIANT *): EIF_BOOLEAN"
		end

	ccom_get_hash_code (cpp_obj: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_INTEGER"
		end

	ccom_get_type (cpp_obj: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_INTEGER"
		end

	ccom_add_select_clause (cpp_obj: POINTER; a_clause: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](ecom_ISE_Reflection_EiffelComponents::_SelectClause *)"
		end

	ccom_set_redefine_clauses (cpp_obj: POINTER; a_list: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](IDispatch *)"
		end

	ccom_set_undefine_clauses (cpp_obj: POINTER; a_list: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](IDispatch *)"
		end

	ccom_set_export_clauses (cpp_obj: POINTER; a_list: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](IDispatch *)"
		end

	ccom_set_name (cpp_obj: POINTER; a_name: STRING) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_rename_clauses (cpp_obj: POINTER): ECOM_INTERFACE is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_export_clauses (cpp_obj: POINTER): ECOM_INTERFACE is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_set_rename_clauses (cpp_obj: POINTER; a_list: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](IDispatch *)"
		end

	ccom_add_undefine_clause (cpp_obj: POINTER; a_clause: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](ecom_ISE_Reflection_EiffelComponents::_UndefineClause *)"
		end

	ccom_name (cpp_obj: POINTER): STRING is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_add_export_clause (cpp_obj: POINTER; a_clause: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](ecom_ISE_Reflection_EiffelComponents::_ExportClause *)"
		end

	ccom_select_clauses (cpp_obj: POINTER): ECOM_INTERFACE is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_add_redefine_clause (cpp_obj: POINTER; a_clause: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](ecom_ISE_Reflection_EiffelComponents::_RedefineClause *)"
		end

	ccom_redefine_clauses (cpp_obj: POINTER): ECOM_INTERFACE is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_undefine_clauses (cpp_obj: POINTER): ECOM_INTERFACE is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_add_rename_clause (cpp_obj: POINTER; a_clause: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](ecom_ISE_Reflection_EiffelComponents::_RenameClause *)"
		end

	ccom_make1 (cpp_obj: POINTER; a_name: STRING) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_set_select_clauses (cpp_obj: POINTER; a_list: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](IDispatch *)"
		end

	ccom_x_internal_rename_clauses (cpp_obj: POINTER): ECOM_INTERFACE is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_set_ref__internal_rename_clauses (cpp_obj: POINTER; p_ret_val: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](IDispatch *)"
		end

	ccom_x_internal_export_clauses (cpp_obj: POINTER): ECOM_INTERFACE is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_set_ref__internal_export_clauses (cpp_obj: POINTER; p_ret_val: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](IDispatch *)"
		end

	ccom_x_internal_name (cpp_obj: POINTER): STRING is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_set__internal_name (cpp_obj: POINTER; p_ret_val: STRING) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_x_internal_select_clauses (cpp_obj: POINTER): ECOM_INTERFACE is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_set_ref__internal_select_clauses (cpp_obj: POINTER; p_ret_val: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](IDispatch *)"
		end

	ccom_x_internal_redefine_clauses (cpp_obj: POINTER): ECOM_INTERFACE is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_set_ref__internal_redefine_clauses (cpp_obj: POINTER; p_ret_val: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](IDispatch *)"
		end

	ccom_x_internal_undefine_clauses (cpp_obj: POINTER): ECOM_INTERFACE is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_set_ref__internal_undefine_clauses (cpp_obj: POINTER; p_ret_val: POINTER) is
			-- No description available.
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](IDispatch *)"
		end

	ccom_delete_x_parent_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"]()"
		end

	ccom_create_x_parent_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"]():EIF_POINTER"
		end

	ccom_last_error_code (cpp_obj: POINTER): INTEGER is
			-- Last error code
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"]():EIF_INTEGER"
		end

	ccom_last_error_description (cpp_obj: POINTER): STRING is
			-- Last error description
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"]():EIF_REFERENCE"
		end

	ccom_last_error_help_file (cpp_obj: POINTER): STRING is
			-- Last error help file
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"]():EIF_REFERENCE"
		end

	ccom_last_source_of_exception (cpp_obj: POINTER): STRING is
			-- Last source of exception
		external
			"C++ [ecom_ISE_Reflection_EiffelComponents::_Parent_impl_proxy %"ecom_ISE_Reflection_EiffelComponents__Parent_impl_proxy.h%"]():EIF_REFERENCE"
		end

end -- X_PARENT_IMPL_PROXY

