indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeTypeReferenceCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION

inherit
	COLLECTION_BASE
	ILIST
		rename
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			remove as system_collections_ilist_remove,
			add as system_collections_ilist_add,
			contains as system_collections_ilist_contains,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only
		end
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE

create
	make_system_dll_code_type_reference_collection_1,
	make_system_dll_code_type_reference_collection,
	make_system_dll_code_type_reference_collection_2

feature {NONE} -- Initialization

	frozen make_system_dll_code_type_reference_collection_1 (value: SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReferenceCollection) use System.CodeDom.CodeTypeReferenceCollection"
		end

	frozen make_system_dll_code_type_reference_collection is
		external
			"IL creator use System.CodeDom.CodeTypeReferenceCollection"
		end

	frozen make_system_dll_code_type_reference_collection_2 (value: NATIVE_ARRAY [SYSTEM_DLL_CODE_TYPE_REFERENCE]) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference[]) use System.CodeDom.CodeTypeReferenceCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (System.Int32): System.CodeDom.CodeTypeReference use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_DLL_CODE_TYPE_REFERENCE]; index: INTEGER) is
		external
			"IL signature (System.CodeDom.CodeTypeReference[], System.Int32): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"CopyTo"
		end

	frozen add_code_type_reference (value: SYSTEM_DLL_CODE_TYPE_REFERENCE): INTEGER is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Int32 use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"Add"
		end

	frozen remove (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_DLL_CODE_TYPE_REFERENCE): BOOLEAN is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Boolean use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION) is
		external
			"IL signature (System.CodeDom.CodeTypeReferenceCollection): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"AddRange"
		end

	frozen add (value: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"Add"
		end

	frozen index_of (value: SYSTEM_DLL_CODE_TYPE_REFERENCE): INTEGER is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Int32 use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"IndexOf"
		end

	frozen add_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"Add"
		end

	frozen add_range_array_code_type_reference (value: NATIVE_ARRAY [SYSTEM_DLL_CODE_TYPE_REFERENCE]) is
		external
			"IL signature (System.CodeDom.CodeTypeReference[]): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"AddRange"
		end

end -- class SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION
