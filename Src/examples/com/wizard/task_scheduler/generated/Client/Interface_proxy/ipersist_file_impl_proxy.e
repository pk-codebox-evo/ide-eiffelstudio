note
	description: "Implemented `IPersistFile' interface."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	IPERSIST_FILE_IMPL_PROXY

inherit
	IPERSIST_FILE_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (a_object: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_ipersist_file_impl_proxy_from_pointer(a_object)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	get_class_id (p_class_id: ECOM_GUID)
			-- `p_class_id' [out].  
		do
			ccom_get_class_id (initializer, p_class_id.item)
		end

	is_dirty
			-- 
		do
			ccom_is_dirty (initializer)
		end

	load (psz_file_name: STRING; dw_mode: INTEGER)
			-- `psz_file_name' [in].  
			-- `dw_mode' [in].  
		do
			ccom_load (initializer, psz_file_name, dw_mode)
		end

	save (psz_file_name: STRING; f_remember: INTEGER)
			-- `psz_file_name' [in].  
			-- `f_remember' [in].  
		do
			ccom_save (initializer, psz_file_name, f_remember)
		end

	save_completed (psz_file_name: STRING)
			-- `psz_file_name' [in].  
		do
			ccom_save_completed (initializer, psz_file_name)
		end

	get_cur_file (ppsz_file_name: CELL [STRING])
			-- `ppsz_file_name' [out].  
		do
			ccom_get_cur_file (initializer, ppsz_file_name)
		end

feature {NONE}  -- Implementation

	delete_wrapper
			-- Delete wrapper
		do
			ccom_delete_ipersist_file_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_get_class_id (a_object: POINTER; p_class_id: POINTER)
			-- 
		external
			"C++ [ecom_MS_TaskSched_lib::IPersistFile_impl_proxy %"ecom_MS_TaskSched_lib_IPersistFile_impl_proxy.h%"](GUID *)"
		end

	ccom_is_dirty (a_object: POINTER)
			-- 
		external
			"C++ [ecom_MS_TaskSched_lib::IPersistFile_impl_proxy %"ecom_MS_TaskSched_lib_IPersistFile_impl_proxy.h%"]()"
		end

	ccom_load (a_object: POINTER; psz_file_name: STRING; dw_mode: INTEGER)
			-- 
		external
			"C++ [ecom_MS_TaskSched_lib::IPersistFile_impl_proxy %"ecom_MS_TaskSched_lib_IPersistFile_impl_proxy.h%"](EIF_OBJECT,EIF_INTEGER)"
		end

	ccom_save (a_object: POINTER; psz_file_name: STRING; f_remember: INTEGER)
			-- 
		external
			"C++ [ecom_MS_TaskSched_lib::IPersistFile_impl_proxy %"ecom_MS_TaskSched_lib_IPersistFile_impl_proxy.h%"](EIF_OBJECT,EIF_INTEGER)"
		end

	ccom_save_completed (a_object: POINTER; psz_file_name: STRING)
			-- 
		external
			"C++ [ecom_MS_TaskSched_lib::IPersistFile_impl_proxy %"ecom_MS_TaskSched_lib_IPersistFile_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_get_cur_file (a_object: POINTER; ppsz_file_name: CELL [STRING])
			-- 
		external
			"C++ [ecom_MS_TaskSched_lib::IPersistFile_impl_proxy %"ecom_MS_TaskSched_lib_IPersistFile_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_delete_ipersist_file_impl_proxy (a_pointer: POINTER)
			-- Release resource
		external
			"C++ [delete ecom_MS_TaskSched_lib::IPersistFile_impl_proxy %"ecom_MS_TaskSched_lib_IPersistFile_impl_proxy.h%"]()"
		end

	ccom_create_ipersist_file_impl_proxy_from_pointer (a_pointer: POINTER): POINTER
			-- Create from pointer
		external
			"C++ [new ecom_MS_TaskSched_lib::IPersistFile_impl_proxy %"ecom_MS_TaskSched_lib_IPersistFile_impl_proxy.h%"](IUnknown *)"
		end

	ccom_item (a_object: POINTER): POINTER
			-- Item
		external
			"C++ [ecom_MS_TaskSched_lib::IPersistFile_impl_proxy %"ecom_MS_TaskSched_lib_IPersistFile_impl_proxy.h%"](): EIF_POINTER"
		end

end -- IPERSIST_FILE_IMPL_PROXY


