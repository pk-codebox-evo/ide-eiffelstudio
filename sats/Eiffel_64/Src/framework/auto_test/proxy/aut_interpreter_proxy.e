note
	description:

		"Proxy for Erl-G interpreters"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_INTERPRETER_PROXY

inherit
	AUT_PROXY_EVENT_PRODUCER
		rename
			make as make_event_producer
		end

	AUT_RESPONSE_PARSER
		rename
			make as make_response_parser
		redefine
			parse_response
		end

	PROCESS_FACTORY
		export {NONE} all end

	DT_SHARED_SYSTEM_CLOCK
		export {NONE} all end

	DT_SHARED_SYSTEM_CLOCK
		export {NONE} all end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	KL_SHARED_EXECUTION_ENVIRONMENT
		export {NONE} all end

	KL_SHARED_OPERATING_SYSTEM
		export {NONE} all end

	UNIX_SIGNALS
		export {NONE} all end

	EXECUTION_ENVIRONMENT
		rename
			system as execution_system
		export
			{NONE} all
		end

	AUT_SHARED_INTERPRETER_INFO

	EXCEPTIONS
		rename
			ignore as exc_ignore,
			catch as exc_catch,
			meaning as exc_meaning
		end

	COMPILER_EXPORTER

	AUT_SHARED_CONSTANTS

	AUT_OBJECT_STATE_REQUEST_UTILITY

	AUT_SHARED_PREDICATE_CONTEXT
		undefine
			system
		end

	AUT_SHARED_RANDOM

	AUT_SHARED_TYPE_FORMATTER

create
	make

feature {NONE} -- Initialization

	make (an_executable_file_name: STRING;
			a_system: like system;
			an_interpreter_log_filename: STRING;
			a_proxy_log_filename: STRING;
			a_error_handler: like error_handler;
			a_config: like configuration)
			-- Create a new proxy for the interpreter found at `an_executable_file_name'.
		require
			an_executable_file_name_not_void: an_executable_file_name /= Void
			a_system_not_void: a_system /= Void
			an_interpreter_log_filename_not_void: an_interpreter_log_filename /= Void
			a_proxy_log_filename_not_void: a_proxy_log_filename /= Void
			a_error_handler_not_void: a_error_handler /= Void
			interpreter_root_class_attached: interpreter_root_class /= Void
		local
			l_itp_class: like interpreter_class
		do
			configuration := a_config

			make_event_producer

			l_itp_class := interpreter_class
			create variable_table.make (a_system)
			create raw_response_analyzer
			make_response_parser (a_system)

				-- You can only do this after the compilation of the interpreter.
			injected_feature_body_id := l_itp_class.feature_named (feature_name_for_byte_code_injection).real_body_id (l_itp_class.types.first)
			injected_feature_pattern_id := l_itp_class.feature_named (feature_name_for_byte_code_injection).real_pattern_id (l_itp_class.types.first)

				-- Setup request printers.
			create socket_data_printer.make (system, variable_table)
			create log_stream.make_empty

				-- We have two printers here because one printer will print byte-code into an IPC socket,
				-- but we also want the test cases to be readable, so we use a text printer to print those
				-- test cases into plain text.
			create request_printer.make
			request_printer.extend (create {AUT_REQUEST_TEXT_PRINTER}.make (system, log_stream, configuration))
			request_printer.extend (create {AUT_CONSOLE_REQUEST_PRINTER})
			request_printer.extend (socket_data_printer)

				-- Ilinca, "number of faults law" experiment
			create failure_log_stream.make_empty
			create failure_request_printer.make (system, failure_log_stream, configuration)

			executable_file_name := an_executable_file_name
			melt_path := file_system.dirname (executable_file_name)
			interpreter_log_filename := an_interpreter_log_filename
			create proxy_log_file.make (a_proxy_log_filename)
			proxy_log_file.open_write

				-- Ilinca, "number of faults law" experiment
			create proxy_failure_log_file.make (a_proxy_log_filename + "_failures_only")
			proxy_failure_log_file.open_write

			create response_printer.make_with_prefix (proxy_log_file, interpreter_log_prefix)
			set_is_logging_enabled (True)
			set_is_speed_logging_enabled (True)
			set_is_test_case_index_logging_enabled (True)
			log_types_under_test

				-- Ilinca, "number of faults law" experiment
			create failure_response_printer.make_with_prefix (proxy_failure_log_file, interpreter_log_prefix)

			log_line ("-- A new proxy has been created.")
			proxy_start_time := system_clock.date_time_now
			error_handler := a_error_handler
			timeout := default_timeout

			if configuration.is_object_state_exploration_enabled then
				create object_state_table.make
			end
		ensure
			executable_file_name_set: executable_file_name = an_executable_file_name
			system_set: system = a_system
			proxy_log_file_created: proxy_log_file /= Void
			error_handler_set: error_handler = a_error_handler
			timeout_set: timeout = default_timeout
			is_logging_enabled: is_logging_enabled
			configuration_set: configuration = a_config
		end

feature -- Status

	is_ready: BOOLEAN
			-- Is client ready for new commands?

	is_running: BOOLEAN
			-- Is the client currently running?
		do
			Result := process /= Void and then process.is_running
		ensure
			result_implies_attached: Result implies process /= Void
			result_implies_running: Result implies process.is_running
		end

	is_launched: BOOLEAN
			-- Has the client been launched?
			-- Note that `is_launched' will be True also when the child has
			-- terminated in the meanwhile.
		do
			Result := process /= Void and then process.is_launched
		ensure
			result_implies_attached: Result implies process /= Void
			result_implies_launched: Result implies process.is_launched
		end

	is_executing: BOOLEAN = True
			-- <Precursor>
			--
			-- Note: `Current' always sends request to an interpreter.

	is_replaying: BOOLEAN
			-- Is Current in replay mode?
			-- If so, no extra "type" request will be generated
			-- after every "assign" request and every query invokation.
			-- Default: False

	is_logging_enabled: BOOLEAN
			-- Should inter-process communication between the proxy and the interpreter
			-- be logged into a file?
			-- Default: True

	is_test_case_index_logging_enabled: BOOLEAN
			-- Should `test_case_index' be logged?

feature -- Access

	timeout: INTEGER
			-- Client timeout in seconds

	last_request: AUT_REQUEST
			-- Last request sent via this proxy

	variable_table: AUT_VARIABLE_TABLE
			-- Table for index and types of object in object pool

	proxy_log_filename: STRING
			-- File name of proxy log
		do
			Result := proxy_log_file.name
		ensure
			filename_not_void: Result /= Void
			valid_filename: Result.is_equal (proxy_log_file.name)
		end

	configuration: TEST_GENERATOR_CONF_I
			-- Configuration associated with current AutoTest run

	proxy_failure_log_filename: STRING
			-- File name of proxy failure log
			-- Ilinca, "number of faults law" experiment
		do
			Result := proxy_failure_log_file.name
		ensure
			filename_not_void: Result /= Void
			valid_filename: Result.is_equal (proxy_failure_log_file.name)
		end

feature -- Settings

	set_timeout (a_timeout: INTEGER)
			-- Set `timeout' with `a_timeout'.
		require
			a_timeout_valid: a_timeout > 0
		do
			timeout := a_timeout
		ensure
			timeout_set: timeout = a_timeout
		end

	set_is_logging_enabled (b: BOOLEAN)
			-- Set `is_logging_enabled' with `b'.
		do
			is_logging_enabled := b
		ensure
			is_logging_enabled_set: is_logging_enabled = b
		end

	set_is_in_replay_mode (b: BOOLEAN)
			-- Set `is_in_replay_mode' with `b'.
		do
			is_replaying := b
		ensure
			is_in_replay_mode_set: is_replaying = b
		end

	set_proxy_log_filename (a_filename: like proxy_log_filename)
			-- Make `a_filename' the new proxy filename.
		require
			a_filename_not_void: a_filename /= Void
		do
			if proxy_log_file.is_open_write then
				proxy_log_file.close
			end
			create proxy_log_file.make (a_filename)
			proxy_log_file.open_write
			log_line ("-- An existing proxy has switched to this log file.")
		end

	set_is_test_case_index_logging_enabled (b: BOOLEAN) is
			-- Set `is_test_case_index_logging_enabled' with `b'.
		do
			is_test_case_index_logging_enabled := b
		ensure
			is_test_case_index_logging_enabled_set: is_test_case_index_logging_enabled = b
		end

