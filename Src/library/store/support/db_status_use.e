indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database : All_Bases

class DB_STATUS_USE

inherit
	HANDLE_USE

feature {NONE} -- Status report

	exhausted: BOOLEAN is
			-- Is there any more resulting row?
		do
			Result := not handle.status.found
		end

	is_connected: BOOLEAN is
			-- Has connection to the database server succeeded?
		do
			Result := handle.status.is_connected
		end

	error_code: INTEGER is
			-- Error code of last transaction
		do
			Result := handle.status.error_code
		end

	is_ok: BOOLEAN is
			-- Is last SQL statement ok ?
		do
			Result := error_code = 0
		end

	error_message: STRING is
			-- SQL error message prompted by database server
		do
			Result := handle.status.error_message
		end
	
	warning_message: STRING is
			-- SQL warning message prompted by database server
		do
			Result := handle.status.warning_message
		end

feature {NONE} -- Status setting

	reset is
			-- Reset `is_ok', `error_code_stored',`error_message_stored' and `warning_message' after error occurred.
			--| Perform this operation through `DB_CONTROL'.
		do
			handle.status.reset
		ensure
			is_ok: is_ok
			no_error: error_code = 0
			no_message_error: error_message.is_equal ("") 
			no_message_warning: warning_message.is_equal ("") 
		end

end -- class DB_STATUS_USE



--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

