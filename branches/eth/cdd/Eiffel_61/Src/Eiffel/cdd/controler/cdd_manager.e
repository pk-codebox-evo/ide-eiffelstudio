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
			on_application_stopped
		end

	EB_CLUSTER_MANAGER_OBSERVER
		rename
			manager as eb_cluster_manager,
			refresh as eb_cluster_refresh,
			on_class_removed as remove_test_case_for_class
		export
			{NONE} all
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

	SHARED_EXEC_ENVIRONMENT
		export
			{NONE} all
		end

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

	SHARED_EIFFEL_PARSER
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

	testing_directory: CONF_DIRECTORY_LOCATION is
			-- Directory where test classes, interpreter,
			-- cdd root class etc. are created
			-- NOTE: if .ecf file is in directory x, `testing_directory'
			-- will point to x/cdd_tests/target
		require
			project_initialized: is_project_initialized
		local
			l_path: STRING
		do
			if cached_testing_directory = Void then
				l_path := ".\cdd_tests\" + target.name
				cached_testing_directory := conf_factory.new_location_from_path (l_path, target)
			end
			Result := cached_testing_directory
		end

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

	status_update_actions: ACTION_SEQUENCE [TUPLE [CDD_STATUS_UPDATE]]
			-- Actions performed whenever `Current' or any cdd controller changes its state

	output_actions: ACTION_SEQUENCE [TUPLE [STRING]]
			-- Actions performed whenever there is some kind of textual output available

	emit_manager_status_update is
			-- Emit a notification to all subscribes of `status_update_actions' that the
			-- state of the manager has changed.
		do
			status_update_actions.call ([status_udpate])
		end

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

feature {EB_CLUSTERS} -- Status setting (General)

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

feature -- Access (Debugging)

	debugger_manager: DEBUGGER_MANAGER
			-- Debugger manager

	cdd_breakpoints: CDD_BREAKPOINTS_LIST
			-- CDD breakpoints.

feature {DEBUGGER_MANAGER} -- Status setting (Debugging)

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
			l_routine_count: INTEGER_32

			l_original_outcome: CDD_ORIGINAL_OUTCOME
			l_file: KL_TEXT_OUTPUT_FILE
			l_class_name: STRING
		do
				-- Before we extract any thing, make sure
				--		* extraction is actually enabled
				--		* the debugger is not debugging a
				--		  test routine right now
				--		* an exception has occured which
				--		  is not a developer exception
			if is_extracting_enabled and
				not debug_executor.is_running and
				a_dbg_manager.application_status.exception_occurred and
				a_dbg_manager.application_status.exception_code /= {EXCEP_CONST}.developer_exception
			then
				l_status := a_dbg_manager.application_status
				capturer.extract_routine_invocations_for_failure (l_status)
				l_list := capturer.last_extracted_routine_invocations

					-- Write the extracted routine invocations to disk
				log.report_printing_start
				from
					l_list.start
				until
					l_list.after
				loop
					create current_test_class_print_start_time.make_now
					create l_original_outcome.make_failing (l_list.item_for_iteration.represented_feature, l_status)
					l_file := test_class_file_for_original_outcome (l_original_outcome)
					if l_file /= Void then
						l_class_name := file_system.basename (l_file.name)
						l_class_name.remove_tail (2)
						l_class_name.to_upper
						test_class_printer.reset
						test_class_printer.set_output_stream (l_file)
						test_class_printer.print_routine_invocation (l_class_name, l_list.item_for_iteration)
						if test_class_printer.has_last_print_failed then
							-- TODO: Error handling
						else
							l_file.close

							l_original_outcome.set_original_class_file_name (l_file.name)

							if last_test_routines_to_replace /= Void and then not last_test_routines_to_replace.is_empty then
									-- An existing test class has been replaced. Delete the outcomes of the corresponding
									-- test routine in order to reset it to the "waiting for initial execution" status
								last_test_routines_to_replace.first.outcomes.wipe_out
								last_test_routines_to_replace.first.set_original_outcome (l_original_outcome)
							else
								ensure_system_contains_testing_cluster
								add_test_class (l_file, l_original_outcome)
							end

							l_routine_count := l_routine_count + 1
						end
					end
					l_list.forth
				end
				log.report_printing_end

				if l_routine_count > 0 then
					schedule_testing_restart
				end
			end
		end

	prepare_debugging is
			-- Initialize and update all data structures needed during one debugging session.
			-- TODO: Also add CDD breakpoints for features marked for extraction of passing routine invocations.
		local
			l_test_class: CDD_TEST_CLASS
			l_test_routine: CDD_TEST_ROUTINE
		do
				-- Do nothing is extraction is disabled or a test case foreground debugging is running
			if is_extracting_enabled and not debug_executor.is_running then

					-- TODO: This basically is redundant and probably could be removed by less paranoid developers.
					-- (Since the cache should be reset by `clean_up_after_debugging')
				capturer.reset_cache

					-- Generate list of test routines for reextraction and insert CDD breakpoints.
				create {DS_ARRAYED_LIST [CDD_TEST_ROUTINE]} non_reproducing_test_routines.make (10)
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
								non_reproducing_test_routines.force_last (l_test_routine)
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

	clean_up_after_debugging is
			-- Clean up data structures needed during one debugging session.
		do
			capturer.reset_cache
			cdd_breakpoints.wipe_out
			non_reproducing_test_routines := Void
		end

	on_routine_entry (a_status: APPLICATION_STATUS) is
			-- Handle entry of top feature of call stack of `a_status'.
		require
			a_feature_not_void: a_status /= Void
		do
			capturer.cache_routine_invocation_for_active_routine (a_status)
			-- It's called printf debugging: io.put_string ("WOOHOOO cdd breakpoint found for ENTRY feature " + a_status.e_feature.name + "%N")
		end

	on_routine_exit (a_status: APPLICATION_STATUS) is
			-- Handle exit of top feature of call stack of `a_status'.
		require
			a_feature_not_void: a_status /= Void
		local
			a_cse: EIFFEL_CALL_STACK_ELEMENT
		do
			a_cse ?= a_status.current_call_stack_element
			if a_cse /= Void then
				capturer.pop_cached_routine_invocation (a_cse.routine)
			end
			-- It's called printf debugging: io.put_string ("WOOHOOO cdd breakpoint found for EXIT feature " + a_status.e_feature.name + "%N")
		end


