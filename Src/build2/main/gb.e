indexing
	description: "Graphical builder application."
	date : "$Date$"
	id : "$Id$"
	revision : "$Revision$"

class
	GB

inherit

	EV_APPLICATION
		redefine
			initialize
		end
		
	GB_SHARED_XML_HANDLER
		undefine
			default_create, copy
		end
		
	GB_SHARED_TOOLS
		undefine
			default_create, copy
		end

create
	execute

feature {NONE} -- Initialization

	execute is
		do
			default_create
			xml_handler.load_components
			main_window.show
			launch	
		end
		
	initialize is
			-- `Initialize `Current'.
		do
			Precursor {EV_APPLICATION}
			-- Any General initialization can be added here.
			-- This will be executed before the program is launched.
		end

end