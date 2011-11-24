note
	description: "Summary description for {AUT_SERIALIZATION_PROCESSOR_C}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_DESERIALIZATION_PROCESSOR

inherit

	EXCEPTIONS

	AUT_DESERIALIZATION_PROCESSOR_I

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	ITP_TEST_CASE_SERIALIZATION_CONSTANTS

	EQA_TEST_CASE_SERIALIZATION_UTILITY

	REFACTORING_HELPER


create
	make

feature{NONE} -- Initialization

	make (a_system: like system; a_conf: like configuration)
			-- Initialization.
		require
			a_system_attached: a_system /= Void
			a_config_attached: a_conf /= Void
		do
			system := a_system
			configuration := a_conf

			create deserialization_started_event
			create test_case_deserialized_event
			create deserialization_finished_event

				-- Configurate the process according to the `configuration'.
			config_processor

				-- Config the `test_case_categorizer' and subscribe it to `data_event'.
			if a_conf.is_deserializing_for_fixing then
				create {AUT_TEST_CASE_CATEGORIZER_BY_FAULT}test_case_extractor.make (configuration)
			else
				create {AUT_TEST_CASE_CATEGORIZER_BY_FEATURE_UNDER_TEST}test_case_extractor.make (configuration)
			end
			deserialization_started_event.subscribe (agent test_case_extractor.on_deserialization_started)
			test_case_deserialized_event.subscribe (agent test_case_extractor.on_test_case_deserialized)
			deserialization_finished_event.subscribe (agent test_case_extractor.on_deserialization_finished)

			if configuration.is_building_behavioral_models then
				create behavioral_model_builder.make (configuration.model_directory)
				deserialization_started_event.subscribe (agent behavioral_model_builder.on_deserialization_started)
				test_case_deserialized_event.subscribe (agent behavioral_model_builder.on_test_case_deserialized)
				deserialization_finished_event.subscribe (agent behavioral_model_builder.on_deserialization_finished)
			end

			create test_case_deserializability_checker.make (test_case_extractor.test_case_dir)
			deserialization_started_event.subscribe (agent test_case_deserializability_checker.start_checking)
			deserialization_finished_event.subscribe (agent test_case_deserializability_checker.finish_checking)

			check is_ready: is_ready end
		end

feature -- Access

	deserialization_started_event: detachable EVENT_TYPE [TUPLE[]]
			-- <Precursor>

	test_case_deserialized_event: EVENT_TYPE [TUPLE [AUT_DESERIALIZED_TEST_CASE]]
			-- <Precursor>

	deserialization_finished_event: detachable EVENT_TYPE [TUPLE[]]
			-- <Precursor>

	test_case_extractor: AUT_TEST_CASE_CATEGORIZER
			-- Test case categorizer.

	behavioral_model_builder: AUT_BEHAVIORAL_MODEL_BUILDER
			-- Behavioral model builder.

	test_case_deserializability_checker: AUT_TEST_CASE_DESERIALIZABILITY_CHECKER
			-- Deserializability checker.

feature -- Configuration

	data_input: STRING
			-- Data input file or directory.

	data_output: STRING
			-- Data output directory.

	is_recursive: BOOLEAN
			-- Is subdirectory processed recursively?

feature -- Operation

	process
			-- <Precursor>
		local
			l_file_names: LINKED_LIST[STRING]
			l_name: STRING
			l_dir: DIRECTORY
			l_file: RAW_FILE
			l_entry_name: STRING
		do
			deserialization_started_event.publish ([])
			if not configuration.error_handler.has_error then
					-- Process all the input files recursively.
				from
					create l_file_names.make
					l_file_names.force (data_input)
				until
					l_file_names.is_empty
				loop
					l_file_names.start
					l_name := l_file_names.item

					create l_file.make (l_name)
					if l_file.exists and then l_name.ends_with (once ".txt") then
						process_file (l_file)
						l_file_names.remove
					else
						if is_recursive then
								-- Recursively add all directory entries into the list.
							create l_dir.make (l_name)
							if l_dir.exists then
								l_dir.open_read
								if not l_dir.is_closed then
									from
										l_dir.start
										l_dir.readentry
									until
										l_dir.lastentry = Void
									loop
										l_entry_name := l_dir.lastentry
										if l_entry_name /~ once "." and then l_entry_name /~ once ".." then
											l_file_names.force (file_system.pathname (l_name, l_entry_name))
										end
										l_dir.readentry
									end
								end
							end
						end

						-- Remove the directory name from the head of queue.
						l_file_names.start
						l_file_names.remove
					end
				end
			else
				configuration.error_handler.report_error_message ("Configuration error, deserialization cannot start.")
			end
			deserialization_finished_event.publish ([])
		end

