﻿note
	description:

		"AutoTest command line parser"

	copyright: "Copyright (c) 2004-2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUTO_TEST_COMMAND_LINE_PARSER

inherit
	AUT_SHARED_RANDOM

	KL_SHARED_ARGUMENTS

	KL_SHARED_FILE_SYSTEM

create
	make_with_arguments

feature{NONE} -- Initialization

	make_with_arguments (a_arguments: DS_LIST [STRING]; error_handler: AUT_ERROR_HANDLER)
			-- Process `a_arguments'.		
		require
			a_arguments_attached: a_arguments /= Void
			error_hadler_not_void: error_handler /= Void
		local
			parser: AUT_AP_PARSER
			version_option: AP_FLAG
			quiet_option: AP_FLAG
			debug_option: AP_FLAG
			just_test_option: AP_FLAG
--			ecf_target_option: AP_STRING_OPTION
--			deep_manual_option: AP_FLAG
			disable_manual_option: AP_FLAG
			disable_auto_option: AP_FLAG
			evolutionary_option: AP_FLAG
			benchmark_option: AP_FLAG
			disable_minimize_option: AP_FLAG
			minimize_option: AP_STRING_OPTION
			finalize_option: AP_FLAG
			output_dir_option: AP_STRING_OPTION
			time_out_option: AP_INTEGER_OPTION
			test_count_option: AP_INTEGER_OPTION
			seed_option: AP_INTEGER_OPTION
			statistics_format_op: AP_STRING_OPTION
			time: TIME
			proxy_time_out_option: AP_INTEGER_OPTION
			l_log_to_replay: AP_STRING_OPTION
			l_help_option: AP_FLAG
			l_help_flag: AP_DISPLAY_HELP_FLAG
			l_load_log_option: AP_STRING_OPTION
			l_state_option: AP_STRING_OPTION
			l_precondition_option: AP_FLAG
			l_object_state_exploration: AP_FLAG
			l_log_processor_op: AP_STRING_OPTION
			l_log_processor_output_op: AP_STRING_OPTION
			l_data_input_op: AP_STRING_OPTION
			l_data_output_op: AP_STRING_OPTION
			l_recursive: AP_FLAG
			l_filters: LIST [STRING]
			l_max_precondition_tries_op: AP_INTEGER_OPTION
			l_max_precondition_time_op: AP_INTEGER_OPTION
			l_candidate_count_option: AP_INTEGER_OPTION
			l_linear_constraint_solver_option: AP_STRING_OPTION
			l_smart_selection_rate_option: AP_INTEGER_OPTION
			l_smt_old_value_rate_option: AP_INTEGER_OPTION
			l_smt_use_predefined_value_rate_option: AP_INTEGER_OPTION
			l_integer_bound_option: AP_STRING_OPTION
			l_use_random_cursor_option: AP_STRING_OPTION
			l_test_case_serialization_option: AP_STRING_OPTION
			l_test_case_serialization_file_option: AP_STRING_OPTION
			l_test_case_deserialization_option: AP_STRING_OPTION
			l_build_behavioral_model_option: AP_STRING_OPTION
			l_build_faulty_feature_list_option: AP_STRING_OPTION
			l_deserialization_for_fixing: AP_FLAG
			l_validate_serialization: AP_STRING_OPTION
			l_interpreter_log_enabled: AP_STRING_OPTION
			l_proxy_log_option: AP_STRING_OPTION
			l_console_log_option: AP_STRING_OPTION
			l_duplicated_test_case_serialization_option: AP_FLAG
			l_strs, l_strs2: LIST [STRING]
			l_word: STRING
			l_log_has_basic: BOOLEAN
			l_post_state_serialization_option: AP_FLAG
			l_exclude_option: AP_STRING_OPTION
			l_collect_interface_related_classes_option: AP_FLAG
			l_2times_option: AP_STRING_OPTION
			l_3times_option: AP_STRING_OPTION
			l_4times_option: AP_STRING_OPTION
			l_5times_option: AP_STRING_OPTION
			l_6times_option: AP_STRING_OPTION
			l_7times_option: AP_STRING_OPTION
			l_8times_option: AP_STRING_OPTION
			l_9times_option: AP_STRING_OPTION
			l_freeze_flag: AP_FLAG
			l_agents_option: AP_STRING_OPTION
			l_sem_host_optioN: AP_STRING_OPTION
			l_sem_user_option: AP_STRING_OPTION
			l_sem_password_option: AP_STRING_OPTION
			l_sem_schema_option: AP_STRING_OPTION
			l_sem_port_option: AP_INTEGER_OPTION
			l_precondition_reduction_file_option: AP_STRING_OPTION
			l_pr_check_objects: AP_FLAG
			l_arff_directory_option: AP_STRING_OPTION
			l_online_statistics_frequency: AP_INTEGER_OPTION

			l_dir: DIRECTORY
			l_file_name: FILE_NAME
			l_text_output: KL_TEXT_OUTPUT_FILE
			l_file: RAW_FILE
			l_is_ok: BOOLEAN
		do
			create parser.make_empty
			parser.set_application_description ("auto_test is a contract-based automated testing tool for Eiffel systems.")
			parser.set_parameters_description ("class-name+")

			create version_option.make ('V', "version")
			version_option.set_description ("Output version information and exit")
			parser.options.force_last (version_option)

			create quiet_option.make ('q', "quiet")
			quiet_option.set_description ("Be quiet.")
			parser.options.force_last (quiet_option)

			create debug_option.make ('d', "debug")
			debug_option.set_description ("Append debugging output to log.")
			parser.options.force_last (debug_option)

			create just_test_option.make ('j', "just-test")
			just_test_option.set_description ("Skip compilation and generation of interpreter and go right to testing.")
			parser.options.force_last (just_test_option)

--			create ecf_target_option.make ('r', "target")
--			ecf_target_option.set_description ("Target (from supplied ECF file) that should be used for testing.")
--			parser.options.force_last (ecf_target_option)

--			create deep_manual_option.make ('d', "deep-manual")
--			deep_manual_option.set_description ("Enable deep relevancy check for manual strategy.")
--			parser.options.force_last (deep_manual_option)

			create evolutionary_option.make ('E', "evolve")
			evolutionary_option.set_description ("Evolve test cases")
			parser.options.force_last (evolutionary_option)

			create disable_manual_option.make ('m', "disable-manual")
			disable_manual_option.set_description ("Disable manual testing strategy.")
			parser.options.force_last (disable_manual_option)

			create disable_auto_option.make ('a', "disable-auto")
			disable_auto_option.set_description ("Disable automated testing strategy.")
			parser.options.force_last (disable_auto_option)

			create benchmark_option.make ('k', "benchmark")
			benchmark_option.set_description ("Log timeing information (usefull for assessing efficiency).")
			parser.options.force_last (benchmark_option)

			create disable_minimize_option.make ('i', "disable-minimize")
			disable_minimize_option.set_description ("Disable minimize testing strategy.")
			parser.options.force_last (disable_minimize_option)

			create minimize_option.make ('n', "minimize")
			minimize_option.set_description ("Minimize with a certain algorithm.")
			parser.options.force_last (minimize_option)

--			create finalize_option.make ('f', "finalize")
--			finalize_option.set_description ("Use finalized intepreter. (Better performance, but no melting)")
--			parser.options.force_last (finalize_option)

			create output_dir_option.make ('o', "output-dir")
			output_dir_option.set_description ("Output directory for reflection library")
			parser.options.force_last (output_dir_option)

			create time_out_option.make ('t', "time-out")
			time_out_option.set_description ("Time used for testing (in minutes). Default is 15 minutes.")
			parser.options.force_last (time_out_option)

			create test_count_option.make ('c', "count")
			test_count_option.set_description ("Maximum number of tests to be executed, 0 means no restriction. Default is 0.")
			parser.options.force_last (test_count_option)

			create seed_option.make ('e', "seed")
			seed_option.set_description ("Integer seed to initialize pseudo-random number generation with. If not specified seed is intialized with current time.")
			parser.options.force_last (seed_option)

			create statistics_format_op.make ('s', "stat-format")
			statistics_format_op.set_description ("Format in which to output statistics. Possibilities are 'html' and 'text'. Default is 'html'.")
			parser.options.force_last (statistics_format_op)

			create proxy_time_out_option.make ('x', "proxy-time-out")
			proxy_time_out_option.set_description ("Time in seconds used by proxy to wait for a feature to execute. Default is 5.")
			parser.options.force_last (proxy_time_out_option)

			create l_log_to_replay.make ('l', "log")
			l_log_to_replay.set_description ("Log file to be replayed. All the test cases in the given log file will be replayed.")
			parser.options.force_last (l_log_to_replay)

			create l_help_option.make ('h', "help")
			l_help_option.set_description ("Display this help message.")
			parser.options.force_last (l_help_option)

			create l_load_log_option.make_with_long_form ("log-file")
			l_load_log_option.set_description ("Process the log file specified as the following parameter.")
			parser.options.force_last (l_load_log_option)

			create l_state_option.make_with_long_form ("state")
			l_state_option.set_description ("Parameters to enable object state monitoring. The format is comma separated names. The supported parameters are %"argumentless%" and %"all%". Default is %"argumentless%".")
			parser.options.force_last (l_state_option)

			create l_precondition_option.make ('p', "precondition")
			l_precondition_option.set_description ("Enable precondition evaluation before feature call.")
			parser.options.force_last (l_precondition_option)

			create l_object_state_exploration.make_with_long_form ("state-explore")
			l_object_state_exploration.set_description ("Enable object state exploration.")
			parser.options.force_last (l_object_state_exploration)

			create l_log_processor_op.make_with_long_form ("log-processor")
			l_log_processor_op.set_description ("Processor for the log file specified with the " + l_load_log_option.name + " option. Supported processors are: 1) ps: precondition satisfaction processor 2) state: object state processor.")
			parser.options.force_last (l_log_processor_op)

			create l_log_processor_output_op.make_with_long_form ("log-processor-output")
			l_log_processor_output_op.set_description ("Name of the output file from the log processor specified with the " + l_log_processor_op.name + " option.")
			parser.options.force_last (l_log_processor_output_op)

			create l_data_input_op.make_with_long_form ("data-input")
			l_data_input_op.set_description ("File or directory where input data is available.")
			parser.options.force_last (l_data_input_op)

			create l_data_output_op.make_with_long_form ("data-output")
			l_data_output_op.set_description ("File or directory where output data should be stored.")
			parser.options.force_last (l_data_output_op)

			create l_recursive.make_with_long_form ("recursive")
			l_recursive.set_description ("Process subdirectories recursively.")
			parser.options.force_last (l_recursive)

			create l_max_precondition_tries_op.make_with_long_form ("max-precondition-tries")
			l_max_precondition_tries_op.set_description ("Maximal tries to search for an object combination satisfying precondition of a feature. 0 means that search until an object combination is found.")
			parser.options.force_last (l_max_precondition_tries_op)

			create l_max_precondition_time_op.make_with_long_form ("max-precondition-time")
			l_max_precondition_time_op.set_description ("Maximal time that can be spent in searching for an object combination satisfying precondition of a feature. 0 means that search until an object combination is found.")
			parser.options.force_last (l_max_precondition_time_op)

			create l_candidate_count_option.make_with_long_form ("max-candidates")
			l_candidate_count_option.set_description ("Max number of candidates to search for which satisfy the precondition of the feature to call. 0 means no limit. Only have effect when precondition satisfaction is enabled through %"-p%" option. Default is 1.")
			parser.options.force_last (l_candidate_count_option)

			create l_linear_constraint_solver_option.make_with_long_form ("linear-constraint-solver")
			l_linear_constraint_solver_option.set_description ("Linear constraint solver to be used, can be either %"smt%", %"lpsolve%" or %"off%". Only have effect when precondition satisfaction is enabled through %"-p%" option. Default is %"lpsolve%".")
			parser.options.force_last (l_linear_constraint_solver_option)

			create l_smart_selection_rate_option.make_with_long_form ("ps-selection-rate")
			l_smart_selection_rate_option.set_description ("Rate under which smart selection of object to satisfy preconditions are used. Value is a number in range [0, 100]. Only have effect when precondition satisfaction is enabled through %"-p%" option. Default: 100.")
			parser.options.force_last (l_smart_selection_rate_option)

			create l_smt_old_value_rate_option.make_with_long_form ("smt-enforce-old-value-rate")
			l_smt_old_value_rate_option.set_description ("Possibility [0-100] to enforce SMT solver to choose an already used value. Default is 25")
			parser.options.force_last (l_smt_old_value_rate_option)

			create l_smt_use_predefined_value_rate_option.make_with_long_form ("smt-use-predefined-value-rate")
			l_smt_use_predefined_value_rate_option.set_description ("Possibility [0-100] to for the SMT solver to choose a predefined value for integers. Default is 25")
			parser.options.force_last (l_smt_use_predefined_value_rate_option)

			create l_integer_bound_option.make_with_long_form ("integer-bounds")
			l_integer_bound_option.set_description ("Lower and upper bounds for integer arguments that are to be solved by a linear constraint solver. In form of %"lower,upper%"")
			parser.options.force_last (l_integer_bound_option)

			create l_use_random_cursor_option.make_with_long_form ("use-random-cursor")
			l_use_random_cursor_option.set_description ("When searching in predicate pool, should random cursor be used? Value can be %"True%" or %"False%". Default is True.")
			parser.options.force_last (l_use_random_cursor_option)

			create l_test_case_serialization_option.make_with_long_form ("serialization")
			l_test_case_serialization_option.set_description ("Enable test case serialization. The value is a string consisting of comma separated keywords: 'passing' or 'failing', indicating passing and failing test cases, respectively, or 'off'. Default: off")
			parser.options.force_last (l_test_case_serialization_option)

			create l_test_case_serialization_file_option.make_with_long_form ("serialization-file")
			l_test_case_serialization_file_option.set_description ("Full path to the serialization file.")
			parser.options.force_last (l_test_case_serialization_file_option)

			create l_test_case_deserialization_option.make_with_long_form ("deserialization")
			l_test_case_deserialization_option.set_description ("Enable test case deserialization. The value is a string consisting of comma separated keywords: 'passing' or 'failing', indicating passing and failing test cases, respectively, or 'off'. Default: off")
			parser.options.force_last (l_test_case_deserialization_option)

			create l_build_behavioral_model_option.make_with_long_form ("build-model")
			l_build_behavioral_model_option.set_description ("Build behavioral model from serialization files. The value is a directory where the models would be saved. This option is only effective when 'deserialization' is present. Default 'auto_test\model'.")
			parser.options.force_last (l_build_behavioral_model_option)

			create l_build_faulty_feature_list_option.make_with_long_form ("build_faulty_feature_list")
			l_build_faulty_feature_list_option.set_description ("Build list of faulty features during model construction.")
			parser.options.force_last (l_build_faulty_feature_list_option)

			create l_deserialization_for_fixing.make_with_long_form ("deserialization-for-fixing")
			l_deserialization_for_fixing.set_description ("Organize the deserialized test cases to favor fixing, i.e. each directory contains failing test cases that reveal the same fault and relevant passing test cases. This option is only effective when 'deserialization' is present.")
			parser.options.force_last (l_deserialization_for_fixing)

			create l_validate_serialization.make_with_long_form ("validating-serialization")
			l_validate_serialization.set_description ("Enable serialization validation during deserialization. Log validities into the file from the argument.")
			parser.options.force_last (l_validate_serialization)

			create l_interpreter_log_enabled.make_with_long_form ("interpreter-log")
			l_interpreter_log_enabled.set_description ("Should messaged from the interpreter be logged? Valid options are: on, off. Default: off.")
			parser.options.force_last (l_interpreter_log_enabled)

			create l_proxy_log_option.make_with_long_form ("proxy-log")
			l_proxy_log_option.set_description ("Proxy-log options. Options consist of comma separated keywords. Valid keywords are: off, passing, failing, invalid, bad, error, type, expr-assign, batch-assign, operand-type, state, precondition, pool-statistics, basic, all. Basic is equal to passing, failing, invalid, bad, error, type, expr-assign, batch-assign. Default: basic")
			parser.options.force_last (l_proxy_log_option)

			create l_console_log_option.make_with_long_form ("console-log")
			l_console_log_option.set_description ("Enable or disable console output. Valid options are: on, off. Default: on")
			parser.options.force_last (l_console_log_option)

			create l_duplicated_test_case_serialization_option.make_with_long_form ("serialize-duplicated-tc")
			l_duplicated_test_case_serialization_option.set_description ("Should duplicated test cases be serialized? Two test cases are duplicated if their operands have the same abstract states. Default: False")
			parser.options.force_last (l_duplicated_test_case_serialization_option)

			create l_post_state_serialization_option.make_with_long_form ("serialize-post-state")
			l_post_state_serialization_option.set_description ("Enable post-state information serialization? Normally only pre-state information is necessary because the test case can be re-executed to observe the post-state. But when post-state information is available, you don't need to re-execute the test case. Default: not enabled")
			parser.options.force_last (l_post_state_serialization_option)

			create l_exclude_option.make_with_long_form ("exclude")
			l_exclude_option.set_description ("Exclude the specidifed features from being tested. Format (feature_name|CLASS_NAME.feature_name)[,(feature_name|CLASS_NAME.feature_name)]+. If only feature_name is specified, any feature with that name (no matter from which class that feature comes, it will not be tested.")
			parser.options.force_last (l_exclude_option)

			create l_collect_interface_related_classes_option.make_with_long_form ("collect-interface")
			l_collect_interface_related_classes_option.set_description ("Collect interface related (non-deferred) classes.")
			parser.options.force_last (l_collect_interface_related_classes_option)

			create l_2times_option.make_with_long_form ("2times")
			l_2times_option.set_description ("Enable features to be tested more often with strength 2 (larger is better). Format (feature_name|CLASS_NAME.feature_name)[,(feature_name|CLASS_NAME.feature_name)]+. If only feature_name is specified, any feature with that name is matched.")
			parser.options.force_last (l_2times_option)

			create l_3times_option.make_with_long_form ("3times")
			l_3times_option.set_description ("Enable features to be tested more often with strength 3 (larger is better). Format (feature_name|CLASS_NAME.feature_name)[,(feature_name|CLASS_NAME.feature_name)]+. If only feature_name is specified, any feature with that name is matched.")
			parser.options.force_last (l_3times_option)

			create l_4times_option.make_with_long_form ("4times")
			l_4times_option.set_description ("Enable features to be tested more often with strength 4 (larger is better). Format (feature_name|CLASS_NAME.feature_name)[,(feature_name|CLASS_NAME.feature_name)]+. If only feature_name is specified, any feature with that name is matched.")
			parser.options.force_last (l_4times_option)

			create l_2times_option.make_with_long_form ("2times")

			create l_5times_option.make_with_long_form ("5times")
			l_5times_option.set_description ("Enable features to be tested more often with strength 5 (larger is better). Format (feature_name|CLASS_NAME.feature_name)[,(feature_name|CLASS_NAME.feature_name)]+. If only feature_name is specified, any feature with that name is matched.")
			parser.options.force_last (l_5times_option)

			create l_6times_option.make_with_long_form ("6times")
			l_6times_option.set_description ("Enable features to be tested more often with strength 6 (larger is better). Format (feature_name|CLASS_NAME.feature_name)[,(feature_name|CLASS_NAME.feature_name)]+. If only feature_name is specified, any feature with that name is matched.")
			parser.options.force_last (l_6times_option)

			create l_7times_option.make_with_long_form ("7times")
			l_7times_option.set_description ("Enable features to be tested more often with strength 7 (larger is better). Format (feature_name|CLASS_NAME.feature_name)[,(feature_name|CLASS_NAME.feature_name)]+. If only feature_name is specified, any feature with that name is matched.")
			parser.options.force_last (l_7times_option)

			create l_8times_option.make_with_long_form ("8times")
			l_8times_option.set_description ("Enable features to be tested more often with strength 8 (larger is better). Format (feature_name|CLASS_NAME.feature_name)[,(feature_name|CLASS_NAME.feature_name)]+. If only feature_name is specified, any feature with that name is matched.")
			parser.options.force_last (l_8times_option)

			create l_9times_option.make_with_long_form ("9times")
			l_9times_option.set_description ("Enable features to be tested more often with strength 9 (larger is better). Format (feature_name|CLASS_NAME.feature_name)[,(feature_name|CLASS_NAME.feature_name)]+. If only feature_name is specified, any feature with that name is matched.")
			parser.options.force_last (l_9times_option)

			create l_freeze_flag.make_with_short_form ('f')
			l_freeze_flag.set_description ("Freeze the target system before testing. Default: False")
			parser.options.force_last (l_freeze_flag)

			create l_agents_option.make_with_long_form ("agents")
			l_agents_option.set_description ("Should features with agent type arguments be processed? Possible options: none, only, all. None means: don't process features of this kind. Only means: discard all but features of this kind. All means: Process all features. Default: all")
			parser.options.force_last (l_agents_option)

			create l_sem_host_option.make_with_long_form ("sem-host")
			l_sem_host_option.set_description ("Setup host name of the semantic database server. Default: localhost")
			parser.options.force_last (l_sem_host_option)

			create l_sem_schema_option.make_with_long_form ("sem-schema")
			l_sem_schema_option.set_description ("Setup schema of the semantic database server. Default: semantic_search")
			parser.options.force_last (l_sem_schema_option)

			create l_sem_user_option.make_with_long_form ("sem-user")
			l_sem_user_option.set_description ("Setup user of the semantic database server. Default: root")
			parser.options.force_last (l_sem_user_option)

			create l_sem_password_option.make_with_long_form ("sem-password")
			l_sem_password_option.set_description ("Setup password of the semantic database server.")
			parser.options.force_last (l_sem_password_option)

			create l_sem_port_option.make_with_long_form ("sem-port")
			l_sem_port_option.set_description ("Setup schema of the semantic database server. Default: 3306")
			parser.options.force_last (l_sem_port_option)

			create l_precondition_reduction_file_option.make_with_long_form ("precondition-reduction")
			l_precondition_reduction_file_option.set_description ("Use precondition reduction strategy. Format: precondition-reduction <file_name>. Where <file_name> specify the file containing pre-state invariant.")
			parser.options.force_last (l_precondition_reduction_file_option)

			create l_pr_check_objects.make_with_long_form ("check-invariant-violating-objects")
			l_pr_check_objects.set_description ("Only check if there are some objects available which violate those given invariants. Do not perform any testing or precondition reductions. Format: --check-invariant-violating-objects --data-output <file>. All invariants with no violating objects are output to <file>.")
			parser.options.force_last (l_pr_check_objects)

			create l_arff_directory_option.make_with_long_form ("arff")
			l_arff_directory_option.set_description ("Specify the location of ARFF files, used by the precondition-reduction strategy to invalidate implications. Format: --arff directory. Directory is the top level directory which stores ARFF files, containing subclasses for particular classes.")
			parser.options.force_last (l_arff_directory_option)

			create l_online_statistics_frequency.make_with_long_form ("online-statistics-frequency")
			l_online_statistics_frequency.set_description ("Specify the frequency of online-statistics output. Format: --online-statistics-frequency <seconds>. <seconds> is the number of seconds. If 0, no online-statistics will be outputed. Default: 0.")
			parser.options.force_last (l_online_statistics_frequency)

			parser.parse_list (a_arguments)

--			if version_option.was_found then
--				error_handler.enable_verbose
--				error_handler.report_version_message
--				error_handler.disable_verbose
--				Exceptions.die (0)
--			end

			if not quiet_option.was_found then
				error_handler.enable_verbose
			end

			if debug_option.was_found then
				is_debugging := True
			end

			just_test := just_test_option.was_found

--			if ecf_target_option.was_found then
--				ecf_target := ecf_target_option.parameter
--			end

			is_manual_testing_enabled := not disable_manual_option.was_found
			is_deep_relevancy_enabled := False -- deep_manual_option.was_found
			is_automatic_testing_enabled := not disable_auto_option.was_found
			is_minimization_enabled := not disable_minimize_option.was_found
--			is_debug_mode_enabled := not finalize_option.was_found

			if benchmark_option.was_found then
				error_handler.enable_benchmarking
			end

			if is_minimization_enabled then
				if minimize_option.was_found then
					if minimize_option.parameter.is_equal ("slice") then
						is_slicing_enabled := True
					elseif minimize_option.parameter.is_equal ("ddmin") then
						is_ddmin_enabled := True
					elseif minimize_option.parameter.is_equal ("slice,ddmin") then
						is_slicing_enabled := True
						is_ddmin_enabled := True
					else
						error_handler.report_invalid_minimization_algorithm (minimize_option.parameter)
						--Exceptions.die (1)

					end
				else
					is_slicing_enabled := True -- Default
				end
			else
				if minimize_option.was_found then
					error_handler.report_cannot_specify_both_disable_minimze_and_minimize
					--Exceptions.die (1)
				end
			end

			if not error_handler.has_error then
				if output_dir_option.was_found then
					output_dirname := output_dir_option.parameter
				end

				if time_out_option.was_found and then time_out_option.parameter >= 0 then
					create time_out.make (0, 0 ,0, 0, time_out_option.parameter, 0)
				else
					create time_out.make (0, 0, 0, 0, default_time_out.as_integer_32, 0)
				end

				if test_count_option.was_found then
					if test_count_option.parameter > 0 then
						test_count := test_count_option.parameter.as_natural_32
					end
				end

				if seed_option.was_found then
					random.set_seed (seed_option.parameter)
				else
					create time.make_now
					random.set_seed (time.milli_second)
				end
				random.start

				if statistics_format_op.was_found then
					if statistics_format_op.parameter.is_equal ("text") then
						is_text_statistics_format_enabled := True
					elseif statistics_format_op.parameter.is_equal ("html") then
						is_html_statistics_format_enabled := True
					else
						error_handler.report_statistics_format_error (statistics_format_op.parameter)
					end
				else
					is_html_statistics_format_enabled := False
					is_text_statistics_format_enabled := False
				end
			end

			 --Must be after output_dirname is set	
			if evolutionary_option.was_found then
				is_evolutionary_enabled := true
			else
				is_evolutionary_enabled := false
			end

			if not error_handler.has_error then
				if proxy_time_out_option.was_found then
					proxy_time_out := proxy_time_out_option.parameter
				end

				if l_log_to_replay.was_found then
					is_replay_enabled := True
					log_to_replay := l_log_to_replay.parameter.twin
				end

				should_display_help_message := l_help_option.was_found
				if should_display_help_message then
					create l_help_flag.make_with_short_form ('h')
					help_message := l_help_flag.full_help_text (parser)
				end
			end

			if not error_handler.has_error then
				if l_load_log_option.was_found then
					is_load_log_enabled := True
					log_file_path := l_load_log_option.parameter

						-- When we are in load log mode, we disable
						-- automatic testing.
					is_automatic_testing_enabled := False
				end
			end

			if not error_handler.has_error then
				if l_state_option.was_found then
					create object_state_config.make_with_string (l_state_option.parameter)
				else
					create object_state_config.make
				end
			end

			if not error_handler.has_error then
				is_precondition_checking_enabled := l_precondition_option.was_found
			end

			if not error_handler.has_error then
				is_object_state_exploration_enabled := l_object_state_exploration.was_found
			end

			if not error_handler.has_error then
				if l_log_processor_op.was_found then
					log_processor := l_log_processor_op.parameter
				end
			end

			if not error_handler.has_error then
				if l_log_processor_output_op.was_found then
					log_processor_output := l_log_processor_output_op.parameter
				end
			end

			if not error_handler.has_error then
				if l_data_input_op.was_found then
					data_input := l_data_input_op.parameter
				end
			end

			if not error_handler.has_error then
				if l_data_output_op.was_found then
					data_output := l_data_output_op.parameter
				end
			end

			if not error_handler.has_error then
				if l_recursive.was_found then
					is_recursive := True
				end
			end

--			if not error_handler.has_error then
--				if l_deserialization.was_found then
--					is_deserializing := True
--				else
--					is_deserializing := False
--				end
--			end

			if not error_handler.has_error then
				if l_max_precondition_tries_op.was_found then
					max_precondition_search_tries := l_max_precondition_tries_op.parameter
				end
			end

			if not error_handler.has_error then
				is_seed_provided := seed_option.was_found
				if is_seed_provided then
					seed := seed_option.parameter
				end
			end

			if not error_handler.has_error then
				if l_max_precondition_time_op.was_found then
					max_precondition_search_time := l_max_precondition_time_op.parameter
				end
			end

			if not error_handler.has_error then
				if l_candidate_count_option.was_found then
					max_candidate_count := l_candidate_count_option.parameter
				else
					max_candidate_count := 1
				end
			end

			if not error_handler.has_error then
				is_smt_linear_constraint_solver_enabled := False
				is_lpsolve_contraint_linear_solver_enabled := False
				if l_linear_constraint_solver_option.was_found then
					if l_precondition_option.was_found then
						l_strs := l_linear_constraint_solver_option.parameter.as_lower.split (',')
						l_strs.compare_objects
						if l_strs.has ("smt") then
							is_smt_linear_constraint_solver_enabled := True
						end
						if l_strs.has ("lpsolve") then
							is_lpsolve_contraint_linear_solver_enabled := True
						end
					end
				else
					if l_precondition_option.was_found then
						is_lpsolve_contraint_linear_solver_enabled := True
					end
				end
			end

			if not error_handler.has_error then
				if l_smart_selection_rate_option.was_found then
					object_selection_for_precondition_satisfaction_rate := l_smart_selection_rate_option.parameter
				else
					object_selection_for_precondition_satisfaction_rate := 70
				end
			end

			if not error_handler.has_error then
				if l_smt_old_value_rate_option.was_found then
					smt_enforce_old_value_rate := l_smt_old_value_rate_option.parameter
				else
					smt_enforce_old_value_rate := 25
				end
			end

			if not error_handler.has_error then
				if l_smt_use_predefined_value_rate_option.was_found then
					smt_use_predefined_value_rate := l_smt_use_predefined_value_rate_option.parameter
				else
					smt_use_predefined_value_rate := 25
				end
			end

			if not error_handler.has_error then
				if l_integer_bound_option.was_found then
					l_strs := l_integer_bound_option.parameter.split (',')
					integer_lower_bound := l_strs.first.to_integer
					integer_upper_bound := l_strs.last.to_integer
				else
					integer_lower_bound := {INTEGER}.min_value
					integer_upper_bound := {INTEGER}.max_value
				end
			end

			if not error_handler.has_error then
				if l_use_random_cursor_option.was_found then
					is_random_cursor_used := l_use_random_cursor_option.parameter.to_boolean
				else
					is_random_cursor_used := True
				end
			end

			if not error_handler.has_error then
				is_passing_test_cases_serialization_enabled := False
				is_failing_test_cases_serialization_enabled := False
				if l_test_case_serialization_option.was_found then
					l_strs := l_test_case_serialization_option.parameter.as_lower.split (',')
					from
						l_strs.start
					until
						l_strs.after
					loop
						if l_strs.item_for_iteration.is_equal ("passing") then
							is_passing_test_cases_serialization_enabled := True
						elseif l_strs.item_for_iteration.is_equal ("failing") then
							is_failing_test_cases_serialization_enabled := True
						end
						l_strs.forth
					end
				end
				if l_test_case_serialization_file_option.was_found then
					test_case_serialization_file := l_test_case_serialization_file_option.parameter

--					l_is_ok := False
--					create l_file_name.make_from_string (test_case_serialization_file)
--					if l_file_name.is_valid then
--						create l_text_output.make (l_file_name)
--						l_text_output.recursive_open_write
--						if l_text_output.is_open_write then
--							l_text_output.close
--						end
--						if l_text_output.exists then
--							l_is_ok := True
--						end
--					end

					prepare_directory_for_output (test_case_serialization_file)
					if not was_last_directory_ready_for_output then
						error_handler.report_cannot_write_error (test_case_serialization_file)
					end
				end
			end

			if not error_handler.has_error then
				is_passing_test_cases_deserialization_enabled := False
				is_failing_test_cases_deserialization_enabled := False
				if l_test_case_deserialization_option.was_found then
					l_strs := l_test_case_deserialization_option.parameter.as_lower.split (',')
					from
						l_strs.start
					until
						l_strs.after
					loop
						if l_strs.item_for_iteration.is_equal ("passing") then
							is_passing_test_cases_deserialization_enabled := True
						elseif l_strs.item_for_iteration.is_equal ("failing") then
							is_failing_test_cases_deserialization_enabled := True
						end
						l_strs.forth
					end

				end
			end

			if not error_handler.has_error then
				if l_build_behavioral_model_option.was_found then
						-- Check if the parameter designates a valid directory.
					create l_file_name.make_from_string (l_build_behavioral_model_option.parameter)
					if l_file_name.is_valid then
						is_building_behavioral_model := True
						model_dir := l_file_name
					else
						error_handler.report_cannot_write_error (l_file_name)
					end
				end

				if l_build_faulty_feature_list_option.was_found then
					create l_file_name.make_from_string (l_build_faulty_feature_list_option.parameter)
					if l_file_name.is_valid then
						is_building_faulty_feature_list := True
						faulty_feature_list_file_name := l_file_name
					else
						error_handler.report_cannot_write_error (l_file_name)
					end
				end

				is_deserializing_for_fixing := l_deserialization_for_fixing.was_found
			end

			if not error_handler.has_error then
				if l_validate_serialization.was_found then
						-- Check if the parameter designates a valid directory.
					create l_file_name.make_from_string (l_validate_serialization.parameter)
					if l_file_name.is_valid then
						serialization_validity_log := l_file_name
					else
						error_handler.report_cannot_write_error (l_file_name)
					end
				end
			end

			if not error_handler.has_error then
				is_interpreter_log_enabled := False
				if l_interpreter_log_enabled.was_found then
					is_interpreter_log_enabled := l_interpreter_log_enabled.parameter.is_case_insensitive_equal ("on")
				end
			end

			if not error_handler.has_error then
				is_console_log_enabled := True
				if l_console_log_option.was_found then
					is_console_log_enabled := l_console_log_option.parameter.is_case_insensitive_equal ("on")
				end
			end

			if not error_handler.has_error then
				l_log_has_basic := False
				if l_proxy_log_option.was_found then
					l_strs := l_proxy_log_option.parameter.as_lower.split (',')
					from
						l_strs.start
					until
						l_strs.after
					loop
						l_word := l_strs.item_for_iteration
						if l_word.is_equal ("off") then
							-- Do nothing.
						elseif l_word.is_case_insensitive_equal ("passing") then
							log_types.put (True, "passing")
						elseif l_word.is_case_insensitive_equal ("failing") then
							log_types.put (True, "failing")
						elseif l_word.is_case_insensitive_equal ("invalid") then
							log_types.put (True, "invalid")
						elseif l_word.is_case_insensitive_equal ("bad") then
							log_types.put (True, "bad")
						elseif l_word.is_case_insensitive_equal ("error") then
							log_types.put (True, "error")
						elseif l_word.is_case_insensitive_equal ("state") then
							log_types.put (True, "state")
						elseif l_word.is_case_insensitive_equal ("operand-type") then
							log_types.put (True, "operand-type")
						elseif l_word.is_case_insensitive_equal ("expr-assign") then
							log_types.put (True, "expr-assign")
						elseif l_word.is_case_insensitive_equal ("type") then
							log_types.put (True, "type")
						elseif l_word.is_case_insensitive_equal ("precondition") then
							log_types.put (True, "precondition")
						elseif l_word.is_case_insensitive_equal ("statistics") then
							log_types.put (True, "statistics")
						elseif l_word.is_case_insensitive_equal ("batch-assign") then
							log_types.put (True, "batch-assign")
						elseif l_word.is_case_insensitive_equal ("basic") then
							l_log_has_basic := True
						elseif l_word.is_case_insensitive_equal ("all") then
							log_types.put (True, "passing")
							log_types.put (True, "failing")
							log_types.put (True, "invalid")
							log_types.put (True, "bad")
							log_types.put (True, "error")
							log_types.put (True, "state")
							log_types.put (True, "operand-type")
							log_types.put (True, "expr-assign")
							log_types.put (True, "type")
							log_types.put (True, "precondition")
							log_types.put (True, "statistics")
							log_types.put (True, "batch-assign")
						end
						l_strs.forth
					end
				end
				if not l_proxy_log_option.was_found or l_log_has_basic then
					log_types.put (True, "passing")
					log_types.put (True, "failing")
					log_types.put (True, "invalid")
					log_types.put (True, "bad")
					log_types.put (True, "error")
					log_types.put (True, "expr-assign")
					log_types.put (True, "batch-assign")
					log_types.put (True, "type")
				end
			end

			if not error_handler.has_error then
				is_duplicated_test_case_serialized := l_duplicated_test_case_serialization_option.was_found
			end

			if not error_handler.has_error then
				is_post_state_serialized := l_post_state_serialization_option.was_found
			end

			create excluded_features.make
			if not error_handler.has_error and then l_exclude_option.was_found then
				setup_excluded_features (l_exclude_option.parameter)
			end

			if not error_handler.has_error then
				is_collecting_interface_related_classes := l_collect_interface_related_classes_option.was_found
			end

			create popular_features.make
			if not error_handler.has_error and then l_2times_option.was_found then
				setup_popular_features (l_2times_option.parameter, 2)
			end

			if not error_handler.has_error and then l_3times_option.was_found then
				setup_popular_features (l_3times_option.parameter, 3)
			end

			if not error_handler.has_error and then l_4times_option.was_found then
				setup_popular_features (l_4times_option.parameter, 4)
			end

			if not error_handler.has_error and then l_5times_option.was_found then
				setup_popular_features (l_5times_option.parameter, 5)
			end

			if not error_handler.has_error and then l_6times_option.was_found then
				setup_popular_features (l_6times_option.parameter, 6)
			end

			if not error_handler.has_error and then l_7times_option.was_found then
				setup_popular_features (l_7times_option.parameter, 7)
			end

			if not error_handler.has_error and then l_8times_option.was_found then
				setup_popular_features (l_8times_option.parameter, 8)
			end

			if not error_handler.has_error and then l_9times_option.was_found then
				setup_popular_features (l_9times_option.parameter, 9)
			end

			if not error_handler.has_error and then l_freeze_flag.was_found then
				should_freeze_before_testing := True
			end

			is_executing_agent_features_enabled := True
			is_executing_normal_features_enabled := True

			if not error_handler.has_error and then l_agents_option.was_found then
				if l_agents_option.parameter ~ "only" then
					is_executing_normal_features_enabled := False
				elseif l_agents_option.parameter ~ "none" then
					is_executing_agent_features_enabled := False
				elseif l_agents_option.parameter ~ "all" then
					-- Do nothing
				else
					error_handler.report_statistics_format_error (l_agents_option.parameter)
				end
			end

			if l_sem_host_option.was_found then
				if semantic_data_base_config = Void then
					create semantic_data_base_config.make
				end
				semantic_data_base_config.set_host (l_sem_host_option.parameter)
			end

			if l_sem_schema_option.was_found then
				if semantic_data_base_config = Void then
					create semantic_data_base_config.make
				end
				semantic_data_base_config.set_schema (l_sem_schema_option.parameter)
			end

			if l_sem_user_option.was_found then
				if semantic_data_base_config = Void then
					create semantic_data_base_config.make
				end
				semantic_data_base_config.set_user (l_sem_user_option.parameter)
			end

			if l_sem_password_option.was_found then
				if semantic_data_base_config = Void then
					create semantic_data_base_config.make
				end
				semantic_data_base_config.set_password (l_sem_password_option.parameter)
			end

			if l_sem_port_option.was_found then
				if semantic_data_base_config = Void then
					create semantic_data_base_config.make
				end
				semantic_data_base_config.set_port (l_sem_port_option.parameter)
			end

			if l_precondition_reduction_file_option.was_found then
				precondition_reduction_file := l_precondition_reduction_file_option.parameter.twin
				is_automatic_testing_enabled := False
			end

			if semantic_data_base_config = Void then
				create semantic_data_base_config.make
			end

			if l_pr_check_objects.was_found then
				should_check_invariant_violating_objects := True
			end

			if l_arff_directory_option.was_found then
				arff_directory := l_arff_directory_option.parameter.twin
			end

			if l_online_statistics_frequency.was_found then
				online_statistics_frequency := l_online_statistics_frequency.parameter
			else
				online_statistics_frequency := 0
			end

--			if parser.parameters.count = 0 then
--				error_handler.report_missing_ecf_filename_error
--				-- TODO: Display usage_instruction (currently not exported, find better way to do it.)
--				-- error_handler.report_info_message (parser.help_option.usage_instruction (parser))
--				Exceptions.die (1)
--			else
--				ecf_filename := parser.parameters.first
				class_names := parser.parameters.twin
--				create {DS_ARRAYED_LIST []} class_names.make
--				from
--					cs := parser.parameters.new_cursor
--					cs.start
----					cs.forth
--				until
--					cs.off
--				loop
--					class_names.force_last (cs.item)
--					cs.forth
--				end
--			end
		ensure
			help_message_set_when_required: should_display_help_message implies help_message /= Void
		end

	setup_popular_features (a_features: STRING; a_strength: INTEGER)
			-- Setup `a_features' to have `a_strength' of popularity to be tested.
		local
			l_strs: LIST [STRING]
			l_strs2: LIST [STRING]
		do
			l_strs := a_features.split (',')
			from
				l_strs.start
			until
				l_strs.after
			loop
				l_strs2 := l_strs.item_for_iteration.split ('.')

				if l_strs2.count = 2 then
					popular_features.extend ([l_strs2.first.as_upper, l_strs2.last.as_lower, a_strength])
				elseif l_strs2.count = 1 then
					popular_features.extend (["", l_strs2.first.as_lower, a_strength])
				end
				l_strs.forth
			end
		end

	setup_excluded_features (a_features: STRING)
			-- Setup `a_features' to be excluded.
		local
			l_strs: LIST [STRING]
			l_strs2: LIST [STRING]
		do
			l_strs := a_features.split (',')
			from
				l_strs.start
			until
				l_strs.after
			loop
				l_strs2 := l_strs.item_for_iteration.split ('.')

				if l_strs2.count = 2 then
					excluded_features.extend ([l_strs2.first.as_upper, l_strs2.last.as_lower])
				elseif l_strs2.count = 1 then
					excluded_features.extend (["", l_strs2.first.as_lower])
				end
				l_strs.forth
			end
		end

feature -- Status report

	output_dirname: STRING
			-- Name of output directory

	ecf_filename: STRING
			-- Name of ecf file of input system

--	ecf_target: STRING
--			-- Name of target in file named `ecf_filename'; Void if no target was specified.

	class_names: DS_LIST [STRING]
			-- List of class names to be tested

	time_out: DT_DATE_TIME_DURATION
			-- Maximal time to test;
			-- A timeout value of `0' means no time out.

	test_count: NATURAL
			-- Maximum number of tests to be executed
			--
			-- Note: a value of `0' means no upper limit

