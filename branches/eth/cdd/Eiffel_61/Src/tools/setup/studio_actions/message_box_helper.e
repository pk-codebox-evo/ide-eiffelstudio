indexing
	description: "Display message in a message box."
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_BOX_HELPER

feature -- Display

	message_box (a_name: STRING) is
			-- Display `a_name' in a dialog box. Mostly used for debugging.
		require
			a_name_not_void: a_name /= Void
		local
			l_name: WEL_STRING
		do
			create l_name.make (a_name)
			c_message_box (l_name.item)
		end

	error_box (a_name: STRING) is
			-- Display `a_name' in an error dialog box. Mostly used to display errors to user.
		require
			a_name_not_void: a_name /= Void
		local
			l_name: WEL_STRING
		do
			create l_name.make (a_name)
			c_error_box (l_name.item)
		end

feature {NONE} -- Implementation

	c_message_box (a_name: POINTER) is
		external
			"C inline use <windows.h>"
		alias
			"MessageBox(NULL, $a_name, L%"Warning%", MB_OK | MB_ICONWARNING);"
		end

	c_error_box (a_name: POINTER) is
		external
			"C inline use <windows.h>"
		alias
			"MessageBox(NULL, $a_name, L%"Error%", MB_OK | MB_ICONERROR);"
		end

end -- class MESSAGE_BOX_HELPER
