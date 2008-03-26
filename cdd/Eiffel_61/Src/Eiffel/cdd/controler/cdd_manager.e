indexing
	description: "Central object for managing all CDD activities"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_MANAGER

inherit

	CDD_ROUTINES
		export
			{NONE} all
		end

	DEBUGGER_OBSERVER
		redefine
			on_application_stopped,
			on_application_launched
		end

	EB_CLUSTER_MANAGER_OBSERVER
		rename
			manager as eb_cluster_manager,
			refresh as eb_cluster_refresh,
			on_class_removed as remove_test_case_for_class
		export
			{NONE} all
			{ANY} eb_cluster_manager
		redefine
			remove_test_case_for_class
		end

	CONF_ACCESS
		export
			{NONE} all
		end

	KL_SHARED_STREAMS
		export
			{NONE} all
		end

	SHARED_FLAGS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (dbg_mng: DEBUGGER_MANAGER; a_project: like project) is
			-- Add `Current' to cluster observer list.
		require
			a_project_not_void: a_project /= Void
		local
			l_prj_manager: EB_PROJECT_MANAGER
		do
			debugger_manager := dbg_mng
			create status_update_actions
			create output_actions
			create test_suite.make (Current)
			create background_executor.make (Current)
			create debug_executor.make (Current)
			create capturer.make (Current)
			create routine_invocation_cache.make
			capturer.set_cache (routine_invocation_cache)
			create file_manager.make (Current)
			create test_class_printer.make

			status_update_actions.extend (agent process_update)

			project := a_project
			l_prj_manager := project.manager
			l_prj_manager.load_agents.extend (agent refresh_status)
			l_prj_manager.compile_stop_agents.extend (agent refresh_status)
			eb_cluster_manager.add_observer (Current)
			create cdd_breakpoints.make (debugger_manager, 30)
			debugger_manager.application_prelaunching_actions.extend (agent prepare_debugging)
			debugger_manager.application_quit_actions.extend (agent clean_up_after_debugging)

			l_prj_manager.compile_start_agents.extend (agent log_sut_compile_start)
			l_prj_manager.compile_stop_agents.extend (agent log_sut_compile_stop)
			l_prj_manager.close_agents.extend (agent log_project_closed)
		ensure
			project_set: project = a_project
		end

feature -- Access (General)

	project: E_PROJECT
			-- Project for which we manager tests

	target: CONF_TARGET is
			-- Currently opened target of `project'
		require
			project_initialized: is_project_initialized
		do
			Result := project.system.universe.target
		end

	status_update_actions: ACTION_SEQUENCE [TUPLE [CDD_STATUS_UPDATE]]
			-- Actions performed whenever `Current' or any cdd controller changes its state

	output_actions: ACTION_SEQUENCE [TUPLE [STRING]]
			-- Actions performed whenever there is some kind of textual output available

	file_manager: CDD_TESTING_FILES_MANAGER
			-- Manager handling automatically generated files

feature -- Status report (General)

	is_project_initialized: BOOLEAN is
			-- Has `project' been initialized?
			-- Note that CDD is not active without an initialized project.
		do
			Result := project.initialized and project.system_defined and then target /= Void
		end

	is_extracting_enabled: BOOLEAN is
			-- Is test case extracting enabled?
		require
			is_project_initialized: is_project_initialized
		do
			Result := configuration.is_extracting_enabled
		ensure
			definition: Result = configuration.is_extracting_enabled
		end

	is_executing_enabled: BOOLEAN is
			-- Is background test case execution enabled?
		require
			is_project_initialized: is_project_initialized
		do
			Result := configuration.is_executing_enabled
		ensure
			definition: Result = configuration.is_executing_enabled
		end

