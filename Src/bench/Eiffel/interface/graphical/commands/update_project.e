indexing
	description: "Command to update the Eiffel."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class UPDATE_PROJECT

inherit
	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	PIXMAP_COMMAND
		rename
			init as make
		redefine
			tool
		end

	SHARED_RESCUE_STATUS

	SHARED_FORMAT_TABLES

	WARNER_CALLBACKS
		rename
			execute_warner_help as choose_template,
			execute_warner_ok as warner_ok
		end

	SHARED_CONFIGURE_RESOURCES

	EB_CONSTANTS

	CREATE_ACE_CALLER

create

	make

feature -- Callbacks

	choose_template is
		do
			load_default_ace
		end

	warner_ok (argument: ANY) is
		local
			chooser: NAME_CHOOSER_W
		do
			chooser := name_chooser (popup_parent)
			chooser.set_open_file
			chooser.set_pattern ("*.ace")
			chooser.set_pattern_name ("System File (*.ace)")
			chooser.call (Current)
		end

feature -- Properties

	is_quick_melt: BOOLEAN
			-- Is this a quick melt?

	is_precompiling: BOOLEAN is
			-- Is this compilation a precompilation?
		do
			-- False for a standard compilation
		end

	symbol: PIXMAP is
			-- Pixmap for the button.
		do
			if is_quick_melt then
				Result := Pixmaps.bm_Quick_update
			else
				Result := Pixmaps.bm_Update
			end
		end

	tool: PROJECT_W
			-- Project tool

	generate_code_only: ANY is
		once
			create Result
		end

feature -- Status Setting

	set_quick_melt is
			-- Set `is_quick_melt' to True
		do
			is_quick_melt := True
		end

	set_run_after_melt (b: BOOLEAN) is
			-- Request for the system to be executed after a
			-- successful melt compilation or not.
			-- Assign `b' to `run_after_melt'.
		do
			run_after_melt2 := b
		end

