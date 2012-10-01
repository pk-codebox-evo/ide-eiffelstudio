note
	description: "[
		Session factory for creating {ETEST_CREATION} descendants in test suite.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_DEFAULT_SESSION_FACTORY [G -> ETEST_CREATION create make end]

inherit
	TEST_SESSION_FACTORY [G]

	SHARED_TEST_SERVICE

feature -- Factory

	new_session (a_test_suite: TEST_SUITE_S; a_is_gui: BOOLEAN): G
			-- <Precursor>
		do
			create Result.make (a_test_suite, etest_suite, a_is_gui)
		end


note
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