feature -- Execution

	start
			-- Start the client.
		require
			not_running: not is_running
		local
			l_listener: AUT_SOCKET_LISTENER
		do
			log_time_stamp ("start")
			log_seed
			create {AUT_START_REQUEST} last_request.make (system)
			variable_table.wipe_out

				-- Create socket and start listening on `port'.
			if socket /= Void and then socket.exists and then not socket.is_closed then
				socket.cleanup
			end

--				-- Initialize a new socket for IPC.
--				-- Fixeme: port number is increased every time when we try to launch the interpreter
--				-- It should be possible to reuse port number, but when I tried it, I always got
--				-- socket connection problems. Jason 2008.10.21
--			fixme ("Try to reuse port number.")
--			port := next_port_number
--			create l_socket.make_server_by_port (port)
--			l_socket.set_blocking
--			l_socket.listen (1)

			create l_listener.make
			l_listener.open_new_socket
			if l_listener.is_listening then
				port := l_listener.current_port

					-- Launch interpreter process.			
				launch_process

				if is_running then
						-- Get socket to communicate with interpreter.
--					l_socket.accept
--					fixme ("If interpreter process dies now, current thread will be blocked forever.")
--					(create {EXECUTION_ENVIRONMENT}).sleep (1000000000)
--					socket := l_socket.accepted
					if attached {like socket} l_listener.wait_for_connection (5000) as l_socket then
						socket := l_socket
						process.set_timeout (timeout)
						log_stream.string.wipe_out
--						failure_log_stream.string.wipe_out -- Ilinca, "number of faults law" experiment
						last_request.process (request_printer)
--						last_request.process (failure_request_printer) -- Ilinca, "number of faults law" experiment
						flush_process
						log_line (proxy_has_started_and_connected_message)
						log_line (itp_start_time_message + error_handler.duration_to_now.second_count.out)
--						failure_log (proxy_has_started_and_connected_message + "%N") -- Ilinca, "number of faults law" experiment
--						failure_log (itp_start_time_message + error_handler.duration_to_now.second_count.out + "%N") -- Ilinca, "number of faults law" experiment
--						record_failure_time_stamp -- Ilinca, "number of faults law" experiment
						parse_start_response
						last_request.set_response (last_response)
						if last_response.is_bad then
							log_bad_response
						end
						is_ready := True
					else
						log_line ("-- Error: Interpreter was not able to connect.")
						is_ready := False
--						failure_log ("-- Error: Interpreter was not able to connect.%N")
					end
				else
					is_ready := False
					log_line ("-- Error: Could not start and connect to interpreter.")
				end
			else
				log_line ("-- Error: Could not find available port for listening.")
			end
			if not is_ready then
				stop
			end
		ensure
			last_request_not_void: last_request /= Void
		end

	stop
			-- Close connection to client and terminate it.
			-- If the client is not responsive to a regular shutdown,
			-- its process will be forced to shut down
		require
			is_running: is_launched
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				if process.is_running then

					create {AUT_STOP_REQUEST} last_request.make (system)
					last_request.process (request_printer)
					last_request.process (failure_request_printer) -- Ilinca, "number of faults law" experiment
					flush_process
					parse_stop_response
					last_request.set_response (last_response)
						-- Give the `process' 50 milliseconds to terminate itself
					process.wait_for_exit_with_timeout (50)
					if not process.has_exited then
							-- Force shutdown of `process' because it has not terminated regularly
						log_line ("-- Warning: proxy was not able to terminate interpreter.")
						failure_log ("-- Warning: proxy was not able to terminate interpreter.%N") -- Ilinca, "number of faults law" experiment

							-- Set flag to indicate that the interpreter should be terminated.
							-- When `time_out_checker_thread' sees this flag, it will terminate the interpreter.
						process.terminate
						is_ready := False
						log_line ("-- Warning: proxy forced termination of interpreter.")
						failure_log ("-- Warning: proxy forced termination of interpreter.%N") -- Ilinca, "number of faults law" experiment
					else
						log_line ("-- Proxy has terminated interpreter.")
						failure_log ("-- Proxy has terminated interpreter.%N") -- Ilinca, "number of faults law" experiment
					end
				end
				if socket /= Void then
					cleanup_socket
				end
			end
		ensure
			last_request_not_void: last_request /= Void
		rescue
			l_retried := True
			cleanup_socket
			retry
		end

	create_object (a_receiver: ITP_VARIABLE; a_type: TYPE_A; a_procedure: FEATURE_I; an_argument_list: DS_LINEAR [ITP_EXPRESSION])
			-- Create new object of type `a_type' using creation
			-- procedure `a_feature' and the arguments `an_argument_list'.
			-- Store the created object in variable `a_receiver'.
		require
			is_launched: is_launched
			is_ready: is_ready
			a_receiver_not_void: a_receiver /= Void
			a_type_not_void: a_type /= Void
			a_type_not_expanded: not a_type.is_expanded
			a_procedure_not_void: a_procedure /= Void
			a_procedure_is_not_infix_or_prefix: not a_procedure.is_prefix and then not a_procedure.is_infix
			an_argument_list_doesnt_have_void: not an_argument_list.has (Void)
		local
			normal_response: AUT_NORMAL_RESPONSE
			l_arg_list: DS_LINEAR [ITP_EXPRESSION]
			l_request: AUT_CREATE_OBJECT_REQUEST
			l_var_set: like variable_set
		do
--			log_time_stamp ("exec")
			l_arg_list := an_argument_list
			if l_arg_list = Void then
				create {DS_LINKED_LIST [ITP_EXPRESSION]} l_arg_list.make
			end
			create l_request.make (system, a_receiver, a_type, a_procedure, l_arg_list)

			log_test_case_index (l_request)
			if is_state_recording_enabled then
				l_var_set := variable_set
				retrieve_argument_objects_state (an_argument_list, l_var_set)
				record_object_states (l_var_set)
			end
			last_request := l_request
			last_request.process (request_printer)
			log_time_stamp (test_case_start_tag)
			flush_process
			parse_invoke_response
			log_time_stamp (test_case_end_tag)
			last_request.set_response (last_response)
			if not last_response.is_bad then
--				is_ready := True
				if not last_response.is_error then
					normal_response ?= last_response
					check
						normal_response_not_void: normal_response /= Void
					end
					if not normal_response.has_exception then
						variable_table.define_variable (a_receiver, a_type)
							-- Predicate evaluation.
						evaluate_predicates_after_test_case (create {AUT_FEATURE_OF_TYPE}.make (a_procedure, a_type), a_receiver, an_argument_list, Void)

							-- Ilinca, "number of faults law" experiment
--						failure_log_test_case_index
--						last_request.process (failure_request_printer)
--						failure_log (failure_log_stream.string)
--						failure_log_stream.string.wipe_out
--						last_response.process (failure_response_printer)
--						record_failure_time_stamp

					else -- Ilinca, "number of faults law" experiment
						evaluate_predicates_after_test_case (create {AUT_FEATURE_OF_TYPE}.make (a_procedure, a_type), Void, an_argument_list, Void)
						if not normal_response.exception.is_invariant_violation_on_feature_entry and not normal_response.exception.is_test_invalid then
--							failure_log_test_case_index
--							last_request.process (failure_request_printer)
--							failure_log (failure_log_stream.string)
--							failure_log_stream.string.wipe_out
--							last_response.process (failure_response_printer)
--							record_failure_time_stamp
--							failure_log_speed
						end
					end
				end
			else
				is_ready := False
			end
			stop_process_on_problems (last_response)
			log_speed

				-- Retrieve object states.
			if is_running and then  is_state_recording_enabled then
				l_var_set.wipe_out
				if variable_table.is_variable_defined (a_receiver) then
					retrieve_target_object_state (a_receiver, l_var_set)
				end
				retrieve_argument_objects_state (an_argument_list, l_var_set)
				record_object_states (l_var_set)
			end
		ensure
			last_request_not_void: last_request /= Void
		end

	invoke_feature (a_type: TYPE_A; a_feature: FEATURE_I; a_target: ITP_VARIABLE; an_argument_list: DS_LINEAR [ITP_EXPRESSION])
			-- Invoke feature `a_feature' from `a_type' with arguments `an_argument_list'.
		require
			is_running: is_launched
			is_ready: is_ready
			a_feature_not_void: a_feature /= Void
			a_feature_is_not_infix_or_prefix: not a_feature.is_prefix and then not a_feature.is_infix
			class_has_feature: has_feature (variable_table.variable_type (a_target).associated_class, a_feature)
			a_target_not_void: a_target /= Void
			a_target_defined: variable_table.is_variable_defined (a_target)
			no_void_target: not variable_table.variable_type (a_target).is_none
			an_argument_list_not_void: an_argument_list /= Void
			an_argument_list_doesnt_have_void: not an_argument_list.has (Void)
		local
			l_invoke_request: AUT_INVOKE_FEATURE_REQUEST
			l_feature: FEATURE_I
			l_target_type: TYPE_A
			l_objects: DS_LINEAR [ITP_EXPRESSION]
			l_var_set: like variable_set
			l_object_state: AUT_OBJECT_STATE
			l_normal_response: AUT_NORMAL_RESPONSE
		do
--			log_time_stamp ("exec")
			l_target_type := variable_table.variable_type (a_target)
			l_feature := l_target_type.associated_class.feature_of_rout_id (a_feature.rout_id_set.first)

				-- Adjust feature according to the actual type of `a_target'.
				-- This is needed because of feature renaming. If we don't do this,
				-- in the replay mode, there will be a problem, either because some feature is not found,
				-- or the type of argument are not correct.
			create l_invoke_request.make (system, l_feature.feature_name, a_target, an_argument_list)
			l_invoke_request.set_target_type (l_target_type)
			log_test_case_index (l_invoke_request)

			if is_state_recording_enabled then
				l_var_set := variable_set

				if configuration.is_target_state_retrieved then
					l_var_set.wipe_out
					retrieve_target_object_state (a_target, l_var_set)
					record_object_states (l_var_set)
					if configuration.is_object_state_exploration_enabled and then attached {AUT_OBJECT_STATE_RESPONSE} last_response as l_object_state_response then
						create l_object_state.make (l_object_state_response)
						object_state_table.put_invoked_source_object_state (l_object_state, a_feature, a_type)
					end
				end

				if configuration.is_argument_state_retrieved then
					l_var_set.wipe_out
					retrieve_argument_objects_state (an_argument_list, l_var_set)
					record_object_states (l_var_set)
				end
			end

			last_request := l_invoke_request
			last_request.process (request_printer)
			log_time_stamp (test_case_start_tag)
			flush_process
			parse_invoke_response
			log_time_stamp (test_case_end_tag)
			last_request.set_response (last_response)
			if not last_response.is_bad or last_response.is_error then
--				is_ready := True
					-- Ilinca, "number of faults law" experiment
