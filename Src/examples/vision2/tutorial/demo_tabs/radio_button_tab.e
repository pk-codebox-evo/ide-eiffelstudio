indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RADIO_BUTTON_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end


creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects

		once
			{ANY_TAB} Precursor (Void)
			
				-- Creates the objects and their commands
			create label.make_with_text(Current, "All features are inherited from EV_CHECK_BUTTON,%Ntherefore there are no features unique to EV_RADIO_BUTTON to modify")
			set_child_position (label, 0, 0, 1, 1)
			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Radio Button"
		end

	label: EV_LABEL

feature -- Execution feature  

feature -- Access

	current_widget: EV_RADIO_BUTTON
	f1: FEATURE_MODIFIER	
	b1: EV_BUTTON
end -- class RADIO_BUTTON_TAB
