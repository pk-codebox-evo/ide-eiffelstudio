indexing
	description: "Objects that represent a command for setting of the root window."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SET_ROOT_WINDOW_COMMAND

inherit
	GB_STANDARD_CMD
		redefine
			execute, executable
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		do
			components := a_components
			make
			set_tooltip ("Set root window")
			set_pixmaps (Icon_titled_window_main_small)
			set_name ("Set root window")
			set_menu_name ("Set root window")
			add_agent (agent execute)
		end

feature -- Access	

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
			Result := not components.tools.widget_selector.objects.is_empty and not components.tools.Layout_constructor.is_empty
		end

feature -- Basic operations

	execute is
				-- Execute `Current'.
		do
			components.tools.widget_selector.change_root_window
			components.tools.widget_selector.tool_bar.update_select_root_window_command
		end

end -- class GB_SET_ROOT_WINDOW_COMMAND
