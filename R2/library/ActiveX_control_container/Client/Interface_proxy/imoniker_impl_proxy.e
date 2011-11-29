note
	description: "Implemented `IMoniker' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	IMONIKER_IMPL_PROXY

inherit
	IMONIKER_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_imoniker_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	get_class_id (p_class_id: ECOM_GUID)
			-- No description available.
			-- `p_class_id' [out].  
		do
			ccom_get_class_id (initializer, p_class_id.item)
		end

	is_dirty
			-- No description available.
		do
			ccom_is_dirty (initializer)
		end

	load (pstm: ECOM_STREAM)
			-- No description available.
			-- `pstm' [in].  
		local
			pstm_item: POINTER
			a_stub: ECOM_STUB
		do
			if pstm /= Void then
				if (pstm.item = default_pointer) then
					a_stub ?= pstm
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pstm_item := pstm.item
			end
			ccom_load (initializer, pstm_item)
		end

	save (pstm: ECOM_STREAM; f_clear_dirty: INTEGER)
			-- No description available.
			-- `pstm' [in].  
			-- `f_clear_dirty' [in].  
		local
			pstm_item: POINTER
			a_stub: ECOM_STUB
		do
			if pstm /= Void then
				if (pstm.item = default_pointer) then
					a_stub ?= pstm
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pstm_item := pstm.item
			end
			ccom_save (initializer, pstm_item, f_clear_dirty)
		end

	get_size_max (pcb_size: ECOM_ULARGE_INTEGER)
			-- No description available.
			-- `pcb_size' [out].  
		do
			ccom_get_size_max (initializer, pcb_size.item)
		end

	bind_to_object (pbc: IBIND_CTX_INTERFACE; pmk_to_left: IMONIKER_INTERFACE; riid_result: ECOM_GUID; ppv_result: CELL [ECOM_INTERFACE])
			-- No description available.
			-- `pbc' [in].  
			-- `pmk_to_left' [in].  
			-- `riid_result' [in].  
			-- `ppv_result' [out].  
		local
			pbc_item: POINTER
			a_stub: ECOM_STUB
			pmk_to_left_item: POINTER
		do
			if pbc /= Void then
				if (pbc.item = default_pointer) then
					a_stub ?= pbc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pbc_item := pbc.item
			end
			if pmk_to_left /= Void then
				if (pmk_to_left.item = default_pointer) then
					a_stub ?= pmk_to_left
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pmk_to_left_item := pmk_to_left.item
			end
			ccom_bind_to_object (initializer, pbc_item, pmk_to_left_item, riid_result.item, ppv_result)
		end

	bind_to_storage (pbc: IBIND_CTX_INTERFACE; pmk_to_left: IMONIKER_INTERFACE; riid: ECOM_GUID; ppv_obj: CELL [ECOM_INTERFACE])
			-- No description available.
			-- `pbc' [in].  
			-- `pmk_to_left' [in].  
			-- `riid' [in].  
			-- `ppv_obj' [out].  
		local
			pbc_item: POINTER
			a_stub: ECOM_STUB
			pmk_to_left_item: POINTER
		do
			if pbc /= Void then
				if (pbc.item = default_pointer) then
					a_stub ?= pbc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pbc_item := pbc.item
			end
			if pmk_to_left /= Void then
				if (pmk_to_left.item = default_pointer) then
					a_stub ?= pmk_to_left
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pmk_to_left_item := pmk_to_left.item
			end
			ccom_bind_to_storage (initializer, pbc_item, pmk_to_left_item, riid.item, ppv_obj)
		end

	reduce (pbc: IBIND_CTX_INTERFACE; dw_reduce_how_far: INTEGER; ppmk_to_left: CELL [IMONIKER_INTERFACE]; ppmk_reduced: CELL [IMONIKER_INTERFACE])
			-- No description available.
			-- `pbc' [in].  
			-- `dw_reduce_how_far' [in].  
			-- `ppmk_to_left' [in, out].  
			-- `ppmk_reduced' [out].  
		local
			pbc_item: POINTER
			a_stub: ECOM_STUB
		do
			if pbc /= Void then
				if (pbc.item = default_pointer) then
					a_stub ?= pbc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pbc_item := pbc.item
			end
			ccom_reduce (initializer, pbc_item, dw_reduce_how_far, ppmk_to_left, ppmk_reduced)
		end

	compose_with (pmk_right: IMONIKER_INTERFACE; f_only_if_not_generic: INTEGER; ppmk_composite: CELL [IMONIKER_INTERFACE])
			-- No description available.
			-- `pmk_right' [in].  
			-- `f_only_if_not_generic' [in].  
			-- `ppmk_composite' [out].  
		local
			pmk_right_item: POINTER
			a_stub: ECOM_STUB
		do
			if pmk_right /= Void then
				if (pmk_right.item = default_pointer) then
					a_stub ?= pmk_right
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pmk_right_item := pmk_right.item
			end
			ccom_compose_with (initializer, pmk_right_item, f_only_if_not_generic, ppmk_composite)
		end

	enum (f_forward: INTEGER; ppenum_moniker: CELL [IENUM_MONIKER_INTERFACE])
			-- No description available.
			-- `f_forward' [in].  
			-- `ppenum_moniker' [out].  
		do
			ccom_enum (initializer, f_forward, ppenum_moniker)
		end

	is_equal1 (pmk_other_moniker: IMONIKER_INTERFACE)
			-- No description available.
			-- `pmk_other_moniker' [in].  
		local
			pmk_other_moniker_item: POINTER
			a_stub: ECOM_STUB
		do
			if pmk_other_moniker /= Void then
				if (pmk_other_moniker.item = default_pointer) then
					a_stub ?= pmk_other_moniker
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pmk_other_moniker_item := pmk_other_moniker.item
			end
			ccom_is_equal1 (initializer, pmk_other_moniker_item)
		end

	hash (pdw_hash: INTEGER_REF)
			-- No description available.
			-- `pdw_hash' [out].  
		do
			ccom_hash (initializer, pdw_hash)
		end

	is_running (pbc: IBIND_CTX_INTERFACE; pmk_to_left: IMONIKER_INTERFACE; pmk_newly_running: IMONIKER_INTERFACE)
			-- No description available.
			-- `pbc' [in].  
			-- `pmk_to_left' [in].  
			-- `pmk_newly_running' [in].  
		local
			pbc_item: POINTER
			a_stub: ECOM_STUB
			pmk_to_left_item: POINTER
			pmk_newly_running_item: POINTER
		do
			if pbc /= Void then
				if (pbc.item = default_pointer) then
					a_stub ?= pbc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pbc_item := pbc.item
			end
			if pmk_to_left /= Void then
				if (pmk_to_left.item = default_pointer) then
					a_stub ?= pmk_to_left
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pmk_to_left_item := pmk_to_left.item
			end
			if pmk_newly_running /= Void then
				if (pmk_newly_running.item = default_pointer) then
					a_stub ?= pmk_newly_running
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pmk_newly_running_item := pmk_newly_running.item
			end
			ccom_is_running (initializer, pbc_item, pmk_to_left_item, pmk_newly_running_item)
		end

	get_time_of_last_change (pbc: IBIND_CTX_INTERFACE; pmk_to_left: IMONIKER_INTERFACE; pfiletime: X_FILETIME_RECORD)
			-- No description available.
			-- `pbc' [in].  
			-- `pmk_to_left' [in].  
			-- `pfiletime' [out].  
		local
			pbc_item: POINTER
			a_stub: ECOM_STUB
			pmk_to_left_item: POINTER
		do
			if pbc /= Void then
				if (pbc.item = default_pointer) then
					a_stub ?= pbc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pbc_item := pbc.item
			end
			if pmk_to_left /= Void then
				if (pmk_to_left.item = default_pointer) then
					a_stub ?= pmk_to_left
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pmk_to_left_item := pmk_to_left.item
			end
			ccom_get_time_of_last_change (initializer, pbc_item, pmk_to_left_item, pfiletime.item)
		end

	inverse (ppmk: CELL [IMONIKER_INTERFACE])
			-- No description available.
			-- `ppmk' [out].  
		do
			ccom_inverse (initializer, ppmk)
		end

	common_prefix_with (pmk_other: IMONIKER_INTERFACE; ppmk_prefix: CELL [IMONIKER_INTERFACE])
			-- No description available.
			-- `pmk_other' [in].  
			-- `ppmk_prefix' [out].  
		local
			pmk_other_item: POINTER
			a_stub: ECOM_STUB
		do
			if pmk_other /= Void then
				if (pmk_other.item = default_pointer) then
					a_stub ?= pmk_other
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pmk_other_item := pmk_other.item
			end
			ccom_common_prefix_with (initializer, pmk_other_item, ppmk_prefix)
		end

	relative_path_to (pmk_other: IMONIKER_INTERFACE; ppmk_rel_path: CELL [IMONIKER_INTERFACE])
			-- No description available.
			-- `pmk_other' [in].  
			-- `ppmk_rel_path' [out].  
		local
			pmk_other_item: POINTER
			a_stub: ECOM_STUB
		do
			if pmk_other /= Void then
				if (pmk_other.item = default_pointer) then
					a_stub ?= pmk_other
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pmk_other_item := pmk_other.item
			end
			ccom_relative_path_to (initializer, pmk_other_item, ppmk_rel_path)
		end

	get_display_name (pbc: IBIND_CTX_INTERFACE; pmk_to_left: IMONIKER_INTERFACE; ppsz_display_name: CELL [STRING])
			-- No description available.
			-- `pbc' [in].  
			-- `pmk_to_left' [in].  
			-- `ppsz_display_name' [out].  
		local
			pbc_item: POINTER
			a_stub: ECOM_STUB
			pmk_to_left_item: POINTER
		do
			if pbc /= Void then
				if (pbc.item = default_pointer) then
					a_stub ?= pbc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pbc_item := pbc.item
			end
			if pmk_to_left /= Void then
				if (pmk_to_left.item = default_pointer) then
					a_stub ?= pmk_to_left
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pmk_to_left_item := pmk_to_left.item
			end
			ccom_get_display_name (initializer, pbc_item, pmk_to_left_item, ppsz_display_name)
		end

	parse_display_name (pbc: IBIND_CTX_INTERFACE; pmk_to_left: IMONIKER_INTERFACE; psz_display_name: STRING; pch_eaten: INTEGER_REF; ppmk_out: CELL [IMONIKER_INTERFACE])
			-- No description available.
			-- `pbc' [in].  
			-- `pmk_to_left' [in].  
			-- `psz_display_name' [in].  
			-- `pch_eaten' [out].  
			-- `ppmk_out' [out].  
		local
			pbc_item: POINTER
			a_stub: ECOM_STUB
			pmk_to_left_item: POINTER
		do
			if pbc /= Void then
				if (pbc.item = default_pointer) then
					a_stub ?= pbc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pbc_item := pbc.item
			end
			if pmk_to_left /= Void then
				if (pmk_to_left.item = default_pointer) then
					a_stub ?= pmk_to_left
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pmk_to_left_item := pmk_to_left.item
			end
			ccom_parse_display_name (initializer, pbc_item, pmk_to_left_item, psz_display_name, pch_eaten, ppmk_out)
		end

	is_system_moniker (pdw_mksys: INTEGER_REF)
			-- No description available.
			-- `pdw_mksys' [out].  
		do
			ccom_is_system_moniker (initializer, pdw_mksys)
		end

