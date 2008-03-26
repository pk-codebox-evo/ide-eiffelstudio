indexing
	description: "Objects managing the creation of automatically generated cdd testing directories and files and associated testing cluster"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TESTING_FILES_MANAGER

inherit

	CDD_ROUTINES
		export
			{NONE} all
		end

	EB_CLUSTER_MANAGER_OBSERVER
		rename
			manager as cluster_manager
		end

	CONF_ACCESS
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

	SHARED_EXEC_ENVIRONMENT
		export
			{NONE} all
		end

	KL_SHARED_FILE_SYSTEM


create
	make

feature -- Initialization

	make (a_cdd_manager: like cdd_manager) is
			-- Initialize `Current'.
		require
			a_cdd_manager_not_void: a_cdd_manager /= Void
		do
			cdd_manager := a_cdd_manager
		ensure
			cdd_manager_set: cdd_manager = a_cdd_manager
		end


feature -- Status report

	is_last_test_class_file_creation_successful: BOOLEAN
			-- Was the last test class file created successfully?

	is_last_test_class_adding_successful: BOOLEAN
			-- Was the last adding of test class contained in `last_created_class_file' to system successful?

	is_adding_failed_due_to_duplicate: BOOLEAN
			-- Did the last test class adding fail because test class to add was a duplicate?

feature -- Access

	cdd_manager: CDD_MANAGER
			-- CDD Manager

	testing_directory: CONF_DIRECTORY_LOCATION is
			-- Directory where test classes, interpreter,
			-- cdd root class etc. are created
			-- NOTE: if .ecf file is in directory x, `testing_directory'
			-- will point to x/cdd_tests/target
		require
			project_initialized: cdd_manager.is_project_initialized
		local
			l_path: STRING
		once
			l_path := ".\cdd_tests\" + target.name
			Result := conf_factory.new_location_from_path (l_path, cdd_manager.target)
		end

	interpreter_log_file: KL_TEXT_OUTPUT_FILE is
			-- File for logging of interpreter communication
		require
			project_initialized: cdd_manager.is_project_initialized
		do
			create Result.make (testing_directory.build_path ("", "cdd_interpreter.log"))
		ensure
			result_not_void: Result /= Void
		end

	cdd_log_file: KL_TEXT_OUTPUT_FILE is
			-- Main CDD log file
		require
			project_initialized: cdd_manager.is_project_initialized
		local
			l_tester_id_string: STRING
			l_time: DATE_TIME
			l_time_string: STRING
		once
			create l_time.make_now
			l_time_string := l_time.formatted_out ("yyyy-[0]mm-[0]dd [0]hh-[0]mi-[0]ss")
			l_time_string.put ('_', 11)
		--	"yyyy-[0]mm-[0]dd hh:[0]mi:[0]ss"
			l_tester_id_string := execution_environment.get (cdd_tester_id_environment_variable)
			if l_tester_id_string /= Void and then not l_tester_id_string.is_empty then
				create Result.make (testing_directory.build_path ("", l_time_string + "_" + l_tester_id_string + "_" + log_file_name))
			else
				create Result.make (testing_directory.build_path ("", l_time_string + "_" + log_file_name))
			end
		ensure
			result_not_void: Result /= Void
		end

	last_created_class_file: KL_TEXT_OUTPUT_FILE
			-- The last created test class file

	last_created_class_name: STRING
			-- The last created class name, associated with `last_created_class_file'

	last_relative_class_path: STRING_8
			-- The path for the `last_created_class_file' relative to `testing_directory'

	last_added_class: CLASS_I
			-- The last test class added to system.

	last_added_cdd_test_class: CDD_TEST_CLASS
			-- The last CDD_TEST_CLASS added to system.

	class_name_from_file_path (a_path: STRING): STRING is
			-- The class name of the eiffel class stored in a file with `a_path' assuming standard conventions are followed
			-- (SOME_CLASS -> stored in file some_class.e)
		require
			a_path_not_void: a_path /= Void
			a_path_valid: file_system.is_absolute_pathname (a_path)
			a_valid_eiffel_class_file: file_system.basename (a_path).count > 2 and then
										file_system.basename (a_path).substring (file_system.basename (a_path).count - 1, file_system.basename (a_path).count).is_equal (".e")
		do
			Result := file_system.basename (a_path)
			Result.remove_tail (2)
			Result.to_upper
		ensure
			Result_not_void_nor_empty: (Result /= Void) and then not Result.is_empty
		end

feature -- Basic operations

	create_new_test_class_file (a_covered_class: CLASS_C) is
			-- Try to create a new class file for a test class covering `a_covered_class'.
			-- Make result available in `is_last_class_file_creation_successful' and `last_created_class_file'
		require
			project_initialized: cdd_manager.is_project_initialized
			a_covered_class_not_void: a_covered_class /= Void
		local
			l_cluster: CONF_CLUSTER
			l_dir: KL_DIRECTORY

			l_prefix: STRING
			i: INTEGER
			l_integer_string: STRING
			l_tester_id_string: STRING
		do
			last_created_class_file := Void
			is_last_test_class_file_creation_successful := True

				-- Build path list in which test case shall be stored
			create last_relative_class_path.make_empty
			from
				l_cluster ?= a_covered_class.group
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
					is_last_test_class_file_creation_successful := False
				end
			end

				-- Try to create the class file
			if is_last_test_class_file_creation_successful then
				l_prefix := class_name_prefix + a_covered_class.name + "_"
				from
					i := 1
				until
					last_created_class_file /= Void or i > max_test_cases_per_sut_class
				loop
					create last_created_class_name.make_from_string (l_prefix)
					create l_integer_string.make_filled ('0', max_test_cases_per_sut_class.out.count)
					l_integer_string.replace_substring (i.out, (max_test_cases_per_sut_class.out.count - i.out.count) + 1, max_test_cases_per_sut_class.out.count)
					last_created_class_name.append_string (l_integer_string)
					l_tester_id_string := execution_environment.get (cdd_tester_id_environment_variable)
					if l_tester_id_string /= Void and then not l_tester_id_string.is_empty then
						last_created_class_name.append_character ('_')
						l_tester_id_string.to_upper
						last_created_class_name.append_string (l_tester_id_string)
					end

					create last_created_class_file.make (testing_directory.build_path (last_relative_class_path, last_created_class_name.as_lower + ".e"))

					if last_created_class_file.exists then
						last_created_class_file := Void
					end
					i := i + 1
				end
				if last_created_class_file = Void then
					is_last_test_class_file_creation_successful := False
				end
			end

			if is_last_test_class_file_creation_successful then
				last_created_class_file.open_write
				if not last_created_class_file.is_open_write then
					is_last_test_class_file_creation_successful := False
					last_created_class_file := Void
				end
			end
		ensure
			success_implies_file_available: is_last_test_class_file_creation_successful implies
													(last_created_class_file /= Void and then
													 last_created_class_file.exists and then
													 last_created_class_file.is_open_write)
			success_implies_class_name_available: is_last_test_class_file_creation_successful implies
													(last_created_class_name /= Void and then
													 not last_created_class_name.is_empty)

		end

	add_last_created_test_class_to_system (an_outcome: CDD_ORIGINAL_OUTCOME) is
			-- Try to add the test class contained in `last_created_class_file' to system with original outcome `an_outcome'.
			-- This involves parsing of the test class file and is not guaranteed to succeed.
			-- There is also a check for duplicates involved. If the test class to add is identified as a duplicate of an
			-- existing class, it is deleted instead of added to the test suite.
		require
			class_creation_successful: is_last_test_class_file_creation_successful
		local
			l_cluster_name: STRING
			l_tests_cluster: CONF_CLUSTER
			l_outcome_list: DS_ARRAYED_LIST [CDD_ORIGINAL_OUTCOME]
			l_new_test_class: CDD_TEST_CLASS