feature -- Status setting (General)

	enable_extracting is
			-- Make cdd create new test cases automatically.
			-- Enable extracting mode in system configuration and store it.
		require
			project_initialized: is_project_initialized
			extraction_disabled: not is_extracting_enabled
			not_cdd_target: not target.is_cdd_target
		do
			configuration.enable_extracting
			target.system.store
			emit_manager_status_update
			log.report_system_status (project.system.name, target.name, is_extracting_enabled, is_executing_enabled, "Enable extraction")
		ensure
			extracting_enabled: is_extracting_enabled
		end

	disable_extracting is
			-- Stop cdd creating test cases automatically.
			-- Disable capturing mode in system configuration and store it.
		require
			project_initialized: is_project_initialized
			extracting_enabled: is_extracting_enabled
		do
			configuration.disable_extracting
			target.system.store
			emit_manager_status_update
			log.report_system_status (project.system.name, target.name, is_extracting_enabled, is_executing_enabled, "Disable extraction")
		ensure
			extracting_disabled: not is_extracting_enabled
		end

	enable_executing is
			-- Enable automated background execution of test cases.
		require
			project_initialized: is_project_initialized
			executing_disabled: not is_executing_enabled
			not_cdd_target: not target.is_cdd_target
		do
			configuration.enable_executing
			target.system.store
			emit_manager_status_update
			schedule_testing_restart
			log.report_system_status (project.system.name, target.name, is_extracting_enabled, is_executing_enabled, "Enable execution")
		ensure
			executing_enabled: is_executing_enabled
		end

	disable_executing is
			-- Stop cdd creating test cases automatically.
			-- Disable capturing mode in system configuration and store it.
		require
			project_initialized: is_project_initialized
			executing_enabled: is_executing_enabled
			not_cdd_target: not target.is_cdd_target
		do
			configuration.disable_executing
			target.system.store
			emit_manager_status_update
			log.report_system_status (project.system.name, target.name, is_extracting_enabled, is_executing_enabled, "Disable execution")
		ensure
			executing_disabled: not is_executing_enabled
		end

feature -- Basic Operations (General)

	emit_manager_status_update is
			-- Emit a notification to all subscribes of `status_update_actions' that the
			-- state of the manager has changed.
		do
			status_update_actions.call ([status_udpate])
		end


	refresh_status is
			-- Check configuration if cdd status has changed and update if so and
			-- reiinitate background testing.
			-- Note: This is usually called when project is opened or compiled.
		do
			if is_project_initialized and then not target.is_cdd_target then
				if degree_5_observer = Void then
					degree_5_observer := agent add_updated_class
					project.system.system.degree_5.process_actions.extend (degree_5_observer)
					status_update_actions.call ([status_udpate])
							-- NOTE: Under the assumption that this happens only once per "developping session"
							-- a project opened message is emmited here (needs investigation...)
					log.report_system_status (project.system.name, target.name, is_extracting_enabled, is_executing_enabled, "Initialized")
				end
				test_suite.refresh
					-- On recompiles the ecf file is loaded a new. It might have changed.
					-- In order to update we emit a notifcation here.
				emit_manager_status_update
				if project.successful and not debug_executor.is_running then
					schedule_testing_restart
				end
			end
		end

feature -- Access (Debugging/Capturing)

	last_replaced_class: CLASS_I
			-- Last test class that was replaced by a newly extracted test class

	last_replaced_class_name: STRING_8
			-- Name of `last_replaced_test_class'

	capturer: CDD_CAPTURER
			-- Capturer for extracting new test cases

	routine_invocation_cache: CDD_ROUTINE_INVOCATION_CACHE
			-- Cache for routine invocations

	test_class_printer: CDD_TEST_CLASS_PRINTER
			-- Printer for creation of new extracted test classes

	debugger_manager: DEBUGGER_MANAGER
			-- Debugger manager

	cdd_breakpoints: CDD_BREAKPOINTS_LIST
			-- CDD breakpoints.

	test_routines_for_reextraction: DS_LIST [CDD_TEST_ROUTINE]
			-- List of all test routines which are candidate for reextraction
			-- NOTE: up-to-date only during debugging session.



