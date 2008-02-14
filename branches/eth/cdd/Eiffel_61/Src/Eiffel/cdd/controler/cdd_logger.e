indexing
	description: "Logger for CDD Plug-In"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_LOGGER

inherit
	CDD_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make (an_output_stream: like output_stream) is
			-- initialize `Current'
		require
			stream_not_void: an_output_stream /= Void
			stream_writable: an_output_stream.is_open_write
		do
			output_stream := an_output_stream
		ensure
			output_stream_set: output_stream = an_output_stream
		end


feature -- Logging (System)

	report_system_status (
								a_project_name: STRING;
								a_target_name: STRING;
								an_extracting_status: BOOLEAN;
								an_execution_status: BOOLEAN;
								a_message: STRING
							  ) is
			-- Write a system status message
		do
			log_element ("system", " project_name=%"" + empty_or_out (a_project_name) + "%" target_name=%"" + empty_or_out (a_target_name) + "%" is_extracting=%"" + empty_or_out (an_extracting_status) + "%" is_executing=%"" + empty_or_out (an_execution_status) + "%" message=%"" + empty_or_out (a_message) + "%"", Void)
		end

feature -- Logging (Test Suite)

	report_test_suite_status (a_test_suite: CDD_TEST_SUITE; a_message: STRING) is
			-- Write a test suite status message.
		local
			l_attributes: STRING
			l_content: STRING
			l_class_list: DS_ARRAYED_LIST [CDD_TEST_CLASS]
			l_class: CDD_TEST_CLASS
			l_routine_list: DS_LIST [CDD_TEST_ROUTINE]
			l_routine: CDD_TEST_ROUTINE
			l_number_of_manual_test_classes: INTEGER
			l_number_of_extracted_test_classes: INTEGER
			l_number_of_synthesized_test_classes: INTEGER
		do
			l_class_list := a_test_suite.test_classes
			l_attributes := "number_of_test_classes=%"" + l_class_list.count.out + "%""
			l_content := ""
			if not l_class_list.is_empty then
				l_class_list.start
				l_class := l_class_list.item_for_iteration
				l_content.append_string ("%T<test_class name=%"" + empty_or_out (l_class.cdd_id) + "--" + l_class.test_class_name + "%"")
				l_content.append (" number_of_test_routines=%"" + l_class.test_routines.count.out + "%"")
				l_content.append (" type=%"" + test_class_type_string (l_class) + "%" >%N")

				l_routine_list := l_class.test_routines
				if not l_routine_list.is_empty then
					l_routine_list.start
					l_routine  := l_routine_list.item_for_iteration
					l_content.append ("%T%T<test_routine " + test_routine_attribute_string (l_routine) + ">%N")
					l_content.append (l_routine.status_string_verbose)
					l_content.append ("%T%T</test_routine>")
					l_routine_list.forth
					from
					until
						l_routine_list.after
					loop
						l_routine  := l_routine_list.item_for_iteration
						l_content.append ("%N%T%T<test_routine " + test_routine_attribute_string (l_routine) + ">%N")
						l_content.append (l_routine.status_string_verbose)
						l_content.append ("%T%T</test_routine>")
						l_routine_list.forth
					end
				end
				l_content.append ("%N</test_class>")

				if l_class.compiled_class /= Void then
					l_number_of_manual_test_classes := l_number_of_manual_test_classes + l_class.is_manual.to_integer
					l_number_of_extracted_test_classes := l_number_of_extracted_test_classes + l_class.is_extracted.to_integer
					l_number_of_synthesized_test_classes := l_number_of_synthesized_test_classes + l_class.is_synthesized.to_integer
				end

				l_class_list.forth
				from
				until
					l_class_list.after
				loop
					l_class := l_class_list.item_for_iteration
					l_content.append_string ("%N%T<test_class name=%"" + empty_or_out (l_class.cdd_id) + "--" + l_class.test_class_name + "%"")
					l_content.append (" number_of_test_routines=%"" + l_class.test_routines.count.out + "%"")
					l_content.append (" type=%"" + test_class_type_string (l_class) + "%" >%N")

					l_routine_list := l_class.test_routines
					if not l_routine_list.is_empty then
						l_routine_list.start
						l_routine  := l_routine_list.item_for_iteration
						l_content.append ("%T%T<test_routine " + test_routine_attribute_string (l_routine) + ">%N")
						l_content.append (l_routine.status_string_verbose)
						l_content.append ("%T%T</test_routine>")
						l_routine_list.forth
						from
						until
							l_routine_list.after
						loop
							l_routine  := l_routine_list.item_for_iteration
							l_content.append ("%N%T%T<test_routine " + test_routine_attribute_string (l_routine) + ">%N")
							l_content.append (l_routine.status_string_verbose)
							l_content.append ("%T%T</test_routine>")
							l_routine_list.forth
						end
					end
					l_content.append ("%N%T</test_class>")

					if l_class.compiled_class /= Void then
						l_number_of_manual_test_classes := l_number_of_manual_test_classes + l_class.is_manual.to_integer
						l_number_of_extracted_test_classes := l_number_of_extracted_test_classes + l_class.is_extracted.to_integer
						l_number_of_synthesized_test_classes := l_number_of_synthesized_test_classes + l_class.is_synthesized.to_integer
					end

					l_class_list.forth
				end
			end
			l_attributes.append_string (" number_of_manual_test_cases=%"" + l_number_of_manual_test_classes.out + "%"")
			l_attributes.append_string (" number_of_extracted_test_cases=%"" + l_number_of_extracted_test_classes.out + "%"")
			l_attributes.append_string (" number_of_synthesized_test_cases=%"" + l_number_of_synthesized_test_classes.out + "%"")
			l_attributes.append_string (" message=%"" + a_message + "%"")

			log_element ( "test_suite", l_attributes,  l_content)
		end

feature -- Logging (Interpreter Compiler)

	report_interpreter_compilation_start is
			-- Start construction of interpreter compilation message.
		do
			create current_interpreter_compilation_start.make_now
			current_interpreter_compilation_element := ["", ""]
		end

	report_interpreter_compilation_end is
			-- Finish and write interpreter compilation message.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
		do
			create l_time.make_now
			l_duration_sec := l_time.definite_duration (current_interpreter_compilation_start).fine_seconds_count
			log_element ("interpreter_compilation", "status=%"completed%" duration=%"" + l_duration_sec.out + "%"", Void)
		end

	report_interpreter_compilation_abort is
			-- Finish and write interpreter compilation message.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
		do
			create l_time.make_now
			l_duration_sec := l_time.definite_duration (current_interpreter_compilation_start).fine_seconds_count
			log_element ("interpreter_compilation", "status=%"aborted%" duration=%"" + l_duration_sec.out + "%"", Void)
		end

	report_interpreter_compilation_error is
			-- Finish and write interpreter compilation message.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
		do
			create l_time.make_now
			l_duration_sec := l_time.definite_duration (current_interpreter_compilation_start).fine_seconds_count
			log_element ("interpreter_compilation", "status=%"error%" duration=%"" + l_duration_sec.out + "%"", Void)
		end

feature -- Logging (Execution)

	report_test_case_execution_start is
			-- Start construction of `current_test_case_execution_element'.
		local
			l_time: DATE_TIME
		do
			create l_time.make_now
			current_test_case_execution_element := ["", ""]
		end

	report_test_case_execution (a_start_time: DATE_TIME; an_end_time: DATE_TIME; a_routine: CDD_TEST_ROUTINE) is
			-- Add the execution of an individual test routine to the `current_test_case_execution_element'.
		local
			l_duration_sec: REAL_64
		do
			l_duration_sec := an_end_time.definite_duration (a_start_time).fine_seconds_count
			current_test_case_execution_element.content.append_string ("%T<test_case_execution")
			current_test_case_execution_element.content.append_string (" duration = %"" + l_duration_sec.out + "%" ")
			current_test_case_execution_element.content.append_string (test_routine_attribute_string (a_routine) + "/>%N")
		end

	report_test_case_execution_end is
			-- finalize `current_test_case_execution_element' and write it to the log.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
		do
			create l_time.make_now
			l_duration_sec := l_time.definite_duration (current_interpreter_compilation_start).fine_seconds_count
			current_test_case_execution_element.head.append_string (" status=%"completed%" duration=%"" + l_duration_sec.out + "%"")
			log_element ("execution", current_test_case_execution_element.head, current_test_case_execution_element.content)
		end

	report_test_case_execution_abort is
			-- finalize `current_test_case_execution_element' and write it to the log.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
		do
			create l_time.make_now
			l_duration_sec := l_time.definite_duration (current_interpreter_compilation_start).fine_seconds_count
			current_test_case_execution_element.head.append_string (" status=%"aborted%" duration=%"" + l_duration_sec.out + "%"")
			log_element ("execution", current_test_case_execution_element.head, current_test_case_execution_element.content)
		end

feature {NONE} -- Implementation

	log_element (an_element_name: STRING; an_attrib_string: STRING; an_element_content: STRING) is
			-- write a message to the log
		local
			l_time: DATE_TIME
		do
			create l_time.make_now
			output_stream.put_string ("<" + an_element_name + " time=%"" + l_time.out + "%" " + an_attrib_string)
			if an_element_content = Void then
				output_stream.put_string ("/>%N")
			else
				output_stream.put_string (">%N")
				output_stream.put_string (an_element_content)
				output_stream.put_string ("%N</" + an_element_name + ">%N")
			end
			output_stream.flush
		end

	empty_or_out (an_any: ANY): STRING is
			-- Return `an_any.out' or empty string if `an_any' is Void.
		do
			if an_any /= Void then
				Result := an_any.out
			else
				Result := ""
			end
		end

	test_routine_attribute_string (a_routine: CDD_TEST_ROUTINE): STRING is
			-- String containing xml-like attributes for `a_routine'
		local
			l_outcome: CDD_TEST_EXECUTION_RESPONSE
		do
			Result := ""
			Result.append ( "name=%"" + empty_or_out (a_routine.test_class.cdd_id) + "--" + a_routine.test_class.test_class_name + "--" + a_routine.name + "%"")
			Result.append (" type=%"" + test_class_type_string (a_routine.test_class) + "%"")
			Result.append (" has_outcome=%"" + a_routine.has_outcome.out + "%"")
			Result.append (" has_original_outcome=%"" + a_routine.has_original_outcome.out + "%"")
			if a_routine.has_outcome and a_routine.has_original_outcome then
				Result.append (" is_reproducing=%"" + a_routine.is_reproducing.out + "%"")
			else
				Result.append (" is_reproducing=%"unknown%"")
			end

			if a_routine.has_outcome then
				l_outcome := a_routine.outcomes.last
				Result.append (" is_pass=%"" + l_outcome.is_pass.out + "%"")
				Result.append (" is_fail=%"" + l_outcome.is_fail.out + "%"")
				Result.append (" is_unresolved=%"" + l_outcome.is_unresolved.out + "%"")
				Result.append (" requires_maintenance=%"" + l_outcome.requires_maintenance.out + "%"")
				Result.append (" has_compile_error=%"" + l_outcome.has_compile_error.out + "%"")
				Result.append (" has_bad_context=%"" + l_outcome.has_bad_context.out + "%"")
				Result.append (" has_bad_communication=%"" + l_outcome.has_bad_communication.out + "%"")
				Result.append (" has_timeout=%"" + l_outcome.has_timeout.out + "%"")
			end

		end

	test_class_type_string (a_test_class: CDD_TEST_CLASS): STRING is
			-- Return string representing type of test class.
			-- Return empty string if type is not known (due to missing compiled class)
		require
			a_test_class_not_void: a_test_class /= Void
		do
			if a_test_class.compiled_class /= Void then
				if a_test_class.is_extracted then
					Result := "extracted"
				elseif a_test_class.is_synthesized then
					Result := "synthesized"
				else
					Result := "manual"
				end
			else
				Result := ""
			end
		ensure
			Result_not_void: Result /= Void
		end


	current_test_case_execution_element: TUPLE [head: STRING; content: STRING]
	current_test_case_execution_start: DATE_TIME

	current_interpreter_compilation_element: TUPLE [head: STRING; content: STRING]
	current_interpreter_compilation_start: DATE_TIME

	current_test_case_extracting_element: TUPLE [head: STRING; content: STRING]
	current_test_case_extracting_start: DATE_TIME

	current_test_case_printing_element: TUPLE [head: STRING; content: STRING]
	current_test_case_printing_start: DATE_TIME


	output_stream: KI_TEXT_OUTPUT_STREAM
			-- All loging messages are written to this stream

invariant
	output_stream_not_void: output_stream /= Void

end