--			l_file: KL_TEXT_INPUT_FILE
		do
			ensure_system_contains_testing_cluster

			parse_last_created_class_file
			if not has_parse_error then
				create l_outcome_list.make (1)
				l_outcome_list.put (an_outcome, 1)
				create l_new_test_class.make_extracted (last_parsed_class, last_created_class_file.name, l_outcome_list)
				last_added_cdd_test_class := l_new_test_class

				if
					l_new_test_class.check_sum /= Void and then
					cdd_manager.test_suite.has_extracted_test_case_with_check_sum (l_new_test_class.check_sum)
				then
					is_last_test_class_adding_successful := False
					is_adding_failed_due_to_duplicate := True
--					create l_file.make (last_created_class_file.name)
					if last_created_class_file.exists then
						last_created_class_file.delete
					end
				else
					cdd_manager.test_suite.add_test_class (l_new_test_class)

					if is_gui then
						l_cluster_name := target.name + "_tests"
						l_tests_cluster := cdd_manager.project.system.system.eiffel_universe.cluster_of_name (l_cluster_name)
						cluster_manager.add_class_to_cluster (last_created_class_name.as_lower + ".e", l_tests_cluster, last_relative_class_path)
						last_added_class := cluster_manager.last_added_class
					end

					is_last_test_class_adding_successful := True
					is_adding_failed_due_to_duplicate := False
				end
			else
				is_last_test_class_adding_successful := False
				is_adding_failed_due_to_duplicate := False
			end
		ensure
			success_implies_last_added_class_available: (is_last_test_class_adding_successful and is_gui) implies (last_added_class /= Void)
			success_implies_last_added_cdd_test_class_available: is_last_test_class_adding_successful implies (last_added_cdd_test_class /= Void)
		end

	delete_class_from_system (a_class: CLASS_I) is
			-- Delete `a_class' from system
		require
			a_class_not_void: a_class /= Void
		local
			file: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
--				if debugger_manager.application_is_executing then
--					debugger_manager.application.kill
--				end
--				debugger_manager.disable_debug
				create file.make (a_class.file_name)
				if
					file.exists and then
					file.is_writable
				then
					file.delete
					cluster_manager.remove_class (a_class)
--					could_not_delete := False
				end
--				Debugger_manager.resynchronize_breakpoints
--				Window_manager.synchronize_all
			end
--			if could_not_delete then
--					-- We were not able to delete the file.
--				(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (Warning_messages.w_Not_writable (class_i.file_name), window.window, Void)
--			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Parsing

	has_parse_error: BOOLEAN
			-- Did an error occur during last 'parse_class_file'?

	last_parsed_class: CLASS_AS
			-- AST generated by last call to `parse_class_file'.

	parse_last_created_class_file is
			-- Parse eiffel class written to `last_created_class_file'
			-- and store ast in `last_parsed_class'. If an
			-- error occurs, set `has_parse_error' to True.
		require
			last_created_class_file_not_void: last_created_class_file /= Void
		do
			has_parse_error := False
			safe_parse_class_file
		end

	safe_parse_class_file is
			-- Parse eiffel class written to `last_created_class_file'
			-- and store ast in `last_parsed_class'. If an
			-- error occurs, catch any exceptions and set
			-- `has_parse_error' to True.
		require
			last_created_class_file_not_void: last_created_class_file /= Void
			has_parse_error_reset: has_parse_error = False
		local
			l_file: KL_BINARY_INPUT_FILE
		do
			if not has_parse_error then
				last_parsed_class := Void
				create l_file.make (last_created_class_file.name)
				l_file.open_read
				eiffel_parser.parse (l_file)
				last_parsed_class := eiffel_parser.root_node
				if eiffel_parser.error_count > 0 then
					has_parse_error := True
					last_parsed_class := Void
				end
				if l_file.is_closable then
					l_file.close
				end
			end
		ensure
			parsed_or_error: (last_parsed_class /= Void) xor has_parse_error
		rescue
			has_parse_error := True
			last_parsed_class := Void
			retry
		end

