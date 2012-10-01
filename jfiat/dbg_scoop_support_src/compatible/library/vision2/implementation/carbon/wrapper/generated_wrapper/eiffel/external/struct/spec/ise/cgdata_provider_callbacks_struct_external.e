-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct CGDataProviderCallbacks

class CGDATA_PROVIDER_CALLBACKS_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct CGDataProviderCallbacks)"
		end

	get_getbytes_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_CGDataProviderCallbacks_member_get_getBytes"
		end

	set_getbytes_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_CGDataProviderCallbacks_member_set_getBytes"
		ensure
			a_value_set: a_value = get_getbytes_external (an_item)
		end

	get_skipbytes_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_CGDataProviderCallbacks_member_get_skipBytes"
		end

	set_skipbytes_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_CGDataProviderCallbacks_member_set_skipBytes"
		ensure
			a_value_set: a_value = get_skipbytes_external (an_item)
		end

	get_rewind_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_CGDataProviderCallbacks_member_get_rewind"
		end

	set_rewind_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_CGDataProviderCallbacks_member_set_rewind"
		ensure
			a_value_set: a_value = get_rewind_external (an_item)
		end

	get_releaseprovider_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_CGDataProviderCallbacks_member_get_releaseProvider"
		end

	set_releaseprovider_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_CGDataProviderCallbacks_member_set_releaseProvider"
		ensure
			a_value_set: a_value = get_releaseprovider_external (an_item)
		end

end

