indexing
	description: "Implemented `IOleCache' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IOLE_CACHE_IMPL_PROXY

inherit
	IOLE_CACHE_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_iole_cache_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	cache (p_formatetc: TAG_FORMATETC_RECORD; advf: INTEGER; pdw_connection: INTEGER_REF) is
			-- No description available.
			-- `p_formatetc' [in].  
			-- `advf' [in].  
			-- `pdw_connection' [out].  
		do
			ccom_cache (initializer, p_formatetc.item, advf, pdw_connection)
		end

	uncache (dw_connection: INTEGER) is
			-- No description available.
			-- `dw_connection' [in].  
		do
			ccom_uncache (initializer, dw_connection)
		end

	enum_cache (ppenum_statdata: CELL [IENUM_STATDATA_INTERFACE]) is
			-- No description available.
			-- `ppenum_statdata' [out].  
		do
			ccom_enum_cache (initializer, ppenum_statdata)
		end

	init_cache (p_data_object: IDATA_OBJECT_INTERFACE) is
			-- No description available.
			-- `p_data_object' [in].  
		local
			p_data_object_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_data_object /= Void then
				if (p_data_object.item = default_pointer) then
					a_stub ?= p_data_object
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_data_object_item := p_data_object.item
			end
			ccom_init_cache (initializer, p_data_object_item)
		end

	set_data (p_formatetc: TAG_FORMATETC_RECORD; pmedium: STGMEDIUM_RECORD; f_release: INTEGER) is
			-- No description available.
			-- `p_formatetc' [in].  
			-- `pmedium' [in].  
			-- `f_release' [in].  
		do
			ccom_set_data (initializer, p_formatetc.item, pmedium.item, f_release)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_iole_cache_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_cache (cpp_obj: POINTER; p_formatetc: POINTER; advf: INTEGER; pdw_connection: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleCache_impl_proxy %"ecom_control_library_IOleCache_impl_proxy_s.h%"](ecom_control_library::tagFORMATETC *,EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_uncache (cpp_obj: POINTER; dw_connection: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleCache_impl_proxy %"ecom_control_library_IOleCache_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_enum_cache (cpp_obj: POINTER; ppenum_statdata: CELL [IENUM_STATDATA_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleCache_impl_proxy %"ecom_control_library_IOleCache_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_init_cache (cpp_obj: POINTER; p_data_object: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleCache_impl_proxy %"ecom_control_library_IOleCache_impl_proxy_s.h%"](::IDataObject *)"
		end

	ccom_set_data (cpp_obj: POINTER; p_formatetc: POINTER; pmedium: POINTER; f_release: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleCache_impl_proxy %"ecom_control_library_IOleCache_impl_proxy_s.h%"](ecom_control_library::tagFORMATETC *,STGMEDIUM *,EIF_INTEGER)"
		end

	ccom_delete_iole_cache_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IOleCache_impl_proxy %"ecom_control_library_IOleCache_impl_proxy_s.h%"]()"
		end

	ccom_create_iole_cache_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IOleCache_impl_proxy %"ecom_control_library_IOleCache_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IOleCache_impl_proxy %"ecom_control_library_IOleCache_impl_proxy_s.h%"]():EIF_POINTER"
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




end -- IOLE_CACHE_IMPL_PROXY

