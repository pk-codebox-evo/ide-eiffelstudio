indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ListBox+SelectedObjectCollection"

external class
	SELECTEDOBJECTCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTBOX

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
			prune_i_th as ilist_prune_i_th,
			remove as ilist_remove,
			insert as ilist_insert,
			clear as ilist_clear,
			extend as ilist_extend,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root
		end

create
	make

feature {NONE} -- Initialization

	frozen make (owner: SYSTEM_WINDOWS_FORMS_LISTBOX) is
		external
			"IL creator signature (System.Windows.Forms.ListBox) use System.Windows.Forms.ListBox+SelectedObjectCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	frozen put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"GetEnumerator"
		end

	frozen has (selected_object: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"Contains"
		end

	frozen index_of (selected_object: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"IndexOf"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"ToString"
		end

	frozen copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"CopyTo"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen ilist_extend (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen ilist_clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"System.Collections.IList.Clear"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen ilist_prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"System.Collections.IList.RemoveAt"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"Finalize"
		end

	frozen ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListBox+SelectedObjectCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class SELECTEDOBJECTCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTBOX
