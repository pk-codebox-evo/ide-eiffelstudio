note
	description: "Application Constants as defined in 'resource.h'"
	author: "Generated by the New WEL Application Wizard"
	date: "${FL_DATE}"
	revision: "1.0.0"

class
	APPLICATION_IDS

feature -- Access

	Idi_wel_application: INTEGER = 1
		-- Icon resource

	Idm_aboutbox: INTEGER = 16
		-- Resource for the "About" dialog box.

	Idd_aboutbox: INTEGER = 100
		-- Resource for the "About" dialog box.

	Ids_aboutbox: INTEGER = 101
		-- Resource for the "About" dialog box.

	Idd_${FL_PROJECT_NAME_LOWERCASE}_dialog: INTEGER = 102
		-- Resource for the Main dialog box.

end
