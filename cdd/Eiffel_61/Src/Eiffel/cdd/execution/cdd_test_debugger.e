indexing
	description: "Objects that execute test routines in some debugger"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_DEBUGGER

inherit

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

	CONF_ACCESS

create
	make

feature {NONE} -- Initialization

	make (a_cdd_manager: like cdd_manager) is
			-- Initialize `Current' with `a_cdd_manager'.
		require
			a_cdd_manager_not_void: a_cdd_manager /= Void
		do
			cdd_manager := a_cdd_manager
			create root_class_printer
			internal_reset_agent := agent reset_system (Void)
		ensure
			cdd_manager_set: cdd_manager = a_cdd_manager
		end

feature -- Access

	cdd_manager: CDD_MANAGER
			-- CDD manager

	log: CDD_LOGGER is
			-- Logger for CDD activities
		do
			Result := cdd_manager.log
		end

	debugger_manager: DEBUGGER_MANAGER is
			-- Debugger manager for executing test case
		do
			Result := run_project_cmd.eb_debugger_manager
		ensure
			not_void: Result /= Void
		end

	application_running: BOOLEAN is
			-- Is `debugger_manager' currently executing an application?
		do
			Result := debugger_manager.application_initialized and then
				debugger_manager.application.is_running
		ensure
			definition: Result = (debugger_manager.application_initialized and then
				debugger_manager.application.is_running)
		end

	can_start: BOOLEAN is
			-- Can we start debugging something?
		do
			Result := not (cdd_manager.project.is_read_only or
				cdd_manager.project.is_compiling or application_running)
		ensure
			definition: Result = not (cdd_manager.project.is_read_only or
				cdd_manager.project.is_compiling or application_running)
		end

	current_test_routine: CDD_TEST_ROUTINE
			-- Test routine currently beeing debugged

	is_running: BOOLEAN
			-- Are we currently debugging a test routine?

	is_valid_test_routine (a_test_routine: CDD_TEST_ROUTINE): BOOLEAN is
			-- Is `a_test_routine' a valid test routine?
			-- NOTE: this also checks whether the test suite
			-- actually points to `a_test_routine'.
		require
			a_test_routine_not_void: a_test_routine /= Void
		do
			Result := cdd_manager.test_suite.test_classes.has (a_test_routine.test_class) and then
				a_test_routine.test_class.test_routines.has (a_test_routine)
		end

feature -- Basic functionality

	start (a_test_routine: like current_test_routine) is
			-- Start running `a_test_routine' in debugger.
		require
			can_start: can_start
			a_test_routine_not_void: a_test_routine /= Void
			a_test_routine_valid: is_valid_test_routine (a_test_routine)
		local
			l_root: CONF_ROOT
			l_dbg_data: DEBUGGER_DATA
		do
			current_test_routine := a_test_routine
			root_class_printer.print_root_class (cdd_manager.file_manager.testing_directory, a_test_routine)
			if root_class_printer.last_print_succeeded then
				log.report_test_case_foreground_execution_start (a_test_routine)
				l_root := conf_factory.new_root (Void, "CDD_ROOT_CLASS", "make", False)
				is_running := True
				set_root_class (l_root)
				cdd_manager.status_update_actions.call ([update_step])
				melt_project_cmd.execute_and_wait

					-- Check if compilation was successful and if
					-- `a_test_routine' is still part of the system
				if cdd_manager.project.successful and is_running and is_valid_test_routine (a_test_routine) then
					debugger_manager.application_quit_actions.extend (internal_reset_agent)

					set_breakpoint_feature (a_test_routine)
					l_dbg_data := debugger_manager.debugger_data
					if l_dbg_data.is_breakpoint_set (breakpoint_feature, 1) then
						old_breakpoint_set := True
						if l_dbg_data.is_breakpoint_enabled (breakpoint_feature, 1) then
							old_breakpoint_enabled := True
						else
							old_breakpoint_enabled := False
							l_dbg_data.enable_breakpoint (breakpoint_feature, 1)
						end
					else
						l_dbg_data.enable_breakpoint (breakpoint_feature, 1)
						old_breakpoint_set := False
						old_breakpoint_enabled := False
					end

					run_project_cmd.execute
				else
					cancel
				end
			else
				cdd_manager.status_update_actions.call ([update_step])
			end
		end

	cancel is
			-- Kill application and reset root class
		require
			debugging: is_running
		do
			if cdd_manager.project.is_compiling then
				project_cancel_cmd.execute
			elseif application_running then
				debugger_manager.application.kill
			end
			reset_system (Void)
		ensure
			not_debugging: not is_running
		end

feature {NONE} -- Implementation

	reset_system (a_dbg_manager: DEBUGGER_MANAGER) is
			-- Reset all changes made to debug and initiate compilation
		require else
			debugging: is_running
			old_root_not_void: old_root /= Void
		do
			if not old_breakpoint_set then
				debugger_manager.debugger_data.remove_breakpoint (breakpoint_feature, 1)
			else
				if not old_breakpoint_enabled then
					debugger_manager.debugger_data.disable_breakpoint (breakpoint_feature, 1)
				end
			end
			breakpoint_feature := Void

			if debugger_manager.application_quit_actions.has (internal_reset_agent) then
				debugger_manager.application_quit_actions.prune (internal_reset_agent)
			end
			set_root_class (old_root)
			current_test_routine := Void
			melt_project_cmd.execute
			is_running := False
			cdd_manager.status_update_actions.call ([update_step])
			log.report_test_case_foreground_execution_end
		end

	set_root_class (a_root: like old_root) is
			-- Set `new_root' as new root class and store configuration.
		require
			debugging: is_running
			a_root_not_void: a_root /= Void
		local
			l_target: CONF_TARGET
		do
			l_target := cdd_manager.project.system.universe.target
			old_root := l_target.root
			l_target.set_root (a_root)
			l_target.system.store
		ensure
			old_root_set: old_root = old cdd_manager.project.system.universe.target.root
		end

	set_breakpoint_feature (a_test_routine: CDD_TEST_ROUTINE) is
			-- Set breakpoint for `a_test_routine'.
			-- NOTE: if `a_test_routine' is an extracted test
			-- then try to set breakpoint in the features
			-- described by the "covers." tag of `a_test_routine'.
		local
			l_universe: UNIVERSE_I
			l_tags: DS_LINEAR_CURSOR [STRING]
			l_class_list: LIST [CLASS_I]
			l_class: CLASS_C
			l_feature: like breakpoint_feature
			l_regex: RX_PCRE_REGULAR_EXPRESSION
		do
			breakpoint_feature := Void
			if a_test_routine.has_matching_tag ("type.extracted") then
				l_tags := a_test_routine.tags.new_cursor
				create l_regex.make
				l_regex.compile ("^covers\.([A-Za-z0-9_]+)\.([A-Za-z0-9_]+)$")
				l_universe := cdd_manager.project.universe
				from
					l_tags.start
				until
					l_tags.after
				loop
					l_regex.match (l_tags.item)
					l_tags.forth
					if l_regex.has_matched then
						l_class_list := l_universe.classes_with_name (l_regex.captured_substring (1))
						if not l_class_list.is_empty then
							l_class := l_class_list.first.compiled_class
							if l_class /= Void then
								l_feature := l_class.feature_with_name (l_regex.captured_substring (2))
								if l_feature /= Void then
									breakpoint_feature := l_feature
									l_tags.go_after
								end
							end
						end
					end
				end
			end
			if breakpoint_feature = Void then
				l_class := a_test_routine.test_class.compiled_class
				check
						-- Should not be void since we have just recompiled the system
					class_not_void: l_class /= Void
				end
				breakpoint_feature := l_class.feature_with_name (a_test_routine.name)
				check
						-- This should not be void since we have
						-- just compiled and made sure that
						-- a_test_routine is still part of the system
					breakpoint_feature_not_void: breakpoint_feature /= Void
				end
			end
		ensure
			breakpoint_feature_not_void: breakpoint_feature /= Void
		end

	internal_reset_agent: PROCEDURE [like Current, TUPLE]
			-- Agent called when application has terminated

	old_root: CONF_ROOT
			-- Old root class

	old_breakpoint_set: BOOLEAN
			-- Was there already a breakpoint when `Current' tried to add one?

	old_breakpoint_enabled: BOOLEAN
			-- Was an already existing breakpoint enabled when `Current' tried to add one?

	breakpoint_feature: E_FEATURE
			-- Feature for which a breakpoint has been set

	root_class_printer: CDD_ROOT_CLASS_PRINTER
			-- Printer for creating root class

	conf_factory: CONF_FACTORY is
			-- Factory for creating new roots
		once
			create Result
		end

	update_step: CDD_STATUS_UPDATE is
			-- Update used after each step of `Current'
		once
			create Result.make_with_code ({CDD_STATUS_UPDATE}.debugger_step_code)
		ensure
			not_void: Result /= Void
		end

invariant

	cdd_manager_not_void: cdd_manager /= Void
	root_class_printer_not_void: root_class_printer /= Void
	debugging_equals_current_test_routine_not_void: is_running = (current_test_routine /= Void)
	internal_reset_agent_not_void: internal_reset_agent /= Void
	valid_breakpoint_feature: (breakpoint_feature /= Void) implies not (
		breakpoint_feature.is_attribute or breakpoint_feature.is_constant or
		breakpoint_feature.is_unique or breakpoint_feature.is_deferred)

end