--	is_debug_mode_enabled: BOOLEAN
			-- Should the interpreter runtime be compiled with
			-- assertion checking on?

	just_test: BOOLEAN
			-- Should generation and compilation of the interpreter be skipped

	is_deep_relevancy_enabled: BOOLEAN
			-- Should the manual testing strategy use deep dependence
			-- checking when locating relevant manual unit tests?

	is_manual_testing_enabled: BOOLEAN
			-- Should the manual testing strategy be used?

	is_automatic_testing_enabled: BOOLEAN
			-- Should the automatic testing strategy be used?

	is_evolutionary_enabled: BOOLEAN
			-- Should use evolutionary algorithm	

	is_minimization_enabled: BOOLEAN
			-- Should bug reproducing examples be minimized?

	is_text_statistics_format_enabled: BOOLEAN
			-- Should statistics be output as plain text?

	is_html_statistics_format_enabled: BOOLEAN
			-- Should statistics be output static HTML?

	is_executing_agent_features_enabled: BOOLEAN
			-- Should features with agent type arguments be used for test cases?

	is_executing_normal_features_enabled: BOOLEAN
			-- Should features without arguments of agent type be used for test cases?

	is_slicing_enabled: BOOLEAN
			-- Should test cases be minimized via slicing?

	is_ddmin_enabled: BOOLEAN
			-- Should test cases be minimized via ddmin?

	proxy_time_out: INTEGER
			-- Proxy time out in second

	is_replay_enabled: BOOLEAN
			-- Is log replay specified?

	log_to_replay: STRING
			-- File name of the log to be replayed.

	should_display_help_message: BOOLEAN
			-- Should help message be displayed?

	help_message: STRING
			-- Help message for command line arguments
			-- This value is only set if help option presents.

	is_debugging: BOOLEAN
			-- True if debugging output should be written to log.

	is_debug_mode_enabled: BOOLEAN
			-- Should the interpreter runtime be compiled with
			-- assertion checking on?

	log_file_path: detachable STRING
			-- Full path of the log file to be loaded.

	is_load_log_enabled: BOOLEAN
			-- Is log load enabled?

	object_state_config: AUT_OBJECT_STATE_CONFIG
			-- Configuration related object state retrieval

	is_precondition_checking_enabled: BOOLEAN
			-- Should precondition evaluation be enabled?

	is_object_state_exploration_enabled: BOOLEAN
			-- Is object state exploration enabled?

	log_processor: detachable STRING
			-- Name of the log processor

	log_processor_output: detachable STRING
			-- Name of the output file from log processor

