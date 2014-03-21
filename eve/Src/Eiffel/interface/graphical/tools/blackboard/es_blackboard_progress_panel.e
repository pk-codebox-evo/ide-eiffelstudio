note
	description: "Panel displaying the progress of the blackboard."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_BLACKBOARD_PROGRESS_PANEL

inherit

	EBB_SHARED_BLACKBOARD

	EB_SHARED_PIXMAPS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize panel.
		local
			l_col: EV_GRID_COLUMN
		do
			create grid
			grid.set_column_count_to (message_column)

			l_col := grid.column (cancel_column)
			l_col.set_width (20)
			l_col.set_title ("")

			l_col := grid.column (state_column)
			l_col.set_width (80)
			l_col.set_title ("State")

			l_col := grid.column (tool_column)
			l_col.set_width (100)
			l_col.set_title ("Tool")

			l_col := grid.column (configuration_column)
			l_col.set_width (100)
			l_col.set_title ("Configuration")

			l_col := grid.column (input_column)
			l_col.set_width (200)
			l_col.set_title ("Input")

			l_col := grid.column (last_change_column)
			l_col.set_width (100)
			l_col.set_title ("Elapsed time [s]")

			l_col := grid.column (message_column)
			l_col.set_width (200)
			l_col.set_title ("Message")
		end

feature -- Access

	grid: ES_GRID
			-- Widget of this panel.

feature -- Basic operations

	update_display
			-- Update display of the data.
		do
			grid.remove_and_clear_all_rows
			add_tool_executions (blackboard.executions.running_executions)
			add_tool_executions (blackboard.executions.waiting_executions)
			add_tool_executions (blackboard.executions.finished_executions)
		end

feature {NONE} -- Implementation

	add_tool_executions (a_list: LIST [EBB_TOOL_EXECUTION])
			-- Add rows for entries in list `a_list'.
		do
			from
				a_list.start
			until
				a_list.after
			loop
				add_tool_execution (a_list.item)
				a_list.forth
			end
		end

	add_tool_execution (a_execution: EBB_TOOL_EXECUTION)
			-- Add row for `a_execution'.
		local
			l_row: EV_GRID_ROW
			l_text: EV_GRID_TEXT_ITEM
			l_button: EV_GRID_TEXT_ITEM
			l_color: EV_COLOR
			l_time: STRING
			l_end: DATE_TIME
		do
			l_row := grid.extended_new_row
			l_row.set_data (a_execution)

				-- State and color
			if a_execution.is_running then
				create l_button.make_with_text ("")
				l_button.set_pixmap (icon_pixmaps.debug_stop_icon)
				l_button.pointer_button_release_actions.force_extend (agent cancel_execution (a_execution))
				create l_text.make_with_text ("Running")
				create l_color.make_with_rgb (0.9, 1.0, 0.9)
				l_time := time_difference_in_seconds (create {TIME}.make_now, a_execution.started_time.time).out
			elseif a_execution.is_canceled then
				create l_text.make_with_text ("Canceled")
				create l_color.make_with_rgb (1.0, 0.9, 0.9)
				l_time := ""
			elseif a_execution.is_finished then
				create l_text.make_with_text ("Finished")
				create l_color.make_with_rgb (0.9, 0.9, 1.0)
				l_time := time_difference_in_seconds (a_execution.finished_time.time, a_execution.started_time.time).out
			else
				create l_button.make_with_text ("")
				l_button.set_pixmap (icon_pixmaps.debug_stop_icon)
				l_button.pointer_button_release_actions.force_extend (agent cancel_execution (a_execution))
				create l_text.make_with_text ("Waiting")
				create l_color.make_with_rgb (1.0, 1.0, 0.9)
				l_time := ""
			end
			if l_button /= Void then
				l_row.set_item (cancel_column, l_button)
			end
			l_row.set_item (state_column, l_text)
			l_row.set_background_color (l_color)

				-- Tool
			create l_text.make_with_text (a_execution.tool.name)
			l_row.set_item (tool_column, l_text)

				-- Configuration
			create l_text.make_with_text (a_execution.configuration.name)
			l_row.set_item (configuration_column, l_text)

				-- Input
			create l_text.make_with_text (a_execution.input.classes.first.name)
			l_row.set_item (input_column, l_text)

				-- Time
			create l_text.make_with_text (l_time)
			l_row.set_item (last_change_column, l_text)

				-- Message
			if attached a_execution.instance and then attached a_execution.instance.status_message then
				create l_text.make_with_text (a_execution.instance.status_message)
			else
				create l_text.make_with_text ("")
			end
			l_row.set_item (message_column, l_text)
		end

	cancel_execution (a_execution: EBB_TOOL_EXECUTION)
			-- Cancel execution `a_execution'.
		do
			if a_execution.is_running then
				a_execution.cancel
			end
		end


	cancel_column: INTEGER = 1
	state_column: INTEGER = 2
	tool_column: INTEGER = 3
	configuration_column: INTEGER = 4
	input_column: INTEGER = 5
	last_change_column: INTEGER = 6
	message_column: INTEGER = 7

	time_difference_in_seconds (a_end_time, a_start_time: TIME): INTEGER
			-- Elapsed time since `a_time'.
		local
			l_now: TIME
		do
			Result := a_end_time.relative_duration (a_start_time).seconds_count
		end

;note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
