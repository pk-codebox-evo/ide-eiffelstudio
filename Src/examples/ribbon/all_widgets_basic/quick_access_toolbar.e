﻿note
	description: "[
					Generated by EiffelRibbon tool
					Don't edit this file, since it will be replaced by EiffelRibbon tool
					generated files everytime
																							]"
	date: "$Date$"
	revision: "$Revision$"

class
	QUICK_ACCESS_TOOLBAR

inherit
	EV_RIBBON_QUICK_ACCESS_TOOLBAR
		redefine
			create_interface_objects
		end
		
create
	make_with_command_list

feature {NONE} -- Initialization

	create_interface_objects
			-- Create objects
		do
			create select_actions
			create button_in_quick_access_toolbar.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.button_in_quick_access_toolbar>>)

			default_buttons.extend (button_in_quick_access_toolbar)
			
		end

feature -- Query
	button_in_quick_access_toolbar: BUTTON_IN_QUICK_ACCESS_TOOLBAR

end
