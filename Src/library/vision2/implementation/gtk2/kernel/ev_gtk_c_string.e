indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_C_STRING

create
	make, make_shared, make_from_pointer

convert
	make ({STRING})
	
	
feature {NONE} -- Initialization
		
	make (a_string: STRING) is
			-- Create a UTF8 string and have ownership
		do
			create_managed_data (a_string, False)
		end

	make_shared (a_string: STRING) is
			-- Create a UTF8 string that doesn't retain ownership
		do
			create_managed_data (a_string, True)
		end

	make_from_pointer (a_utf8_ptr: POINTER) is
			-- Set `Current' to use `a_utf8_ptr'
		do
			create managed_data.make_from_pointer (a_utf8_ptr, feature {EV_GTK_DEPENDENT_EXTERNALS}.g_utf8_strlen (a_utf8_ptr, -1) + 1)
		end

feature -- Access

	item: POINTER is
			-- Pointer to the UTF8 string
		do
			Result := managed_data.item
		end

	string: STRING is
			-- Locale string representation of the UTF8 string
		local
			str_ptr: POINTER
			bytes_read, bytes_written: INTEGER
			gerror: POINTER
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.g_locale_from_utf8 (item, managed_data.count - 1, $bytes_read, $bytes_written, $gerror, $str_ptr)
			if str_ptr /= default_pointer then
				create Result.make_from_c (str_ptr)
				feature {EV_GTK_EXTERNALS}.g_free (str_ptr)
			else
				-- Sometimes the UTF8 string cannot be translated
				create Result.make_from_c (item)
			end
		end

	string_length: INTEGER is
			-- Length of string data held in `managed_data'
		do
			Result := managed_data.count - 1
		end

feature {NONE} -- Implementation

	create_managed_data (a_string: STRING; a_shared: BOOLEAN) is
			-- Create a UTF8 string from `a_string'
		require
			a_string_not_void: a_string /= Void
		local
			utf8_ptr: POINTER
			string_value: ANY
			bytes_read, bytes_written: INTEGER
			gerror: POINTER
			i: INTEGER
			a_str, temp_string: STRING
			a_end: POINTER
		do
			string_value := a_string.to_c
			feature {EV_GTK_DEPENDENT_EXTERNALS}.g_locale_to_utf8 ($string_value, a_string.count, $bytes_read, $bytes_written, $gerror, $utf8_ptr)
			if utf8_ptr = default_pointer then
					-- An error has occurred, this is probably due to `a_string' containing invalid characters
				from
					i := 1
					a_str := a_string.twin
				until
					i > a_str.count
				loop
					temp_string := a_str.item (i).out
					string_value := temp_string.to_c
					if not feature {EV_GTK_DEPENDENT_EXTERNALS}.g_utf8_validate ($string_value, -1, $a_end) then
						a_str.put (' ', i)
							-- If character doesn't validate as UTF8 then we change to a blank character
					end
					i := i + 1
				end
				string_value := a_str.to_c
				feature {EV_GTK_DEPENDENT_EXTERNALS}.g_locale_to_utf8 ($string_value, -1, $bytes_read, $bytes_written, $gerror, $utf8_ptr)
			end
				-- The value of bytes_written doesn't take the null character in to account
			if a_shared then
				create managed_data.share_from_pointer (utf8_ptr, bytes_written + 1)
			else
				create managed_data.make_from_pointer (utf8_ptr, bytes_written + 1)
				feature {EV_GTK_EXTERNALS}.g_free (utf8_ptr)
			end
		end

	managed_data: MANAGED_POINTER
		-- Pointer to the UTF8 string

end -- class EV_GTK_C_STRING

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

