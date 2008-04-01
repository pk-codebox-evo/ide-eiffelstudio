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
		local
			l_attributes: STRING_8
		do
			l_attributes := ""
			append_xml_attribute (l_attributes, "project_name", empty_or_out (a_project_name))
			append_xml_attribute (l_attributes, "target_name", empty_or_out (a_target_name))
			append_xml_attribute (l_attributes, "is_extracting", empty_or_out (an_extracting_status))
			append_xml_attribute (l_attributes, "is_executing", empty_or_out (an_execution_status))
			append_xml_attribute (l_attributes, "message", empty_or_out (a_message))
			log_element ("system", l_attributes, Void)
		end

	report_exception (an_original_outcome: CDD_ORIGINAL_OUTCOME) is
			-- Log a thrown exception represented by `an_original_outcome'.
		local
			l_attributes: STRING_8
		do
				-- Logging is robust.. (this should be a precondition... not an if condition)
			if an_original_outcome.is_failing then
				l_attributes := ""
				append_xml_attribute (l_attributes, "code", an_original_outcome.exception_code.out)
				append_xml_attribute (l_attributes, "name", an_original_outcome.exception_name)
				append_xml_attribute (l_attributes, "tag", an_original_outcome.exception_tag_name)
				append_xml_attribute (l_attributes, "recipient", an_original_outcome.exception_recipient_name)
				append_xml_attribute (l_attributes, "class", an_original_outcome.exception_class_name)
				log_element ("exception", l_attributes, an_original_outcome.exception_trace)
			end
		end

	report_sut_debugging_start is
			-- Log start of sut debugging.
		do
			create current_sut_debugging_start.make_now
			log_element ("sut_debugging", " status=%"started%"", Void)
		end

	report_sut_debugging_end is
			-- Log stop of sut debugging.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
			l_attributes: STRING
		do
			create l_time.make_now

				-- NOTE: In case `report_sut_debugging_start' has not been called before last call to `report_sut_debugging_end',
				-- the following handling will lead to a negative duration. This can be used as an error flag.
			l_attributes := " "
			append_xml_attribute (l_attributes, "status", "ended")
			if current_sut_debugging_start = Void then
				append_xml_attribute (l_attributes, "duration", "-1")
			else
				l_duration_sec := l_time.definite_duration (current_sut_debugging_start).fine_seconds_count
				append_xml_attribute (l_attributes, "duration", l_duration_sec.out)
			end

			log_element ("sut_debugging", l_attributes, Void)

			current_sut_debugging_start := Void
		end

	report_test_case_foreground_execution_start (a_test_routine: CDD_TEST_ROUTINE) is
			-- Log start of foreground execution of `a_test_routine'.
		local
			l_attributes: STRING
		do
			create current_test_case_foreground_execution_start.make_now

			l_attributes := ""
			append_xml_attribute (l_attributes, "status", "started")
			l_attributes.append_string (" " + test_routine_attribute_string (a_test_routine))

			log_element ("test_case_foreground_execution", l_attributes, Void)
		end

	report_test_case_foreground_execution_end is
			-- Log end of foreground execution of some test case.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
			l_attributes: STRING
		do
			create l_time.make_now

				-- NOTE: In case `report_test_case_foreground_execution_start' has not been called before last call to
				-- `report_test_case_foreground_execution_end',
				-- the following handling will lead to a negative duration. This can be used as an error flag.
			l_attributes := ""
			append_xml_attribute (l_attributes, "status", "ended")
			if current_test_case_foreground_execution_start = Void then
				append_xml_attribute (l_attributes, "duration", "-1")
			else
				l_duration_sec := l_time.definite_duration (current_test_case_foreground_execution_start).fine_seconds_count
				append_xml_attribute (l_attributes, "duration", l_duration_sec.out)
			end

			log_element ("test_case_foreground_execution", l_attributes, Void)

			current_test_case_foreground_execution_start := Void
		end

feature {NONE} -- Implementation (System)

	current_sut_debugging_start: DATE_TIME
			-- Start time of current sut debugging

	current_test_case_foreground_execution_start: DATE_TIME
			-- Start time of current foreground test case execution

feature -- Logging (Test Suite)

	report_test_suite_status (a_test_suite: CDD_TEST_SUITE; a_start_time: DATE_TIME; an_end_time: DATE_TIME; a_message: STRING) is
			-- Write a test suite status message.
		local
			l_duration_sec: REAL_64
			l_attributes: STRING
			l_content: STRING
			l_routine_status: STRING
			l_class_list: DS_ARRAYED_LIST [CDD_TEST_CLASS]
			l_class: CDD_TEST_CLASS
			l_routine_list: DS_LIST [CDD_TEST_ROUTINE]
			l_routine: CDD_TEST_ROUTINE
			l_number_of_manual_test_classes: INTEGER
			l_number_of_extracted_test_classes: INTEGER
			l_number_of_synthesized_test_classes: INTEGER
		do
			l_class_list := a_test_suite.test_classes
			l_duration_sec := an_end_time.definite_duration (a_start_time).fine_seconds_count
			l_attributes := ""
			append_xml_attribute (l_attributes, "duration", l_duration_sec.out)
			append_xml_attribute (l_attributes, "number_of_test_classes", l_class_list.count.out)
			l_content := ""
			if not l_class_list.is_empty then
				l_class_list.start
				l_class := l_class_list.item_for_iteration
				l_content.append_string ("%T<test_class" + test_class_attribute_string (l_class) + " >%N")
				l_routine_list := l_class.test_routines
				if not l_routine_list.is_empty then
					l_routine_list.start
					l_routine  := l_routine_list.item_for_iteration
					l_content.append ("%T%T<test_routine " + test_routine_attribute_string (l_routine) + ">%N")
					l_routine_status := ""
					if l_routine.has_outcome then
						l_routine_status.append ("****last_execution_trace:%N")
						l_routine_status.append (replace_xml_entities (l_routine.outcomes.last.out_trace))
					end
					if l_routine.has_original_outcome then
						l_routine_status.append ("****original_trace:%N")
						l_routine_status.append (replace_xml_entities (l_routine.original_outcome.exception_trace))
					end
					l_routine_status.prune_all_leading ('%N')
					l_routine_status.prune_all_trailing ('%N')
					l_content.append ("%N" + l_routine_status + "%N")
					l_content.append ("%T%T</test_routine>")
					l_routine_list.forth
					from
					until
						l_routine_list.after
					loop
						l_routine  := l_routine_list.item_for_iteration
						l_content.append ("%N%T%T<test_routine " + test_routine_attribute_string (l_routine) + ">%N")
						l_routine_status := ""
						if l_routine.has_outcome then
							l_routine_status.append ("****last_execution_trace:%N")
							l_routine_status.append (replace_xml_entities (l_routine.outcomes.last.out_trace))
						end
						if l_routine.has_original_outcome then
							l_routine_status.append ("****original_trace:%N")
							l_routine_status.append (replace_xml_entities (l_routine.original_outcome.exception_trace))
						end
						l_routine_status.prune_all_leading ('%N')
						l_routine_status.prune_all_trailing ('%N')
						l_content.append ("%N" + l_routine_status + "%N")
						l_content.append ("%T%T</test_routine>")
						l_routine_list.forth
					end
				end
				l_content.append ("%N%T</test_class>")

				l_number_of_manual_test_classes := l_number_of_manual_test_classes + l_class.is_manual.to_integer
				l_number_of_extracted_test_classes := l_number_of_extracted_test_classes + l_class.is_extracted.to_integer
				l_number_of_synthesized_test_classes := l_number_of_synthesized_test_classes + l_class.is_synthesized.to_integer

				l_class_list.forth
				from
				until
					l_class_list.after
				loop
					l_class := l_class_list.item_for_iteration
					l_content.append_string ("%N%T<test_class" + test_class_attribute_string (l_class) + " >%N")
					l_routine_list := l_class.test_routines
					if not l_routine_list.is_empty then
						l_routine_list.start
						l_routine  := l_routine_list.item_for_iteration
						l_content.append ("%T%T<test_routine " + test_routine_attribute_string (l_routine) + ">%N")
						l_routine_status := ""
						if l_routine.has_outcome then
							l_routine_status.append ("****last_execution_trace:%N")
							l_routine_status.append (replace_xml_entities (l_routine.outcomes.last.out_trace))
						end
						if l_routine.has_original_outcome then
							l_routine_status.append ("****original_trace:%N")
							l_routine_status.append (replace_xml_entities (l_routine.original_outcome.exception_trace))
						end
						l_routine_status.prune_all_leading ('%N')
						l_routine_status.prune_all_trailing ('%N')
						l_content.append ("%N" + l_routine_status + "%N")
						l_content.append ("%T%T</test_routine>")
						l_routine_list.forth
						from
						until
							l_routine_list.after
						loop
							l_routine  := l_routine_list.item_for_iteration
							l_content.append ("%N%T%T<test_routine " + test_routine_attribute_string (l_routine) + ">%N")
							l_routine_status := ""
							if l_routine.has_outcome then
								l_routine_status.append ("****last_execution_trace:%N")
								l_routine_status.append (replace_xml_entities (l_routine.outcomes.last.out_trace))
							end
							if l_routine.has_original_outcome then
							l_routine_status.append ("****original_trace:%N")
								l_routine_status.append (replace_xml_entities (l_routine.original_outcome.exception_trace))
							end
							l_routine_status.prune_all_leading ('%N')
							l_routine_status.prune_all_trailing ('%N')
							l_content.append ("%N" + l_routine_status + "%N")
							l_content.append ("%T%T</test_routine>")
							l_routine_list.forth
						end
					end
					l_content.append ("%N%T</test_class>")

					l_number_of_manual_test_classes := l_number_of_manual_test_classes + l_class.is_manual.to_integer
					l_number_of_extracted_test_classes := l_number_of_extracted_test_classes + l_class.is_extracted.to_integer
					l_number_of_synthesized_test_classes := l_number_of_synthesized_test_classes + l_class.is_synthesized.to_integer

					l_class_list.forth
				end
			end
			append_xml_attribute (l_attributes, "number_of_manual_test_cases", l_number_of_manual_test_classes.out)
			append_xml_attribute (l_attributes, "number_of_extracted_test_cases", l_number_of_extracted_test_classes.out)
			append_xml_attribute (l_attributes, "number_of_synthesized_test_cases", l_number_of_synthesized_test_classes.out)
			append_xml_attribute (l_attributes, "message", a_message)

			log_element ( "test_suite", l_attributes,  l_content)
		end

feature -- Logging (Interpreter Compiler)

	report_interpreter_compilation_start is
			-- Start construction of interpreter compilation message.
		do
			create current_interpreter_compilation_start.make_now
		ensure
			current_interpreter_compilation_start_not_void: current_interpreter_compilation_start /= Void
		end

	report_interpreter_compilation_end is
			-- Finish and write interpreter compilation message.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
			l_attributes: STRING
		do
			create l_time.make_now

				-- NOTE: In case `report_interpreter_compilation_start' has not been called before this,
				-- a negative duration is inserted. This can be used as an error flag.
			l_attributes := ""
			if current_interpreter_compilation_start = Void then
				append_xml_attribute (l_attributes, "duration", "-1")
			else
				l_duration_sec := l_time.definite_duration (current_interpreter_compilation_start).fine_seconds_count
				append_xml_attribute (l_attributes, "duration", l_duration_sec.out)
			end

			append_xml_attribute (l_attributes, "status", "completed")
			log_element ("interpreter_compilation", l_attributes, Void)

			current_interpreter_compilation_start := Void
		ensure
			current_interpreter_compilation_start_reset: current_interpreter_compilation_start = Void
		end


	report_interpreter_compilation_abort is
			-- Finish and write interpreter compilation message.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
			l_attributes: STRING
		do
			create l_time.make_now

				-- NOTE: In case `report_interpreter_compilation_start' has not been called before this,
				-- a negative duration is inserted. This can be used as an error flag.
			l_attributes := ""
			if current_interpreter_compilation_start = Void then
				append_xml_attribute (l_attributes, "duration", "-1")
			else
				l_duration_sec := l_time.definite_duration (current_interpreter_compilation_start).fine_seconds_count
				append_xml_attribute (l_attributes, "duration", l_duration_sec.out)
			end

			append_xml_attribute (l_attributes, "status", "abort")
			log_element ("interpreter_compilation", l_attributes, Void)

			current_interpreter_compilation_start := Void
		ensure
			current_interpreter_compilation_start_reset: current_interpreter_compilation_start = Void
		end

	report_interpreter_compilation_error is
			-- Finish and write interpreter compilation message.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
			l_attributes: STRING
		do
			create l_time.make_now

				-- NOTE: In case `report_interpreter_compilation_start' has not been called before this,
				-- a negative duration is inserted. This can be used as an error flag.
			l_attributes := ""
			if current_interpreter_compilation_start = Void then
				append_xml_attribute (l_attributes, "duration", "-1")
			else
				l_duration_sec := l_time.definite_duration (current_interpreter_compilation_start).fine_seconds_count
				append_xml_attribute (l_attributes, "duration", l_duration_sec.out)
			end

			append_xml_attribute (l_attributes, "status", "error")
			log_element ("interpreter_compilation", l_attributes, Void)

			current_interpreter_compilation_start := Void
		ensure
			current_interpreter_compilation_start_reset: current_interpreter_compilation_start = Void
		end