--	is_deserializing: BOOLEAN
--			-- Is the task to deserialize the testing history into test cases?

	data_input: detachable STRING
			-- File or directory where the input data is available.

	data_output: detachable STRING
			-- File or directory where the output data should be stored.

	is_recursive: BOOLEAN
			-- Is each subdirectory of the input directory processed recursively?

	max_precondition_search_tries: INTEGER
			-- Max tries in the search to satisfy precondition of a feature
			-- 0 means that search until a satisfying object comibination is found.

	max_precondition_search_time: INTEGER
			-- Maximal time (in second) that can be spent in searching for
			-- objects satisfying precondition of a feature

	is_seed_provided: BOOLEAN
			-- Is seed to the random number generator provided?

	seed: INTEGER
			-- Provided seed
			-- Only have effect if `is_seed_provided' is True.

	max_candidate_count: INTEGER
			-- Max number of candidates that satisfy the precondition of
			-- the feature to call.
			-- 0 means no limit. Default is 100.

	is_smt_linear_constraint_solver_enabled: BOOLEAN
			-- Is SMT based linear constraint solver enabled?
			-- Default: False

	is_lpsolve_contraint_linear_solver_enabled: BOOLEAN
			-- Is lp_solve based linear constraint solver enabled?
			-- Default: True

	object_selection_for_precondition_satisfaction_rate: INTEGER
			-- Possibility [0-100] under which smart object selection for precondition satisfaction
			-- is used.
			-- Only have effect when precondition evaluation is enabled.
			-- Default: 70.

	smt_enforce_old_value_rate: INTEGER
			-- Possibility [0-100] to enforce SMT solver to choose an already used value
			-- Default is 25

	smt_use_predefined_value_rate: INTEGER
			-- Possibility [0-100] to for the SMT solver to choose a predefined value for integers
			-- Default is 25

	integer_lower_bound: INTEGER
			-- Lower bound (min value) for integer arguments that are to be solved by a linear constraint solver
			-- Default is -512.

	integer_upper_bound: INTEGER
			-- Upper bound (max value) for integer arguments that are to be solved by a linear constraint solver
			-- Default is 512.

	is_random_cursor_used: BOOLEAN
			-- When searching in predicate pool, should random cursor be used?
			-- Default: False

	is_passing_test_cases_serialization_enabled: BOOLEAN
			-- Is test case serialization for passing test cases enabled?
			-- Only has effect if `is_test_case_serialization_enabled' is True.
			-- Default: False

	is_failing_test_cases_serialization_enabled: BOOLEAN
			-- Is test case serialization for failing test cases enabled?
			-- Only has effect if `is_test_case_serialization_enabled' is True.
			-- Default: False

	test_case_serialization_file: STRING
			-- Full path to the serialization file.

	is_passing_test_cases_deserialization_enabled: BOOLEAN
			-- Is test case deserialization for passing test cases enabled?

	is_failing_test_cases_deserialization_enabled: BOOLEAN
			-- Is test case deserialization for failing test cases enabled?

	is_building_behavioral_model: BOOLEAN
			-- Is AutoTest building behavioral models from serialization files?

	is_building_faulty_feature_list: BOOLEAN
			-- Is AutoTest building faulty feature list file?

	is_deserializing_for_fixing: BOOLEAN
			-- Is AutoTest deserializing test cases to favor fixing?
			-- When True, test cases are grouped by faults; otherwise, by routine under test.

	serialization_validity_log: FILE_NAME
			-- External storage to log the validation states.
			-- Multiple deserialization sessions may be necessary to generate test cases.

	model_dir: FILE_NAME
			-- Directory to save the behavioral models.

	faulty_feature_list_file_name: FILE_NAME
			-- File name of the faulty feature list.

	is_interpreter_log_enabled: BOOLEAN
			-- Is the messages from the interpreter logged?
			-- Default: False

	is_console_log_enabled: BOOLEAN
			-- Should console output be enabled?
			-- Default: True

	is_duplicated_test_case_serialized: BOOLEAN
			-- Should duplicated test cases be serialized?
			-- Two test cases are duplicated if their operands have the same abstract states.
			-- Default: False

	log_types: HASH_TABLE [BOOLEAN, STRING]
			-- Types of messages that are to be logged
			-- Key is the type name, value indicates if messages of that type should be logged.
		do
			if log_types_internal = Void then
				create log_types_internal.make (10)
				log_types_internal.compare_objects
			end
			Result := log_types_internal
		end

	log_types_internal: like log_types
			-- Cache for `log_types'

	is_post_state_serialized: BOOLEAN
			-- Should post-state information be serialized?
			-- Default: False

	excluded_features: LINKED_LIST [TUPLE [class_name: STRING; feature_name: STRING]]
			-- List of features that are excluded from being tested.


	popular_features: LINKED_LIST [TUPLE [class_name: STRING; feature_name: STRING; level: INTEGER]]
			-- List of features that should be tested more often

	is_collecting_interface_related_classes: BOOLEAN
			-- Is this AutoTest session for collecting interface related classes?

	should_freeze_before_testing: BOOLEAN
			-- Should the target system be freezed before testing?
			-- Default: False

	semantic_data_base_config: AUT_SEMANTIC_DATABASE_CONFIG
			-- Config for semantic database

	precondition_reduction_file: STRING
			-- File containing pre-state invariants

	is_precondition_reduction_enabled: BOOLEAN
			-- Is precondition-reduction enabled?
		do
			Result := precondition_reduction_file /= Void
		end

	should_check_invariant_violating_objects: BOOLEAN
			-- Should we check invariant-violating objects,
			-- instead of performing precondition reduction?

	arff_directory: detachable STRING
			-- The directory storing ARFF files, needed
			-- by the precnodition-reduction strategy to
			-- invalidcate inferred implications.

	online_statistics_frequency: INTEGER
			-- Number of seconds for the online-statistics to be outputed once.
			-- If 0, no online-statistics is outputed.
			-- Default: 0

feature{NONE} -- Implementation

	prepare_directory_for_output (a_path: STRING)
			-- Prepare the parent directory of 'a_path' for writing.
		require
			path_not_empty: a_path /= Void and then not a_path.is_empty
		local
			l_file_name: FILE_NAME
			l_dir_str: STRING
			l_dir: DIRECTORY
		do
			was_last_directory_ready_for_output := False

			create l_file_name.make_from_string (a_path)
			if l_file_name.is_valid then
				l_dir_str := File_system.dirname (a_path)
				if l_file_name.is_directory_name_valid (l_dir_str) then
					create l_dir.make (l_dir_str)
					if not l_dir.exists then
						l_dir.recursive_create_dir
					end
					if l_dir.exists then
						was_last_directory_ready_for_output := True
					end
				end
			end
		end

	was_last_directory_ready_for_output: BOOLEAN
			-- Was last call to 'prepare_directory_for_output' successful?

feature {NONE} -- Constants

	default_time_out: NATURAL = 5
			-- Default value for `time_out' in minutes

invariant
	minimization_is_either_slicing_or_ddmin: is_minimization_enabled implies (is_slicing_enabled xor is_ddmin_enabled)

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
