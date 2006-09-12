indexing
	description: "Confirmation dialog with confirmed state"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_CONFIRMATION_DIALOG

inherit
	EV_CONFIRMATION_DIALOG
		redefine
			make_with_text
		end

create
	make_with_text

feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
			-- Initialize 'Current' with predefined action when user clicks 'Ok'
		do
			make_with_text_and_actions (a_text, << agent do confirmed := True end >>)
		end

feature -- Access

	confirmed: BOOLEAN
			-- Did user confirm?

end