feature{NONE} -- Implementation

	config_processor
			-- Internal initialization according to the `configuration'.
		require
			configuration_attached: configuration /= Void
		local
			l_conf: like configuration
			l_dir: DIRECTORY
			l_input_name: FILE_NAME
			l_file: RAW_FILE
		do
			l_conf := configuration
			is_recursive := l_conf.is_recursive

				-- Check the existence of `data_input' source.
			data_input := l_conf.data_input
			if data_input = Void or else data_input.is_empty then
					-- Use the serialization file from project directory.
				create l_input_name.make_from_string (configuration.log_dirname)
				l_input_name.extend ("serialization.txt")
			end

			create l_file.make (data_input)
			create l_dir.make (data_input)
			if not l_file.exists then
				configuration.error_handler.report_cannot_read_error (data_input)
			end

			if not configuration.error_handler.has_error then
					-- `data_output' should always denote a directory.
					-- As long as there is no existing file with the same name, it's acceptable.
				data_output := l_conf.data_output
				check data_output /= Void and then not data_output.is_empty end
				create l_file.make (data_output)
				if l_file.exists and then not l_file.is_directory then
					configuration.error_handler.report_cannot_write_error (data_output)
				end
			end
		end

	process_file (a_file: RAW_FILE)
			-- Deserialization information from 'a_file'.
		local
			l_retried: BOOLEAN
			l_line: STRING
		do
			io.put_string (once "%NNow processing: " + a_file.name + once "...")

			if not l_retried then
				a_file.open_read
				if a_file.is_open_read then
					last_file_path := a_file.name.twin
					line_number := 0
					from
						a_file.start
					until
						a_file.end_of_file or else not has_next_line (a_file)
					loop
						l_line := next_line
						parse_line (l_line, a_file)
					end
				else
					configuration.error_handler.report_cannot_read_error (a_file.name)
				end
			else
				configuration.error_handler.report_error_message ("Bad serialization data file: " + a_file.name)
			end

			io.put_string (once "Done.")
		rescue
			l_retried := True
			retry
		end

	parse_line (a_line: STRING; a_stream: RAW_FILE)
			-- Parse one line of file.
			-- Read from `a_stream' when necessary to complete a tag.
		local
			l_start_tag, l_finish_tag: STRING
			l_length: INTEGER
			l_retried: BOOLEAN
		do
			if not l_retried then
				if a_line.substring_index (test_case_tag_start, 1) /= 0 then
					start_serialization
				elseif is_inside_serialization then
					if a_line.substring_index (test_case_tag_end, 1) /= 0 then
						finish_serialization
					elseif is_good_serialization_block then
						if has_start_tag (a_line) then
							check last_tag_attached: last_tag /= Void end
							collect_tag_block (last_tag, a_line, a_stream)

							-- Process data tag specially.
							if last_tag ~ pre_serialization_length_tag_start then
								if last_length /= Void and then last_length.is_integer then
									l_length := last_length.to_integer
									collect_serialization_tag_block (l_length, a_stream)
								else
									raise ("Bad data length format.")
								end
							end
						else
							raise ("Missing start tag.")
						end
					end
				end
			end
		rescue
			l_retried := True
			is_good_serialization_block := False
			retry
		end

	last_class_name: detachable STRING

	last_time: detachable STRING

	last_test_case: detachable STRING

	last_operands: detachable STRING

	last_variables: detachable STRING

	last_trace: detachable STRING

	last_hash_code: detachable STRING

	last_pre_state: detachable STRING

	last_post_state: detachable STRING

	last_length: detachable STRING

	last_pre_serialization: detachable ARRAY[NATURAL_8]

	last_post_serialization: detachable ARRAY[NATURAL_8]

	last_tag: detachable STRING

	last_file_path: detachable STRING
			-- Full path of the last processed file

	line_number: INTEGER
			-- Current line number