feature {DEBUGGER_MANAGER, STOPPED_HDLR} -- Basic Operations (Debugging/Capturing)

	prepare_debugging is
			-- Initialize and update all data structures needed during one debugging session.
			-- TODO: Also add CDD breakpoints for features marked for extraction of passing routine invocations.
		require
			routine_invocation_cache_empty: routine_invocation_cache.is_empty
			cdd_breakpoint_list_empty: cdd_breakpoints.count = 0
		local
			l_test_class: CDD_TEST_CLASS
			l_test_routine: CDD_TEST_ROUTINE
		do
				-- Do nothing is extraction is disabled or a test case is beeing debugged (in foreground).
			if is_extracting_enabled and not debug_executor.is_running then

					-- Generate list of test routines for reextraction and insert CDD breakpoints.
				create {DS_ARRAYED_LIST [CDD_TEST_ROUTINE]} test_routines_for_reextraction.make (10)
				from
					test_suite.test_classes.start
				until
					test_suite.test_classes.after
				loop
					l_test_class := test_suite.test_classes.item_for_iteration

					from
						l_test_class.test_routines.start
					until
						l_test_class.test_routines.after
					loop
						l_test_routine := l_test_class.test_routines.item_for_iteration
						if l_test_routine.has_original_outcome then
							l_test_routine.update_original_outcome
							if l_test_routine.is_automatic_reextraction_required then
								test_routines_for_reextraction.force_last (l_test_routine)
								if not cdd_breakpoints.has_cdd_breakpoint (l_test_routine.original_outcome.covered_feature) then
									cdd_breakpoints.add_cdd_breakpoints (l_test_routine.original_outcome.covered_feature)
								end
							end
						end
						l_test_class.test_routines.forth
					end

					test_suite.test_classes.forth
				end
			end
		end

	on_routine_entry (a_status: APPLICATION_STATUS) is
			-- Handle entry of top feature of call stack of `a_status'.
		require
			a_feature_not_void: a_status /= Void
			valid_state_for_extraction: is_extracting_enabled and not debug_executor.is_running
		do
			log.report_extraction_start
			capturer.set_use_cache (False)
			capturer.extract_active_routine (a_status)
			log.report_extraction_end
				-- NOTE: extraction of active routine is not guaranteed to succeed
			if capturer.is_last_extraction_successful then
				routine_invocation_cache.cache_routine_invocation (capturer.last_extracted_routine_invocations.first)
			end
			-- It's called printf debugging: io.put_string ("WOOHOOO cdd breakpoint found for ENTRY feature " + a_status.e_feature.name + "%N")
		end

	on_routine_exit (a_status: APPLICATION_STATUS) is
			-- Handle exit of top feature of call stack of `a_status'.
		require
			a_feature_not_void: a_status /= Void
			valid_state_for_extraction: is_extracting_enabled and not debug_executor.is_running
		local
			a_cse: EIFFEL_CALL_STACK_ELEMENT
		do
			a_cse ?= a_status.current_call_stack_element
			if a_cse /= Void and then routine_invocation_cache.has_cached_routine_invocation (a_cse.routine) then
				routine_invocation_cache.pop_cached_routine_invocation (a_cse.routine)
			end
			-- It's called printf debugging: io.put_string ("WOOHOOO cdd breakpoint found for EXIT feature " + a_status.e_feature.name + "%N")
		end

	on_application_stopped (a_dbg_manager: DEBUGGER_MANAGER) is
			-- Check whether we want to create a new test case from the current
			-- application status `an_application_status'.
		require else
			a_dbg_manager_not_void: a_dbg_manager /= Void
			valid_app_status: a_dbg_manager.application_is_executing and
				a_dbg_manager.application_is_stopped
		local
			l_status: APPLICATION_STATUS
			l_list: DS_LIST [CDD_ROUTINE_INVOCATION]
			l_test_routines_to_replace: DS_LIST [CDD_TEST_ROUTINE]
--			l_update_list: DS_ARRAYED_LIST [CDD_TEST_ROUTINE_UPDATE]
			l_class_to_delete_list: LIST [CLASS_I]

			l_routine_count: INTEGER_32

			l_original_outcome: CDD_ORIGINAL_OUTCOME
			l_file: KL_TEXT_OUTPUT_FILE
			l_print_start_time: DATE_TIME
		do
				-- Before we extract any thing, make sure
				--		* extraction is actually enabled
				--		* the debugger is not debugging a
				--		  test routine right now
				--		* an exception has occured which
				--		  is not a developer exception
				--
				-- logging takes place for all exceptions.
			if a_dbg_manager.application_status.exception_occurred then
				l_status := a_dbg_manager.application_status
				create l_original_outcome.make_failing (l_status.e_feature, l_status)
				log.report_exception (l_original_outcome)
				if is_extracting_enabled and
					not debug_executor.is_running and
					a_dbg_manager.application_status.exception_code /= {EXCEP_CONST}.developer_exception
				then
					log.report_extraction_start
					capturer.set_use_cache (True)
					capturer.extract_routine_invocations_for_failure (l_status)
					log.report_extraction_end
					l_list := capturer.last_extracted_routine_invocations

						-- Write the extracted routine invocations to disk
					log.report_printing_start
					from
						l_routine_count := 0
						l_list.start
					until
						l_list.after
					loop
						create l_print_start_time.make_now
						create l_original_outcome.make_failing (l_list.item_for_iteration.represented_feature, l_status)

							-- Look for non-reproducing test routines with a matching original outcome
							-- If such a test routine exists, the corresponding test class will get replaced
							-- NOTE: it is possible that more than one matching test routine is found, currently only first one is considered.
						from
							create {DS_ARRAYED_LIST [CDD_TEST_ROUTINE]} l_test_routines_to_replace.make (10)
							test_routines_for_reextraction.start
						until
							test_routines_for_reextraction.after
						loop
							if
								test_routines_for_reextraction.item_for_iteration.original_outcome.is_same (l_original_outcome)
							then
								l_test_routines_to_replace.force_last (test_routines_for_reextraction.item_for_iteration)
							end

							test_routines_for_reextraction.forth
						end

						if not l_test_routines_to_replace.is_empty then
								-- Rewrite test class file of first test routine found
								-- NOTE/TODO delete test classes associated with other found test routines?

								-- Remove corresponding test class from test suite.
							test_suite.remove_test_class (l_test_routines_to_replace.first.test_class.test_class_name)
							create l_file.make (l_test_routines_to_replace.first.class_file_name)
							l_file.open_write
							if l_file.is_open_write then
								test_class_printer.reset
								test_class_printer.set_output_stream (l_file)
								test_class_printer.print_routine_invocation (file_manager.class_name_from_file_path (l_test_routines_to_replace.first.class_file_name), l_list.item_for_iteration)
								if not test_class_printer.has_last_print_failed then
										-- An existing test class has been replaced. Delete the outcomes of the corresponding
										-- test routine in order to reset it to the "waiting for initial execution" status
									l_file.close
									if l_test_routines_to_replace.first.test_class.compiled_class /= Void then
										last_replaced_class := l_test_routines_to_replace.first.test_class.compiled_class.original_class
										last_replaced_class_name := Void
									else
										last_replaced_class := Void
										last_replaced_class_name := l_test_routines_to_replace.first.test_class.test_class_name
									end
									l_test_routines_to_replace.first.outcomes.wipe_out
									l_test_routines_to_replace.first.set_original_outcome (l_original_outcome)
								else
									-- TODO Error handling
								end
							else
								-- TODO Error handling
							end

								-- Update and re-add class to test suite, IF no duplicate
								-- NOTE: A complete update would be based on obsolete information, since associated parsed/compiled class do not yet
								-- correspond to the new file content. But information which is gathered directly from the file will be correct,
								-- especially the check sum used for duplicate detection (relies directly on the file, plus on the covered class/feature,
								-- which are impossible to have changed due to semantics of second chance reextraction)
								-- TODO: Remove class completely from system, and parse anew before re-adding to test suite.
							l_test_routines_to_replace.first.test_class.update_check_sum
							if
								l_test_routines_to_replace.first.test_class.check_sum /= Void and then
								not test_suite.has_extracted_test_case_with_check_sum (l_test_routines_to_replace.first.test_class.check_sum)
							then
								test_suite.add_test_class (l_test_routines_to_replace.first.test_class)
								status_update_actions.call ([create {CDD_STATUS_UPDATE}.make_with_code ({CDD_STATUS_UPDATE}.printer_existing_step_code)])
								l_routine_count := l_routine_count + 1
								log.report_printing (l_print_start_time, create {DATE_TIME}.make_now, l_test_routines_to_replace.first.test_class, True, False)
							else
									-- The reextracted test class is a duplicate. Delete it from system (including associated file)
								l_class_to_delete_list := eb_cluster_manager.eiffel_universe.classes_with_name (l_test_routines_to_replace.first.test_class.test_class_name)
									-- To be sure, only delete anything if exactly one class is found
								if l_class_to_delete_list.count = 1 then
									file_manager.delete_class_from_system (l_class_to_delete_list.first)
								end
								status_update_actions.call ([create {CDD_STATUS_UPDATE}.make_with_code ({CDD_STATUS_UPDATE}.printer_existing_duplicate_step_code)])
								l_routine_count := l_routine_count + 1
								log.report_printing (l_print_start_time, create {DATE_TIME}.make_now, l_test_routines_to_replace.first.test_class, True, True)
							end
						else
								-- Get a new class file.
							file_manager.create_new_test_class_file (l_original_outcome.covered_feature.associated_class)
							if file_manager.is_last_test_class_file_creation_successful then
								test_class_printer.reset
								test_class_printer.set_output_stream (file_manager.last_created_class_file)
								test_class_printer.print_routine_invocation (file_manager.last_created_class_name, l_list.item_for_iteration)
								if not test_class_printer.has_last_print_failed then
									file_manager.last_created_class_file.close
									file_manager.add_last_created_test_class_to_system (l_original_outcome)
									l_routine_count := l_routine_count + 1
									if file_manager.is_last_test_class_adding_successful then
										status_update_actions.call ([create {CDD_STATUS_UPDATE}.make_with_code ({CDD_STATUS_UPDATE}.printer_new_step_code)])
										log.report_printing (l_print_start_time, create {DATE_TIME}.make_now, file_manager.last_added_cdd_test_class, False, False)
									elseif file_manager.is_adding_failed_due_to_duplicate then
										status_update_actions.call ([create {CDD_STATUS_UPDATE}.make_with_code ({CDD_STATUS_UPDATE}.printer_duplicate_step_code)])
										log.report_printing (l_print_start_time, create {DATE_TIME}.make_now, file_manager.last_added_cdd_test_class, False, True)
									end
								else
									-- TODO Error handling
								end
							else
								-- TODO Error handling
							end
						end

						l_list.forth
					end
					if l_routine_count > 0 then
						schedule_testing_restart
					end
					log.report_printing_end
				end
			end
		end

	on_application_launched (dbg: DEBUGGER_MANAGER) is
			-- Emit status update affecting GUI.
		do
			emit_manager_status_update
		end

	clean_up_after_debugging is
			-- Clean up data structures needed during one debugging session.
		do
			routine_invocation_cache.wipe_out
			cdd_breakpoints.wipe_out
			test_routines_for_reextraction := Void
			emit_manager_status_update
		end

	execution_paused_on_breakpoint (a_status: APPLICATION_STATUS_CLASSIC) is
			-- Execution paused on breakpoint
		local
			cse: CALL_STACK_ELEMENT_CLASSIC
			f: E_FEATURE
			i: INTEGER
		do
			cse := a_status.current_call_stack.i_th (1)
			f := cse.routine
			i := cse.break_index
			if f.first_breakpoint_slot_index = f.number_of_breakpoint_slots then
					-- This feature can do nothing, so we do nothing
			elseif cdd_breakpoints.has_cdd_breakpoint (f) then
				if
						-- NOTE/TODO `first_breakpoint_slot_index' seems to be bugged or does not work like intended
						-- Taking '1' as first index has dangers if precondition checking is disabled!!
					--i = f.first_breakpoint_slot_index
					i = 1
				then
					--| We reached feature entry CDD breakpoint
					--| on routine `f'
					a_status.reload_current_call_stack
					on_routine_entry (a_status)
				elseif i = f.number_of_breakpoint_slots then
					--| We reached feature exit CDD breakpoint
					--| on routine `f'
					a_status.reload_current_call_stack
					on_routine_exit (a_status)
				else
						-- CDD breakpoints are corrupted !
					check
						corrupted_cdd_breakpoints: False
					end
				end
			end
		end

