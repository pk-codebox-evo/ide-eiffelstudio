note
	description: "[
					Generated by EiffelRibbon tool
																							]"
	date: "$Date$"
	revision: "$Revision$"

class
	SPLIT_BUTTON_CHILD_1

inherit
	SPLIT_BUTTON_CHILD_1_IMP
		redefine
			create_interface_objects
		end

create
	{EV_RIBBON_GROUP, EV_RIBBON_SPLIT_BUTTON} make_with_command_list

feature -- Query

	text: STRING_32 = "Button 1"
			-- This is generated by EiffelRibbon tool

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			Precursor
			select_actions.extend (agent do
											print ("%NSplit button item 1 selected")
										end)
		end
end