feature {NONE} -- Implementation (Interpreter Compiler)

	current_interpreter_compilation_start: DATE_TIME
			-- Start time of current interpreter compilation

feature -- Logging (SUT Compiler)

	report_compilation_start is
			-- Start construction of interpreter compilation message.
		do
			create current_sut_compilation_start.make_now
		ensure
			current_sut_compilation_start_not_void: current_sut_compilation_start /= Void
		end

	report_compilation_end is
			-- Finish and write interpreter compilation message.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
			l_attributes: STRING
		do
			create l_time.make_now

				-- NOTE: In case `report_compilation_start' has not been called before last call to `report_compilation_end',
				-- the following handling will lead to a negative duration. This can be used as an error flag.
			l_attributes := ""
			if current_sut_compilation_start = Void then
				append_xml_attribute (l_attributes, "duration", "-1")
			else
				l_duration_sec := l_time.definite_duration (current_sut_compilation_start).fine_seconds_count
				append_xml_attribute (l_attributes, "duration", l_duration_sec.out)
			end

			append_xml_attribute (l_attributes, "status", "ended")
			log_element ("sut_compilation", l_attributes, Void)

			current_sut_compilation_start := Void
		ensure
			current_sut_compilation_start_reset: current_sut_compilation_start = Void
		end

