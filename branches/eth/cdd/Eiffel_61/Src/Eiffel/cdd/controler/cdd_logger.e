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
			-- initialize `current'
		require
			stream_not_void: an_output_stream /= void
			stream_writable: an_output_stream.is_open_write
		do
			output_stream := an_output_stream
		ensure
			output_stream_set: output_stream = an_output_stream
		end


feature -- Logging

	put_system_status_message(
								a_project_name: STRING;
								a_target_name: STRING;
								an_extracting_status: BOOLEAN;
								an_execution_status: BOOLEAN;
								a_message: STRING
							  ) is
			-- Write a system status message
		do
			log_message ("system", " project_name=%"" + empty_or_out(a_project_name) + "%" target_name=%"" + empty_or_out(a_target_name) + "%" is_extracting=%"" + empty_or_out(an_extracting_status) + "%" is_executing=%"" + empty_or_out(an_execution_status) + "%" message=%"" + empty_or_out (a_message) + "%"", void)
		end

	put_test_suite_status_message(a_test_suite: CDD_TEST_SUITE; a_message: STRING) is
			-- Write a test suite status message
		local
			l_message: STRING
			l_content: STRING
			l_class_list: DS_ARRAYED_LIST[CDD_TEST_CLASS]
		do
			l_class_list := a_test_suite.test_classes
			l_message := "number_of_test_classes=%"" + l_class_list.count.out + "%""
			l_message.append_string (" message=%"" + a_message + "%"")
			l_content := ""
			if not l_class_list.is_empty then
				l_class_list.start
				l_content.append_string (empty_or_out (l_class_list.item_for_iteration.cdd_id) + "--" + l_class_list.item_for_iteration.test_class_name)
				l_class_list.forth
				from
				until
					l_class_list.after
				loop
					l_content.append_string (",%N" + empty_or_out (l_class_list.item_for_iteration.cdd_id) + "--" + l_class_list.item_for_iteration.test_class_name)
					l_class_list.forth
				end
			end

			log_message ( "test_suite", l_message,  l_content)
		end


	put_test_routines_status_message(updates: DS_LINEAR [CDD_TEST_ROUTINE_UPDATE]) is
			-- Write a for each test routine a status message
		local
			l_message: STRING
			l_content: STRING
			l_routine: CDD_TEST_ROUTINE
		do
			l_message := ""
			l_content := ""
			from
				updates.start
			until
				updates.after
			loop
				l_message.wipe_out
				l_content.wipe_out
				inspect updates.item_for_iteration.code
				when {CDD_TEST_ROUTINE_UPDATE}.add_code then
					l_message.append_string ("action=%"add%"")
				when {CDD_TEST_ROUTINE_UPDATE}.changed_code then
					l_message.append_string ("action=%"change%"")
				when {CDD_TEST_ROUTINE_UPDATE}.remove_code then
					l_message.append_string ("action=%"remove%"")
				else
					check got_invalid_update_code: false end
				end
				l_routine := updates.item_for_iteration.test_routine
				l_message.append_string (" name=%"" + empty_or_out(l_routine.test_class.cdd_id) + "--" + l_routine.test_class.test_class_name + "--" + l_routine.name + "%"")
				if not l_routine.outcomes.is_empty then
					l_content.append_string (l_routine.outcomes.last.out)
				end

				log_message ("test_routine", l_message, l_content)

				updates.forth
			end
		end

feature {NONE} -- Implementation

	log_message (an_element_name: STRING; an_attrib_string: STRING; an_element_content: STRING) is
			-- write a message to the log
		local
			l_time: DATE_TIME
		do
			create l_time.make_now
			output_stream.put_string ("<" + an_element_name + " time=%"" + l_time.out + "%" " + an_attrib_string)
			if an_element_content = void then
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


	output_stream: KI_TEXT_OUTPUT_STREAM
			-- All loging messages are written to this stream

invariant
	output_stream_not_void: output_stream /= void

end
