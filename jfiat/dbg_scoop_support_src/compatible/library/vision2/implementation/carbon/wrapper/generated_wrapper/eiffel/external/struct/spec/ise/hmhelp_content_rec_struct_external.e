-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct HMHelpContentRec

class HMHELP_CONTENT_REC_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct HMHelpContentRec)"
		end

	get_version_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_HMHelpContentRec_member_get_version"
		end

	set_version_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_HMHelpContentRec_member_set_version"
		ensure
			a_value_set: a_value = get_version_external (an_item)
		end

	get_abshotrect_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_HMHelpContentRec_member_get_absHotRect"
		end

	set_abshotrect_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_HMHelpContentRec_member_set_absHotRect"
		end

	get_tagside_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_HMHelpContentRec_member_get_tagSide"
		end

	set_tagside_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_HMHelpContentRec_member_set_tagSide"
		ensure
			a_value_set: a_value = get_tagside_external (an_item)
		end

	get_content_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_HMHelpContentRec_member_get_content"
		end

end

