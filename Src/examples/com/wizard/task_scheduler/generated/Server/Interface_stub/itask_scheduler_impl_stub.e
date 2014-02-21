note
	description: "Implemented `ITaskScheduler' interface."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	ITASK_SCHEDULER_IMPL_STUB

inherit
	ITASK_SCHEDULER_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	set_target_computer (pwsz_computer: STRING)
			-- Selects the computer that the ITaskScheduler interface operates on.
			-- `pwsz_computer' [in].  
		do
			-- Put Implementation here.
		end

	get_target_computer (ppwsz_computer: CELL [STRING])
			-- Returns the name of the computer on which ITaskScheduler is currently targeted.
			-- `ppwsz_computer' [out].  
		do
			-- Put Implementation here.
		end

	enum (pp_enum_work_items: CELL [IENUM_WORK_ITEMS_INTERFACE])
			-- Retrieves a pointer to an OLE enumerator object that enumerates the tasks in the current task folder.
			-- `pp_enum_work_items' [out].  
		do
			-- Put Implementation here.
		end

	activate (pwsz_name: STRING; a_riid: ECOM_GUID; pp_unk: CELL [ECOM_INTERFACE])
			-- Returns an active interface to the specified task.
			-- `pwsz_name' [in].  
			-- `a_riid' [in].  
			-- `pp_unk' [out].  
		do
			-- Put Implementation here.
		end

	delete (pwsz_name: STRING)
			-- Deletes a task.
			-- `pwsz_name' [in].  
		do
			-- Put Implementation here.
		end

	new_work_item (pwsz_task_name: STRING; rclsid: ECOM_GUID; a_riid: ECOM_GUID; pp_unk: CELL [ECOM_INTERFACE])
			-- Allocates space for a new task and retrieves its address.
			-- `pwsz_task_name' [in].  
			-- `rclsid' [in].  
			-- `a_riid' [in].  
			-- `pp_unk' [out].  
		do
			-- Put Implementation here.
		end

	add_work_item (pwsz_task_name: STRING; p_work_item: ISCHEDULED_WORK_ITEM_INTERFACE)
			-- Adds a task to the schedule of tasks.
			-- `pwsz_task_name' [in].  
			-- `p_work_item' [in].  
		do
			-- Put Implementation here.
		end

	is_of_type (pwsz_name: STRING; a_riid: ECOM_GUID)
			-- Checks the object type.
			-- `pwsz_name' [in].  
			-- `a_riid' [in].  
		do
			-- Put Implementation here.
		end

	create_item
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: ITASK_SCHEDULER_IMPL_STUB): POINTER
			-- Initialize `item'
		external
			"C++ [new ecom_MS_TaskSched_lib::ITaskScheduler_impl_stub %"ecom_MS_TaskSched_lib_ITaskScheduler_impl_stub.h%"](EIF_OBJECT)"
		end

end -- ITASK_SCHEDULER_IMPL_STUB


