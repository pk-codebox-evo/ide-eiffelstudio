note
	description: "Window in which ovals are drawn."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	launch_demo
		local
			cmd: like oval_demo_cmd
		do
			if attached client_window as win then
				create cmd.make_in (win, display_mutex)
				oval_demo_cmd := cmd
				cmd.launch
			end
		end

	oval_demo_cmd: detachable OVAL_DEMO_CMD
			-- To draw ovals.

	title: STRING = "Ovals";
			-- Title of the window.


note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end -- class OVAL_DEMO_WINDOW