feature {NONE} -- Implementation (SUT Compiler)

	current_sut_compilation_start: DATE_TIME
			-- Start time of current sut compilation

feature -- Logging (Extraction - Capturing)

	report_extraction_start is
			-- Start construction of extraction message.
		do
			create current_test_case_extracting_start.make_now
			current_test_case_extracting_element := ""
			number_of_extracted_test_cases := 0
		ensure
			current_test_case_extracting_start_not_void: current_test_case_extracting_start /= Void
		end

	report_extraction (a_start_time: DATE_TIME; an_end_time: DATE_TIME; an_invocation: CDD_ROUTINE_INVOCATION) is
			-- Add extraction element to content of `current_test_case_extracting_element'.
		local
			l_duration_sec: REAL_64
			l_attributes: STRING
		do
			l_duration_sec := an_end_time.definite_duration (a_start_time).fine_seconds_count
			l_attributes := ""
			append_xml_attribute (l_attributes, "duration", l_duration_sec.out)
			l_attributes.append_string (routine_invocation_attribute_string (an_invocation))
			current_test_case_extracting_element.append_string ("%T<extraction" + l_attributes + "/>%N")
			number_of_extracted_test_cases := number_of_extracted_test_cases + 1
		end


	report_extraction_end is
			-- Finish and write extraction message.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
			l_attributes: STRING
		do
			create l_time.make_now

				-- NOTE: In case `report_extraction_start' has not been called before this,
				-- the following handling will lead to a negative duration and potentially corrupt content is wiped out.
				-- This can be used as an error flag.
			l_attributes := ""
			if current_test_case_extracting_start = Void then
				append_xml_attribute (l_attributes, "duration", "-1")
				current_test_case_extracting_element := ""
			else
				l_duration_sec := l_time.definite_duration (current_test_case_extracting_start).fine_seconds_count
				append_xml_attribute (l_attributes, "duration", l_duration_sec.out)
			end

			append_xml_attribute (l_attributes, "number_of_extracted_test_cases", number_of_extracted_test_cases.out)
			log_element ("test_case_extraction", l_attributes, current_test_case_extracting_element)

			current_test_case_extracting_start := Void
		ensure
			current_test_case_extracting_start_reset: current_test_case_extracting_start = Void
		end