--				if last_response.is_normal then
--					l_normal_response ?= last_response
--					check
--						l_normal_response_not_void: l_normal_response /= Void
--					end
--					if l_normal_response.exception /= Void and then
--						(not l_normal_response.exception.is_invariant_violation_on_feature_entry and not l_normal_response.exception.is_test_invalid) then
--							failure_log_test_case_index
--							last_request.process (failure_request_printer)
--							failure_log (failure_log_stream.string)
--							failure_log_stream.string.wipe_out
--							last_response.process (failure_response_printer)
--							record_failure_time_stamp
----							failure_log_speed
--						end
--				end
			else
				is_ready := False
			end
			stop_process_on_problems (last_response)
			log_speed

				-- Precondition evaluation.
			evaluate_predicates_after_test_case (create {AUT_FEATURE_OF_TYPE}.make (a_feature, a_type), a_target, an_argument_list, Void)

				-- Object state retrieval.
			if is_running and then is_state_recording_enabled then
				l_var_set.wipe_out
				retrieve_target_object_state (a_target, l_var_set)
				retrieve_argument_objects_state (an_argument_list, l_var_set)
				record_object_states (l_var_set)
			end
		ensure
			last_request_not_void: last_request /= Void
		end

	invoke_and_assign_feature (a_receiver: ITP_VARIABLE; a_type: TYPE_A; a_query: FEATURE_I; a_target: ITP_VARIABLE; an_argument_list: DS_LINEAR [ITP_EXPRESSION])
			-- Invoke query `a_query' from `a_type' with arguments `an_argument_list'.
			-- Store result in variable `a_receiver'.
		require
			is_running: is_launched
			is_ready: is_ready
			a_receiver_not_void: a_receiver /= Void
			a_query_not_void: a_query /= Void
			a_query_is_not_infix_or_prefix: not a_query.is_prefix and then not a_query.is_infix
			class_has_query: has_feature (variable_table.variable_type (a_target).associated_class, a_query)
			a_target_not_void: a_target /= Void
			a_target_defined: variable_table.is_variable_defined (a_target)
			no_void_target: not variable_table.variable_type (a_target).is_none
			an_argument_list_not_void: an_argument_list /= Void
			an_argument_list_doesnt_have_void: not an_argument_list.has (Void)
		local
			normal_response: AUT_NORMAL_RESPONSE
			l_invoke_request: AUT_INVOKE_FEATURE_REQUEST
			l_var_set: like variable_set
			l_object_state: AUT_OBJECT_STATE
		do
--			log_time_stamp ("exec")
			create l_invoke_request.make_assign (system, a_receiver, a_query.feature_name, a_target, an_argument_list)
			l_invoke_request.set_target_type (a_type)
			log_test_case_index (l_invoke_request)

			if is_state_recording_enabled then
				l_var_set := variable_set

				if configuration.is_target_state_retrieved then
					l_var_set.wipe_out
					retrieve_target_object_state (a_target, l_var_set)
					record_object_states (l_var_set)
					if configuration.is_object_state_exploration_enabled and then attached {AUT_OBJECT_STATE_RESPONSE} last_response as l_object_state_response then
						create l_object_state.make (l_object_state_response)
						object_state_table.put_invoked_source_object_state (l_object_state, a_query, a_type)
					end
				end

				if configuration.is_argument_state_retrieved then
					l_var_set.wipe_out
					retrieve_argument_objects_state (an_argument_list, l_var_set)
					record_object_states (l_var_set)
				end
			end

			last_request := l_invoke_request
			last_request.process (request_printer)
			log_time_stamp (test_case_start_tag)
			flush_process
			parse_invoke_response
			log_time_stamp (test_case_end_tag)
			last_request.set_response (last_response)
			if not last_response.is_bad then
--				is_ready := True
				if not last_response.is_error then
					normal_response ?= last_response
					check
						normal_response_not_void: normal_response /= Void
					end

						-- Ilinca, "number of faults law" experiment
--					if last_response.is_normal then
--						if normal_response.exception /= Void and then
--							(not normal_response.exception.is_invariant_violation_on_feature_entry and not normal_response.exception.is_test_invalid) then
--								failure_log_test_case_index
--								last_request.process (failure_request_printer)
--								failure_log (failure_log_stream.string)
--								failure_log_stream.string.wipe_out
--								last_response.process (failure_response_printer)
--								record_failure_time_stamp
--	--							failure_log_speed
--							end
--					end
				end
			else
				is_ready := False
			end
			stop_process_on_problems (last_response)
			if is_ready and normal_response /= Void and then normal_response.exception = Void then
				if not is_replaying then
						-- If we are not in replay mode, we generate "type" request to get the
						-- dynamic type of the assignment target. If we are in replay mode,
						-- the "type" request will be already in the replay list, so we don't need to
						-- generate them automatically.					
					retrieve_type_of_variable (a_receiver)
				end
			end
			log_speed

				-- Predicate evaluation.
			evaluate_predicates_after_test_case (create {AUT_FEATURE_OF_TYPE}.make (a_query, a_type), a_target, an_argument_list, a_receiver)

			if is_running and then is_state_recording_enabled then
				l_var_set.wipe_out
				retrieve_target_object_state (a_target, l_var_set)
				retrieve_argument_objects_state (an_argument_list, l_var_set)
				if variable_table.is_variable_defined (a_receiver) then
					retrieve_query_result_object_state (a_receiver, l_var_set)
				end
				record_object_states (l_var_set)
			end
		ensure
			last_request_not_void: last_request /= Void
		end

	assign_expression (a_receiver: ITP_VARIABLE; an_expression: ITP_EXPRESSION)
			-- Assign `a_constant' to `a_receiver'.
		require
			is_launched: is_launched
			is_ready: is_ready
			a_receiver_not_void: a_receiver /= Void
			a_constant_not_void: an_expression /= Void
		do
			create {AUT_ASSIGN_EXPRESSION_REQUEST} last_request.make (system, a_receiver, an_expression)

			last_request.process (request_printer)
			flush_process
			parse_invoke_response
			last_request.set_response (last_response)
			if not last_response.is_bad or last_response.is_error  then
--				is_ready := True
			else
				is_ready := False
			end
			stop_process_on_problems (last_response)
			if is_ready and then not is_replaying then
					-- If we are not in replay mode, we generate "type" request to get the
					-- dynamic type of the assignment target. If we are in replay mode,
					-- the "type" request will be already in the replay list, so we don't need to
					-- generate them automatically.
				retrieve_type_of_variable (a_receiver)
			end
		ensure
			last_request_not_void: last_request /= Void
		end

	retrieve_type_of_variable (a_variable: ITP_VARIABLE)
			-- Retrieve the type of variable `a_variable' and
			-- store the result in `variable_type_table'.
		require
			a_variable_not_void: a_variable /= Void
			is_running: is_launched
			is_ready: is_ready
		local
			normal_response: AUT_NORMAL_RESPONSE
		do
			create {AUT_TYPE_REQUEST} last_request.make (system, a_variable)
			last_request.process (request_printer)
			flush_process
			is_waiting_for_type := True
			parse_type_of_variable_response
			is_waiting_for_type := False
			last_request.set_response (last_response)
			if not last_response.is_bad then
--				is_ready := True
				if not last_response.is_error then
					normal_response ?= last_response
					check
						normal_response_not_void: normal_response /= Void
						no_exception: normal_response.exception = Void
						valid_type: base_type (normal_response.text) /= Void
					end
					variable_table.define_variable (a_variable, base_type (normal_response.text))

						-- Ilinca, "number of faults law" experiment
