-- This file has been generated by EWG. Do not edit. Changes will be lost!

class EDIT_UNICODE_POST_UPDATE_PROC_PTR_DISPATCHER

inherit

	ANY

	EWG_CARBON_CALLBACK_C_GLUE_CODE_FUNCTIONS_EXTERNAL
		export {NONE} all end

create

	make

feature {NONE}

	make (a_callback: EDIT_UNICODE_POST_UPDATE_PROC_PTR_CALLBACK) is
		require
			a_callback_not_void: a_callback /= Void
		do
			callback := a_callback
			set_edit_unicode_post_update_proc_ptr_entry_external (Current, $on_callback)
		end

feature {ANY}

	callback: EDIT_UNICODE_POST_UPDATE_PROC_PTR_CALLBACK

	c_dispatcher: POINTER is
		do
			Result := get_edit_unicode_post_update_proc_ptr_stub_external
		end

feature {NONE} -- Implementation

	frozen on_callback (a_unitext: POINTER; a_unitextlength: INTEGER; a_istartoffset: INTEGER; a_iendoffset: INTEGER; a_refcon: POINTER): INTEGER is 
		do
			Result := callback.on_callback (a_unitext, a_unitextlength, a_istartoffset, a_iendoffset, a_refcon) 
		end

invariant

	 callback_not_void: callback /= Void

end