feature {NONE} -- Implementation (Extraction - Capturing)

	current_test_case_extracting_element: STRING
			-- Element describing the current test case extraction

	current_test_case_extracting_start: DATE_TIME
			-- Start time of current test case extraction

	number_of_extracted_test_cases: INTEGER_32

feature -- Logging (Extraction - Printing)

	report_printing_start is
			-- Start construction of test case printing message.
		do
			create current_test_case_printing_start.make_now
			current_test_case_printing_element := ""
			number_of_printed_test_cases := 0
		ensure
			current_test_case_printing_start_not_void: current_test_case_printing_start /= Void
		end

	report_printing (a_start_time: DATE_TIME; an_end_time: DATE_TIME; a_test_class: CDD_TEST_CLASS; a_is_replacing_flag: BOOLEAN; a_is_duplicate_flag: BOOLEAN) is
			-- Add test class printing element to content of `current_test_case_printing_element'.
		local
			l_duration_sec: REAL_64
			l_attributes: STRING
			l_routine: CDD_TEST_ROUTINE
			l_routine_status: STRING
			l_content: STRING
		do
			l_duration_sec := an_end_time.definite_duration (a_start_time).fine_seconds_count
			l_attributes := ""
			append_xml_attribute (l_attributes, "duration", l_duration_sec.out)
			l_attributes.append_string (test_class_attribute_string (a_test_class))
				-- Extracted test classes are supposed to have exactly one test routine, but we go for sure here
			l_content := ""
			if a_test_class.test_routines /= Void and then not a_test_class.test_routines.is_empty then
				l_routine := a_test_class.test_routines.first
				l_content.append ("%T%T<test_routine " + test_routine_attribute_string (l_routine))
				l_content.append (" is_replacing=%"" + a_is_replacing_flag.out + "%">%N")
				l_content.append (" was_duplicate=%"" + a_is_duplicate_flag.out + "%">%N")
				l_routine_status := replace_xml_entities (l_routine.status_string_verbose)
				l_routine_status.prune_all_leading ('%N')
				l_routine_status.prune_all_trailing ('%N')
				l_content.append ("%N" + l_routine_status + "%N")
				l_content.append ("%T%T</test_routine>%N")
			end
			current_test_case_printing_element.append_string ("%T<test_routine_printing" + l_attributes + ">%N")
			current_test_case_printing_element.append_string (l_content)
			current_test_case_printing_element.append_string ("%T</test_routine_printing>%N")
			number_of_printed_test_cases := number_of_printed_test_cases + 1
		end


	report_printing_end is
			-- Finish and write test case printing message.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
			l_attributes: STRING
		do
			create l_time.make_now

				-- NOTE: In case `report_printing_start' has not been called before this,
				-- the following handling will lead to a negative duration and potentially corrupt content is wiped out.
				-- This can be used as an error flag.
			l_attributes := ""
			if current_test_case_printing_start = Void then
				append_xml_attribute (l_attributes, "duration", "-1")
				current_test_case_printing_element := ""
			else
				l_duration_sec := l_time.definite_duration (current_test_case_printing_start).fine_seconds_count
				append_xml_attribute (l_attributes, "duration", l_duration_sec.out)
			end

			append_xml_attribute (l_attributes, "number_of_printed_test_cases", number_of_printed_test_cases.out)
			log_element ("test_case_printing", l_attributes, current_test_case_printing_element)

			current_test_case_printing_start := Void
		ensure
			current_test_case_printing_start_reset: current_test_case_printing_start = Void
		end

