note
	description: "[
					Generated by EiffelRibbon tool
					Don't edit this file, since it will be replaced by EiffelRibbon tool
					generated files everytime
																							]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAB_3_IMP

inherit
	EV_RIBBON_TAB

feature {NONE} -- Initialization

	create_interface_objects
			-- Create objects
		do
			create group_4.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.group_4>>)

			create groups.make (1)
			groups.extend (group_4)

		end

feature -- Query
	group_4: GROUP_4


end

