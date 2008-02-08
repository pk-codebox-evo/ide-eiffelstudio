indexing
	description: "Interface to the MSI API."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MSI_API

feature -- Access

	get_property (a_handle: POINTER; a_name: STRING): STRING is
			-- Value of property `a_name' associated with `a_handle'
		require
			a_handle_not_null: a_handle /= default_pointer
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		local
			l_name, l_val: WEL_STRING
			l_count: INTEGER
		do
			create l_name.make (a_name)
			create l_val.make_empty (512)
			l_count := l_val.capacity - 1
			msi_get_property (a_handle, l_name.item, l_val.item, $l_count)
			l_val.set_count (l_count)
			Result := l_val.string
		ensure
			get_property_not_void: Result /= Void
		end

	get_boolean_property (a_handle: POINTER; a_name: STRING): BOOLEAN is
			-- Value of property `a_name' associated with `a_handle'
		require
			a_handle_not_null: a_handle /= default_pointer
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		local
			l_name, l_val: WEL_STRING
			l_result: STRING
			l_count: INTEGER
		do
			create l_name.make (a_name)
			create l_val.make_empty (512)
			l_count := l_val.capacity - 1
			msi_get_property (a_handle, l_name.item, l_val.item, $l_count)
			l_val.set_count (l_count)
			l_result := l_val.string
			Result := l_result /= Void and then not l_result.is_equal (flag_false)
		end

	new_record (a_count: INTEGER): POINTER is
			-- Creates a new record object with the specified number of fields.
			-- It should be closed using `msi_close_handle'.
		external
			"C signature (unsigned int): MSIHANDLE use <msiquery.h>"
		alias
			"MsiCreateRecord"
		end

	frozen error_success: INTEGER is
			-- Value for successful calls
		external
			"C macro use <msiquery.h>"
		alias
			"ERROR_SUCCESS"
		end

	frozen error_install_failure: INTEGER is -1
			-- Value for failure calls

feature -- Settings

	set_property (a_handle: POINTER; a_name, a_value: STRING) is
			-- Set value of property `a_name' associated with `a_handle' with `a_value'.
		require
			a_handle_not_null: a_handle /= default_pointer
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			a_value_not_void: a_value /= Void
		local
			l_name, l_val: WEL_STRING
		do
			create l_name.make (a_name)
			create l_val.make (a_value)
			msi_set_property (a_handle, l_name.item, l_val.item)
		end

	set_boolean_property (a_handle: POINTER; a_name: STRING; a_value: BOOLEAN) is
			-- Set value of property `a_name' associated with `a_handle' with `a_value'.
		require
			a_handle_not_null: a_handle /= default_pointer
			a_name_not_void: a_name /= Void
		local
			l_name, l_val: WEL_STRING
		do
			create l_name.make (a_name)
			if a_value then
				create l_val.make (flag_true)
			else
				create l_val.make (flag_false)
			end
			msi_set_property (a_handle, l_name.item, l_val.item)
		end

	record_set_integer (a_handle: POINTER; a_field_id, a_value: INTEGER) is
			-- Sets a record field to an integer field.
		require
			a_handle_not_null: a_handle /= default_pointer
		external
			"C signature (MSIHANDLE, unsigned int, int) use <msiquery.h>"
		alias
			"MsiRecordSetInteger"
		end

	record_set_string (a_handle: POINTER; a_field_id: INTEGER; a_value: STRING) is
			-- Set a record field to a string field.
		require
			a_handle_not_null: a_handle /= default_pointer
			a_value_not_void: a_value /= Void
			a_value_not_empty: not a_value.is_empty
		local
			l_val: WEL_STRING
		do
			create l_val.make (a_value)
			msi_record_set_string (a_handle, a_field_id, l_val.item)
		end

	process_message (a_handle: POINTER; a_message_id: INTEGER; a_record: POINTER) is
			-- Sends an message record to the installer for processing
		require
			a_handle_not_null: a_handle /= default_pointer
		external
			"C signature (MSIHANDLE, INSTALLMESSAGE, MSIHANDLE) use <msiquery.h>"
		alias
			"MsiProcessMessage"
		end

	close_handle (a_handle: POINTER) is
			-- Close `a_handle'.
		require
			a_handle_not_null: a_handle /= default_pointer
		external
			"C signature (MSIHANDLE) use <msiquery.h>"
		alias
			"MsiCloseHandle"
		end

feature {NONE} -- Access

	msi_get_property (a_handle, a_name, a_value: POINTER a_length: TYPED_POINTER [INTEGER]) is
			-- Gets the value for an installer property.
		require
			a_handle_not_null: a_handle /= default_pointer
			a_name_not_null: a_name /= default_pointer
			a_value_not_null: a_value /= default_pointer
			a_length_not_null: a_length /= default_pointer
		external
			"C inline use <msiquery.h>"
		alias
			"[
				{
					DWORD length = (DWORD) *$a_length;
					UINT err;
					err = MsiGetProperty((MSIHANDLE) $a_handle, (LPCTSTR) $a_name, (LPTSTR) $a_value, &length);
					if (err != ERROR_SUCCESS) {
						MessageBox (NULL, $a_name, L"Error", MB_OK| MB_ICONWARNING);
					}
					*$a_length = (EIF_INTEGER) length;
				}
			]"
		end

	msi_set_property (a_handle, a_name, a_value: POINTER) is
			-- Sets the value for an installation property.
		require
			a_handle_not_null: a_handle /= default_pointer
			a_name_not_null: a_name /= default_pointer
			a_value_not_null: a_value /= default_pointer
		external
			"C signature (MSIHANDLE, LPCTSTR, LPCTSTR) use <msiquery.h>"
		alias
			"MsiSetProperty"
		end

	msi_record_set_string (a_handle: POINTER; a_field_id: INTEGER; a_value: POINTER) is
			-- Copies a string into the designated field.
		require
			a_handle_not_null: a_handle /= default_pointer
			a_value_not_null: a_value /= default_pointer
		external
			"C signature (MSIHANDLE, unsigned int, LPCTSTR) use <msiquery.h>"
		alias
			"MsiRecordSetString"
		end

feature -- Properties

	install_dir (a_handle: POINTER): STRING is
			-- Retrieve installer's set install location
		require
			a_handle_not_null: a_handle /= default_pointer
		do
			Result := get_property (a_handle, install_dir_property)
			if Result = Void then
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
		end

	product_name (a_handle: POINTER): STRING is
			-- Retrieve installer's product name
		require
			a_handle_not_null: a_handle /= default_pointer
		do
			Result := get_property (a_handle, product_name_property)
			if Result = Void then
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Property settings

	set_install_dir (a_handle: POINTER; a_folder: STRING) is
			-- Retrieve installer's set install location
		require
			a_handle_not_null: a_handle /= default_pointer
			a_folder_attached: a_folder /= Void
			not_a_folder_is_empty: not a_folder.is_empty
		do
			set_property (a_handle, install_dir_property, a_folder)
		ensure
			install_dir_set: install_dir (a_handle).is_equal (a_folder)
		end

feature {NONE} -- Constants

	install_dir_property: STRING = "INSTALLDIR"
			-- Property for install location

	product_name_property: STRING = "ProductName"
			-- Property for installer product name

	flag_true: STRING = "1"
			-- Flag for true states

	flag_false: STRING = "0"
			-- Flag for false states

end -- class MSI_API
