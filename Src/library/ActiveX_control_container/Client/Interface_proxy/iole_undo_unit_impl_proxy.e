note
	description: "Implemented `IOleUndoUnit' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IOLE_UNDO_UNIT_IMPL_PROXY

inherit
	IOLE_UNDO_UNIT_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_iole_undo_unit_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	do1 (p_undo_manager: IOLE_UNDO_MANAGER_INTERFACE)
			-- No description available.
			-- `p_undo_manager' [in].  
		local
			p_undo_manager_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_undo_manager /= Void then
				if (p_undo_manager.item = default_pointer) then
					a_stub ?= p_undo_manager
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_undo_manager_item := p_undo_manager.item
			end
			ccom_do1 (initializer, p_undo_manager_item)
		end

	get_description (p_bstr: CELL [STRING])
			-- No description available.
			-- `p_bstr' [out].  
		do
			ccom_get_description (initializer, p_bstr)
		end

	get_unit_type (p_clsid: ECOM_GUID; pl_id: INTEGER_REF)
			-- No description available.
			-- `p_clsid' [out].  
			-- `pl_id' [out].  
		do
			ccom_get_unit_type (initializer, p_clsid.item, pl_id)
		end

	on_next_add
			-- No description available.
		do
			ccom_on_next_add (initializer)
		end

feature {NONE}  -- Implementation

	delete_wrapper
			-- Delete wrapper
		do
			ccom_delete_iole_undo_unit_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_do1 (cpp_obj: POINTER; p_undo_manager: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IOleUndoUnit_impl_proxy %"ecom_control_library_IOleUndoUnit_impl_proxy_s.h%"](::IOleUndoManager *)"
		end

	ccom_get_description (cpp_obj: POINTER; p_bstr: CELL [STRING])
			-- No description available.
		external
			"C++ [ecom_control_library::IOleUndoUnit_impl_proxy %"ecom_control_library_IOleUndoUnit_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_get_unit_type (cpp_obj: POINTER; p_clsid: POINTER; pl_id: INTEGER_REF)
			-- No description available.
		external
			"C++ [ecom_control_library::IOleUndoUnit_impl_proxy %"ecom_control_library_IOleUndoUnit_impl_proxy_s.h%"](GUID *,EIF_OBJECT)"
		end

	ccom_on_next_add (cpp_obj: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IOleUndoUnit_impl_proxy %"ecom_control_library_IOleUndoUnit_impl_proxy_s.h%"]()"
		end

	ccom_delete_iole_undo_unit_impl_proxy (a_pointer: POINTER)
			-- Release resource
		external
			"C++ [delete ecom_control_library::IOleUndoUnit_impl_proxy %"ecom_control_library_IOleUndoUnit_impl_proxy_s.h%"]()"
		end

	ccom_create_iole_undo_unit_impl_proxy_from_pointer (a_pointer: POINTER): POINTER
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IOleUndoUnit_impl_proxy %"ecom_control_library_IOleUndoUnit_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER
			-- Item
		external
			"C++ [ecom_control_library::IOleUndoUnit_impl_proxy %"ecom_control_library_IOleUndoUnit_impl_proxy_s.h%"]():EIF_POINTER"
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




end -- IOLE_UNDO_UNIT_IMPL_PROXY

