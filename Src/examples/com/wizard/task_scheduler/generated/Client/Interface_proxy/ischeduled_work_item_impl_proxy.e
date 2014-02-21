note
	description: "Implemented `IScheduledWorkItem' interface."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	ISCHEDULED_WORK_ITEM_IMPL_PROXY

inherit
	ISCHEDULED_WORK_ITEM_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (a_object: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_ischeduled_work_item_impl_proxy_from_pointer(a_object)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	create_trigger (pi_new_trigger: INTEGER_REF; pp_trigger: CELL [ITASK_TRIGGER_INTERFACE])
			-- Creates a trigger using a work item object.
			-- `pi_new_trigger' [out].  
			-- `pp_trigger' [out].  
		do
			ccom_create_trigger (initializer, pi_new_trigger, pp_trigger)
		end

	delete_trigger (i_trigger: INTEGER)
			-- Deletes a trigger from a work item. 
			-- `i_trigger' [in].  
		do
			ccom_delete_trigger (initializer, i_trigger)
		end

	get_trigger_count (pw_count: INTEGER_REF)
			-- Retrieves the number of triggers associated with a work item.
			-- `pw_count' [out].  
		do
			ccom_get_trigger_count (initializer, pw_count)
		end

	get_trigger (i_trigger: INTEGER; pp_trigger: CELL [ITASK_TRIGGER_INTERFACE])
			-- Retrieves a trigger structure.
			-- `i_trigger' [in].  
			-- `pp_trigger' [out].  
		do
			ccom_get_trigger (initializer, i_trigger, pp_trigger)
		end

	get_trigger_string (i_trigger: INTEGER; ppwsz_trigger: CELL [STRING])
			-- Retrieves a trigger string.
			-- `i_trigger' [in].  
			-- `ppwsz_trigger' [out].  
		do
			ccom_get_trigger_string (initializer, i_trigger, ppwsz_trigger)
		end

	get_run_times (pst_begin: X_SYSTEMTIME_RECORD; pst_end: X_SYSTEMTIME_RECORD; p_count: INTEGER_REF; rgst_task_times: CELL [X_SYSTEMTIME_RECORD])
			-- Retrieves the work item run times for a specified time period.
			-- `pst_begin' [in].  
			-- `pst_end' [in].  
			-- `p_count' [in, out].  
			-- `rgst_task_times' [out].  
		do
			ccom_get_run_times (initializer, pst_begin.item, pst_end.item, p_count, rgst_task_times)
		end

	get_next_run_time (pst_next_run: X_SYSTEMTIME_RECORD)
			-- Retrieves the next time the work item will run.
			-- `pst_next_run' [in, out].  
		do
			ccom_get_next_run_time (initializer, pst_next_run.item)
		end

	set_idle_wait (w_idle_minutes: INTEGER; w_deadline_minutes: INTEGER)
			-- Sets the idle wait time for the work item.
			-- `w_idle_minutes' [in].  
			-- `w_deadline_minutes' [in].  
		do
			ccom_set_idle_wait (initializer, w_idle_minutes, w_deadline_minutes)
		end

	get_idle_wait (pw_idle_minutes: INTEGER_REF; pw_deadline_minutes: INTEGER_REF)
			-- Retrieves the idle wait time for the work item.
			-- `pw_idle_minutes' [out].  
			-- `pw_deadline_minutes' [out].  
		do
			ccom_get_idle_wait (initializer, pw_idle_minutes, pw_deadline_minutes)
		end

	run
			-- Runs the work item.
		do
			ccom_run (initializer)
		end

	terminate
			-- Ends the execution of the work item.
		do
			ccom_terminate (initializer)
		end

	edit_work_item (h_parent: POINTER; dw_reserved: INTEGER)
			-- Opens the configuration properties for the work item.
			-- `h_parent' [in].  
			-- `dw_reserved' [in].  
		do
			ccom_edit_work_item (initializer, h_parent, dw_reserved)
		end

	get_most_recent_run_time (pst_last_run: X_SYSTEMTIME_RECORD)
			-- Retrieves the most recent time the work item began running.
			-- `pst_last_run' [out].  
		do
			ccom_get_most_recent_run_time (initializer, pst_last_run.item)
		end

	get_status (phr_status: ECOM_HRESULT)
			-- Retrieves the status of the work item.
			-- `phr_status' [out].  
		do
			ccom_get_status (initializer, phr_status)
		end

	get_exit_code (pdw_exit_code: INTEGER_REF)
			-- Retrieves the work item's last exit code.
			-- `pdw_exit_code' [out].  
		do
			ccom_get_exit_code (initializer, pdw_exit_code)
		end

	set_comment (pwsz_comment: STRING)
			-- Sets the comment for the work item.
			-- `pwsz_comment' [in].  
		do
			ccom_set_comment (initializer, pwsz_comment)
		end

	get_comment (ppwsz_comment: CELL [STRING])
			-- Retrieves the comment for the work item.
			-- `ppwsz_comment' [out].  
		do
			ccom_get_comment (initializer, ppwsz_comment)
		end

	set_creator (pwsz_creator: STRING)
			-- Sets the creator of the work item.
			-- `pwsz_creator' [in].  
		do
			ccom_set_creator (initializer, pwsz_creator)
		end

	get_creator (ppwsz_creator: CELL [STRING])
			-- Retrieves the creator of the work item.
			-- `ppwsz_creator' [out].  
		do
			ccom_get_creator (initializer, ppwsz_creator)
		end

	set_work_item_data (cb_data: INTEGER; rgb_data: CHARACTER_REF)
			-- Stores application-defined data associated with the work item.
			-- `cb_data' [in].  
			-- `rgb_data' [in].  
		do
			ccom_set_work_item_data (initializer, cb_data, rgb_data)
		end

	get_work_item_data (pcb_data: INTEGER_REF; prgb_data: CELL [CHARACTER_REF])
			-- Retrieves application-defined data associated with the work item.
			-- `pcb_data' [out].  
			-- `prgb_data' [out].  
		do
			ccom_get_work_item_data (initializer, pcb_data, prgb_data)
		end

	set_error_retry_count (w_retry_count: INTEGER)
			-- Not currently implemented.
			-- `w_retry_count' [in].  
		do
			ccom_set_error_retry_count (initializer, w_retry_count)
		end

	get_error_retry_count (pw_retry_count: INTEGER_REF)
			-- Not currently implemented.
			-- `pw_retry_count' [out].  
		do
			ccom_get_error_retry_count (initializer, pw_retry_count)
		end

	set_error_retry_interval (w_retry_interval: INTEGER)
			-- Not currently implemented.
			-- `w_retry_interval' [in].  
		do
			ccom_set_error_retry_interval (initializer, w_retry_interval)
		end

	get_error_retry_interval (pw_retry_interval: INTEGER_REF)
			-- Not currently implemented.
			-- `pw_retry_interval' [out].  
		do
			ccom_get_error_retry_interval (initializer, pw_retry_interval)
		end

	set_flags (dw_flags: INTEGER)
			-- Sets the flags that modify the behavior of the work item.
			-- `dw_flags' [in].  
		do
			ccom_set_flags (initializer, dw_flags)
		end

	get_flags (pdw_flags: INTEGER_REF)
			-- Retrieves the flags that modify the behavior of the work item.
			-- `pdw_flags' [out].  
		do
			ccom_get_flags (initializer, pdw_flags)
		end

	set_account_information (pwsz_account_name: STRING; pwsz_password: STRING)
			-- Sets the account name and password for the work item.
			-- `pwsz_account_name' [in].  
			-- `pwsz_password' [in].  
		do
			ccom_set_account_information (initializer, pwsz_account_name, pwsz_password)
		end

	get_account_information (ppwsz_account_name: CELL [STRING])
			-- Retrieves the account name for the work item.
			-- `ppwsz_account_name' [out].  
		do
			ccom_get_account_information (initializer, ppwsz_account_name)
		end

feature {NONE}  -- Implementation

	delete_wrapper
			-- Delete wrapper
		do
			ccom_delete_ischeduled_work_item_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_create_trigger (a_object: POINTER; pi_new_trigger: INTEGER_REF; pp_trigger: CELL [ITASK_TRIGGER_INTERFACE])
			-- Creates a trigger using a work item object.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_delete_trigger (a_object: POINTER; i_trigger: INTEGER)
			-- Deletes a trigger from a work item. 
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_INTEGER)"
		end

	ccom_get_trigger_count (a_object: POINTER; pw_count: INTEGER_REF)
			-- Retrieves the number of triggers associated with a work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_get_trigger (a_object: POINTER; i_trigger: INTEGER; pp_trigger: CELL [ITASK_TRIGGER_INTERFACE])
			-- Retrieves a trigger structure.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_get_trigger_string (a_object: POINTER; i_trigger: INTEGER; ppwsz_trigger: CELL [STRING])
			-- Retrieves a trigger string.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_get_run_times (a_object: POINTER; pst_begin: POINTER; pst_end: POINTER; p_count: INTEGER_REF; rgst_task_times: CELL [X_SYSTEMTIME_RECORD])
			-- Retrieves the work item run times for a specified time period.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](ecom_MS_TaskSched_lib::_SYSTEMTIME *,ecom_MS_TaskSched_lib::_SYSTEMTIME *,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_get_next_run_time (a_object: POINTER; pst_next_run: POINTER)
			-- Retrieves the next time the work item will run.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](ecom_MS_TaskSched_lib::_SYSTEMTIME *)"
		end

	ccom_set_idle_wait (a_object: POINTER; w_idle_minutes: INTEGER; w_deadline_minutes: INTEGER)
			-- Sets the idle wait time for the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_INTEGER,EIF_INTEGER)"
		end

	ccom_get_idle_wait (a_object: POINTER; pw_idle_minutes: INTEGER_REF; pw_deadline_minutes: INTEGER_REF)
			-- Retrieves the idle wait time for the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_run (a_object: POINTER)
			-- Runs the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"]()"
		end

	ccom_terminate (a_object: POINTER)
			-- Ends the execution of the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"]()"
		end

	ccom_edit_work_item (a_object: POINTER; h_parent: POINTER; dw_reserved: INTEGER)
			-- Opens the configuration properties for the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_POINTER,EIF_INTEGER)"
		end

	ccom_get_most_recent_run_time (a_object: POINTER; pst_last_run: POINTER)
			-- Retrieves the most recent time the work item began running.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](ecom_MS_TaskSched_lib::_SYSTEMTIME *)"
		end

	ccom_get_status (a_object: POINTER; phr_status: ECOM_HRESULT)
			-- Retrieves the status of the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_get_exit_code (a_object: POINTER; pdw_exit_code: INTEGER_REF)
			-- Retrieves the work item's last exit code.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_set_comment (a_object: POINTER; pwsz_comment: STRING)
			-- Sets the comment for the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_get_comment (a_object: POINTER; ppwsz_comment: CELL [STRING])
			-- Retrieves the comment for the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_set_creator (a_object: POINTER; pwsz_creator: STRING)
			-- Sets the creator of the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_get_creator (a_object: POINTER; ppwsz_creator: CELL [STRING])
			-- Retrieves the creator of the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_set_work_item_data (a_object: POINTER; cb_data: INTEGER; rgb_data: CHARACTER_REF)
			-- Stores application-defined data associated with the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_get_work_item_data (a_object: POINTER; pcb_data: INTEGER_REF; prgb_data: CELL [CHARACTER_REF])
			-- Retrieves application-defined data associated with the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_set_error_retry_count (a_object: POINTER; w_retry_count: INTEGER)
			-- Not currently implemented.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_INTEGER)"
		end

	ccom_get_error_retry_count (a_object: POINTER; pw_retry_count: INTEGER_REF)
			-- Not currently implemented.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_set_error_retry_interval (a_object: POINTER; w_retry_interval: INTEGER)
			-- Not currently implemented.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_INTEGER)"
		end

	ccom_get_error_retry_interval (a_object: POINTER; pw_retry_interval: INTEGER_REF)
			-- Not currently implemented.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_set_flags (a_object: POINTER; dw_flags: INTEGER)
			-- Sets the flags that modify the behavior of the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_INTEGER)"
		end

	ccom_get_flags (a_object: POINTER; pdw_flags: INTEGER_REF)
			-- Retrieves the flags that modify the behavior of the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_set_account_information (a_object: POINTER; pwsz_account_name: STRING; pwsz_password: STRING)
			-- Sets the account name and password for the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_get_account_information (a_object: POINTER; ppwsz_account_name: CELL [STRING])
			-- Retrieves the account name for the work item.
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_delete_ischeduled_work_item_impl_proxy (a_pointer: POINTER)
			-- Release resource
		external
			"C++ [delete ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"]()"
		end

	ccom_create_ischeduled_work_item_impl_proxy_from_pointer (a_pointer: POINTER): POINTER
			-- Create from pointer
		external
			"C++ [new ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](IUnknown *)"
		end

	ccom_item (a_object: POINTER): POINTER
			-- Item
		external
			"C++ [ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy %"ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h%"](): EIF_POINTER"
		end

end -- ISCHEDULED_WORK_ITEM_IMPL_PROXY