feature{NONE} -- Auxiliary routines

	start_serialization
			-- Start new serialization by reset the `last_*' attributes.
		do
			is_good_serialization_block := True
			is_inside_serialization := True

			reset_serialization_data
		end

	reset_serialization_data
			-- Reset serialization data used during parsing.
		do
			last_class_name := Void
			last_time := Void
			last_test_case := Void
			last_operands := Void
			last_variables := Void
			last_trace := Void
			last_hash_code := Void
			last_pre_state := Void
			last_post_state := Void
			last_length := Void
			last_pre_serialization := Void
		end

	collect_tag_block (a_tag: STRING; a_line: STRING; a_stream: RAW_FILE)
			-- Collect tag information to `last_*' attribute.
			-- 'a_tag': the tag to be finished
			-- 'a_line': the line where 'a_tag' started
			-- 'a_stream': the stream where the tag information beyond `a_line' is available
		require
			valid_tag: serialization_tags.has (a_tag)
			tag_start_from_line: a_line.substring_index (a_tag, 1) /= 0
		local
			l_start_index, l_finish_index: INTEGER
			l_finish_tag: STRING
			l_line: STRING
			l_block: STRING
		do
			l_finish_tag := serialization_tags[a_tag]
			from
				l_line := a_line
				l_start_index := l_line.substring_index (a_tag, 1) + a_tag.count
				l_finish_index :=l_line.substring_index (l_finish_tag, 1)
				l_block := ""
			until
				l_finish_index /= 0
			loop
					-- Append all intermediate lines to the block.
				l_block.append (l_line.substring (l_start_index, l_line.count))
				l_block.append ("%N")

				if has_next_line(a_stream) then
					l_line := next_line
					l_start_index := 1
					l_finish_index :=l_line.substring_index (l_finish_tag, 1)
				else
					raise ("Unexpected file end.")
				end
			end

				-- Append the content before finish tag to the block.
			check l_finish_index /= 0 and then l_start_index <= l_finish_index end
			l_block.append (l_line.substring (l_start_index, l_finish_index - 1))

				-- Save tag block.
			save_tag_block (a_tag, l_block)
		end

	save_tag_block (a_tag: STRING; a_block: STRING)
			-- Save block infomration into the tag with name `a_tag'.
		require
			valid_tag: serialization_tags.has (a_tag)
		local
			l_start, l_end: INTEGER
		do
			if a_tag ~ class_tag_start then
				last_class_name := pruned_string (a_block)
			elseif a_tag ~ time_tag_start then
				last_time := pruned_string (a_block)
			elseif a_tag ~ code_tag_start then
				last_test_case := pruned_string (a_block)
			elseif a_tag ~ operands_tag_start then
				last_operands := pruned_string (a_block)
			elseif a_tag ~ all_variables_tag_start then
				last_variables := pruned_string (a_block)
			elseif a_tag ~ trace_tag_start then
				l_start := a_block.substring_index (cdata_tag_start, 1) + cdata_tag_start.count
				l_end := a_block.substring_index (cdata_tag_end, 1) - 1
				check l_start /= 0 and l_start <= l_end end
				last_trace := pruned_string (a_block.substring (l_start, l_end))
			elseif a_tag ~ hash_code_tag_start then
				last_hash_code := pruned_string (a_block)
			elseif a_tag ~ pre_state_tag_start then
				last_pre_state := pruned_string (a_block)
			elseif a_tag ~ post_state_tag_start then
				last_post_state := pruned_string (a_block)
			elseif a_tag ~ pre_serialization_length_tag_start then
				last_length := pruned_string (a_block)
			else
				check dead_end: False end
			end
		end

	collect_serialization_tag_block (a_length: INTEGER; a_stream: RAW_FILE)
			-- Collect the "<![CDATA[...]]" information for <serialization> tag,
			-- save the result into `last_pre_object'.
			-- The routine should be called right after <pre/post_serialization_length> has been processed.
		local
			l_length: INTEGER
			l_data: STRING
			l_serialization_str: STRING
			l_start_index, l_finish_index: INTEGER
			l_index: INTEGER
			l_prefix_count, l_postfix_count: INTEGER
			l_objects: like last_pre_serialization
		do
				-- Total length of the block, including the preceding/succeeding tags
			l_prefix_count := pre_serialization_tag_start.count + cdata_tag_start.count
			l_postfix_count := pre_serialization_tag_end.count + cdata_tag_end.count
			l_length := a_length + l_prefix_count + l_postfix_count

				-- Read the whole block (with delimiters) into a string.
			a_stream.read_stream (l_length)
			l_data := a_stream.last_string

			l_start_index := l_data.substring_index (cdata_tag_start, 1) + cdata_tag_start.count
			check l_start_index = l_prefix_count + 1 end
			l_finish_index := l_data.substring_index (cdata_tag_end, 1) - 1
			check l_finish_index = l_length - l_postfix_count end
			l_serialization_str := l_data.substring (l_start_index, l_finish_index)

				-- Save pre serialization string.
			create last_pre_serialization.make (1, a_length + 1)
			l_objects := last_pre_serialization

			from
				l_index := 1
			until
				l_index > a_length
			loop
				l_objects.put (l_serialization_str[l_index].code.as_natural_8, l_index)
				l_index := l_index + 1
			end
		end

	has_start_tag (a_line: STRING): BOOLEAN
			-- Has `a_line' a start tag?
			-- If yes, save the start tag in `last_tag'; otherwise, clear `last_tag'.
		local
			l_tag: STRING
			l_tags: like serialization_tags
		do
			from
				Result := False
				last_tag := Void
				l_tags := serialization_tags
				l_tags.start
			until
				Result or else l_tags.after
			loop
				l_tag := l_tags.key_for_iteration
				if a_line.substring_index (l_tag, 1) /= 0 then
					Result := True
					last_tag := l_tag
				end
				l_tags.forth
			end
		end

	finish_serialization
			-- Finish a serialization block.
			-- Notify the listeners, if a serialization block was parsed successfully.
		local
			l_serialization: AUT_DESERIALIZED_TEST_CASE
		do
			if is_good_serialization_block and then is_serialization_block_information_complete then
				create l_serialization.make (last_class_name,
						last_test_case,
						last_operands,
						last_variables,
						last_trace,
						last_hash_code,
						last_pre_state,
						last_post_state,
						last_time,
						last_pre_serialization)
				test_case_deserializability_checker.check_deserializability (l_serialization)
				if test_case_deserializability_checker.last_result then
					report_serialization_data (l_serialization)
				end
			end
			is_inside_serialization := False
		end

	report_serialization_data (a_data: AUT_DESERIALIZED_TEST_CASE)
			-- Report a newly found serialization data.
		local
			l_is_unique: BOOLEAN
		do
			if (a_data.is_execution_successful implies configuration.is_passing_test_case_deserialization_enabled)
					and then (not a_data.is_execution_successful implies configuration.is_failing_test_case_deserialization_enabled)
					or else (configuration.is_building_behavioral_models and then a_data.is_execution_successful)
					or else (configuration.is_deserializing_for_fixing) then
				check a_data.class_ /= Void and then a_data.feature_ /= Void end
				test_case_deserialized_event.publish ([a_data])
			end
		end

	has_next_line (a_stream: RAW_FILE): BOOLEAN
			-- Has next non-empty line in `a_stream'?
		local
			l_line: STRING
		do
			next_line := once "";
			line_number := line_number + 1
			from
			until
				a_stream.end_of_file or not next_line.is_empty
			loop
				a_stream.read_line
				next_line := pruned_string (a_stream.last_string)
			end

			Result := not next_line.is_empty
		end

	next_line: STRING
			-- The line read during last `has_non_empty_line' test.
			-- If the test returns `False', set `next_line' to be "".

	pruned_string (a_string: STRING): STRING
			-- The pruned version of `a_string', by removing the
			-- 	invisible characters from the beginning and the end.
		require
			string_not_void: a_string /= Void
		local
			l_char: CHARACTER
			l_start, l_end: INTEGER
			l_found: BOOLEAN
		do
			-- Search for the first visible character from beginning.
			from
				l_start := 1
				l_found := False
			until l_start > a_string.count or else l_found
			loop
				l_char := a_string[l_start]
				if l_char = '%N' or else l_char = ' ' or else l_char = '%T' or else l_char = '%R' then
					l_start := l_start + 1
				else
					l_found := True
				end
			end

			if l_start > a_string.count then
				-- No visible character found.
				Result := once ""
			else
				-- First visible character in the reverse order.
				from
					l_end := a_string.count
					l_found := False
				until l_end < 1 or else l_found
				loop
					l_char := a_string[l_end]
					if l_char = '%N' or else l_char = ' ' or else l_char = '%T' or else l_char = '%R' then
						l_end := l_end - 1
					else
						l_found := True
					end
				end

				-- Return the substring.
				check correct_order: l_end >= l_start end
				Result := a_string.substring (l_start, l_end)
			end
		ensure
			result_set: Result /= Void
		end

feature{NONE} -- Status report

	is_serialization_block_information_complete: BOOLEAN
			-- Is the serialization block information complete?
		do
			Result := last_class_name /= Void and then not last_class_name.is_empty
					and then last_time /= Void
					and then last_test_case /= Void and then not last_test_case.is_empty
					and then last_operands /= Void and then not last_operands.is_empty
					and then last_variables /= Void --and then not last_variables.is_empty
					and then last_trace /= Void
					and then last_hash_code /= Void and then not last_hash_code.is_empty
					and then last_pre_state /= Void
					and then last_post_state /= Void
					and then last_length /= Void and then not last_length.is_empty
					and then last_pre_serialization /= Void
		end

	is_good_serialization_block: BOOLEAN
			-- Is the parsing of the serialization block successful so far?

	is_inside_serialization: BOOLEAN
			-- Is parsing inside a serialization block?

feature{NONE} -- Constants

	serialization_tags: HASH_TABLE [STRING, STRING]
			-- Serialization tags used in the files.
		do
			if serialization_tags_cache = Void then
				create serialization_tags_cache.make (16)
				serialization_tags_cache.compare_objects
				serialization_tags_cache.put (class_tag_end,   class_tag_start)
				serialization_tags_cache.put (time_tag_end,         time_tag_start)
				serialization_tags_cache.put (code_tag_end,    code_tag_start)
				serialization_tags_cache.put (operands_tag_end,     operands_tag_start)
				serialization_tags_cache.put (all_variables_tag_end,    all_variables_tag_start)
				serialization_tags_cache.put (trace_tag_end,        trace_tag_start)
				serialization_tags_cache.put (hash_code_tag_end,     hash_code_tag_start)
				serialization_tags_cache.put (pre_state_tag_end, pre_state_tag_start)
				serialization_tags_cache.put (post_state_tag_end, post_state_tag_start)
				serialization_tags_cache.put (pre_serialization_length_tag_end,  pre_serialization_length_tag_start)
				serialization_tags_cache.put (pre_serialization_tag_end,         pre_serialization_tag_start)
			end

			Result := serialization_tags_cache
		end

	serialization_tags_cache: detachable like serialization_tags
			-- Cached serialization tags.



;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
