note
	description: "Implemented `IAdviseSink' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	IADVISE_SINK_IMPL_PROXY

inherit
	IADVISE_SINK_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_iadvise_sink_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	on_data_change (p_formatetc: TAG_FORMATETC_RECORD; p_stgmed: STGMEDIUM_RECORD)
			-- No description available.
			-- `p_formatetc' [in].  
			-- `p_stgmed' [in].  
		do
			ccom_on_data_change (initializer, p_formatetc.item, p_stgmed.item)
		end

	on_view_change (dw_aspect: INTEGER; lindex: INTEGER)
			-- No description available.
			-- `dw_aspect' [in].  
			-- `lindex' [in].  
		do
			ccom_on_view_change (initializer, dw_aspect, lindex)
		end

	on_rename (pmk: IMONIKER_INTERFACE)
			-- No description available.
			-- `pmk' [in].  
		local
			pmk_item: POINTER
			a_stub: ECOM_STUB
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
			ccom_on_rename (initializer, pmk_item)
		end

	on_save
			-- No description available.
		do
			ccom_on_save (initializer)
		end

	on_close
			-- No description available.
		do
			ccom_on_close (initializer)
		end

feature {NONE}  -- Implementation

	delete_wrapper
			-- Delete wrapper
		do
			ccom_delete_iadvise_sink_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_on_data_change (cpp_obj: POINTER; p_formatetc: POINTER; p_stgmed: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IAdviseSink_impl_proxy %"ecom_control_library_IAdviseSink_impl_proxy_s.h%"](ecom_control_library::tagFORMATETC *,STGMEDIUM *)"
		end

	ccom_on_view_change (cpp_obj: POINTER; dw_aspect: INTEGER; lindex: INTEGER)
			-- No description available.
		external
			"C++ [ecom_control_library::IAdviseSink_impl_proxy %"ecom_control_library_IAdviseSink_impl_proxy_s.h%"](EIF_INTEGER,EIF_INTEGER)"
		end

	ccom_on_rename (cpp_obj: POINTER; pmk: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IAdviseSink_impl_proxy %"ecom_control_library_IAdviseSink_impl_proxy_s.h%"](::IMoniker *)"
		end

	ccom_on_save (cpp_obj: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IAdviseSink_impl_proxy %"ecom_control_library_IAdviseSink_impl_proxy_s.h%"]()"
		end

	ccom_on_close (cpp_obj: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IAdviseSink_impl_proxy %"ecom_control_library_IAdviseSink_impl_proxy_s.h%"]()"
		end

	ccom_delete_iadvise_sink_impl_proxy (a_pointer: POINTER)
			-- Release resource
		external
			"C++ [delete ecom_control_library::IAdviseSink_impl_proxy %"ecom_control_library_IAdviseSink_impl_proxy_s.h%"]()"
		end

	ccom_create_iadvise_sink_impl_proxy_from_pointer (a_pointer: POINTER): POINTER
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IAdviseSink_impl_proxy %"ecom_control_library_IAdviseSink_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER
			-- Item
		external
			"C++ [ecom_control_library::IAdviseSink_impl_proxy %"ecom_control_library_IAdviseSink_impl_proxy_s.h%"]():EIF_POINTER"
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




end -- IADVISE_SINK_IMPL_PROXY

