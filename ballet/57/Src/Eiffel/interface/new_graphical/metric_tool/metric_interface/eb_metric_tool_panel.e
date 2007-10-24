indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_TOOL_PANEL

inherit
	EB_METRIC_TOOL_PANEL_IMP

	EB_CONSTANTS
		undefine
			is_equal,
			copy,
			default_create
		end

	SHARED_WORKBENCH
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_METRIC_SHARED
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_RECYCLABLE
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_METRIC_TOOL_INTERFACE
		undefine
			is_equal,
			copy,
			default_create
		end
create
	make

feature{NONE} -- Initialization

	make (a_dev_window: like development_window; a_metric_tool: like metric_tool) is
			-- Initialize `development_window' with `a_dev_window' and `metric_tool' with `a_metric_tool'.
		require
			a_dev_window_attached: a_dev_window /= Void
			a_metric_tool_attached: a_metric_tool /= Void
		do
			development_window := a_dev_window
			metric_tool := a_metric_tool
			set_metric_tool (a_metric_tool)
			create panel_table.make (4)
			default_create
		ensure
			development_window_set: development_window = a_dev_window
			metric_tool_set: metric_tool = a_metric_tool
			panel_list_attached: panel_table /= Void
		end

feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
				-- Setup metric evaluation tab.
			create metric_evaluation_panel.make (metric_tool)
			metric_evaluation_tab.extend (metric_evaluation_panel)

				-- Setup metric definition tab.
			create new_metric_panel.make (metric_tool)
			new_metric_tab.extend (new_metric_panel)

				-- Setup metric archive tab.
			create metric_archive_panel.make (metric_tool)
			metric_archive_tab.extend (metric_archive_panel)

				-- Setup detailed result tab.
			create detail_result_panel.make (metric_tool)
			result_tab.extend (detail_result_panel)

				-- Setup `panel_table'.
			panel_table.put (metric_evaluation_panel, 1)
			panel_table.put (new_metric_panel, 2)
			panel_table.put (metric_archive_panel, 3)
			panel_table.put (detail_result_panel, 4)

				-- Setup tab names			
			metric_notebook.set_item_text (metric_notebook.i_th (1), metric_names.t_evaluation_tab)
			metric_notebook.set_item_text (metric_notebook.i_th (2), metric_names.t_definition_tab)
			metric_notebook.set_item_text (metric_notebook.i_th (3), metric_names.t_archive_tab)
			metric_notebook.set_item_text (metric_notebook.i_th (4), metric_names.t_detail_result_tab)

			metric_notebook.selection_actions.extend (agent on_tab_change)
			metric_notebook.select_item (metric_evaluation_tab)
		end

feature -- Access

	development_window: EB_DEVELOPMENT_WINDOW
			-- Development window to which current belongs

	metric_evaluation_panel: EB_METRIC_EVALUATION_PANEL
			-- Metric evaluation panel

	new_metric_panel: EB_NEW_METRIC_PANEL
			-- New metric panel

	detail_result_panel: EB_METRIC_RESULT_AREA
			-- Detailed result panel

	metric_archive_panel: EB_METRIC_ARCHIVE_PANEL
			-- Metric archive panel

	panel_table: HASH_TABLE [EB_METRIC_PANEL, INTEGER]
			-- Table of all panels in metric tool
			-- Key is panel index in `metric_notebook', value is that panel

feature -- Access

	metric_evaluation_tab_index: INTEGER is 1
	metric_definition_tab_index: INTEGER is 2
	metric_archive_tab_index: INTEGER is 3
	metric_result_tab_index: INTEGER is 4
			-- Tab index for tabs in metric tool

feature -- Actions

	on_tab_change is
			-- Action to be performed when selected tab changes
		local
			l_index: INTEGER
			l_panel_table: like panel_table
		do
			l_index := metric_notebook.selected_item_index
			from
				l_panel_table := panel_table
				l_panel_table.start
			until
				l_panel_table.after
			loop
				if l_panel_table.key_for_iteration = l_index then
					l_panel_table.item_for_iteration.on_select
				else
					l_panel_table.item_for_iteration.set_is_selected (False)
				end
				l_panel_table.forth
			end
		end

feature -- Basic operations

	recycle is
			-- To be called when the button has became useless.
		do
			metric_evaluation_panel.recycle
			new_metric_panel.recycle
			metric_archive_panel.recycle
			detail_result_panel.recycle

			metric_evaluation_panel := Void
			new_metric_panel := Void
			metric_archive_panel := Void
			detail_result_panel := Void
			development_window := Void
		end

	set_stone (a_stone: STONE) is
			-- Notify that `a_stone' has been dropp on metric panel.
		local
			l_panel: EB_METRIC_PANEL
		do
			l_panel := panel_table.item (metric_notebook.selected_item_index)
			if l_panel /= Void then
				l_panel.set_stone (a_stone)
			end
		end

invariant
	development_window_attached: development_window /= Void
	panel_list_attached: panel_table /= Void

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
        license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
        licensing_options:	"http://www.eiffel.com/licensing"
        copying: "[
                        This file is part of Eiffel Software's Eiffel Development Environment.
                        
                        Eiffel Software's Eiffel Development Environment is free
                        software; you can redistribute it and/or modify it under
                        the terms of the GNU General Public License as published
                        by the Free Software Foundation, version 2 of the License
                        (available at the URL listed under "license" above).
                        
                        Eiffel Software's Eiffel Development Environment is
                        distributed in the hope that it will be useful,	but
                        WITHOUT ANY WARRANTY; without even the implied warranty
                        of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
                        See the	GNU General Public License for more details.
                        
                        You should have received a copy of the GNU General Public
                        License along with Eiffel Software's Eiffel Development
                        Environment; if not, write to the Free Software Foundation,
                        Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
                ]"
        source: "[
                         Eiffel Software
                         356 Storke Road, Goleta, CA 93117 USA
                         Telephone 805-685-1006, Fax 805-685-6869
                         Website http://www.eiffel.com
                         Customer support http://support.eiffel.com
                ]"


end -- class EB_METRIC_TOOL_PANEL

