note
	description: "[
		The error command response that occurs if the server cannot send a command to the webapp.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCCR_CANNOT_SEND

inherit
	XCCR_ERROR

feature -- Access

	description: STRING
			-- Describes the error
		do
			Result := "There was a problem transmitting the command to the server."
		end

end