feature -- Access (Test Suite)

	test_suite: CDD_TEST_SUITE
			-- Test suite which is managed by `Current'

	last_updated_test_class: EIFFEL_CLASS_C
			-- Test class which has last been processed in degree 5

feature {EB_CLUSTERS} -- Basic Operations (Test Suite)

	add_updated_class is
			-- If `project.system.system.degree_5.current_class' is a test class (exists in test suite)
			-- add it to classes which for which test class should
			-- be updated.
		local
			l_class: EIFFEL_CLASS_C
		do
			l_class := project.system.system.degree_5.current_class
			if test_suite.has_test_case_for_class (l_class) then
				last_updated_test_class := l_class
				status_update_actions.call ([create {CDD_STATUS_UPDATE}.make_with_code ({CDD_STATUS_UPDATE}.test_class_update_code)])
			end
			last_updated_test_class := Void
		end

	remove_test_case_for_class (a_class: CLASS_I) is
			-- Check if there is a test case for `a_class'. If this is
			-- the case, remove the test case.
		do
			if test_suite.has_test_case_with_name (a_class.name) then
				test_suite.remove_test_class (a_class.name)
			end
		end

feature -- Access (Execution)

	background_executor: CDD_TEST_EXECUTOR
			-- Background executor of test suite

	debug_executor: CDD_TEST_DEBUGGER
			-- Test debugger for debugging tests

feature {ANY} -- Basic Operations (Execution)

	schedule_testing_restart is
			-- Schedule that background testing starts a new as soon as possible.
		require
			not_cdd_target: not target.is_cdd_target
		do
			if is_gui and then is_executing_enabled then
				if background_executor.has_next_step and then background_executor.is_compiling then
					background_executor.schedule_restart_after_compilation
				elseif background_executor.has_next_step then
					background_executor.cancel
					background_executor.start
				else
					background_executor.start
				end
			end
		end

	drive_background_tasks is
			-- Drive background tasks (e.g.: test case compilation and
			-- execution). In an event driven setting call this routine
			-- whenever time perimits. This routine must not execute for
			-- very long so that it can be called from within GUI event loops
		do
			if not project.is_compiling and background_executor.has_next_step then
				background_executor.step
			end
		end

feature -- Logging

	log_sut_compile_start is
			-- Delegates compiler started notification to logger.
			-- This indirection prevents an untimely call to `log' (before `project_is_initialized').
		do
			if is_project_initialized then
				log.report_compilation_start
			end
		end

	log_sut_compile_stop is
			-- Delegates compiler stopped notification to logger.
			-- This indirection prevents an untimely call to `log' (before `project_is_initialized').
		do
			if is_project_initialized then
				log.report_compilation_end
			end
		end

	log_project_closed is
			-- Delegates project closed notification to logger.
			-- This indirection prevents an untimely call to `log' (before `project_is_initialized').
		do
			if is_project_initialized then
				log.report_system_status (project.system.name, target.name, is_extracting_enabled, is_executing_enabled, "Exit")
			end
		end



	log: CDD_LOGGER is
			-- Logger for cdd plugin
		require
			project_is_initialized: is_project_initialized
		local
			l_output_file: KL_TEXT_OUTPUT_FILE
		once
					-- NOTE: If logging is enabled, which currently is always the case, the cdd_tests folder gets created (almost) immediately.
					-- In order to prevent modification of precompile systems, for targets of systems which contain a library target, logging is disabled
					-- automatically.
			if not target.is_cdd_target and then target.system.library_target = Void then
				l_output_file := file_manager.cdd_log_file
				l_output_file.recursive_open_append
				if l_output_file.is_open_write then
					create Result.make (l_output_file)
				else
					create Result.make (null_output_stream)
				end
			else
					-- No logging for cdd targets and library targets
				create Result.make (null_output_stream)
			end
		ensure
			logger_not_void: Result /= Void
		end

