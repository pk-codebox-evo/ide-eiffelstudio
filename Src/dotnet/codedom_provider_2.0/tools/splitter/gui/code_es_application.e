indexing
	description: "Objects that represent the Vision2 application.%
		%The original version of this class has been generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ES_APPLICATION

inherit
	EV_THREAD_APPLICATION

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		do
			default_create
			create main_window.make
			main_window.set_help_context (agent help_context)
			set_help_engine (create {CODE_HELP_ENGINE})
			main_window.show
			launch
		end
		
feature {NONE} -- Implementation

	help_context: CODE_HELP_CONTEXT is
			-- Help context
		do
			create Result.make_from_string ("tools/esplitter.html")
		end

	main_window: CODE_ES_MAIN_WINDOW
		-- Main window of `Current'.

end -- class CODE_ES_APPLICATION

--+--------------------------------------------------------------------
--| eSplitter
--| Copyright (C) Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------