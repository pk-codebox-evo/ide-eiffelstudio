-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct NavTypeList

class NAV_TYPE_LIST_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct NavTypeList)"
		end

	get_componentsignature_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_NavTypeList_member_get_componentSignature"
		end

	set_componentsignature_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_NavTypeList_member_set_componentSignature"
		ensure
			a_value_set: a_value = get_componentsignature_external (an_item)
		end

	get_reserved_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_NavTypeList_member_get_reserved"
		end

	set_reserved_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_NavTypeList_member_set_reserved"
		ensure
			a_value_set: a_value = get_reserved_external (an_item)
		end

	get_ostypecount_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_NavTypeList_member_get_osTypeCount"
		end

	set_ostypecount_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_NavTypeList_member_set_osTypeCount"
		ensure
			a_value_set: a_value = get_ostypecount_external (an_item)
		end

	get_ostype_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_NavTypeList_member_get_osType"
		end

end