feature {NONE} -- Implementation (General)

	process_update (an_update: CDD_STATUS_UPDATE) is
			-- Process `an_update' if necessary.
		require
			an_update_not_void: an_update /= Void
		do
			-- Currently there is for cdd manager to process
		end

	configuration: CONF_CDD is
			-- CDD part of project configuration
		require
			is_project_initialized: is_project_initialized
		do
			if target.cdd = Void then
				target.set_cdd (conf_factory.new_cdd (target))
			end
			Result := target.cdd
		ensure
			configuration_not_void: Result /= Void
		end

	degree_5_observer: PROCEDURE [ANY, TUPLE]

	conf_factory: CONF_FACTORY is
			-- Factory for creating cdd library
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	status_udpate: CDD_STATUS_UPDATE is
			-- New status update message
		once
			create Result.make_with_code ({CDD_STATUS_UPDATE}.manager_update_code)
		ensure
			not_void: Result /= Void
		end

invariant
	test_suite_not_void: test_suite /= Void
	executor_not_void: background_executor /= Void
	debugger_not_void: debug_executor /= Void
	capturer_not_void: capturer /= Void
	test_class_printer_not_void: test_class_printer /= Void
	file_manager_not_void: file_manager /= Void
	routine_invocation_cache_not_void: routine_invocation_cache /= Void
	status_update_actions_not_void: status_update_actions /= Void
	output_actions_not_void: output_actions /= Void
	last_updated_test_class_valid: (last_updated_test_class /= Void) implies test_suite.has_test_case_for_class (last_updated_test_class)

end