--					last_request.process (failure_request_printer)
--					failure_log (failure_log_stream.string)
--					failure_log_stream.string.wipe_out
--					last_response.process (failure_response_printer)
				end
			else
				is_ready  := False
			end
			stop_process_on_problems (last_response)
		ensure
			last_request_not_void: last_request /= Void
		end

	retrieve_object_state (a_variable: ITP_VARIABLE) is
			-- Retrieve the state of variable `a_variable'.
		require
			a_variable_attached: a_variable /= Void
			a_variable_defined: variable_table.is_variable_defined (a_variable)
		local
			l_type: TYPE_A
			l_request: AUT_OBJECT_STATE_REQUEST
		do
			l_type := variable_table.variable_type (a_variable)
			create l_request.make (system, a_variable)
			if l_type /= none_type then
				l_request.set_queries (supported_queries_of_type (l_type))
			else
				l_request.set_queries (create {LINKED_LIST [FEATURE_I]}.make)
			end
			last_request := l_request
			last_request.process (request_printer)
			flush_process
			parse_object_state_response
			last_request.set_response (last_response)

			if configuration.is_object_state_exploration_enabled and then attached {AUT_OBJECT_STATE_RESPONSE} last_response as l_object_state_response then
				object_state_table.put_variable (a_variable, create {AUT_OBJECT_STATE}.make (l_object_state_response), l_type)
			end

			if not last_response.is_bad then

			else
				is_ready  := False
			end
			stop_process_on_problems (last_response)
		ensure
--			last_request_attached: is_object_state_retrieval_enabled implies last_request /= Void
		end

	retrieve_argument_objects_state (a_expressions: DS_LINEAR [ITP_EXPRESSION]; a_variable_set: DS_HASH_SET [ITP_VARIABLE]) is
			-- Retrieve states of variables in `a_expressions'.
		require
			a_expressions_attached: a_expressions /= Void
		local
			l_cursor: DS_LINEAR_CURSOR [ITP_EXPRESSION]
		do
			if configuration.is_argument_state_retrieved then
				from
					l_cursor := a_expressions.new_cursor
					l_cursor.start
				until
					l_cursor.after or not is_running
				loop
					if attached {ITP_VARIABLE} l_cursor.item as l_variable then
						if not a_variable_set.has (l_variable) then
							a_variable_set.force_last (l_variable)
						end
					end
					l_cursor.forth
				end
			end
		end

	retrieve_target_object_state (a_variable: ITP_VARIABLE; a_variable_set: DS_HASH_SET [ITP_VARIABLE]) is
			-- Record state of `a_variable' as a target of a feature call.			
		do
			if configuration.is_target_state_retrieved and then not a_variable_set.has (a_variable) then
				a_variable_set.force_last (a_variable)
			end
		end

	retrieve_query_result_object_state (a_variable: ITP_VARIABLE; a_variable_set: DS_HASH_SET [ITP_VARIABLE]) is
			-- Record state of `a_variable' as a return value of a query.
		do
			if configuration.is_query_result_state_retrieved and then not a_variable_set.has (a_variable) then
				a_variable_set.force_last (a_variable)
			end
		end

	parse_object_state_response is
			-- Parse response from the last object state request.
		local
			l_response: AUT_OBJECT_STATE_RESPONSE
			l_features: LIST [STRING]
			l_table: HASH_TABLE [detachable STRING, STRING]
		do
			if attached {AUT_OBJECT_STATE_REQUEST} last_request as l_request then
				retrieve_object_state_response
				l_features := l_request.query_names
				create l_table.make (l_features.count)
				l_features.do_all (agent l_table.force (Void, ?))
				if is_logging_enabled then
					last_response.process (response_printer)
				end
			end
		end

	retrieve_object_state_response
			-- Retrieve response from the interpreter,
			-- store it in `last_raw_response'.
		local
			l_data: TUPLE [values: detachable LINKED_LIST [detachable STRING]; status: detachable LINKED_LIST [BOOLEAN]; output: detachable STRING; error: detachable STRING]
			l_retried: BOOLEAN
			l_socket: like socket
			l_response_flag: NATURAL_32
			l_response: AUT_OBJECT_STATE_RESPONSE
		do
			if not l_retried then
				l_socket := socket
				l_socket.read_natural_32
				l_response_flag := l_socket.last_natural_32
				l_data ?= l_socket.retrieved
				process.set_timeout (0)
				if l_data /= Void and then attached {AUT_OBJECT_STATE_REQUEST} last_request as l_request then
					create last_raw_response.make (l_data.output, l_data.error, l_response_flag)
						-- Fixme: This is a walk around for the issue that we cannot launch a process
						-- only with standard input redirected. Remove the following line when fixed,
						-- because everything that the interpreter output should come from `l_data.output'.
						-- Jason 2008.10.22
					replace_output_from_socket_by_pipe_data
					if l_response_flag = {AUT_SHARED_CONSTANTS}.object_is_void_flag then
						create l_response.make_with_void
					elseif l_response_flag = {AUT_SHARED_CONSTANTS}.invariant_violation_on_entry_response_flag then
						create l_response.make_with_class_invariant_violation
					else
						create l_response.make (l_request.query_names, l_data.values, l_data.status)
					end
					last_response := l_response
				else
					last_raw_response := Void
				end
			end
		rescue
			is_ready := False
			l_retried := True
			last_raw_response := Void
			retry
		end

	is_target_object_state_retrieval_enabled: BOOLEAN
			-- Is object state retrieval enabled?

	is_argument_object_state_retrieval_enabled: BOOLEAN
			-- Should state of argument object be retrieved?

	is_query_result_object_state_retrieval_enabled: BOOLEAN
			-- Should state of object returned by a query be retrieved?

	is_variable_equal (a_var, b_var: ITP_VARIABLE): BOOLEAN is
			-- Is `a_var' equal to `b_bar'?
		do
			Result := a_var ~ b_var
		ensure
			good_result: Result = (a_var ~ b_var)
		end

	variable_set: DS_HASH_SET [ITP_VARIABLE] is
			-- Hash set for variables
		do
			create Result.make (2)
			Result.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [ITP_VARIABLE]}.make (agent is_variable_equal))
		end

	record_object_states (a_variables: DS_HASH_SET [ITP_VARIABLE]) is
			-- Record state of `a_variables'.
		do
			a_variables.do_all (agent retrieve_object_state)
		end

	is_state_recording_enabled: BOOLEAN is
			-- Is object state recording enabled?
		do
			Result := configuration.is_object_state_retrieval_enabled
		ensure
			good_result: Result = configuration.is_object_state_retrieval_enabled
		end

feature -- Response parsing

	parse_response
			-- Parse response from interpreter, store it in `last_response'.
		local
			l_response: like last_response
		do
			Precursor

			l_response := last_response
			check l_response /= Void end
			report_event (l_response)

				-- Print `last_response' into log file when `is_logging_enabled'.
				--
				-- Note: this will be removed once logging is implemented as an observer
			if is_logging_enabled then
				last_response.process (response_printer)
			end
		end

	parse_start_response
			-- Parse the response issued by the interpreter after it has been
			-- started.
		do
			parse_empty_response
		ensure then
			last_response_not_void: last_response /= Void
		end

	parse_stop_response
			-- Parse the response issued by the interpreter after it received a stop request.
		do
			parse_empty_response
		ensure then
			last_response_not_void: last_response /= Void
		end

	parse_invoke_response
			-- Parse the response issued by the interpreter after a
			-- create-object/create-object-default/invoke-feature/invoke-and-assign-feature
			-- request has been sent.
		do
			parse_response
		ensure then
			last_response_not_void: last_response /= Void
		end

	parse_assign_expression_response
			-- Parse response issued by interpreter after receiving an
			-- assign-expresion request.
		do
			parse_response
		ensure then
			last_response_not_void: last_response /= Void
		end

	parse_type_of_variable_response
			-- Parse response issued by interpreter after receiving a
			-- retrieve-type-of-variable request.
		do
			parse_response
		ensure then
			last_response_not_void: last_response /= Void
		end

	parse_empty_response
			-- Parse a response consisting of no characters.
		do
			raw_response_analyzer.set_raw_response (create {AUT_RAW_RESPONSE}.make ("", "", {ITP_SHARED_CONSTANTS}.normal_response_flag))
			last_response := raw_response_analyzer.response
		end

feature {NONE} -- Process scheduling

	process: AUT_PROCESS_CONTROLLER
			-- Process controller

	request_count: NATURAL_64
			-- Number of requests that have been sent to interpreter so far

feature{NONE} -- Process scheduling

	stdout_reader: AUT_THREAD_SAFE_LINE_READER
			-- Non blocking reader for client-stdout
			-- This is a walkaround for the problem that the process libarry
			-- cannot launch interpreter just with input redirected.

	is_waiting_for_type: BOOLEAN
			-- Are we waiting for repsone for a type request
			-- This is a walkaround for the problem that the process libarry
			-- cannot launch interpreter just with input redirected.

	launch_process
			-- Launch `process'.
		local
			arguments: ARRAYED_LIST [STRING]
			l_body_id: INTEGER
			l_workdir: STRING
		do
				-- $MELT_PATH needs to be set here in only to allow debugging.
			execution_environment.set_variable_value ("MELT_PATH", melt_path)
			create stdout_reader.make

				-- We need `injected_feature_body_id'-1 because the underlying C array is 0-based.
			l_body_id := injected_feature_body_id - 1
			create arguments.make_from_array (<<"localhost", port.out, l_body_id.out, injected_feature_pattern_id.out, interpreter_log_filename, "-eif_root", interpreter_root_class_name + "." + interpreter_root_feature_name>>)

			l_workdir := system.lace.directory_name
			create process.make (executable_file_name, arguments, l_workdir)
			process.set_timeout (0)
			process.launch (agent stdout_reader.put_string)
		end

	flush_process
			-- Send request data into interpreter through `socket'.
			-- If error occurs, close `socket'.
		local
			failed: BOOLEAN
			l_last_request: like last_request
			l_last_bc_request: TUPLE [flag: NATURAL_8; data: detachable ANY]
		do
			if not failed then
					-- Log request
				l_last_request := last_request
				check l_last_request /= Void end
				report_event (l_last_request)

--				is_ready := False
				if process.input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_stream then
					log (log_stream.string)
--					failure_log (failure_log_stream.string) -- Ilinca, "number of faults law" experiment
					request_count := request_count + 1
					process.set_timeout (timeout)
					if socket /= Void and then socket.is_open_write and socket.extendible then
						l_last_bc_request := socket_data_printer.last_request
						socket.put_natural_32 (l_last_bc_request.flag)
						socket.independent_store (l_last_bc_request.data)
					end
				else
					log_line ("-- Error: could not send instruction to interpreter due its input stream being closed.")
				end
				log_stream.string.wipe_out
--				failure_log_stream.string.wipe_out -- Ilinca, "number of faults law" experiment
			end
		rescue
			is_ready := False
			failed := True
			retry
		end

	stop_process_on_problems (a_response: AUT_RESPONSE)
			-- Stop `process' if a class invariant has occured in the interpreter or
			-- a bad response has been received.
			-- The interpreter will shut down in case of a class invariant, because the
			-- system will be in an invalid state.
		require
			a_response_not_void: a_response /= Void
		local
			normal_response: AUT_NORMAL_RESPONSE
		do
			if is_running then
				if a_response.is_bad then
					if not process.force_terminated then
						stop
					end
					log_line ("-- Proxy has terminated interpreter due to bad behavior.")
				elseif a_response.is_error then
					-- Do nothing
				else
					normal_response ?= a_response
					check
						normal_response_not_void: normal_response /= Void
					end
					if normal_response.exception /= Void then
						if normal_response.exception.code = Class_invariant then
--							stop
--							log_line ("-- Proxy has terminated interpreter due to class invariant violation.")
--							failure_log_line (exception_thrown_message + error_handler.duration_to_now.second_count.out)
						end
					end
				end
			else
				log_line ("-- Interpreter seems to have quit on its own.")
			end
		end

feature -- Socket IPC

	port: INTEGER
			-- Port number used for socket IPC

	min_port: INTEGER = 49152
			-- Minimal port number

	port_cell: CELL [INTEGER]
			-- Cell to contain port number.
		once
			create Result.put (min_port)
		ensure
			result_attached: Result /= Void
		end

	next_port_number: INTEGER
			-- Next port number to connect through socket
		do
			fixme ("Ideally, we should reuse the same port number.")
			Result := port_cell.item
			port_cell.put (Result + 1)
		end

	socket: NETWORK_STREAM_SOCKET
			-- Socked used to

	cleanup
			-- Clean up Current proxy.
		do
			observers.wipe_out
			if socket /= Void then
				cleanup_socket
			end
		end

	cleanup_socket
			-- Cleanup `socket'.
		require
			socket_attached: socket /= Void
		do
			if socket.exists and then not socket.is_closed then
				socket.close
			end
		end

	retrieve_response
			-- Retrieve response from the interpreter,
			-- store it in `last_raw_response'.
		local
			l_data: TUPLE [invariant_violating_object_index: INTEGER; output: STRING; error: STRING]
			l_retried: BOOLEAN
			l_socket: like socket
			l_response_flag: NATURAL_32
		do
			if not l_retried then
				l_socket := socket
				l_socket.read_natural_32
				l_response_flag := l_socket.last_natural_32
				l_data ?= l_socket.retrieved
				process.set_timeout (0)
				if l_data /= Void then
					create last_raw_response.make (create {STRING}.make_from_string (l_data.output), create {STRING}.make_from_string (l_data.error), l_response_flag)
						-- Fixme: This is a walk around for the issue that we cannot launch a process
						-- only with standard input redirected. Remove the following line when fixed,
						-- because everything that the interpreter output should come from `l_data.output'.
						-- Jason 2008.10.22
					replace_output_from_socket_by_pipe_data

						-- Mark object as invariant violating.
					if
						l_response_flag = {AUT_SHARED_CONSTANTS}.invariant_violation_on_entry_response_flag and then
						l_data.invariant_violating_object_index > 0
					then