feature {STOPPED_HDLR} -- Status setting (Debugging)

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
					i = f.first_breakpoint_slot_index
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

feature {EB_CLUSTERS} -- Status setting (Test Suite)

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

feature -- Access (Extraction)

	capturer: CDD_CAPTURER
			-- Capturer for extracting new test cases

	last_printed_class: CLASS_I

	test_class_printer: CDD_TEST_CLASS_PRINTER
			-- Mangager for creation of new test classes

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
			if background_executor.has_next_step and then background_executor.is_compiling then
				background_executor.schedule_restart_after_compilation
			elseif background_executor.has_next_step then
				background_executor.cancel
				background_executor.start
			else
				background_executor.start
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

feature -- Access (Logging)

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
			l_tester_id_string: STRING
		once

					-- NOTE: If logging is enabled, which currently is the case, the cdd_tests folder gets created (almost) immediately.
					-- To prevent modification of precompile systems for targets of a system containing a library target logging is disabled
					-- automatically.
			if not target.is_cdd_target and then target.system.library_target = Void then
				l_tester_id_string := execution_environment.get (cdd_tester_id_environment_variable)
				if l_tester_id_string /= Void and then not l_tester_id_string.is_empty then
					create l_output_file.make (testing_directory.build_path ("", l_tester_id_string + "_" + log_file_name))
				else
					create l_output_file.make (testing_directory.build_path ("", log_file_name))
				end
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

	current_test_class_print_start_time: DATE_TIME


feature {NONE} -- Implementation (General)

	process_update (an_update: CDD_STATUS_UPDATE) is
			-- Process `an_update' if necessary.
		require
			an_update_not_void: an_update /= Void
		do
			-- semantics of capturer_extracted_code changed, currently there is nothing to do here
--			if an_update.code = an_update.capturer_extracted_code then
--				schedule_testing_restart
--			end
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

	cached_testing_directory: like testing_directory
			-- Cached `testing_directory'

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

