indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	MAIN_WINDOW_IMP
	
	GRID_ACCESSOR
		undefine
			copy, default_create, is_equal
		end

	MEMORY
		undefine
			copy, default_create, is_equal, dispose
		end


feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			grid_cell.extend (grid)
			close_request_actions.extend (agent ((create {EV_ENVIRONMENT}).application).destroy)
			status_bar_frame.extend (status_bar)
			create mem_short.make_with_key_combination (create {EV_KEY}.make_with_code (feature {EV_KEY_CONSTANTS}.key_1), True, False, False)
			accelerators.extend (mem_short)
			tools_notebook.selection_actions.extend (agent update_tab_information)
		end

	mem_short: EV_ACCELERATOR

feature {NONE} -- Implementation

	update_tab_information is
			-- A selection has changed in `tools_notebook' so update tabs.

		do
			if tools_notebook.selected_item = position_tab then
				position_tab.set_is_selected (True)
			else
				position_tab.set_is_selected (False)
			end
		end
		

	file_exit_menu_item_selected is
			-- Called by `select_actions' of `file_exit_menu_item'.
		do
			((create {EV_ENVIRONMENT}).application).destroy
		end
	
	profiling_on_menu_item_selected is
			-- Called by `select_actions' of `profiling_on_menu_item'.
		do
			if profiling_on_menu_item.is_selected then
				enable_profile
			else
				disable_profile
			end
		end

	view_tools_menu_item_selected is
			-- Called by `select_actions' of `view_tools_menu_item'.
		do
			if view_tools_menu_item.is_selected then
				tools_notebook.show
			else
				tools_notebook.hide
			end
		end

	full_collect_menu_item_selected is
			-- Called by `select_actions' of `full_collect_menu_item'.
		do
			collect
			full_collect
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


end -- class MAIN_WINDOW