--						variable_table.mark_invalid_object (l_data.invariant_violating_object_index)
						mark_invalid_object (l_data.invariant_violating_object_index)
					end
				else
					last_raw_response := Void
				end
			end
		rescue
			is_ready := False
			l_retried := True
			last_raw_response := Void
			retry
		end

	replace_output_from_socket_by_pipe_data
			-- Replace output received from `socket' by output received from
			-- pipe reader `stdout_reader'.
			-- Fixme: This is a walk around for the issue that we cannot launch a process
			-- only with standard input redirected. Jason 2008.10.22
		do
			fixme ("Remove this feature when the bug described in header comment is fixed.")
			check last_raw_response_attached: last_raw_response /= Void end
			if not is_waiting_for_type then
				if stdout_reader.has_read_line then
						-- Because pipe reading is done in a separate thread,
						-- we cannot guarantee the compete output from interpreter
						-- has been read at this point.
					stdout_reader.try_read_all_lines
					if stdout_reader.last_string /= Void then
						last_raw_response.set_output (create {STRING}.make_from_string (stdout_reader.last_string))
					end
				end
			end
		end

feature -- Logging

	log_line (a_string: STRING)
			-- Log `a_string' followed by a new-line character to `log_file'.
		require
			a_string_not_void: a_string /= Void
		do
			log (a_string)
			log ("%N")
		end

	failure_log_line (a_string: STRING)
			-- Log `a_string' followed by a new-line character to `failure_log_file'.
			-- Ilinca, "number of faults law" experiment
		require
			a_string_not_void: a_string /= Void
		do
			failure_log (a_string)
			failure_log ("%N")
		end


feature {NONE} -- Logging

	log (a_string: STRING)
			-- Log `a_string' to `log_file'.
		require
			a_string_not_void: a_string /= Void
		do
			if is_logging_enabled and then proxy_log_file.is_open_write then
				proxy_log_file.put_string (a_string)
				proxy_log_file.flush
			end
		end

	failure_log (a_string: STRING)
			-- Log `a_string' to `failure_log_file'.
			-- Ilinca, "number of faults law" experiment
		require
			a_string_not_void: a_string /= Void
		do
			if is_logging_enabled and then proxy_failure_log_file.is_open_write then
				proxy_failure_log_file.put_string (a_string)
				proxy_failure_log_file.flush
			end
		end

	log_bad_response
			-- Log that we received a bad response.
		do
			log_line ("-- Proxy received a bad response.")
		end

	log_time_stamp (a_tag: STRING)
			-- Log tag `a_tag' with timing information.
		local
			time_now: DT_DATE_TIME
			duration: DT_DATE_TIME_DURATION
		do
			time_now := system_clock.date_time_now
			duration := time_now.duration (proxy_start_time)
			duration.set_time_canonical
			log ("-- time stamp: ")
			log (a_tag)
			log ("; ")
			log (duration.second_count.out)
			log ("; ")
			log_line (duration.millisecond_count.out)
		end

	record_failure_time_stamp
			-- Record the timing information for `last_request'.
			-- Ilinca, "number of faults law" experiment
		local
			time_now: DT_DATE_TIME
			duration: DT_DATE_TIME_DURATION
		do
			time_now := system_clock.date_time_now
			duration := time_now.duration (proxy_start_time)
			duration.set_time_canonical
			last_request.set_time (duration)
		end

	log_test_case_index (a_request: like last_request) is
			-- Log `test_case_index' in `a_request' and
		require
			a_request_attached: a_request /= Void
		do
			if is_test_case_index_logging_enabled then
	            test_case_count := test_case_count + 1
	            last_request.set_test_case_index (test_case_count)
			end
			log_line ("-- test case No." + test_case_count.out)
		ensure
			test_case_logged:
				is_test_case_index_logging_enabled implies (
					test_case_count = old test_case_count + 1 and
					last_request.test_case_index = test_case_count)
		end

	failure_log_test_case_index is
			-- Log `test_case_index' in `a_request'
			-- Ilinca, "number of faults law" experiment
		do
			if is_test_case_index_logging_enabled then
	            last_request.set_test_case_index (test_case_count)
			end
			failure_log_line ("-- test case No." + test_case_count.out)
		ensure
			test_case_logged:
				is_test_case_index_logging_enabled implies (
					test_case_count = old test_case_count + 1 and
					last_request.test_case_index = test_case_count)
		end

feature {NONE} -- Implementation

	executable_file_name: STRING
			-- File name of interpreter executable

	interpreter_log_filename: STRING
			-- File name of the interpreters log

	melt_path: STRING
			-- Path where melt file of test client resides

	request_printer: AUT_REQUEST_PROCESSORS
			-- Request printer

	failure_request_printer: AUT_REQUEST_TEXT_PRINTER
			-- Request printer in textual form printing only requests trigerring failures
			-- (Ilinca, "number of faults law" experiment)

	socket_data_printer: AUT_REQUEST_PRINTER
			-- Printer to generate socket data for interpreter

	log_stream: KL_STRING_OUTPUT_STREAM
			-- Output stream used by `request_printer' for log file generation

	failure_log_stream: KL_STRING_OUTPUT_STREAM
			-- Output stream used by `failure_request_printer' for log file generation
			-- Ilinca, "number of faults law" experiment

	injected_feature_body_id: INTEGER
			-- Feature body ID of the feature whose byte-code is to be injected

	injected_feature_pattern_id: INTEGER
			-- Pattern ID of the feature whose byte-code is to be injected

	error_handler: AUT_ERROR_HANDLER
			-- Error handler

	response_printer: AUT_RESPONSE_LOG_PRINTER
			-- Log printer

	failure_response_printer: AUT_RESPONSE_LOG_PRINTER
			-- Response printer, printing only responses representing failures
			-- (Ilinca, "number of faults law" experiment)

	proxy_start_time: DT_DATE_TIME
			-- Time when Current proxy started.

	proxy_log_file: KL_TEXT_OUTPUT_FILE
			-- Proxy log file

	proxy_failure_log_file: KL_TEXT_OUTPUT_FILE
			-- Proxy log file recording only the failing test cases
			-- (Ilinca, "Number of faults law" experiment)

	default_timeout: INTEGER = 5
			-- Default value in second for `timeout'

	test_case_count: INTEGER
			-- Number of executed test cases so far

feature{NONE} -- Speed logging

	is_speed_logging_enabled: BOOLEAN
			-- Is testing speed logging enabled?

	last_speed_check_time: DT_DATE_TIME
			-- Last time point when testing speed is checked

	test_case_log_count: INTEGER
			-- Test case count for speed logging

	set_is_speed_logging_enabled (b: BOOLEAN) is
			-- Set `is_speed_logging_enabled' with `b'.
		do
			is_speed_logging_enabled := b
		ensure
			is_speed_logging_enabled_set: is_speed_logging_enabled = b
		end

	log_speed is
			-- Log testing speed when `is_speed_logging_enabled' is True.
		local
			l_time_now: DT_DATE_TIME
			l_speed: INTEGER
			l_second_count: INTEGER
			l_duration: like duration_until_now
        do
			if is_speed_logging_enabled then
				l_time_now := system_clock.date_time_now
				if last_speed_check_time /= Void then
					l_second_count := l_time_now.duration (last_speed_check_time).second_count
					if l_second_count > 60 then
						l_speed := ((test_case_log_count.to_real / l_second_count) * 60).floor
						log_line ("-- testing speed: " + l_speed.out + " test cases per minute.")
						test_case_log_count := 0
						last_speed_check_time := l_time_now
						
						l_duration := duration_until_now
						log_pool_statistics (l_duration)
						log_precondition_evaluation_failure_rate (l_duration)
					else
						test_case_log_count := test_case_log_count + 1
					end
				else
					last_speed_check_time := l_time_now
				end
			end
		end

	failure_log_speed is
			-- Log testing speed when `is_speed_logging_enabled' is True.
		local
			l_time_now: DT_DATE_TIME
			l_speed: INTEGER
			l_second_count: INTEGER
        do
			if is_speed_logging_enabled then
				l_time_now := system_clock.date_time_now
				if last_speed_check_time /= Void then
					l_second_count := l_time_now.duration (last_speed_check_time).second_count
					if l_second_count > 60 then
						l_speed := ((test_case_log_count.to_real / l_second_count) * 60).floor
						failure_log_line ("-- testing speed: " + l_speed.out + " test cases per minute.")
						test_case_log_count := 0
						last_speed_check_time := l_time_now
					else
						test_case_log_count := test_case_log_count + 1
					end
				else
					last_speed_check_time := l_time_now
				end
			end
		end

