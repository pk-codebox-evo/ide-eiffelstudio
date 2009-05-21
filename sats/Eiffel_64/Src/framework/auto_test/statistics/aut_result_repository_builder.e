note
	description:

		"Builds result repositories from log files"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_RESULT_REPOSITORY_BUILDER

inherit
	AUT_LOG_PARSER
		redefine
			process_start_request,
			process_create_object_request,
			process_invoke_feature_request,
			report_comment_line
		end

create
	make

feature -- Building

	build (a_input_stream: KI_TEXT_INPUT_STREAM)
			-- Build result repository from `a_input_stream' and
			-- store result in `last_result_repository'.
		require
			a_input_stream_attached: a_input_stream /= Void
			a_input_stream_is_open_read: a_input_stream.is_open_read
		do
			create last_result_repository.make
			parse_stream (a_input_stream)
		ensure
			last_result_repository_built: last_result_repository /= Void
		end

feature -- Access

	last_result_repository: AUT_TEST_CASE_RESULT_REPOSITORY
			-- Last result repository built by `build'

feature{NONE} -- Processing

	process_start_request (a_request: AUT_START_REQUEST)
		do
			check
				a_request_in_history: request_history.has (a_request)
			end
			Precursor (a_request)
			last_start_index := request_history.count + 1
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST)
		do
			if last_test_case_request /= Void then
				last_test_case_request.set_end_time (last_test_case_end_time)
			end
			a_request.set_start_time (last_test_case_start_time)
			Precursor (a_request)
			update_result_reposotory
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST)
		do
			if last_test_case_request /= Void then
				last_test_case_request.set_end_time (last_test_case_end_time)
			end
			a_request.set_start_time (last_test_case_start_time)
			Precursor (a_request)
			update_result_reposotory
		end

	report_comment_line (a_line: STRING) is
			-- Report comment line `a_line'.
		local
			l_line: STRING
		do
			if a_line.substring (1, time_stamp_header.count).is_equal (time_stamp_header) then
				l_line := a_line.substring (time_stamp_header.count + 1, a_line.count)
				analyze_time_stamp (l_line)
			end
		end

feature {NONE} -- Implementation

	last_start_index: INTEGER
			-- Index of the last "start" request in `request_history'

	update_result_reposotory
			-- Update result repository based on last request in result-history.			
		require
			last_start_index_large_enough: last_start_index > 0 -- To be removed when added back to invariant
			last_start_index_small_enough: last_start_index <= request_history.count -- To be removed when added back to invariant
			request_history_not_empty: request_history.count > 0
			last_request_has_response: request_history.item (request_history.count).response /= Void
		local
			witness: AUT_WITNESS
		do
			create witness.make (request_history, last_start_index, request_history.count)
			last_result_repository.add_witness (witness)
			last_test_case_request := witness.item (witness.count)
		end

feature -- Time measurement

	last_test_case_start_time: INTEGER
			-- Time in millisecond when the last test case started

	last_test_case_end_time: INTEGER
			-- Time in millisecond when the last test case ended

	time_stamp_header: STRING is "-- time stamp: "
			-- Header for time stamp

	test_case_start_time_header: STRING is "TC start"
			-- Test case start time tag

	test_case_end_time_header: STRING is "TC end"
			-- Test case end time tag	

	analyze_time_stamp (a_line: STRING) is
			-- Analyze time stamp in `a_line'.
		local
			l_parts: LIST [STRING]
			l_time: INTEGER
		do
			l_parts := a_line.split (';')
			check l_parts.count = 3 end
			l_time := l_parts.last.to_integer

			if l_parts.first.is_equal (test_case_start_time_header) then
				last_test_case_start_time := l_time
			elseif l_parts.first.is_equal (test_case_end_time_header) then
				last_test_case_end_time := l_time
			end
		end

	last_test_case_request: detachable AUT_REQUEST;
			-- Request of the last met test case

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
