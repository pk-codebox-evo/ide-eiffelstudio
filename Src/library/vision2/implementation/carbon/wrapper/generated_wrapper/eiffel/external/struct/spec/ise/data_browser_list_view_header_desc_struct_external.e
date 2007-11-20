-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct DataBrowserListViewHeaderDesc

class DATA_BROWSER_LIST_VIEW_HEADER_DESC_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct DataBrowserListViewHeaderDesc)"
		end

	get_version_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_get_version"
		end

	set_version_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_set_version"
		ensure
			a_value_set: a_value = get_version_external (an_item)
		end

	get_minimumwidth_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_get_minimumWidth"
		end

	set_minimumwidth_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_set_minimumWidth"
		ensure
			a_value_set: a_value = get_minimumwidth_external (an_item)
		end

	get_maximumwidth_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_get_maximumWidth"
		end

	set_maximumwidth_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_set_maximumWidth"
		ensure
			a_value_set: a_value = get_maximumwidth_external (an_item)
		end

	get_titleoffset_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_get_titleOffset"
		end

	set_titleoffset_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_set_titleOffset"
		ensure
			a_value_set: a_value = get_titleoffset_external (an_item)
		end

	get_titlestring_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_get_titleString"
		end

	set_titlestring_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_set_titleString"
		ensure
			a_value_set: a_value = get_titlestring_external (an_item)
		end

	get_initialorder_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_get_initialOrder"
		end

	set_initialorder_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_set_initialOrder"
		ensure
			a_value_set: a_value = get_initialorder_external (an_item)
		end

	get_btnfontstyle_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_get_btnFontStyle"
		end

	set_btnfontstyle_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_set_btnFontStyle"
		end

	get_btncontentinfo_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_get_btnContentInfo"
		end

	set_btncontentinfo_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_DataBrowserListViewHeaderDesc_member_set_btnContentInfo"
		end

end

