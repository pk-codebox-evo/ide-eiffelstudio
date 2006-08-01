indexing
	description: "Director of all EB_DEVELOPMENT_WINDOW_BUILDERs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"


class
	EB_DEVELOPMENT_WINDOW_DIRECTOR

create
	make

feature{NONE} -- Initlization

	make is
			-- Creation method
		do
		end

feature -- Command

	construct is
			-- Create a new development window.
		do
			internal_construct
			develop_window.window.show
			develop_window.restore_tools_docking_layout
			develop_window.window.hide
		end

	construct_as_context_tool is
			-- Create a new development window and expand the context tool.
		do
			construct
				-- Perform window setting from `show_actions', as the
				-- resizing executed as a result only works correctly
				-- while the window is displayed.
			develop_window.window.show_actions.extend (agent set_context_mode)
		end

	set_context_mode is
			-- Set `current' into context mode, that is the context tool
			-- maximized, and the non editor panel is hidden.
		do
			if not develop_window.unified_stone then
				develop_window.commands.toggle_stone_cmd.execute
			end
		end

	construct_as_editor is
			-- Create a new development window and expand the editor tool.
		do
			construct

			-- Following comments are from non-docking Eiffel Studio.
			-- Perform window setting from `show_actions', as the resizing executed
			-- must be performed after `current' is displayed.
		end

	construct_with_session_data (a_dev_window: EB_DEVELOPMENT_WINDOW; a_session_data: EB_DEVELOPMENT_WINDOW_SESSION_DATA) is
			-- Recreate a previously existing development window using `a_session_data'.
		local
			l_class_i: CLASS_I
			l_class_c_stone: CLASSC_STONE
			l_cluster_string, l_class_string, l_feature_string: STRING
		do
			if a_dev_window = Void then
				internal_construct
			else
				develop_window := a_dev_window
			end

			develop_window.set_internal_development_window_data (a_session_data)
				-- Initial editors.
			develop_window.editors_manager.restore_editors (a_session_data.open_classes, a_session_data.open_clusters)

				-- Attempt to reload last edited class of `Current'.
			if a_session_data.file_name /= Void then
				develop_window.conf_todo
				-- FIXIT: there are list of classes assiociate with a class name, which one should we use?
--				l_class_i := develop_window.eiffel_universe.classes_with_name (a_session_data.file_name).first
				if l_class_i /= Void and then l_class_i.compiled then
						-- Create compiled class stone and target `Current' to it.
					create l_class_c_stone.make (l_class_i.compiled_class)
					develop_window.set_stone (l_class_c_stone)
					if a_session_data.editor_position > 0 then
						develop_window.editors_manager.current_editor.display_line_when_ready (a_session_data.editor_position, False)
					end
				end
			end
					-- Presumption is made that if the strings are not void then they represent
					-- valid entities in the project.
				l_cluster_string := a_session_data.context_cluster_string
				l_class_string := a_session_data.context_class_string
				l_feature_string := a_session_data.context_feature_string
				if l_feature_string /= Void then
					develop_window.tools.features_relation_tool.address_manager.feature_address.set_text (l_feature_string)
					develop_window.tools.features_relation_tool.address_manager.class_address.set_text (l_class_string)
					develop_window.tools.features_relation_tool.address_manager.execute_with_feature
				elseif l_class_string /= Void then
					develop_window.tools.class_tool.address_manager.class_address.set_text (l_cluster_string)
					develop_window.tools.class_tool.address_manager.execute_with_class
				elseif l_cluster_string /= Void then
					-- FIXIT: We only cluster information available, which tool should we put it?
					develop_window.tools.class_tool.address_manager.cluster_address.set_text (l_cluster_string)
					develop_window.tools.class_tool.address_manager.execute_with_cluster
				end
		end

feature -- Query

	develop_window: EB_DEVELOPMENT_WINDOW
			-- Result of Current.

feature -- Test

	on_uncaught_exception_test (a_exception: EXCEPTION) is
			-- FIXIT: remove this function when commit
		do
			debug ("fixme")
				print ("%N on_uncaught_exception_test " + a_exception.tag + " %N  " + a_exception.trace_as_string)
			end
		end

feature{NONE} -- Implementation

	internal_construct is
			-- Construct a development window.
		local
			l_test: EV_ENVIRONMENT
			l_history_manager: EB_HISTORY_MANAGER
			l_address_manager: EB_ADDRESS_MANAGER
			l_shared: SD_SHARED
			l_icons: SD_ICONS
		do
			create l_shared
			create l_icons.make
			l_shared.set_icons (l_icons)

			create develop_window.make
			create main_builder.make (develop_window)
			create menu_builder.make (develop_window)
			create toolbar_builder.make (develop_window)

			create l_test
			l_test.application.uncaught_exception_actions.extend (agent on_uncaught_exception_test)

			develop_window.set_unified_stone (develop_window.preferences.development_window_data.context_unified_stone)
				-- Build the history manager, the address manager, ...

			create l_history_manager.make (develop_window)
			develop_window.set_history_manager (l_history_manager)

			create l_address_manager.make (develop_window, False)
			develop_window.set_address_manager (l_address_manager)
			main_builder.build_formatters
			develop_window.address_manager.set_formatters (develop_window.managed_main_formatters)

				-- Init commands, build interface, build menus, ...
			main_builder.build_vision_window
			menu_builder.build_menus
			main_builder.build_help_engine

			develop_window.set_initialized_for_builder (False)

			main_builder.set_up_accelerators

			develop_window.window.focus_in_actions.extend(agent (develop_window.agents).on_focus)

				-- Create the toolbars.
			toolbar_builder.build_toolbars_area

				-- Rebuild toolbar menu in View menu
			develop_window.menus.view_menu.put_front (menu_builder.build_toolbar_menu)

				-- Update widgets visibilities
			develop_window.status_bar.remove_cursor_position
			develop_window.address_manager.set_output_line (develop_window.status_bar.label)

				-- Finish initializing the main editor formatters
			main_builder.end_build_formatters

			develop_window.address_manager.disable_formatters
			if develop_window.Eiffel_project.manager.is_project_loaded then
				develop_window.agents.on_project_created
				develop_window.agents.on_project_loaded
			elseif develop_window.Eiffel_project.manager.is_created then
				develop_window.agents.on_project_unloaded
				develop_window.agents.on_project_created
			else
				develop_window.agents.on_project_unloaded
			end

			develop_window.set_initialized_for_builder (True)
			develop_window.set_is_destroying (False)
		end

	main_builder: EB_DEVELOPMENT_WINDOW_MAIN_BUILDER
			-- Builder which build tools, commands, formatters.

	menu_builder: EB_DEVELOPMENT_WINDOW_MENU_BUILDER
			-- Builder which build menus.

	toolbar_builder: EB_DEVELOPMENT_WINDOW_TOOLBAR_BUILDER;
			-- Builder which build toolbars.

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

end