feature {NONE} -- Implementation (Extraction)

	test_class_file_for_original_outcome (an_original_outcome: CDD_ORIGINAL_OUTCOME): KL_TEXT_OUTPUT_FILE is
			-- Output stream for writing extracted test class covering `an_original_outcome.covered_feature' and reproducing `an_original_outcome'
			-- If a non-reproducing test class for `an_original_outcome.covered_feature' and `an_original_outcome' exists already,
			-- return stream to existing file (overwrite).
			-- Otherwise, create a new class and file.
			-- Upon failure, return Void
		require
			an_original_outcome_not_void: an_original_outcome /= Void
		local
			i: INTEGER

			l_cluster: CONF_CLUSTER
			l_dir: KL_DIRECTORY

			l_prefix: STRING
			l_integer_string: STRING
			l_tester_id_string: STRING

			l_output_file: KL_TEXT_OUTPUT_FILE
			l_class_name: STRING
			l_class: CLASS_C

			has_failed: BOOLEAN
		do
			if has_failed then
				Result := Void
			else
					-- Look for non-reproducing test routines whith a matching original outcome
				from
					create {DS_ARRAYED_LIST [CDD_TEST_ROUTINE]} last_test_routines_to_replace.make (10)
					non_reproducing_test_routines.start
				until
					non_reproducing_test_routines.after
				loop
					if
						non_reproducing_test_routines.item_for_iteration.original_outcome.is_same (an_original_outcome)
					then
						last_test_routines_to_replace.force_last (non_reproducing_test_routines.item_for_iteration)
					end

					non_reproducing_test_routines.forth
				end

				if not last_test_routines_to_replace.is_empty then
						-- Rewrite test class file of first test routine found
					create Result.make (last_test_routines_to_replace.first.class_file_name)
					Result.open_write
				else
						-- Generate a new class file
					l_class := an_original_outcome.covered_feature.associated_class
						-- Build path list in which test case shall be stored
					create last_relative_class_path.make_empty
					from
						l_cluster ?= l_class.group
					until
						l_cluster = Void
					loop
						last_relative_class_path := "/" + l_cluster.name + last_relative_class_path
						l_cluster := l_cluster.parent
					end

						-- Create directories from path list
					create l_dir.make (testing_directory.build_path (last_relative_class_path, ""))
					if not l_dir.exists then
						l_dir.recursive_create_directory
						if not l_dir.exists then
							has_failed := True
						end
					end

						-- Try to create the class file
					if not has_failed then
						l_prefix := class_name_prefix + l_class.name + "_"
						from
							i := 1
						until
							l_output_file /= Void or i > max_test_cases_per_sut_class
						loop
							create l_class_name.make_from_string (l_prefix)
							create l_integer_string.make_filled ('0', max_test_cases_per_sut_class.out.count)
							l_integer_string.replace_substring (i.out, (max_test_cases_per_sut_class.out.count - i.out.count) + 1, max_test_cases_per_sut_class.out.count)
							l_class_name.append_string (l_integer_string)
							l_tester_id_string := execution_environment.get (cdd_tester_id_environment_variable)
							if l_tester_id_string /= Void and then not l_tester_id_string.is_empty then
								l_class_name.append_character ('_')
								l_tester_id_string.to_upper
								l_class_name.append_string (l_tester_id_string)
							end

							create l_output_file.make (testing_directory.build_path (last_relative_class_path, l_class_name.as_lower + ".e"))

							if l_output_file.exists then
								l_output_file := Void
							end
							i := i + 1
						end
						if l_output_file = Void then
							has_failed := True
							Result := Void
						end
					end

					if not has_failed then
						l_output_file.open_write
						if not l_output_file.is_open_write then
							has_failed := True
							Result := Void
						else
							Result := l_output_file
						end
					end
				end
			end
		ensure
			Resulting_file_writeable_if_exists: Result /= Void implies (Result.is_open_write)
			Class_path_set_or_test_routines_for_replacing_found_if_exists:
												Result /= Void implies
													((last_relative_class_path /= Void) or else
													 (last_test_routines_to_replace /= Void and then
													  not last_test_routines_to_replace.is_empty))
		rescue
			has_failed := True
			Retry
		end

	last_test_routines_to_replace: DS_LIST [CDD_TEST_ROUTINE]

	last_relative_class_path: STRING_8
			-- Class path relative to testing directory for last file returned by `test_class_file_for_original_outcome'

	ensure_system_contains_testing_cluster is
			--  Add the general cdd testing cluster to the system if it doesn't exist yet
		local
			l_comp_conf_factory: CONF_COMP_FACTORY
			l_cluster_name: STRING
			l_tests_cluster: CONF_CLUSTER
			l_cluster_list: LIST [CONF_CLUSTER]
			l_loc: CONF_DIRECTORY_LOCATION
			l_directory: KL_DIRECTORY
		do
			create l_comp_conf_factory
			l_cluster_name := target.name + "_tests"
			l_tests_cluster := project.system.system.eiffel_universe.cluster_of_name (l_cluster_name)
			if l_tests_cluster = Void Then
				create l_directory.make (target.system.directory)
				l_cluster_list := project.system.system.eiffel_universe.cluster_of_location (l_directory.name)
				if l_cluster_list.is_empty then
					-- Note (Arno): first version prints absolute path to cluster
					--cluster_manager.add_cluster (current_cluster.cluster_name + cluster_name_suffix, current_cluster, l_directory.name)

					-- Note: need to replace {EB_CLUSTERS}.add_cluster with own routine
					-- cluster_manager.add_cluster (l_cluster_name, Void, ".\" + l_cluster_name)
					l_loc := l_comp_conf_factory.new_location_from_path (".\cdd_tests\" + target.name, target)
					l_tests_cluster := l_comp_conf_factory.new_cdd_cluster (l_cluster_name, l_loc, target)
					l_tests_cluster.set_recursive (True)
					l_tests_cluster.set_classes (create {HASH_TABLE [EIFFEL_CLASS_I, STRING]}.make (0))
					l_tests_cluster.set_classes_by_filename (create {HASH_TABLE [EIFFEL_CLASS_I, STRING]}.make (0))

					target.add_cluster (l_tests_cluster)
					project.system.system.set_config_changed (True)
					eb_cluster_manager.refresh
				else
					l_tests_cluster := l_cluster_list.first
				end
			end
			project.system.system.set_rebuild (True)
		end

	add_test_class (a_file: KL_TEXT_OUTPUT_FILE; an_outcome: CDD_ORIGINAL_OUTCOME) is
			-- Add test class with name `a_class_name' located in `a_class_path' contained in `a_file'
		require
			last_relative_class_path_not_void: last_relative_class_path /= Void
		local
			l_class_file_name: STRING
			l_cluster_name: STRING
			l_tests_cluster: CONF_CLUSTER
			l_new_test_class: CDD_TEST_CLASS
			l_outcome_list: DS_ARRAYED_LIST [CDD_ORIGINAL_OUTCOME]
		do
			l_class_file_name := file_system.basename (a_file.name)

			if is_gui then
				l_cluster_name := target.name + "_tests"
				l_tests_cluster := project.system.system.eiffel_universe.cluster_of_name (l_cluster_name)
				eb_cluster_manager.add_class_to_cluster (l_class_file_name, l_tests_cluster, last_relative_class_path)
				last_printed_class := eb_cluster_manager.last_added_class
				status_update_actions.call ([create {CDD_STATUS_UPDATE}.make_with_code ({CDD_STATUS_UPDATE}.printer_step_code)])
			end

			parse_output_stream (a_file)
			if not has_parse_error then
				create l_outcome_list.make (1)
				l_outcome_list.put (an_outcome, 1)
				create l_new_test_class.make_with_ast_and_outcomes (last_parsed_class, l_outcome_list)
				test_suite.add_test_class (l_new_test_class)
				log.report_printing (current_test_class_print_start_time, create {DATE_TIME}.make_now, l_new_test_class)
			end
		end

	non_reproducing_test_routines: DS_LIST [CDD_TEST_ROUTINE]


feature {NONE} -- Implementation (Extraction - Parsing)

	has_parse_error: BOOLEAN
			-- Did an error occur during last 'parse_class_file'?

	last_parsed_class: CLASS_AS
			-- AST generated by last call to `parse_class_file'.

	parse_output_stream (an_output_stream: KI_TEXT_OUTPUT_STREAM) is
			-- Parse eiffel class written to `output_stream'
			-- and store ast in `last_parsed_class'. If an
			-- error occurs, set `has_parse_error' to True.
		require
			an_output_stream_not_void: an_output_stream /= Void
		do
			has_parse_error := False
			safe_parse_class_file (an_output_stream)
		end

	safe_parse_class_file (an_output_stream: KI_TEXT_OUTPUT_STREAM) is
			-- Parse eiffel class written to `output_stream'
			-- and store ast in `last_parsed_class'. If an
			-- error occurs, catch any exceptions and set
			-- `has_parse_error' to True.
		require
			an_output_stream_not_void: an_output_stream /= Void
			has_parse_error_reset: has_parse_error = False
		local
			l_file: KL_BINARY_INPUT_FILE
		do
			if not has_parse_error then
				last_parsed_class := Void
				create l_file.make (an_output_stream.name)
				l_file.open_read
				eiffel_parser.parse (l_file)
				last_parsed_class := eiffel_parser.root_node
				if eiffel_parser.error_count > 0 then
					has_parse_error := True
					last_parsed_class := Void
				end
			end
		ensure
			parsed_or_error: (last_parsed_class /= Void) xor has_parse_error
		rescue
			has_parse_error := True
			last_parsed_class := Void
			retry
		end


invariant
	test_suite_not_void: test_suite /= Void
	executor_not_void: background_executor /= Void
	debugger_not_void: debug_executor /= Void
	capturer_not_void: capturer /= Void
	test_class_printer_not_void: test_class_printer /= Void
	status_update_actions_not_void: status_update_actions /= Void
	output_actions_not_void: output_actions /= Void
	last_updated_test_class_valid: (last_updated_test_class /= Void) implies test_suite.has_test_case_for_class (last_updated_test_class)

end