feature -- Precondition satisfaction

	generate_typed_object_pool is
			-- Generate `typed_object_pool' and
			-- initialize it with `a_types'.
		local
			l_pool: AUT_TYPED_OBJECT_POOL
		do
			create l_pool.make (system, configuration.types_under_test, interpreter_class)
			variable_table.set_defining_variable_action (agent l_pool.put_variable)
			variable_table.wipe_out_actions.extend (agent l_pool.wipe_out)
			typed_object_pool_cell.put (l_pool)
			variable_table.wipe_out_actions.extend (agent predicate_pool.wipe_out)
			variable_table.wipe_out_actions.extend (agent constant_pool.wipe_out)
			variable_table.wipe_out_actions.extend (agent used_integer_values.wipe_out)
		end

	is_precondition_satisfied (a_feature: AUT_FEATURE_OF_TYPE; a_variables: DS_LIST [ITP_VARIABLE]): BOOLEAN is
			-- Can the precondition of `a_feature' be satisfied by `a_variables'?
		local
			l_request: AUT_PRECONDITION_EVALUATION_REQUEST
		do
			create l_request.make (system, a_feature, a_variables)
			last_request := l_request
			last_request.process (request_printer)
			flush_process
			parse_precondition_evaluation_response
			last_request.set_response (last_response)
			Result := attached {AUT_PRECONDITION_EVALUATION_RESPONSE} last_response as l_response and then l_response.is_satisfied
			stop_process_on_problems (last_response)
		end

	parse_precondition_evaluation_response is
			-- Parse the response of the last precondition evaluation request.
		do
			if attached {AUT_PRECONDITION_EVALUATION_REQUEST} last_request as l_request then
				retrieve_precondition_evaluation_response
				if is_logging_enabled then
					last_response.process (response_printer)
				end
			end
		end

	retrieve_precondition_evaluation_response is
			-- Retrieve response of the last precondition evaluation request.
		local
			l_data: TUPLE [object_index: detachable ARRAY [INTEGER]; output: detachable STRING; error: detachable STRING]
			l_retried: BOOLEAN
			l_socket: like socket
			l_response_flag: NATURAL_32
			l_response: AUT_PRECONDITION_EVALUATION_RESPONSE
			l_any: detachable ANY
		do
			if not l_retried then
				l_socket := socket
				l_socket.read_natural_32
				l_response_flag := l_socket.last_natural_32
				l_any ?= l_socket.retrieved
				l_data ?= l_any
				process.set_timeout (0)
				if l_data /= Void then
					create l_response.make (l_data.object_index /= Void)
					last_response := l_response
				else
					last_raw_response := Void
				end
			end
		rescue
			is_ready := False
			l_retried := True
			last_raw_response := Void
			retry
		end

	object_state (a_variable: ITP_VARIABLE): HASH_TABLE [detachable STRING, STRING] is
			-- State of `a_variable'
			-- Value is in the form [query value, query name].
		do
			retrieve_object_state (a_variable)

			if is_ready then
				if attached {AUT_OBJECT_STATE_RESPONSE} last_response as l_response then
					Result := l_response.query_results
				end
			end
			if Result = Void then
				create Result.make (0)
				Result.compare_objects
			end
		end

	test_case_start_tag: STRING is "TC start"
			-- Log tag for test case start

	test_case_end_tag: STRING is "TC end"
			-- Log tag for test case end

	log_types_under_test is
			-- Log `types_under_test'.
		local
			l_types: DS_LINEAR [TYPE_A]
			i: INTEGER
			l_count: INTEGER
		do
			log ("-- classes under test: ")
			l_types := configuration.types_under_test
			from
				l_types.start
				l_count := l_types.count
				i := 1
			until
				l_types.after
			loop
				log (l_types.item_for_iteration.associated_class.name_in_upper)
				if i < l_count then
					log (", ")
				end
				i := i + 1
				l_types.forth
			end
			log_line ("")
		end

	duration_until_now: DT_DATE_TIME_DURATION is
			-- Duration from the start of current AutoTest run until now
		local
			time_now: DT_DATE_TIME
		do
			to_implement ("log_time_stamp can be simplified with current feature.")
			time_now := system_clock.date_time_now
			Result := time_now.duration (proxy_start_time)
			Result.set_time_canonical
		end

	log_precondition_evaluation (a_type: TYPE_A; a_feature: FEATURE_I; a_tried_count: INTEGER; a_worst_case_count: INTEGER; a_start_time: INTEGER; a_end_time: INTEGER; a_succeed_level: INTEGER) is
			-- Log precondition evaluation statistics.
			-- `a_feature' is the feature whose preconditions are evaluated.
			-- `a_type' is where `a_feature' is from.
			-- `a_tried_count' is the number of times that different object combinations are tried for that precondition.
			-- `a_worst_case_count' is the number of object combinations that need to be tried out in the worst case.
			-- `a_start_time' is the start time in millisecond when the precondition evaluation started.
			-- `a_end_time' is the end time in millisecond when the precondition evaluation ended.
			-- `a_succeed' is whether an object combination satisfying `a_feature''s precondition is found.
		require
			a_type_attached: a_type /= Void
			a_type_valid: a_type.has_associated_class
			a_feature_attached: a_feature /= Void
			a_tried_count_non_negative: a_tried_count >= 0
			a_worst_case_count_non_negative: a_worst_case_count >= 0
			a_worst_case_count_valid: a_tried_count <= a_worst_case_count
			a_start_time_non_negative: a_start_time >= 0
			a_end_time_non_negative: a_end_time >= 0
			a_time_valid: a_end_time >= a_start_time
		local
			l_text: STRING
		do
			create l_text.make (128)
			l_text.append ("-- Precondition_evaluation: ")

			l_text.append ("tried_times: ")
			l_text.append (a_tried_count.out)
			l_text.append ("; ")

			l_text.append ("max_times: ")
			l_text.append (a_worst_case_count.out)
			l_text.append ("; ")

			l_text.append ("start time: ")
			l_text.append (a_start_time.out)
			l_text.append ("; ")

			l_text.append ("end time: ")
			l_text.append (a_end_time.out)
			l_text.append ("; ")

			l_text.append ("Succeeded: ")
			l_text.append (a_succeed_level.out)
			l_text.append ("; ")

			l_text.append (a_type.associated_class.name_in_upper)
			l_text.append (".")
			l_text.append (a_feature.feature_name.as_lower)

			log_line (l_text)
		end

feature -- Predicate evaluation

	evaluate_predicates (a_predicates: LINKED_LIST [TUPLE [predicate: INTEGER; arguments: SPECIAL [INTEGER]]]) is
			-- Evaluate `a_predicates'.
		require
			a_predicates_attached: a_predicates /= Void
			a_predicates_valid: not a_predicates.has (Void)
		local
			l_request: AUT_PREDICATE_EVALUATION_REQUEST
		do
			create l_request.make (system, a_predicates)
			last_request := l_request
			last_request.process (request_printer)
			flush_process
			parse_predicate_evaluation_response
			last_request.set_response (last_response)
			if last_response.is_bad then
				is_ready  := False
			end
			stop_process_on_problems (last_response)
		end

	parse_predicate_evaluation_response is
			-- Parse the response of the last predicate evaluation request.
		do
			if attached {AUT_PREDICATE_EVALUATION_REQUEST} last_request as l_request then
				retrieve_predicate_evaluation_response
				if is_logging_enabled then
					last_response.process (response_printer)
				end
			end
		end

	retrieve_predicate_evaluation_response is
			-- Retrieve response of the last predicate evaluation request.
		local
			l_data: TUPLE [evaluation_result: detachable LINKED_LIST [TUPLE [INTEGER, SPECIAL [NATURAL_8]]]; output: detachable STRING; error: detachable STRING]
			l_retried: BOOLEAN
			l_socket: like socket
			l_response_flag: NATURAL_32
			l_response: AUT_PREDICATE_EVALUATION_RESPONSE
			l_any: detachable ANY
		do
			if not l_retried then
				l_socket := socket
				l_socket.read_natural_32
				l_response_flag := l_socket.last_natural_32
				l_any ?= l_socket.retrieved
				l_data ?= l_any
				process.set_timeout (0)
				if l_data /= Void and then l_data.evaluation_result /= Void then
					create l_response.make (l_data.evaluation_result)
					last_response := l_response
				else
					last_raw_response := Void
				end
			end
		rescue
			is_ready := False
			l_retried := True
			last_raw_response := Void
			retry
		end

	update_predicate_pool_on_precondition_violation (a_feature: AUT_FEATURE_OF_TYPE; a_related_objects: ARRAY [ITP_VARIABLE]) is
			-- Update predicate pool if there is a precondition violation when `a_feature' was executed with `a_related_objects'.
		local
			l_bp_slot: INTEGER
			l_pattern_cursor: DS_HASH_SET_CURSOR [AUT_PREDICATE_ACCESS_PATTERN]
			l_access_patterns: DS_HASH_SET [AUT_PREDICATE_ACCESS_PATTERN]
			l_done: BOOLEAN
			l_pred_args: LINKED_LIST [INTEGER]
			l_pattern: DS_HASH_TABLE [INTEGER, INTEGER]
			l_ptn_cursor: DS_HASH_TABLE_CURSOR [INTEGER, INTEGER]
			l_failed_predicate: AUT_PREDICATE
		do
			if configuration.is_precondition_checking_enabled then
					-- When there is a precondition violation, we first update the predicate pool.

				if attached {AUT_NORMAL_RESPONSE} last_response as l_normal_response then
					if l_normal_response.exception /= Void and then l_normal_response.exception.is_test_invalid then
						increase_failed_precondition_count
						l_bp_slot := l_normal_response.exception.break_point_slot
						l_access_patterns := precondition_access_pattern.item (a_feature)
						if l_access_patterns /= Void then
							l_pattern_cursor := l_access_patterns.new_cursor
							from
								l_pattern_cursor.start
							until
								l_pattern_cursor.after or else l_done
							loop
								if l_pattern_cursor.item.break_point_slot = l_bp_slot then
									l_done := True
									l_failed_predicate := l_pattern_cursor.item.predicate
									create l_pred_args.make
									from
										l_pattern := l_pattern_cursor.item.access_pattern
										l_ptn_cursor := l_pattern.new_cursor
										l_ptn_cursor.start
									until
										l_ptn_cursor.after
									loop
										l_pred_args.extend (a_related_objects.item (l_ptn_cursor.item).index)
										l_ptn_cursor.forth
									end
								end
								l_pattern_cursor.forth
							end

								-- Update predicate: Set `l_failed_predicate' with `l_pred_args' with value False.
							if l_done then
								update_predicate (l_failed_predicate, l_pred_args, False)
								log_failed_precondition_satisfaction_proposal (a_feature, l_failed_predicate)
							end
						end
					end
				end
			end
		end

	log_failed_precondition_satisfaction_proposal (a_feature: AUT_FEATURE_OF_TYPE; a_failed_predicate: AUT_PREDICATE) is
			-- Log a message saying that the precondition satisfaction propsal for `a_failed_predicate' in `a_feature' is wrong.
		require
			a_feature_attached: a_feature /= Void
			a_failed_predicate_attached: a_failed_predicate /= Void
		local
			l_message: STRING
		do
			if
				attached {AUT_PRECONDITION_SATISFACTION_TASK} precondition_evaluator as l_evaluator and then
				l_evaluator.is_precondition_satisfaction_performed and then
				l_evaluator.last_precondition_satisfaction_level /= {AUT_PRECONDITION_SATISFACTION_TASK}.precondition_satisfaction_not_satisfied
			then
				create l_message.make (128)
				l_message.append ("-- Failed predicate: ")
				l_message.append (a_feature.type.associated_class.name_in_upper)
				l_message.append_character ('.')
				l_message.append (a_feature.feature_name)
				l_message.append ("; ")
				l_message.append (a_failed_predicate.text)
				l_message.append ("; time(ms): ")
				l_message.append (duration_until_now.millisecond_count.out)
				log_line (l_message)
			end
		end

	calculate_feature_invalid_test_case_rate (a_feature: AUT_FEATURE_OF_TYPE; a_related_objects: ARRAY [ITP_VARIABLE]) is
			-- Calculate invalid test case rate for `a_feature' and store result in `feature_invalid_test_case_rate'.
		require
			a_feature_attached: a_feature /= Void
			a_related_objects_attached: a_related_objects /= Void
		local
			l_failure_rate: like feature_invalid_test_case_rate
			l_rate: TUPLE [failed_times: INTEGER; all_times: INTEGER; last_tested_time: INTEGER]
			l_table: like predicate_feature_table
			l_cursor: DS_HASH_TABLE_CURSOR [DS_HASH_SET [AUT_FEATURE_OF_TYPE], AUT_PREDICATE]
			l_features: DS_HASH_SET [AUT_FEATURE_OF_TYPE]
			l_predicates: LINKED_LIST [AUT_PREDICATE]
		do
			l_failure_rate := feature_invalid_test_case_rate
			if not l_failure_rate.has (a_feature) then
				l_rate := [0, 0, 0]
				l_failure_rate.force_last (l_rate, a_feature)
			else
				l_rate := l_failure_rate.item (a_feature)
			end
			if last_response.is_precondition_violation then
				l_rate.put_integer (l_rate.failed_times + 1, 1)
				update_predicate_pool_on_precondition_violation (a_feature, a_related_objects)
			else
				l_rate.put_integer (duration_until_now.second_count, 3)
