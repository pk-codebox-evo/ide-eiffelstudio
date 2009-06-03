-- This file has been generated by EWG. Do not edit. Changes will be lost!

class EVENT_HANDLER_PROC_PTR_DISPATCHER

inherit

	ANY

	EWG_CARBON_CALLBACK_C_GLUE_CODE_FUNCTIONS_EXTERNAL
		export {NONE} all end

create

	make

feature {NONE}

	make (a_callback: EVENT_HANDLER_PROC_PTR_CALLBACK) is
		require
			a_callback_not_void: a_callback /= Void
		do
			callback := a_callback
			set_event_handler_proc_ptr_entry_external (Current, $on_callback)
		end

feature {ANY}

	callback: EVENT_HANDLER_PROC_PTR_CALLBACK

	c_dispatcher: POINTER is
		do
			Result := get_event_handler_proc_ptr_stub_external
		end

feature {NONE} -- Implementation

	frozen on_callback (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER is 
		do
			Result := callback.on_callback (a_inhandlercallref, a_inevent, a_inuserdata) 
		end

invariant

	 callback_not_void: callback /= Void

end
