note
	description	: "Root class for this WEL Application"
	author		: "Generated by the New WEL Application Wizard"
	date		: "${FL_DATE}"
	revision	: "1.0.0"

class
	ROOT_CLASS

inherit
	WEL_APPLICATION

create
	make

feature

	main_window: ${FL_MAIN_CLASS}
			-- Create the application's main window
		once
			create Result.make
		end

end
