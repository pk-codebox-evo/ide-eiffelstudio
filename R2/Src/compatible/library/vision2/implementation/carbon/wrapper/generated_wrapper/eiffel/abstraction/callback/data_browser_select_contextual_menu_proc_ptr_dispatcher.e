-- This file has been generated by EWG. Do not edit. Changes will be lost!

class DATA_BROWSER_SELECT_CONTEXTUAL_MENU_PROC_PTR_DISPATCHER

inherit

	ANY

	EWG_CARBON_CALLBACK_C_GLUE_CODE_FUNCTIONS_EXTERNAL
		export {NONE} all end

create

	make

feature {NONE}

	make (a_callback: DATA_BROWSER_SELECT_CONTEXTUAL_MENU_PROC_PTR_CALLBACK) is
		require
			a_callback_not_void: a_callback /= Void
		do
			callback := a_callback
			set_data_browser_select_contextual_menu_proc_ptr_entry_external (Current, $on_callback)
		end

feature {ANY}

	callback: DATA_BROWSER_SELECT_CONTEXTUAL_MENU_PROC_PTR_CALLBACK

	c_dispatcher: POINTER is
		do
			Result := get_data_browser_select_contextual_menu_proc_ptr_stub_external
		end

feature {NONE} -- Implementation

	frozen on_callback (a_browser: POINTER; a_menu: POINTER; a_selectiontype: INTEGER; a_menuid: INTEGER; a_menuitem: INTEGER) is 
		do
			callback.on_callback (a_browser, a_menu, a_selectiontype, a_menuid, a_menuitem) 
		end

invariant

	 callback_not_void: callback /= Void

end
