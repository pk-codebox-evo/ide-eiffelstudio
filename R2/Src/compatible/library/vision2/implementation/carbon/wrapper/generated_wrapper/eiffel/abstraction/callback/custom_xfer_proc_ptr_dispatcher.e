-- This file has been generated by EWG. Do not edit. Changes will be lost!

class CUSTOM_XFER_PROC_PTR_DISPATCHER

inherit

	ANY

	EWG_CARBON_CALLBACK_C_GLUE_CODE_FUNCTIONS_EXTERNAL
		export {NONE} all end

create

	make

feature {NONE}

	make (a_callback: CUSTOM_XFER_PROC_PTR_CALLBACK) is
		require
			a_callback_not_void: a_callback /= Void
		do
			callback := a_callback
			--set_custom_xfer_proc_ptr_entry_external (Current, $on_callback)
		end

feature {ANY}

	callback: CUSTOM_XFER_PROC_PTR_CALLBACK

	c_dispatcher: POINTER is
		do
			--Result := get_custom_xfer_proc_ptr_stub_external
		end

feature {NONE} -- Implementation

	frozen on_callback (a_info: POINTER) is 
		do
			callback.on_callback (a_info) 
		end

invariant

	 callback_not_void: callback /= Void

end
