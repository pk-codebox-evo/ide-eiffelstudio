indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.SchemaNameCollection"

external class
	SYSTEM_DIRECTORYSERVICES_SCHEMANAMECOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			remove as ilist_remove,
			insert as ilist_insert,
			index_of as ilist_index_of,
			has as ilist_has,
			extend as ilist_extend,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			copy_to as icollection_copy_to,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_read_only as ilist_get_is_read_only
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			copy_to as icollection_copy_to
		end

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.DirectoryServices.SchemaNameCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.DirectoryServices.SchemaNameCollection"
		alias
			"get_Count"
		end

feature -- Element Change

	frozen put_i_th (index: INTEGER; value: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.DirectoryServices.SchemaNameCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.SchemaNameCollection"
		alias
			"ToString"
		end

	frozen extend (value: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.DirectoryServices.SchemaNameCollection"
		alias
			"Add"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.DirectoryServices.SchemaNameCollection"
		alias
			"GetHashCode"
		end

	frozen copy_to (string_array: ARRAY [STRING]; index: INTEGER) is
		external
			"IL signature (System.String[], System.Int32): System.Void use System.DirectoryServices.SchemaNameCollection"
		alias
			"CopyTo"
		end

	frozen insert (index: INTEGER; value: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.DirectoryServices.SchemaNameCollection"
		alias
			"Insert"
		end

	frozen add_range_array_string (value: ARRAY [STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.DirectoryServices.SchemaNameCollection"
		alias
			"AddRange"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.DirectoryServices.SchemaNameCollection"
		alias
			"GetEnumerator"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.DirectoryServices.SchemaNameCollection"
		alias
			"Clear"
		end

	frozen has (value: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.DirectoryServices.SchemaNameCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_DIRECTORYSERVICES_SCHEMANAMECOLLECTION) is
		external
			"IL signature (System.DirectoryServices.SchemaNameCollection): System.Void use System.DirectoryServices.SchemaNameCollection"
		alias
			"AddRange"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.DirectoryServices.SchemaNameCollection"
		alias
			"Equals"
		end

	frozen index_of (value: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.DirectoryServices.SchemaNameCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.DirectoryServices.SchemaNameCollection"
		alias
			"Remove"
		end

	frozen prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.DirectoryServices.SchemaNameCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen ilist_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.DirectoryServices.SchemaNameCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.DirectoryServices.SchemaNameCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.DirectoryServices.SchemaNameCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

	frozen ilist_index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.DirectoryServices.SchemaNameCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.DirectoryServices.SchemaNameCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen ilist_extend (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.DirectoryServices.SchemaNameCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.DirectoryServices.SchemaNameCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.DirectoryServices.SchemaNameCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen ilist_has (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.DirectoryServices.SchemaNameCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.DirectoryServices.SchemaNameCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.DirectoryServices.SchemaNameCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.DirectoryServices.SchemaNameCollection"
		alias
			"Finalize"
		end

	frozen ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.DirectoryServices.SchemaNameCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class SYSTEM_DIRECTORYSERVICES_SCHEMANAMECOLLECTION
