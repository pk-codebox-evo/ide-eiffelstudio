
-- Command to update the Eiffel

class UPDATE_PROJECT

inherit

	SHARED_WORKBENCH;
	PROJECT_CONTEXT;
	ICONED_COMMAND
		redefine
			text_window
		end;
	SHARED_DEBUG;
	SHARED_RESCUE_STATUS;
	SHARED_FORMAT_TABLES;
	SHARED_RESOURCES;
	SHARED_MELT_ONLY;
	OBJECT_ADDR

creation

	make

feature

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window);
			set_action ("!c<Btn1Down>", Current, generate_code_only)
			!!request;
			request.pass_address
		end;

	text_window: PROJECT_TEXT;

feature {NONE}

	reset_debugger is
		do
			if Run_info.is_running then
				quit_cmd.exit_now;
				debug_window.clear_window;
				debug_window.put_string ("System terminated%N");
				debug_window.display;
				run_info.set_is_running (false);
				quit_cmd.recv_dead
			end;
			debug_info.wipe_out;
				-- Get rid of adopted objects.
			addr_table.clear_all;
			window_manager.object_win_mgr.reset
		end;

	not_saved: BOOLEAN is
			-- Has the text of some tool been edited and not saved?
		do
			Result := window_manager.class_win_mgr.changed or
				system_tool.text_window.changed
		end;

	compile (argument: ANY) is
		local
			rescued: BOOLEAN;
			temp: STRING;
			title: STRING
		do
			if not rescued then
				reset_debugger;
				error_window.clear_window;
				set_global_cursor (watch_cursor);
				project_tool.set_changed (true);
				Workbench.recompile;
				if Workbench.successfull then
						-- If a freezing already occured (due to a new external
						-- or new derivation of SPECIAL), no need to freeze again.
					if not System.freezing_occurred then
						freezing_actions;
					end
					project_tool.set_changed (false);
					project_tool.set_icon_name (System.system_name);
					title := clone (l_Project);
					title.append (": ");
					title.append (Project_directory.name);
					project_tool.set_title (title);
					system.server_controler.wipe_out; -- ???
					save_failed := False;
					save_workbench_file;
					if save_failed then
						!! temp.make (0);
						temp.append ("Could not write to ");
						temp.append (Project_file_name);
						temp.append ("%NPlease check permissions and disk space%
									%%NThen press ");
						temp.append (command_name);
						temp.append (" again%N");
						error_window.put_string (temp);
					else
						if System.is_dynamic then
							dle_link_system
						end;
						finalization_actions (argument);
						if not finalization_error then
							launch_c_compilation (argument)
						end
					end;
				end;
				tool_resynchronization (argument)
			else
					-- The project may be corrupted => the project
					-- becomes read-only.
				warner (text_window).gotcha_call (w_Project_may_be_corrupted);
				Project_read_only.set_item (true)
			end;
			error_window.display;
			restore_cursors
		rescue
			if not Rescue_status.fail_on_rescue then
				if original_exception = Io_exception then
						-- We probably don't have the write permissions
						-- on the server files.
					rescued := true;
					retry
				end
			end
		end;

	tool_resynchronization (argument: ANY) is
			-- Resynchronize class, feature and system tools.
			-- Clear the format_context buffers.
		local
			saved_msg, messages: STRING;
		do
				-- `image' is a once function which will be overewritten
				-- during the resynchronization of the class and feature
				-- tools. We need a copy of it to keep track of various
				-- error messages generated by the compilation.
			messages := error_window.image;
			!! saved_msg.make (messages.count);
			saved_msg.append (messages);
			Window_manager.class_win_mgr.synchronize;
			Window_manager.routine_win_mgr.synchronize;
			if system_tool.realized and then system_tool.shown then
				system_tool.set_default_format;
				system_tool.synchronize
			end;
			messages.wipe_out;
			messages.append (saved_msg);

				-- Clear the format_context buffers.
			clear_format_tables
		end;

	launch_c_compilation (argument: ANY) is
		do
			error_window.put_string ("System recompiled%N");
			if start_c_compilation then
				if System.freezing_occurred then
					error_window.put_string
						("System had to be frozen to include new externals.%N%
							%Background C compilation launched.%N");
					finish_freezing
				else
					link_driver
				end;
			end;
		end;

	freezing_actions is
		do
		end;

	finalization_actions (argument: ANY) is
		do
		end;

	finalization_error: BOOLEAN is
			-- Has a validity error been detected during the
			-- finalization? This happens with DLE dealing
			-- with statically bound feature calls
		do
		end;

	confirm_and_compile (argument: ANY) is
		do
			if
				not Run_info.is_running or else
				(argument /= Void and
				argument = last_confirmer and end_run_confirmed)
			then
				compile (argument);
				if 
					run_after_melt and then
					Lace.file_name /= Void and then
					Workbench.successfull and 
					not System.freezing_occurred
				then
						-- The system has been successfully melted.
						-- The system can be executed as required.
					text_window.tool.debug_run_command.execute (text_window)
				end
			else
				end_run_confirmed := true;
				confirmer (text_window).call (Current,
						"Recompiling project will end current run.%N%
						%Start compilation anyway?", "Compile")
			end
		end;

	end_run_confirmed: BOOLEAN;
			-- Was the last confirmer popped up to confirm the end of run?

	start_c_compilation: BOOLEAN;
			-- Do we have to start the C compilation after C Code generation?

	run_after_melt: BOOLEAN;
			-- Should we execute the system after sucessful melt?

	run_after_melt2: BOOLEAN;
			-- Should we execute the system after sucessful melt?
			-- This boolean value is only reliable at the beginning
			-- of the execution of this command. After a warning or
			-- confirmation panel has been popped up, this value
			-- can be cleared by the caller. To prevent that, we
			-- keep track of that value in `run_after_melt' at the 
			-- beginning of the execution, so that we can still 
			-- rely on it after a confirmation when we resume 
			-- (i.e. re-execute) the command

feature

	set_run_after_melt (b: BOOLEAN) is
			-- Request for the system to be executed after a
			-- successful melt compilation or not.
			-- Assign `b' to `run_after_melt'.
		do
			run_after_melt2 := b
		end;

feature {NONE}

	work (argument: ANY) is
			-- Recompile the project.
		local
			fn: STRING;
			f: PLAIN_TEXT_FILE;
			temp: STRING
			arg: ANY
		do
			if argument = generate_code_only then
				arg := text_window
				start_c_compilation := False;
				run_after_melt := false
			else
				if argument = text_window then
					start_c_compilation := True;
						-- Should we execute the system after sucessful melt?
						-- (See header comment of `run_after_melt2'.)
					run_after_melt := run_after_melt2
				end;
				arg := argument
			end
			if Project_read_only.item then
				warner (text_window).gotcha_call (w_Cannot_compile)
			elseif project_tool.initialized then
				if not_saved and arg = text_window then
					end_run_confirmed := false;
					confirmer (text_window).call (Current,
						"Some files have not been saved.%N%
						%Start compilation anyway?", "Compile")
				elseif compilation_allowed then
					if Lace.file_name /= Void then
						confirm_and_compile (arg);
						if resources.get_boolean (r_Raise_on_error, true) then
							project_tool.raise
						end
					elseif arg = Void then
						system_tool.display;
						load_default_ace;
					elseif arg = last_warner then
						name_chooser.set_window (text_window);
						name_chooser.call (Current)
					elseif arg = name_chooser then
						fn := clone (name_chooser.selected_file);
						if not fn.empty then
							!! f.make (fn);
							if
								f.exists and then 
								f.is_readable and then 
								f.is_plain
							then
								Lace.set_file_name (fn);
								work (Current)
							elseif f.exists and then not f.is_plain then
								warner (text_window).custom_call (Current,
								w_Not_a_file_retry (fn), " OK ", Void, "Cancel")
							else
								warner (text_window).custom_call
									(Current, w_Cannot_read_file_retry (fn),
									" OK ", Void, "Cancel");
							end
						else
							warner (text_window).custom_call (Current,
								w_Not_a_file_retry (fn), " OK ", Void, "Cancel")
						end
					else
						warner (text_window).custom_call (Current,
							l_Specify_ace, "Choose", "Template", "Cancel");
					end;
				else
					warner (text_window).custom_call (Void,
						w_Melt_only, " OK ", Void, Void);
				end
			end;
		end;

	link_driver is
		local
			cmd_string: STRING;
			uf: RAW_FILE;
			file_name: FILE_NAME;
			app_name: STRING;
		do
			if
				not melt_only and then
				System.uses_precompiled and then
				not System.is_dynamic
			then
					-- Target
				!!file_name.make_from_string (Workbench_generation_path);
				app_name := clone (System.system_name);
				app_name.append (Executable_suffix);
				file_name.set_file_name (app_name);

				!!uf.make (file_name);
				if not uf.exists then
					eif_gr_link_driver (request, Workbench_generation_path.to_c, System.system_name.to_c,
						Prelink_command_name.to_c, Precompilation_driver.to_c);
				end;
			end;
		end;

	retried: BOOLEAN;
	save_failed: BOOLEAN;

	save_workbench_file is
			-- Save the `.workbench' file.
		local
			file: RAW_FILE
		do
			if not retried then
				System.server_controler.wipe_out;
				!!file.make (Project_file_name);
				file.open_write;
				workbench.basic_store (file);
				file.close;
			else
				retried := False
				if not file.is_closed then
					file.close
				end;
				save_failed := True;
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				retried := True;
				retry
			end
		end;

feature {NONE}

	compilation_allowed: BOOLEAN is
		do
			Result := True
		end

	request: ASYNC_SHELL;

	load_default_ace is
		require
			project_tool.initialized
		local
			file_name: STRING;
		do
			!!file_name.make (50);
			file_name.append (Default_ace_name);
			system_tool.text_window.show_file_content (file_name);
			system_tool.text_window.set_changed (True)
		end;

	c_code_directory: STRING is
		do
			Result := Workbench_generation_path
		end;

feature

	finish_freezing is
		do
			eif_gr_call_finish_freezing (request, c_code_directory.to_c, freeze_command_name.to_c);
		end;

	symbol: PIXMAP is
		once
			Result := bm_Update
		end;

feature {NONE} -- Externals

	eif_gr_call_finish_freezing(rqst: ANY; c_code_dir, freeze_cmd: ANY) is
		external
			"C"
		end

	eif_gr_link_driver (rqst: ANY; c_code_dir, syst_name, prelink_cmd, driver_name: ANY) is
		external
			"C"
		end

feature {NONE}

	command_name: STRING is do Result := l_Update end;

feature -- DLE

	dle_link_system is
			-- Link executable and melted.eif files from the static system.
		require
			dynamic_system: System.is_dynamic
		local
			uf: RAW_FILE;
			file_name: FILE_NAME;
			app_name: STRING
		do
			!!file_name.make_from_string (Workbench_generation_path);
			app_name := clone (System.system_name);
			app_name.append (Executable_suffix);
			file_name.set_file_name (app_name);
			!!uf.make (file_name);
			if not uf.exists then
				!! file_name.make_from_string (Extendible_W_code);
				app_name := clone (System.dle_system_name);
				app_name.append (Executable_suffix);
				file_name.set_file_name (app_name);
				eif_gr_link_driver (request,
					Workbench_generation_path.to_c,
					System.system_name.to_c,
					Prelink_command_name.to_c,
					file_name.to_c);
				!! file_name.make_from_string (Extendible_W_code);
				file_name.set_file_name (Updt);
				eif_gr_link_driver (request,
					Workbench_generation_path.to_c,
					Updt.to_c,
					Prelink_command_name.to_c,
					file_name.to_c);
			end
		end;

end
