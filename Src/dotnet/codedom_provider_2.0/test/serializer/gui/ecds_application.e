indexing
	description: "Objects that represent the Vision2 application.%
		%The original version of this class has been generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	ECDS_APPLICATION

inherit
	EV_APPLICATION

create
	make_and_launch
	
feature {NONE} -- Initialization

	make_and_launch is
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		do
			default_create
			create main_window
			main_window.show
			launch
		end
		
feature {NONE} -- Implementation

	main_window: ECDS_MAIN_WINDOW
		-- Main window of `Current'.

end -- class ECDS_APPLICATION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Serializer
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
