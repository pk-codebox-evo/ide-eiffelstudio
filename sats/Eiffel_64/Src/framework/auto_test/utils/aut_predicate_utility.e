note
	description: "Summary description for {AUT_PREDICATE_UTILITY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_PREDICATE_UTILITY

feature -- Access

	predicate_equality_tester: AGENT_BASED_EQUALITY_TESTER [AUT_PREDICATE] is
			-- Equality tester for predicate
		do
			create Result.make (agent (a, b: AUT_PREDICATE): BOOLEAN do Result := a.is_equal (b) end)
		end

	feature_of_type_equality_tester: AUT_FEATURE_OF_TYPE_EQUALITY_TESTER is
			-- Equality tester for feature of type
		do
			create Result.make
		end

	string_equality_tester: AGENT_BASED_EQUALITY_TESTER [STRING] is
			-- Equality test for string
		do
			create Result.make (agent (a, b: STRING): BOOLEAN do Result := a.is_equal (b) end)
		end


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
