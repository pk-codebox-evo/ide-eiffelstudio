note
	description: "[
					Generated by EiffelRibbon tool
																							]"
	date: "$Date$"
	revision: "$Revision$"

class
	BUTTON_CHANGE_LABEL_TITLE

inherit
	BUTTON_CHANGE_LABEL_TITLE_IMP
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
											set_text ("Text changed " + counter.item.out)
											counter.put (counter.item + 1)
										end)
		end

	counter: CELL [INTEGER]
			--
		once
			create Result.put (0)
		end

end