feature {NONE}  -- Implementation

	delete_wrapper
			-- Delete wrapper
		do
			ccom_delete_imoniker_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_get_class_id (cpp_obj: POINTER; p_class_id: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](GUID *)"
		end

	ccom_is_dirty (cpp_obj: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"]()"
		end

	ccom_load (cpp_obj: POINTER; pstm: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](IStream *)"
		end

	ccom_save (cpp_obj: POINTER; pstm: POINTER; f_clear_dirty: INTEGER)
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](IStream *,EIF_INTEGER)"
		end

	ccom_get_size_max (cpp_obj: POINTER; pcb_size: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](ULARGE_INTEGER *)"
		end

	ccom_bind_to_object (cpp_obj: POINTER; pbc: POINTER; pmk_to_left: POINTER; riid_result: POINTER; ppv_result: CELL [ECOM_INTERFACE])
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](::IBindCtx *,::IMoniker *,GUID *,EIF_OBJECT)"
		end

	ccom_bind_to_storage (cpp_obj: POINTER; pbc: POINTER; pmk_to_left: POINTER; riid: POINTER; ppv_obj: CELL [ECOM_INTERFACE])
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](::IBindCtx *,::IMoniker *,GUID *,EIF_OBJECT)"
		end

	ccom_reduce (cpp_obj: POINTER; pbc: POINTER; dw_reduce_how_far: INTEGER; ppmk_to_left: CELL [IMONIKER_INTERFACE]; ppmk_reduced: CELL [IMONIKER_INTERFACE])
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](::IBindCtx *,EIF_INTEGER,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_compose_with (cpp_obj: POINTER; pmk_right: POINTER; f_only_if_not_generic: INTEGER; ppmk_composite: CELL [IMONIKER_INTERFACE])
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](::IMoniker *,EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_enum (cpp_obj: POINTER; f_forward: INTEGER; ppenum_moniker: CELL [IENUM_MONIKER_INTERFACE])
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_is_equal1 (cpp_obj: POINTER; pmk_other_moniker: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](::IMoniker *)"
		end

	ccom_hash (cpp_obj: POINTER; pdw_hash: INTEGER_REF)
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_is_running (cpp_obj: POINTER; pbc: POINTER; pmk_to_left: POINTER; pmk_newly_running: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](::IBindCtx *,::IMoniker *,::IMoniker *)"
		end

	ccom_get_time_of_last_change (cpp_obj: POINTER; pbc: POINTER; pmk_to_left: POINTER; pfiletime: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](::IBindCtx *,::IMoniker *,ecom_control_library::_FILETIME *)"
		end

	ccom_inverse (cpp_obj: POINTER; ppmk: CELL [IMONIKER_INTERFACE])
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_common_prefix_with (cpp_obj: POINTER; pmk_other: POINTER; ppmk_prefix: CELL [IMONIKER_INTERFACE])
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](::IMoniker *,EIF_OBJECT)"
		end

	ccom_relative_path_to (cpp_obj: POINTER; pmk_other: POINTER; ppmk_rel_path: CELL [IMONIKER_INTERFACE])
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](::IMoniker *,EIF_OBJECT)"
		end

	ccom_get_display_name (cpp_obj: POINTER; pbc: POINTER; pmk_to_left: POINTER; ppsz_display_name: CELL [STRING])
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](::IBindCtx *,::IMoniker *,EIF_OBJECT)"
		end

	ccom_parse_display_name (cpp_obj: POINTER; pbc: POINTER; pmk_to_left: POINTER; psz_display_name: STRING; pch_eaten: INTEGER_REF; ppmk_out: CELL [IMONIKER_INTERFACE])
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](::IBindCtx *,::IMoniker *,EIF_OBJECT,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_is_system_moniker (cpp_obj: POINTER; pdw_mksys: INTEGER_REF)
			-- No description available.
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_delete_imoniker_impl_proxy (a_pointer: POINTER)
			-- Release resource
		external
			"C++ [delete ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"]()"
		end

	ccom_create_imoniker_impl_proxy_from_pointer (a_pointer: POINTER): POINTER
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER
			-- Item
		external
			"C++ [ecom_control_library::IMoniker_impl_proxy %"ecom_control_library_IMoniker_impl_proxy_s.h%"]():EIF_POINTER"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IMONIKER_IMPL_PROXY

