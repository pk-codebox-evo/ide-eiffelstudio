note
	description: "Implemented `IPersist' interface."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	IPERSIST_IMPL_PROXY

inherit
	IPERSIST_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (a_object: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_ipersist_impl_proxy_from_pointer(a_object)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	get_class_id (p_class_id: ECOM_GUID)
			-- `p_class_id' [out].  
		do
			ccom_get_class_id (initializer, p_class_id.item)
		end

feature {NONE}  -- Implementation

	delete_wrapper
			-- Delete wrapper
		do
			ccom_delete_ipersist_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_get_class_id (a_object: POINTER; p_class_id: POINTER)
			-- 
		external
			"C++ [ecom_MS_TaskSched_lib::IPersist_impl_proxy %"ecom_MS_TaskSched_lib_IPersist_impl_proxy.h%"](GUID *)"
		end

	ccom_delete_ipersist_impl_proxy (a_pointer: POINTER)
			-- Release resource
		external
			"C++ [delete ecom_MS_TaskSched_lib::IPersist_impl_proxy %"ecom_MS_TaskSched_lib_IPersist_impl_proxy.h%"]()"
		end

	ccom_create_ipersist_impl_proxy_from_pointer (a_pointer: POINTER): POINTER
			-- Create from pointer
		external
			"C++ [new ecom_MS_TaskSched_lib::IPersist_impl_proxy %"ecom_MS_TaskSched_lib_IPersist_impl_proxy.h%"](IUnknown *)"
		end

	ccom_item (a_object: POINTER): POINTER
			-- Item
		external
			"C++ [ecom_MS_TaskSched_lib::IPersist_impl_proxy %"ecom_MS_TaskSched_lib_IPersist_impl_proxy.h%"](): EIF_POINTER"
		end

end -- IPERSIST_IMPL_PROXY


