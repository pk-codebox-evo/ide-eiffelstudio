note
	description: "[
					Generated by EiffelRibbon tool
					Don't edit this file, since it will be replaced by EiffelRibbon tool
					generated files everytime
						]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAB_COMBO_BOX_IMP

inherit
	EV_RIBBON_TAB

feature {NONE} -- Initialization

	create_interface_objects
			-- Create objects
		do
			create group_combo_box.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.group_combo_box>>)

			create groups.make (1)
			groups.extend (group_combo_box)

		end

feature -- Query
	group_combo_box: GROUP_COMBO_BOX


end

