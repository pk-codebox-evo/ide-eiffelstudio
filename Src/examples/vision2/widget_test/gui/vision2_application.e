indexing
	description: "Objects that represent the Vision2 application.%
		%The original version of this class has been generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VISION2_APPLICATION

inherit
	EV_APPLICATION

	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch is
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		local
			l_layout: VISION2_TOUR_LAYOUT
		do
			create l_layout
			l_layout.check_environment_variable
			set_eiffel_layout (l_layout)
			default_create
			create main_window
			main_window.show
			launch
		end

feature {NONE} -- Implementation

	main_window: MAIN_WINDOW;
		-- Main window of `Current'.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class VISION2_APPLICATION