feature {NONE} -- Implementation

	reset_debugger is
			-- Kill the application, if it is running.
		do
			if Application.is_running then
				Application.kill
			end
		end

	compile (argument: ANY) is
			-- Compile, in the one way or the other.
		local
			rescued: BOOLEAN
			st: STRUCTURED_TEXT
			title: STRING
			mp: MOUSE_PTR
		do
			if not rescued then
				if not Eiffel_project.is_compiling then
					reset_debugger
					error_window.clear_window
					create mp.set_watch_cursor
					tool.update_compile_menu (is_precompiling or Compilation_modes.is_precompiling)
					perform_compilation (argument)

					if Eiffel_project.successful then
							-- If a freezing already occurred (due to a new external
							-- or new derivation of SPECIAL), no need to freeze again.
						title := clone (Interface_names.t_Project)
						title.append (" : ")
						title.append (Project_directory_name)
						tool.set_title (title)
						if Eiffel_project.save_error then
							create st.make
							st.add_string ("Could not write to ")
							st.add_string (Project_directory_name)
							st.add_new_line
							st.add_string ("Please check permissions and disk space")
							st.add_new_line
							st.add_string ("Then press ")
							st.add_string (name)
							st.add_string (" again")
							st.add_new_line
							error_window.process_text (st)
						else
							if not finalization_error then
								launch_c_compilation (argument)
							end
						end
					end

					mp.restore
					error_window.display
					tool_resynchronization (argument)
					Degree_output.finish_degree_output
				end
			else
					-- The project may be corrupted => the project
					-- becomes read-only.
				warner (popup_parent).gotcha_call (Warning_messages.w_Project_may_be_corrupted)

				error_window.display
				tool_resynchronization (argument)
				Degree_output.finish_degree_output
			end

		rescue
			if not fail_on_rescue then
				if original_exception = Io_exception then
						-- We probably don't have the write permissions
						-- on the server files.
					rescued := true
					retry
				end
			end
		end

	tool_resynchronization (argument: ANY) is
			-- Resynchronize class, feature and system tools.
			-- Clear the format_context buffers.
		local
			saved_msg, messages: STRING
			er_w: TEXT_WINDOW
		do
				-- `image' is a once function which will be overwritten
				-- during the resynchronization of the class and feature
				-- tools. We need a copy of it to keep track of various
				-- error messages generated by the compilation.
			er_w ?= error_window
			messages := er_w.text
			create saved_msg.make (messages.count)
			saved_msg.append (messages)
			if Window_manager.has_active_editor_tools then
				Degree_output.put_string (Interface_names.d_Resynchronizing_tools)
				Window_manager.class_win_mgr.synchronize_to_default
				Window_manager.routine_win_mgr.synchronize_to_default
			end
			Project_tool.synchronize_routine_tool_to_default
			if
				is_system_tool_created and then
				system_tool.realized and then
				system_tool.shown
			then
				system_tool.set_default_format
				system_tool.synchronize
			end

			if
				is_dynamic_lib_tool_created and then
				dynamic_lib_tool.realized and then
				dynamic_lib_tool.shown
			then
				dynamic_lib_tool.set_default_format
				dynamic_lib_tool.synchronize
			end

			messages.wipe_out
			messages.append (saved_msg)

				-- Clear the format_context buffers.
			clear_format_tables
		end

	launch_c_compilation (argument: ANY) is
			-- Launch the C compilation.
		local
			window: GRAPHICAL_TEXT_WINDOW
		do
			window ?= Error_window
			if window /= Void then
				window.set_changed (True)
			end

			Error_window.put_string ("System recompiled%N")
	
			if start_c_compilation then
				if Eiffel_project.freezing_occurred then
					error_window.put_string	("System had to be frozen to include new externals.%N%
									%Background C compilation launched.%N")
					Eiffel_project.call_finish_freezing (True)
				end
			end

			if window /= Void then
				window.set_changed (False)
			end
		end

	confirm_and_compile (argument: ANY) is
			-- Ask for a confirmation, and thereafter compile.
		do
			if
				not Application.is_running or else
				(argument /= Void and
				argument = last_confirmer and end_run_confirmed)
			then
				compile (argument)
				if 
					run_after_melt and then
					Eiffel_ace.file_name /= Void and then
					Eiffel_project.successful and 
					not Eiffel_project.freezing_occurred
				then
						-- The system has been successfully melted.
						-- The system can be executed as required.
					tool.debug_run_hole_holder.associated_command.execute (text_window)
				end
			else
				end_run_confirmed := true
				confirmer (popup_parent).call (Current,
						"Recompiling project will end current run.%N%
						%Start compilation anyway?", "Compile")
			end
		end

	perform_compilation (argument: ANY) is
			-- The real compilation. (This is melting.)
		do
			license_display
			if is_quick_melt then
				Eiffel_project.quick_melt
			else
				Eiffel_project.melt
			end
		end

	load_default_ace is
			-- Load the default ace file.
		require
			tool.initialized
		local
			wizard: WIZARD
		do
			create wizard.make (Project_tool, wiz_dlg, ace_b)
			wizard.execute_action
		end

	perform_post_creation is
		local
			file_name: STRING
		do
			create file_name.make (0)
			file_name.append ("Ace.ace")
			Eiffel_ace.set_file_name (file_name)
			wiz_dlg.popdown
			confirm_and_compile (Void)
		end

feature {NONE} -- Attributes

	wiz_dlg: WIZARD_DIALOG is
			-- Dialog used to display the wizard.
		do
			create Result.make (Interface_names.t_Ace_builder, Project_tool)
		end

	not_saved: BOOLEAN is
			-- Has the text of some tool been edited and not saved?
		do
			Result := window_manager.class_win_mgr.changed or else
						(is_system_tool_created and then system_tool.changed)
		end

	finalization_error: BOOLEAN is
			-- Has a validity error been detected during the
			-- finalization? This happens with DLE dealing
			-- with statically bound feature calls
		do
		end

	end_run_confirmed: BOOLEAN
			-- Was the last confirmer popped up to confirm the end of run?

	start_c_compilation: BOOLEAN
			-- Do we have to start the C compilation after C Code generation?

	run_after_melt: BOOLEAN
			-- Should we execute the system after sucessful melt?

	run_after_melt2: BOOLEAN
			-- Should we execute the system after sucessful melt?
			-- This boolean value is only reliable at the beginning
			-- of the execution of this command. After a warning or
			-- confirmation panel has been popped up, this value
			-- can be cleared by the caller. To prevent that, we
			-- keep track of that value in `run_after_melt' at the 
			-- beginning of the execution, so that we can still 
			-- rely on it after a confirmation when we resume 
			-- (i.e. re-execute) the command

	retried: BOOLEAN
			-- Is this already tried?

	c_code_directory: STRING is
			-- Directory where the C code is stored.
		do
			Result := Workbench_generation_path
		end

	name: STRING is
			-- Name of the command.
		do
			if is_quick_melt then
				Result := Interface_names.f_Quick_update
			else
				Result := Interface_names.f_Update
			end
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			if is_quick_melt then
				Result := Interface_names.m_Quick_update
			else
				Result := Interface_names.m_Update
			end
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			if is_quick_melt then
				Result := Interface_names.a_Quick_Update
			else
				Result := Interface_names.a_Update
			end
		end

	ace_b: ACE_BUILDER is
			-- Wizard action to generate ace file (the only one)
			-- At the moment there is only one step
		do
			create Result.make (Current)
		end