feature {NONE} -- Implementation (Extraction - Printing)

	current_test_case_printing_element: STRING
			-- Element describing the current printing of test cases

	current_test_case_printing_start: DATE_TIME
			-- Start time of current test case printing

	number_of_printed_test_cases: INTEGER
			-- Number of printed test cases

feature -- Logging (Execution)

	report_test_case_execution_start is
			-- Start construction of `current_test_case_execution_element'.
		do
			create current_test_case_execution_start.make_now
			current_test_case_execution_element := ""
		ensure
			current_test_case_execution_start_not_void: current_test_case_execution_start /= Void
		end

	report_test_case_execution (a_start_time: DATE_TIME; an_end_time: DATE_TIME; a_routine: CDD_TEST_ROUTINE) is
			-- Add the execution of an individual test routine to the `current_test_case_execution_element'.
		local
			l_duration_sec: REAL_64
			l_attributes: STRING
		do
			l_duration_sec := an_end_time.definite_duration (a_start_time).fine_seconds_count
			l_attributes := ""
			append_xml_attribute (l_attributes, "duration", l_duration_sec.out)
			l_attributes.append_string (test_routine_attribute_string (a_routine))
			current_test_case_execution_element.append_string ("%T<test_case_execution" + l_attributes + "/>%N")
		end

	report_test_case_execution_end is
			-- finalize `current_test_case_execution_element' and write it to the log.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
			l_attributes: STRING
		do
			create l_time.make_now

				-- NOTE: In case `report_test_case_execution_start' has not been called before last call to `report_compilation_end',
				-- the following handling will lead to a negative duration and potentially corrupt content is wiped out.
				-- This can be used as an error flag.
			l_attributes := ""
			if current_test_case_execution_start = Void then
				append_xml_attribute (l_attributes, "duration", "-1")
				current_test_case_execution_element := ""
			else
				l_duration_sec := l_time.definite_duration (current_test_case_execution_start).fine_seconds_count
				append_xml_attribute (l_attributes, "duration", l_duration_sec.out)
			end

			append_xml_attribute (l_attributes, "status", "completed")
			log_element ("execution", l_attributes, current_test_case_execution_element)

			current_test_case_execution_start := Void
		ensure
			current_test_case_execution_start_reset: current_test_case_execution_start = Void
		end

	report_test_case_execution_abort is
			-- finalize `current_test_case_execution_element' and write it to the log.
		local
			l_time: DATE_TIME
			l_duration_sec: REAL_64
			l_attributes: STRING
		do
			create l_time.make_now

				-- NOTE: In case `report_test_case_execution_start' has not been called before last call to `report_compilation_end',
				-- the following handling will lead to a negative duration and potentially corrupt content is wiped out.
				-- This can be used as an error flag.
			l_attributes := ""
			if current_test_case_execution_start = Void then
				append_xml_attribute (l_attributes, "duration", "-1")
				current_test_case_execution_element := ""
			else
				l_duration_sec := l_time.definite_duration (current_test_case_execution_start).fine_seconds_count
				append_xml_attribute (l_attributes, "duration", l_duration_sec.out)
			end

			append_xml_attribute (l_attributes, "status", "aborted")
			log_element ("execution", l_attributes, current_test_case_execution_element)

			current_test_case_execution_start := Void
		ensure
			current_test_case_execution_start_reset: current_test_case_execution_start = Void
		end

