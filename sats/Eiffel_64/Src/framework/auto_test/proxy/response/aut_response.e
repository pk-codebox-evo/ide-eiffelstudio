note
	description:

		"Abstract ancestor to all responses received from the interpreter"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class AUT_RESPONSE

feature {NONE} -- Initialization

	make (a_response_text: like raw_text)
			-- Create new response.
		require
			a_response_text_not_void: a_response_text /= Void
		do
			raw_text := a_response_text
		ensure
			text_set: raw_text = a_response_text
		end

feature -- Status report

	is_bad: BOOLEAN
			-- Is response not well formed syntacticly?
		deferred
		end

	is_error: BOOLEAN
			-- Is response an error message?
		deferred
		end

	is_normal: BOOLEAN
			-- Is response a normal response?
		do
			Result := not is_bad and not is_error
		ensure
			definition: Result = (not is_bad and not is_error)
		end

	is_exception: BOOLEAN
			-- Does response contain an exception from testee feature?
		do
		end

	is_precondition_violation: BOOLEAN is
			-- Does response contain a precondition violation from the testee feature?
			-- True means current test case is invalid.
		do
		end

	is_postcondition_violation: BOOLEAN is
			-- Does response contain a postcondition violation from the testee feature?
		do
		end

	is_class_invariant_violation_on_entry: BOOLEAN is
			-- Does response contain a class invariant violation on feature entry?
		do
		end

	is_class_invariant_violation_on_exit: BOOLEAN is
			-- Does response contain a class invariant violation on feature exit?
		do
		end

feature -- Access

	text: STRING
			-- Response as received in unparsed form
		do
			Result := raw_text
		ensure
			result_attached: Result /= Void
		end

	time: DT_DATE_TIME_DURATION
			-- Time (in seconds) elapsed since the beginning of the testing session when this response was received
			-- (NOTE: is currently only recorded for thrown exceptions)

	set_time (a_time: like time)
			-- Set `time' to `a_time'.
		require
			a_time_not_void: a_time /= Void
		do
			time := a_time
		ensure
			time_set: time = a_time
		end

feature -- Process

	process (a_visitor: AUT_RESPONSE_VISITOR)
			-- Process `Current' using `a_visitor'.
		require
			a_visitor_attached: a_visitor /= Void
		deferred
		end

feature{NONE} -- Implementation

		raw_text: STRING
				-- Text associated with Current response

invariant
	raw_text_attached: raw_text /= Void

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
