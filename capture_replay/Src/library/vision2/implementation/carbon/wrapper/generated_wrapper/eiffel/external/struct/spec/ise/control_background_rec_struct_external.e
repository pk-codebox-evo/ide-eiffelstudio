-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct ControlBackgroundRec

class CONTROL_BACKGROUND_REC_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct ControlBackgroundRec)"
		end

	get_depth_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_ControlBackgroundRec_member_get_depth"
		end

	set_depth_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_ControlBackgroundRec_member_set_depth"
		ensure
			a_value_set: a_value = get_depth_external (an_item)
		end

	get_colordevice_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_ControlBackgroundRec_member_get_colorDevice"
		end

	set_colordevice_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_ControlBackgroundRec_member_set_colorDevice"
		ensure
			a_value_set: a_value = get_colordevice_external (an_item)
		end

end