feature {NONE} -- Implementation Execution

	work (argument: ANY) is
			-- Recompile the project.
		local
			fn: STRING
			f: PLAIN_TEXT_FILE
			arg: ANY
		do
			if argument = generate_code_only then
				arg := tool
				start_c_compilation := False
				run_after_melt := false
			else
				if argument = tool then
					start_c_compilation := True
						-- Should we execute the system after sucessful melt?
						-- (See header comment of `run_after_melt2'.)
					run_after_melt := run_after_melt2
				end
				arg := argument
			end
			if Eiffel_project.is_read_only then
				warner (popup_parent).gotcha_call (Warning_messages.w_Cannot_compile)
			elseif tool.initialized then
				if not_saved and arg = tool then
					end_run_confirmed := false
					confirmer (popup_parent).call (Current, "Some files have not been saved.%NStart compilation anyway?", "Compile")
				else
					if Eiffel_ace.file_name /= Void then
						confirm_and_compile (arg)
						if Project_resources.raise_on_error.actual_value then
							tool.raise
						end
					elseif arg = Void then
						choose_template
					elseif arg = last_warner then
						warner_ok (arg)
					elseif arg = last_name_chooser then
						fn := clone (last_name_chooser.selected_file)
						if not fn.is_empty then
							create f.make (fn)
							if
								f.exists and then 
								f.is_readable and then 
								f.is_plain
							then
								Eiffel_ace.set_file_name (fn)
								work (Current)
							elseif f.exists and then not f.is_plain then
								warner (popup_parent).custom_call (Current,
								Warning_messages.w_Not_a_file_retry (fn), Interface_names.b_Ok, Void, Interface_names.b_Cancel)
							else
								warner (popup_parent).custom_call
									(Current, Warning_messages.w_Cannot_read_file_retry (fn),
									Interface_names.b_Ok, Void, Interface_names.b_Cancel)
							end
						else
							warner (popup_parent).custom_call (Current,
								Warning_messages.w_Not_a_file_retry (fn), Interface_names.b_Ok, Void, Interface_names.b_Cancel)
						end
					else
						warner (popup_parent).custom_call (Current,
							Warning_messages.w_specify_ace, Interface_names.b_Browse, Interface_names.b_Build, Interface_names.b_Cancel)
					end
				end
			end
		end

	license_display is
			-- Display the license reminder.
		do
			if license.demo_mode then
				number_of_compilations := number_of_compilations + 1
				if number_of_compilations \\ license_frequency = 0 then
					license.get_license
				end
			end
		end

feature {NONE} -- Implementation

	license_frequency: INTEGER is
			-- Frequency of license appearance in demo mode.
		once
			Result := 5
		end

	number_of_compilations: INTEGER;
			-- Number of compilations done in a certain mode so far.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class UPDATE_PORJECT