feature {NONE} -- Implementation

	status_update: CDD_STATUS_UPDATE is
			-- Status update for `Current'
		once
			create Result.make_with_code ({CDD_STATUS_UPDATE}.printer_new_step_code)
		ensure
			not_void: Result /= Void
		end

	target: CONF_TARGET is
			-- Target in which test cases will be created
		do
			Result := cdd_manager.test_suite.target
		end

	conf_factory: CONF_COMP_FACTORY is
			-- Factory for creating CONF_LOCATION
		once
			create Result
		end

	ensure_system_contains_testing_cluster is
			--  Add the general cdd testing cluster to the system if it doesn't exist yet
		local
			l_cluster_name: STRING
			l_tests_cluster: CONF_CLUSTER
			l_cluster_list: LIST [CONF_CLUSTER]
			l_loc: CONF_DIRECTORY_LOCATION
			l_directory: KL_DIRECTORY
		do
			l_cluster_name := target.name + "_tests"
			l_tests_cluster := cdd_manager.project.system.system.eiffel_universe.cluster_of_name (l_cluster_name)
			if l_tests_cluster = Void Then
				create l_directory.make (target.system.directory)
				l_cluster_list := cdd_manager.project.system.system.eiffel_universe.cluster_of_location (l_directory.name)
				if l_cluster_list.is_empty then
					-- Note (Arno): first version prints absolute path to cluster
					--cluster_manager.add_cluster (current_cluster.cluster_name + cluster_name_suffix, current_cluster, l_directory.name)

					-- Note: need to replace {EB_CLUSTERS}.add_cluster with own routine
					-- cluster_manager.add_cluster (l_cluster_name, Void, ".\" + l_cluster_name)
					l_loc := conf_factory.new_location_from_path (".\cdd_tests\" + target.name, target)
					l_tests_cluster := conf_factory.new_cdd_cluster (l_cluster_name, l_loc, target)
					l_tests_cluster.set_recursive (True)
					l_tests_cluster.set_classes (create {HASH_TABLE [EIFFEL_CLASS_I, STRING]}.make (0))
					l_tests_cluster.set_classes_by_filename (create {HASH_TABLE [EIFFEL_CLASS_I, STRING]}.make (0))

					target.add_cluster (l_tests_cluster)
					cdd_manager.project.system.system.set_config_changed (True)
					cluster_manager.refresh
				else
					l_tests_cluster := l_cluster_list.first
				end
			end
			cdd_manager.project.system.system.set_rebuild (True)
		end

invariant

	cdd_manager_not_void: cdd_manager /= Void
	successful_creation_implies_class_file_exists: is_last_test_class_file_creation_successful implies
														(last_created_class_file /= Void)
	successful_creation_implies_class_name_valid: is_last_test_class_file_creation_successful implies
														(last_created_class_name /= Void and then
														 not last_created_class_name.is_empty)
	successful_creation_implies_relative_class_path_exists: is_last_test_class_file_creation_successful implies
														 last_relative_class_path /= Void
end