--				if is_eager_feature_selection_enabled then
--					create l_predicates.make
--					l_table := predicate_feature_table
--					from
--						l_cursor := l_table.new_cursor
--						l_cursor.start
--					until
--						l_cursor.after
--					loop
--						l_features := l_cursor.item
--						l_features.remove (a_feature)
--						if l_features.is_empty then
--							l_predicates.extend (l_cursor.key)
--						end
--						l_cursor.forth
--					end
--					l_predicates.do_all (agent l_table.remove)
--				end
			end
			l_rate.put_integer (l_rate.all_times + 1, 2)
		end

	evaluate_predicates_after_test_case (a_feature: AUT_FEATURE_OF_TYPE; a_target: ITP_VARIABLE; a_arguments: DS_LINEAR [ITP_EXPRESSION]; a_result: detachable ITP_VARIABLE) is
			-- Evaluate `relevant_predicates_of_feature' for `a_feature' with relevant objects consisting
			-- `a_target', `a_arguments' and `a_result'.
		require
			a_feature_attached: a_feature /= Void
		local
			l_predicate_table: DS_HASH_TABLE [DS_LINKED_LIST [ARRAY [AUT_FEATURE_SIGNATURE_TYPE]], AUT_PREDICATE]
			l_cursor: DS_HASH_TABLE_CURSOR [DS_LINKED_LIST [ARRAY [AUT_FEATURE_SIGNATURE_TYPE]], AUT_PREDICATE]
			l_request_data:  LINKED_LIST [TUPLE [predicate: INTEGER; arguments: SPECIAL [INTEGER]]]
			l_arguments: SPECIAL [INTEGER]
			l_predicate: AUT_PREDICATE
			l_arranger: DS_LINKED_LIST [ARRAY [AUT_FEATURE_SIGNATURE_TYPE]]
			i, j: INTEGER
			l_arranger_cursor: DS_LINKED_LIST_CURSOR [ARRAY [AUT_FEATURE_SIGNATURE_TYPE]]
			l_args: ARRAY [AUT_FEATURE_SIGNATURE_TYPE]
			l_arity: INTEGER
			l_related_objects: ARRAY [ITP_VARIABLE]
		do
			l_related_objects := relevant_objects (a_target, a_arguments, a_result)
			calculate_feature_invalid_test_case_rate (a_feature, l_related_objects)
			if
				configuration.is_precondition_checking_enabled and then
				is_running and then