feature {NONE} -- Implementation (Execution)

	current_test_case_execution_element: STRING
			-- Element describing current test case execution

	current_test_case_execution_start: DATE_TIME
			-- Start time of current test case execution

feature {NONE} -- Implementation

	log_element (an_element_name: STRING; an_attrib_string: STRING; an_element_content: STRING) is
			-- write a message to the log
		local
			l_time: DATE_TIME
			l_attributes: STRING
		do
			create l_time.make_now
			l_attributes := ""
			append_xml_attribute (l_attributes, "timestamp", l_time.out)
			l_attributes.append_string(an_attrib_string)
			output_stream.put_string ("<" + an_element_name + l_attributes)
			if an_element_content = Void then
				output_stream.put_string ("/>%N")
			else
				output_stream.put_string (">%N")
				an_element_content.prune_all_leading ('%N')
				an_element_content.prune_all_trailing ('%N')
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

	test_class_attribute_string (a_class: CDD_TEST_CLASS): STRING is
			-- String containing XML attributes for `a_class'
		do
			Result := ""
			append_xml_attribute (Result, "name", empty_or_out (a_class.cdd_id) + "--" + a_class.test_class_name)
			append_xml_attribute (Result, "number_of_test_routines", a_class.test_routines.count.out)
			append_xml_attribute (Result, "is_manual", a_class.is_manual.out)
			append_xml_attribute (Result, "is_synthesized", a_class.is_synthesized.out)
			append_xml_attribute (Result, "is_extracted", a_class.is_extracted.out)
		ensure
			result_not_void: Result /= Void
		end

	test_routine_attribute_string (a_routine: CDD_TEST_ROUTINE): STRING is
			-- String containing xml-like attributes for `a_routine'
		local
			l_outcome: CDD_TEST_EXECUTION_RESPONSE
			l_orig: CDD_ORIGINAL_OUTCOME
			l_values: DS_LIST [STRING]
		do
			Result := ""
			append_xml_attribute (Result, "name", empty_or_out (a_routine.test_class.cdd_id) + "--" + a_routine.test_class.test_class_name + "--" + a_routine.name)
			append_xml_attribute (Result, "type", test_class_type_string (a_routine.test_class))

			l_values := a_routine.tags_with_prefix ("failure.")
			if not l_values.is_empty then
				append_xml_attribute (Result, "failure_id", l_values.first)
			end

			append_xml_attribute (Result, "outcome", a_routine.has_outcome.out)
			append_xml_attribute (Result, "original_outcome", a_routine.has_original_outcome.out)
			append_xml_attribute (Result, "reproducing_outcome", a_routine.has_reproducing_outcome.out)

			if a_routine.has_outcome then
				l_outcome := a_routine.outcomes.last
				append_xml_attribute (Result, "maintenance", l_outcome.requires_maintenance.out)
				append_xml_attribute (Result, "bad_communication", l_outcome.has_bad_communication.out )
				append_xml_attribute (Result, "timeout", l_outcome.has_timeout.out)
				append_xml_attribute (Result, "pass", l_outcome.is_pass.out)
				append_xml_attribute (Result, "fail", l_outcome.is_fail.out)
				append_xml_attribute (Result, "unresolved", l_outcome.is_unresolved.out)
				if l_outcome.is_unresolved then
					append_xml_attribute (Result, "compile_error", l_outcome.has_compile_error.out )
					append_xml_attribute (Result, "bad_context", l_outcome.has_bad_context.out)
				elseif l_outcome.is_fail then
					append_xml_attribute (Result, "le_code", l_outcome.test_response.exception.exception_code.out)
					append_xml_attribute (Result, "le_name", l_outcome.test_response.exception.exception_name)
					append_xml_attribute (Result, "le_tag", l_outcome.test_response.exception.exception_tag_name)
					append_xml_attribute (Result, "le_recipient", l_outcome.test_response.exception.exception_recipient_name)
					append_xml_attribute (Result, "le_class", l_outcome.test_response.exception.exception_class_name)
				end
			end

			if a_routine.has_original_outcome then
				l_orig := a_routine.original_outcome
				append_xml_attribute (Result, "orig_is_fail", l_orig.is_failing.out)
				if l_orig.is_failing then
					append_xml_attribute (Result, "oe_code", l_orig.exception_code.out)
					append_xml_attribute (Result, "oe_name", l_orig.exception_name)
					append_xml_attribute (Result, "oe_tag", l_orig.exception_tag_name)
					append_xml_attribute (Result, "oe_recipient", l_orig.exception_recipient_name)
					append_xml_attribute (Result, "oe_class", l_orig.exception_class_name)
				end
			end
		end

	routine_invocation_attribute_string (an_invocation: CDD_ROUTINE_INVOCATION): STRING is
			-- String containing xml-like attributes for `an_invocation'
		do
			Result := ""
			append_xml_attribute (Result, "covered_class", an_invocation.operand_type_list.first)
			append_xml_attribute (Result, "covered_feature", an_invocation.represented_feature.name)
			append_xml_attribute (Result, "is_creation_feature", an_invocation.is_creation_feature.out)
			append_xml_attribute (Result, "call_stack_id", an_invocation.call_stack_id.out)
			append_xml_attribute (Result, "call_stack_index", an_invocation.call_stack_index.out)
			append_xml_attribute (Result, "nr_of_context_objects", an_invocation.context.count.out)
			append_xml_attribute (Result, "is_once", an_invocation.represented_feature.is_once.out)
		end

	test_class_type_string (a_test_class: CDD_TEST_CLASS): STRING is
			-- Return string representing type of test class.
			-- Return empty string if type is not known (due to missing compiled class)
		require
			a_test_class_not_void: a_test_class /= Void
		do
			if a_test_class.is_extracted then
				Result := "extracted"
			elseif a_test_class.is_synthesized then
				Result := "synthesized"
			else
				Result := "manual"
			end
		ensure
			Result_not_void: Result /= Void
		end

	append_xml_attribute (an_attribute_string, a_new_attribute_name, a_new_attribute_value: STRING_8) is
			-- Appends to `an_attribute_string' a new XML attribute with name `a_new_attribute_name' and value `a_new_attribute_value'.
		do
			an_attribute_string.append (" " + a_new_attribute_name + "=%"" + replace_xml_entities_for_attribute (a_new_attribute_value) + "%"")
		end

	replace_xml_entities_for_attribute (a_string: STRING_8): STRING_8
			-- New string equal to `a_string' except for replacement of characters
			-- <, >, &, ', " by corresponding XML entity
		require
			a_string_not_void: a_string /= Void
		local
			i: INTEGER
			c: CHARACTER
		do
			Result := ""
			from
				i := 1
			until
				i > a_string.count
			loop
				c := a_string.item (i)
				inspect c
				when '<' then
					Result.append_string ("&lt;")
				when '>' then
					Result.append_string ("&gt;")
				when '&' then
					Result.append_string ("&amp;")
				when '%'' then
					Result.append_string ("&apos;")
				when '%"' then
					Result.append_string ("&quot;")
				when '%R' then
					Result.append_string (" ")
				when '%N' then
					Result.append_string (" ")
				when '%T' then
					Result.append_string (" ")
				else
					Result.append_character (c)
				end
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

	replace_xml_entities (a_string: STRING_8): STRING_8
			-- New string equal to `a_string' except for replacement of characters
			-- <, >, &, ', " by corresponding XML entity
		require
			a_string_not_void: a_string /= Void
		local
			i: INTEGER
			c: CHARACTER
		do
			Result := ""
			from
				i := 1
			until
				i > a_string.count
			loop
				c := a_string.item (i)
				inspect c
				when '<' then
					Result.append_string ("&lt;")
				when '>' then
					Result.append_string ("&gt;")
				when '&' then
					Result.append_string ("&amp;")
				when '%'' then
					Result.append_string ("&apos;")
				when '%"' then
					Result.append_string ("&quot;")
				else
					Result.append_character (c)
				end
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

	output_stream: KI_TEXT_OUTPUT_STREAM
			-- All loging messages are written to this stream

invariant
	output_stream_not_void: output_stream /= Void

end
