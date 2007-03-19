indexing
	description: "[
			A EV_TITLED_WINDOW containing a tree view of application preferences.  Provides a
			list to view preference information and ability to edit the preferences using popup floating widgets.  Also allows
			to restore preferences to their defaults.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

obsolete "You should use PREFERENCES_GRID_DIALOG"
class
	PREFERENCES_GRID

inherit
	PREFERENCES_GRID_DIALOG
		rename
			make as view_make,
			make_with_hidden as view_make_with_hidden
		end

create
	make, make_with_hidden

feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES; a_obs_parent_window: EV_WINDOW) is
			-- New window.  Redefined to register EiffelStudio specific preference widgets for
			-- special preference types.
		do
			make_with_hidden (a_preferences, a_obs_parent_window, False)
		end

	make_with_hidden (a_preferences: PREFERENCES; a_obs_parent_window: EV_WINDOW; a_show_hidden_flag: BOOLEAN) is
			-- New window.  Redefined to register EiffelStudio specific preference widgets for
			-- special preference types.
		do
			view_make_with_hidden (a_preferences, a_show_hidden_flag)
		end

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

end -- class PREFERENCES_GRID