--				not (last_response.is_bad or last_response.is_error) and then
--				not (last_response.is_class_invariant_violation_on_entry or last_response.is_class_invariant_violation_on_exit)
				last_response.is_normal
			then
				if attached {AUT_NORMAL_RESPONSE} last_response as l_normal_response and then l_normal_response.exception = Void then
					create l_request_data.make
					if relevant_predicates_of_feature.has (a_feature) then
						l_predicate_table := relevant_predicates_of_feature.item (a_feature)
						from
							l_cursor := l_predicate_table.new_cursor
							l_cursor.start
						until
							l_cursor.after
						loop
							l_predicate := l_cursor.key
							l_arranger := l_cursor.item
							l_arity := l_predicate.arity
							create l_arguments.make (l_arranger.count * l_arity)
							from
								i := 0
								l_arranger_cursor := l_arranger.new_cursor
								l_arranger_cursor.start
							until
								l_arranger_cursor.after
							loop
								from
									l_args := l_arranger_cursor.item
									j := 1
								until
									j > l_arity
								loop
									l_arguments.put (l_related_objects.item (l_args.item (j).position).index, i)
									i := i + 1
									j := j + 1
								end
								l_arranger_cursor.forth
							end
							l_request_data.extend ([l_predicate.id, l_arguments])
							l_cursor.forth
						end
						evaluate_predicates (l_request_data)
						update_predicate_pool (last_request)
					end
				end
			end
		end

	relevant_objects (a_target: ITP_VARIABLE; a_arguments: DS_LINEAR [ITP_EXPRESSION]; a_result: detachable ITP_VARIABLE): ARRAY [ITP_VARIABLE] is
			-- Relevant objects
		local
			l_cursor: DS_LINEAR_CURSOR [ITP_EXPRESSION]
			l_variable: ITP_VARIABLE
			i: INTEGER
		do
			if a_result /= 0 then
				create Result.make (0, a_arguments.count + 1)
			else
				create Result.make (0, a_arguments.count)
			end
			Result.put (a_target, 0)
			if not a_arguments.is_empty then
				from
					l_cursor := a_arguments.new_cursor
					i := 1
					l_cursor.start
				until
					l_cursor.after
				loop
					l_variable ?= l_cursor.item
					check l_variable /= Void end
					Result.put (l_variable, i)
					i := i + 1
					l_cursor.forth
				end
			end
			if a_result /= Void then
				Result.put (a_result, Result.upper)
			end
		ensure
			result_attached: Result /= Void
			result_valid: Result.lower = 0
		end

	update_predicate_pool (a_request: AUT_REQUEST) is
			-- Update predicate pool according to `a_request' and its response.
		require
			a_request_attached: a_request /= Void
			a_response_attached: a_request.response /= Void
		local
			l_predicate_request: LINKED_LIST [TUPLE [predicate: INTEGER_32; arguments: SPECIAL [INTEGER]]]
			l_result: LINKED_LIST [TUPLE [predicate: INTEGER_32; evaluation: SPECIAL [NATURAL_8]]]
			l_predicate: AUT_PREDICATE
			l_arity: INTEGER
			l_predicate_tbl: like predicate_table
			l_arguments: SPECIAL [INTEGER]
			l_evaluation: SPECIAL [NATURAL_8]
			i: INTEGER
			j: INTEGER
			l_count: INTEGER
			l_pred_args: LINKED_LIST [INTEGER]
		do
			if attached {AUT_PREDICATE_EVALUATION_REQUEST} a_request as l_request then
				if attached {AUT_PREDICATE_EVALUATION_RESPONSE} a_request.response as l_response then
					l_predicate_request := l_request.predicates
					l_result := l_response.evaluation_result
					if l_predicate_request.count = l_result.count then
						l_predicate_tbl := predicate_table
						from
							l_predicate_request.start
							l_result.start
						until
							l_predicate_request.after
						loop
								-- Get the predicate under consideration.
							l_predicate := l_predicate_tbl.item (l_predicate_request.item_for_iteration.predicate)
							l_arity := l_predicate.arity

							l_arguments := l_predicate_request.item_for_iteration.arguments
							l_evaluation := l_result.item_for_iteration.evaluation

								-- Check if the number of evaluation request and the number of results are consistant.
							if l_arity = 0 and then l_evaluation.count = 1 then
								create l_pred_args.make
								update_predicate (l_predicate, l_pred_args, l_evaluation.item (0) = 0)
							elseif l_arguments.count = l_evaluation.count * l_arity then
								l_count := l_evaluation.count
								create l_pred_args.make
								from
									i := 0
									j := 0
								until
									j = l_count
								loop
									l_pred_args.extend (l_arguments.item (i))
									i := i + 1
									if i \\ l_arity = 0 then
										update_predicate (l_predicate, l_pred_args, (l_evaluation.item (j) = 0))
										l_pred_args.wipe_out
										j := j + 1
									end
								end
							end
							l_predicate_request.forth
							l_result.forth
						end
					end
				end
			end
		end

	update_predicate (a_predicate: AUT_PREDICATE; a_arguments: LINKED_LIST [INTEGER]; a_result: BOOLEAN) is
			-- Update the value of `a_predicate' evaluated with `a_arguments' to `a_result' in predicate pool.
			-- `a_arguments' stored the object index of the corresponding argument for `a_predicate'.
		require
			a_predicate_attached: a_predicate /= Void
			a_arguments_attached: a_arguments /= Void
			a_arguments_valid: a_arguments.count = a_predicate.arity
		local
			l_arguments: ARRAY [ITP_VARIABLE]
		do
			l_arguments := variables_from_indexes (a_arguments)
			predicate_pool.update_predicate_valuation (a_predicate, l_arguments, a_result)

		end

	variables_from_indexes (a_indexes: LIST [INTEGER]): ARRAY [ITP_VARIABLE] is
			-- Variables from object indexes
		require
			a_indexes_attached: a_indexes /= Void
		local
			i: INTEGER
		do
			create Result.make (1, a_indexes.count)
			from
				i := 1
				a_indexes.start
			until
				a_indexes.after
			loop
				Result.put (create {ITP_VARIABLE}.make (a_indexes.item), i)
				i := i + 1
				a_indexes.forth
			end
		ensure
			result_attached: Result /= Void
		end

	log_seed is
			-- Log seed.
		do
			log_line ("-- Seed: " + random.seed.out)
		end

	failed_precondition_count: INTEGER
			-- Number of times when precondition fails
			-- on feature whose target and arguments are suggensted
			-- by precondition satisfaction strategy

	failed_precondition_count_partial: INTEGER
			-- Number of times when precondition fails
			-- on feature whose target and arguments are partially suggested

	suggested_precondition_count: INTEGER
			-- Number of times when objects that seems to satisfy
			-- precodition of a feature is suggested.

	suggested_precondition_count_partial: INTEGER
			-- Number of times when objects that seems to satisfy
			-- precondition of a feautre is suggested.
			-- These objects candidates are partial, meaning according to
			-- the predicate pool, they only satisfy part of the feature's
			-- precondition, not all of them.

	increase_failed_precondition_count is
			-- Increase the number of failed preconditions.
		local
			l_evaluator: like precondition_evaluator
		do
			l_evaluator := precondition_evaluator
			if l_evaluator /= Void and then l_evaluator.is_precondition_satisfaction_performed then
				if l_evaluator.last_precondition_satisfaction_level = {AUT_PRECONDITION_SATISFACTION_TASK}.precondition_satisfaction_satisfied then
					failed_precondition_count := failed_precondition_count + 1
				elseif l_evaluator.last_precondition_satisfaction_level = {AUT_PRECONDITION_SATISFACTION_TASK}.precondition_satisfaction_partially_satisfied then
					failed_precondition_count_partial := failed_precondition_count_partial + 1
				end
			end
		end

	increase_suggested_precondition_count is
			-- Increase `suggested_precondition_count' by 1.
		do
			suggested_precondition_count := suggested_precondition_count + 1
		ensure
			suggested_precondition_count_increase: suggested_precondition_count = old suggested_precondition_count + 1
		end

	increase_suggested_precondition_count_partial is
			-- Increase `suggested_precondition_count_partial' by 1.
		do
			suggested_precondition_count_partial := suggested_precondition_count_partial + 1
		ensure
			suggested_precondition_count_partial_increase: suggested_precondition_count_partial = old suggested_precondition_count_partial + 1
		end

	precondition_satisfaction_failure_rate_header: STRING is "-- Precondition satisfactoin failure rate:"
			-- Header for precondition satisfaction failure rate logging

	log_precondition_evaluation_failure_rate (a_duration: DT_DATE_TIME_DURATION) is
			-- Log failure rate of precondition satisfaction.
			-- `a_duration' is the duration relative to the starting of current test run.
		require
			a_duration_attached: a_duration /= Void
		do
			if configuration.is_precondition_checking_enabled then
				log_line (
					precondition_satisfaction_failure_rate_header +
					" second: " + a_duration.second_count.out +
					"; full_suggested: " + suggested_precondition_count.out +
					"; full_failed: " + failed_precondition_count.out +
					"; partial_suggested: " + suggested_precondition_count_partial.out +
					"; partial_failed: " + failed_precondition_count_partial.out)
			end
		end

	log_precondition_evaluation_overhead (a_precondition_evaluatior: AUT_PRECONDITION_SATISFACTION_TASK; a_type: TYPE_A; a_feature_to_call: FEATURE_I) is
			-- Log overhead of current precondition evaluation task.
		require
			a_preconditior_evaluation_attached: a_precondition_evaluatior /= Void
			a_type_attached: a_type /= Void
			a_feature_to_call_attached: a_feature_to_call /= Void
		do
			if
				configuration.is_precondition_checking_enabled and then
				a_precondition_evaluatior.has_precondition and then
				a_precondition_evaluatior.is_precondition_satisfaction_performed
			then
				log_precondition_evaluation (
					a_type,
					a_feature_to_call,
					a_precondition_evaluatior.tried_count,
					a_precondition_evaluatior.worst_case_search_count,
					a_precondition_evaluatior.start_time,
					a_precondition_evaluatior.end_time,
					a_precondition_evaluatior.last_precondition_satisfaction_level)

						-- If there is an incorrect lpsolve input file, log it.
				if not a_precondition_evaluatior.is_lp_linear_solvable_model_correct then
					log_lpsolve_input_file_error (a_precondition_evaluatior, a_type, a_feature_to_call)
				end
			end
		end

	log_lpsolve_input_file_error (a_precondition_evaluatior: AUT_PRECONDITION_SATISFACTION_TASK; a_type: TYPE_A; a_feature: FEATURE_I) is
			-- Log that there is an incorrect lpsolve input file generated for `a_feature' in `a_type'.
		require
			a_precondition_evaluatior_attached: a_precondition_evaluatior /= Void
			a_type_attached: a_type /= Void
			a_type_valid: a_type.has_associated_class
			a_feature_attached: a_feature /= Void
		local
			l_message: STRING
		do
			create l_message.make (64)
			l_message.append ("-- Incorrect lpsolve file: ")
			l_message.append (a_type.associated_class.name_in_upper)
			l_message.append_character ('.')
			l_message.append (a_feature.feature_name)
			l_message.append ("; time: ")
			l_message.append (duration_until_now.millisecond_count.out)
			log_line (l_message)
		end

	log_pool_statistics (a_duration: DT_DATE_TIME_DURATION) is
			-- Log statistics about predicate pool.
			-- `a_duration' is the time duration relative to the starting of current test run
		local
			l_context_class: CLASS_C
			l_var_table_cursor: DS_HASH_TABLE_CURSOR [DS_ARRAYED_LIST [ITP_VARIABLE], TYPE_A]
			l_pred_table_cursor: DS_HASH_TABLE_CURSOR [AUT_PREDICATE_VALUATION, AUT_PREDICATE]
			l_stat_object_pool: STRING
			l_stat_predicate_pool: STRING
		do
			if configuration.is_pool_statistics_logged then
				l_context_class := interpreter_class
				check l_context_class /= Void end

					-- Log statistics of object pool: which is the number of objects of each type.
				log_line ("-- Pool statistics: " + a_duration.millisecond_count.out)
				if typed_object_pool /= Void then
					l_stat_object_pool := "-- object_pool: "
					from
						l_var_table_cursor := typed_object_pool.variable_table.new_cursor
						l_var_table_cursor.start
					until
						l_var_table_cursor.after
					loop
						log_line (l_stat_object_pool + type_name_with_context (l_var_table_cursor.key, l_context_class, Void) + ": " + l_var_table_cursor.item.count.out)
						l_var_table_cursor.forth
					end
				end

					-- Log statistics of predicate pool: which is the number of valuations for each predicate.
				l_stat_predicate_pool := "-- predicate_pool: "
				from
					l_pred_table_cursor := predicate_pool.valuation_table.new_cursor
					l_pred_table_cursor.start
				until
					l_pred_table_cursor.after
				loop
					log_line (l_stat_predicate_pool + l_pred_table_cursor.key.text_with_type_name + ": " + l_pred_table_cursor.item.count.out)
					l_pred_table_cursor.forth
				end
			end
		end

	mark_invalid_object (a_index: INTEGER) is
			-- Mark object with `a_index' as invalid, because its class invariants are violated.
		require
			a_index_valid: a_index > 0
		local
			l_class: CLASS_C
		do
			l_class := interpreter_root_class
			typed_object_pool.mark_invalid_object (a_index, l_class)
			if configuration.is_precondition_checking_enabled then
				predicate_pool.remove_variable (create {ITP_VARIABLE}.make (a_index))
			end
		end

	precondition_evaluator: detachable AUT_PRECONDITION_SATISFACTION_TASK
			-- Last used precondition evaluator

	set_precondition_evaluator (a_evaluator: like precondition_evaluator) is
			-- Set `precondition_evaluator' with `a_evaluator'.
		do
			precondition_evaluator := a_evaluator
		ensure
			precondition_evaluator_set: precondition_evaluator = a_evaluator
		end

feature -- Object State Exploration

	object_state_table: AUT_OBJECT_STATE_TABLE
			-- Table with information about encountered object states

invariant
	is_running_implies_reader: is_running implies (stdout_reader /= Void)
	request_printer_not_void: request_printer /= Void
	executable_file_name_not_void: executable_file_name /= Void
	melt_path_not_void: melt_path /= Void
--	not_running_implies_not_ready: not is_running implies not is_ready
--	is_ready_implies_is_running: is_ready implies is_running
	proxy_log_file_not_void: proxy_log_file /= Void
	interpreter_log_file_name_not_void: interpreter_log_filename /= Void
	error_handler_not_void: error_handler /= Void
	variable_table_attached: variable_table /= Void
	socket_data_printer_attached: socket_data_printer /= Void
	response_printer_attached: response_printer /= Void
	raw_response_analyzer_attached: raw_response_analyzer /= Void


note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
