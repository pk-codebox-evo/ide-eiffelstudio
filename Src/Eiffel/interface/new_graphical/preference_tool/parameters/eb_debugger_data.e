indexing
	description: "All shared preferences for the debugger."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_DATA

inherit
	ES_TOOLBAR_PREFERENCE

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end

feature {EB_SHARED_PREFERENCES} -- Value

	default_maximum_stack_depth: INTEGER is
			-- 		
		do
			Result := default_maximum_stack_depth_preference.value
		end

	critical_stack_depth: INTEGER is
			-- Call stack depth at which we warn the user against a possible stack overflow.
		do
			Result := critical_stack_depth_preference.value
			if Result < -1 or Result = 0 then
				Result := 1000
			end
		end

	default_expanded_view_size: INTEGER is
			-- Default size for expanded view dialog
		do
			Result := default_expanded_view_size_preference.value
			if Result < 1 then
				Result := 500
			end
		end

	show_text_in_project_toolbar: BOOLEAN is
			-- Show selected text in the project toolbar?
		do
			Result := show_text_in_project_toolbar_preference.value
		end

	show_all_text_in_project_toolbar: BOOLEAN is
			-- Show all selected text in the project toolbar?
		do
			Result := show_all_text_in_project_toolbar_preference.value
		end

	dotnet_debugger: ARRAY [STRING] is
			-- .NET debugger to launch
		do
			Result := dotnet_debugger_preference.value
		end

	project_toolbar_layout: ARRAY [STRING] is
			-- Toolbar organization
		do
			Result := project_toolbar_layout_preference.value
		end

	close_classic_dbg_daemon_on_end_of_debugging: BOOLEAN is
			-- Do we close the classic dbg daemon when the debugging is finished ?
		do
			Result := close_classic_dbg_daemon_on_end_of_debugging_preference.value
		end

	classic_debugger_timeout: INTEGER is
		do
			Result := classic_debugger_timeout_preference.value
		end

	classic_debugger_location: STRING is
		do
			Result := classic_debugger_location_preference.value
		end

feature {EB_SHARED_PREFERENCES} -- Preference

	default_maximum_stack_depth_preference: INTEGER_PREFERENCE
	critical_stack_depth_preference: INTEGER_PREFERENCE
	default_expanded_view_size_preference: INTEGER_PREFERENCE
	show_text_in_project_toolbar_preference: BOOLEAN_PREFERENCE
	show_all_text_in_project_toolbar_preference: BOOLEAN_PREFERENCE
	project_toolbar_layout_preference: ARRAY_PREFERENCE
	dotnet_debugger_preference: ARRAY_PREFERENCE
	close_classic_dbg_daemon_on_end_of_debugging_preference: BOOLEAN_PREFERENCE
	classic_debugger_timeout_preference: INTEGER_PREFERENCE
	classic_debugger_location_preference: STRING_PREFERENCE

feature -- Toolbar Convenience

	retrieve_project_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the project toolbar using the available commands in `command_pool'
		do
			Result := retrieve_toolbar (command_pool, project_toolbar_layout_preference.value)
			if show_text_in_project_toolbar then
				Result.enable_important_text
			elseif show_all_text_in_project_toolbar then
				Result.enable_text_displayed
			end
		end

	save_project_toolbar (project_toolbar: EB_TOOLBAR) is
			-- Save the project toolbar `project_toolbar' layout/status into the preferences.
			-- Call `save_preferences' to have the changes actually saved.
		do
			project_toolbar_layout_preference.set_value (save_toolbar (project_toolbar))
			show_text_in_project_toolbar_preference.set_value (project_toolbar.is_text_important)
			show_all_text_in_project_toolbar_preference.set_value (project_toolbar.is_text_displayed)
			preferences.save_preference (project_toolbar_layout_preference)
			preferences.save_preference (show_text_in_project_toolbar_preference)
			preferences.save_preference (show_all_text_in_project_toolbar_preference)
		end

feature {NONE} -- Preference Strings

	project_toolbar_layout_string: STRING is "debugger.project_toolbar_layout"
	critical_stack_depth_string: STRING is "debugger.critical_stack_depth"
	show_text_in_project_toolbar_string: STRING is "debugger.show_text_in_project_toolbar"
	show_all_text_in_project_toolbar_string: STRING is "debugger.show_all_text_in_project_toolbar"
	default_expanded_view_size_string: STRING is "debugger.default_expanded_view_size"
	default_maximum_stack_depth_string: STRING is "debugger.default_maximum_stack_depth"
	dotnet_debugger_string: STRING is "debugger.dotnet_debugger"
	close_classic_dbg_daemon_on_end_of_debugging_string: STRING is "debugger.classic_debugger.close_dbg_daemon_on_end_of_debugging"
	classic_debugger_timeout_string: STRING is "debugger.classic_debugger.timeout"
	classic_debugger_location_string: STRING is "debugger.classic_debugger.debugger_location"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "debugger")

			default_maximum_stack_depth_preference := l_manager.new_integer_preference_value (l_manager, default_maximum_stack_depth_string, 500)
			critical_stack_depth_preference := l_manager.new_integer_preference_value (l_manager, critical_stack_depth_string, 500)
			default_expanded_view_size_preference := l_manager.new_integer_preference_value (l_manager, default_expanded_view_size_string, 50)
			show_text_in_project_toolbar_preference := l_manager.new_boolean_preference_value (l_manager, show_text_in_project_toolbar_string, True)
			show_all_text_in_project_toolbar_preference := l_manager.new_boolean_preference_value (l_manager, show_all_text_in_project_toolbar_string, True)
			project_toolbar_layout_preference := l_manager.new_array_preference_value (l_manager, project_toolbar_layout_string, <<"Clear_bkpt__visible">>)
			dotnet_debugger_preference := l_manager.new_array_preference_value (l_manager, dotnet_debugger_string, <<"[EiffelStudio Dbg];cordbg;DbgCLR">>)
			dotnet_debugger_preference.set_is_choice (True)
			close_classic_dbg_daemon_on_end_of_debugging_preference := l_manager.new_boolean_preference_value (l_manager, close_classic_dbg_daemon_on_end_of_debugging_string, True)
			classic_debugger_timeout_preference := l_manager.new_integer_preference_value (l_manager, classic_debugger_timeout_string, 0)
			classic_debugger_location_preference := l_manager.new_string_preference_value (l_manager, classic_debugger_location_string, "")
		end

	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void
	default_maximum_stack_depth_preference_not_void: default_maximum_stack_depth_preference /= Void
	critical_stack_depth_preference_not_void: critical_stack_depth_preference /= Void
	default_expanded_view_size_preference_not_void: default_expanded_view_size_preference /= Void
	show_text_in_project_toolbar_preference_not_void: show_text_in_project_toolbar_preference /= Void
	show_all_text_in_project_toolbar_preference_not_void: show_all_text_in_project_toolbar_preference /= Void
	project_toolbar_layout_preference_not_void: project_toolbar_layout_preference /= Void
	close_classic_dbg_daemon_on_end_of_debugging_preference_not_void:  close_classic_dbg_daemon_on_end_of_debugging_preference /= Void
	classic_debugger_timeout_preference_not_void: classic_debugger_timeout_preference /= Void
	classic_debugger_location_preference_not_void: classic_debugger_location_preference /= Void

--	_preference_not_void: _preference /= Void

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

end -- class EB_DEBUGGER_DATA
