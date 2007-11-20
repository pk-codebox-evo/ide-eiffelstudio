indexing
	description: "Implemented `IBindHost' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IBIND_HOST_IMPL_PROXY

inherit
	IBIND_HOST_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_ibind_host_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	create_moniker (sz_name: STRING; pbc: IBIND_CTX_INTERFACE; ppmk: CELL [IMONIKER_INTERFACE]; dw_reserved: INTEGER) is
			-- No description available.
			-- `sz_name' [in].  
			-- `pbc' [in].  
			-- `ppmk' [out].  
			-- `dw_reserved' [in].  
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
			ccom_create_moniker (initializer, sz_name, pbc_item, ppmk, dw_reserved)
		end

	moniker_bind_to_storage (pmk: IMONIKER_INTERFACE; pbc: IBIND_CTX_INTERFACE; p_bsc: IBIND_STATUS_CALLBACK_INTERFACE; riid: ECOM_GUID; ppv_obj: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `pmk' [in].  
			-- `pbc' [in].  
			-- `p_bsc' [in].  
			-- `riid' [in].  
			-- `ppv_obj' [out].  
		local
			pmk_item: POINTER
			a_stub: ECOM_STUB
			pbc_item: POINTER
			p_bsc_item: POINTER
		do
			if pmk /= Void then
				if (pmk.item = default_pointer) then
					a_stub ?= pmk
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pmk_item := pmk.item
			end
			if pbc /= Void then
				if (pbc.item = default_pointer) then
					a_stub ?= pbc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pbc_item := pbc.item
			end
			if p_bsc /= Void then
				if (p_bsc.item = default_pointer) then
					a_stub ?= p_bsc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_bsc_item := p_bsc.item
			end
			ccom_moniker_bind_to_storage (initializer, pmk_item, pbc_item, p_bsc_item, riid.item, ppv_obj)
		end

	moniker_bind_to_object (pmk: IMONIKER_INTERFACE; pbc: IBIND_CTX_INTERFACE; p_bsc: IBIND_STATUS_CALLBACK_INTERFACE; riid: ECOM_GUID; ppv_obj: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `pmk' [in].  
			-- `pbc' [in].  
			-- `p_bsc' [in].  
			-- `riid' [in].  
			-- `ppv_obj' [out].  
		local
			pmk_item: POINTER
			a_stub: ECOM_STUB
			pbc_item: POINTER
			p_bsc_item: POINTER
		do
			if pmk /= Void then
				if (pmk.item = default_pointer) then
					a_stub ?= pmk
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pmk_item := pmk.item
			end
			if pbc /= Void then
				if (pbc.item = default_pointer) then
					a_stub ?= pbc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pbc_item := pbc.item
			end
			if p_bsc /= Void then
				if (p_bsc.item = default_pointer) then
					a_stub ?= p_bsc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_bsc_item := p_bsc.item
			end
			ccom_moniker_bind_to_object (initializer, pmk_item, pbc_item, p_bsc_item, riid.item, ppv_obj)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_ibind_host_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_create_moniker (cpp_obj: POINTER; sz_name: STRING; pbc: POINTER; ppmk: CELL [IMONIKER_INTERFACE]; dw_reserved: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IBindHost_impl_proxy %"ecom_control_library_IBindHost_impl_proxy_s.h%"](EIF_OBJECT,::IBindCtx *,EIF_OBJECT,EIF_INTEGER)"
		end

	ccom_moniker_bind_to_storage (cpp_obj: POINTER; pmk: POINTER; pbc: POINTER; p_bsc: POINTER; riid: POINTER; ppv_obj: CELL [ECOM_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IBindHost_impl_proxy %"ecom_control_library_IBindHost_impl_proxy_s.h%"](::IMoniker *,::IBindCtx *,::IBindStatusCallback *,GUID *,EIF_OBJECT)"
		end

	ccom_moniker_bind_to_object (cpp_obj: POINTER; pmk: POINTER; pbc: POINTER; p_bsc: POINTER; riid: POINTER; ppv_obj: CELL [ECOM_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IBindHost_impl_proxy %"ecom_control_library_IBindHost_impl_proxy_s.h%"](::IMoniker *,::IBindCtx *,::IBindStatusCallback *,GUID *,EIF_OBJECT)"
		end

	ccom_delete_ibind_host_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IBindHost_impl_proxy %"ecom_control_library_IBindHost_impl_proxy_s.h%"]()"
		end

	ccom_create_ibind_host_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IBindHost_impl_proxy %"ecom_control_library_IBindHost_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IBindHost_impl_proxy %"ecom_control_library_IBindHost_impl_proxy_s.h%"]():EIF_POINTER"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IBIND_HOST_IMPL_PROXY

