indexing
	description: "Constants for MSI"
	date: "$Date$"
	revision: "$Revision$"

class
	MSI_CONSTANTS

feature -- Run mode

	run_mode_scheduled: INTEGER is 16

feature -- Install message

	install_message_progress: INTEGER is 0x0A000000
	install_message_action_start: INTEGER is 0x08000000
	install_message_action_data: INTEGER is 0x09000000

end -- class MSI_CONSTANTS
