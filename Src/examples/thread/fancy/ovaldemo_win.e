indexing
	description: "Window in which ovals are drawn."
	date: "$Date$"
	revision: "$Revision$"

class
	OVAL_DEMO_WINDOW

inherit
	DEMO_WIN
		rename
			fig_demo_cmd as oval_demo_cmd
		end

create
	make

feature -- Implementation
	
	launch_demo is
		do
			create oval_demo_cmd.make_in (client_window, display_mutex)
			oval_demo_cmd.launch
		end

	oval_demo_cmd: OVAL_DEMO_CMD
			-- To draw ovals.

	title: STRING is "Ovals"
			-- Title of the window.
		

end -- class OVAL_DEMO_WINDOW

--|----------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

