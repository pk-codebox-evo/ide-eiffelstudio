indexing 
	description:
		"Eiffel Vision file save dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_SAVE_DIALOG

inherit
	EV_FILE_DIALOG
		rename
			ok_actions as save_actions
		redefine
			implementation
		end

create
	default_create
	
feature -- Event handling

	ok_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when user clicks Save.
		obsolete
			"This has been replaced by save_actions"
		do
			Result := save_actions
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_FILE_SAVE_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_FILE_SAVE_DIALOG_IMP} implementation.make (Current)
		end

end -- class EV_FILE_SAVE_DIALOG

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

