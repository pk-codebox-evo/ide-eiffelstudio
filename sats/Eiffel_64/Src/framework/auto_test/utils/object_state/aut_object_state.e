note
	description: "Summary description for {AUT_OBJECT_STATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_OBJECT_STATE

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (an_object_state_response: AUT_OBJECT_STATE_RESPONSE)
			-- Initialization for `Current'.
		require
			an_object_state_response_attached: an_object_state_response /= Void
		local
			l_key_string, l_item_string: STRING
		do
			if an_object_state_response.query_results = Void then
				create boolean_query_results.make (1)
			else
				create boolean_query_results.make (an_object_state_response.query_results.count)

				from
					an_object_state_response.query_results.start
				until
					an_object_state_response.query_results.after
				loop
					l_key_string := an_object_state_response.query_results.key_for_iteration
					l_item_string := an_object_state_response.query_results.item_for_iteration

					if l_item_string.is_equal ("True%N") or l_item_string.is_equal ("True") then
						boolean_query_results.put (True, l_key_string)
					elseif l_item_string.is_equal ("False%N") or l_item_string.is_equal ("False") then
						boolean_query_results.put (False, l_key_string)
					end

					an_object_state_response.query_results.forth
				end
			end
		ensure
			boolean_query_results_attached: boolean_query_results /= Void
			boolean_query_results_not_overfilled: an_object_state_response.query_results = Void or else
				boolean_query_results.count <= an_object_state_response.query_results.count
		end

feature -- Access

	boolean_query_results: HASH_TABLE [detachable BOOLEAN, STRING]
			-- Table to store results of queries
			-- The attached result is stored as boolean, otherwise Void is stored.
			-- This table only stores achievable results, if there is an exception when trying to
			-- evaluate a query, that result is not stored.

feature -- Measurement

feature -- Status report

	textual_vector_representation: STRING is
			-- Return a textual vector representation of current object state
		do
			Result := "<"

			if boolean_query_results.is_empty then
				Result.append ("is_empty")
			else
				from
					boolean_query_results.start
				until
					boolean_query_results.after
				loop
					Result.append (boolean_query_results.key_for_iteration)
					Result.append (":")
					Result.append_boolean (boolean_query_results.item_for_iteration)

					boolean_query_results.forth

					if not boolean_query_results.after then
						Result.append (", ")
					end
				end
			end

			Result.append (">")
		end


feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is the current state made of same query results as `other'
		local
			l_break: BOOLEAN
		do
			if other = Current then
				Result := True
			elseif other = Void then
				Result := False
			elseif other.boolean_query_results.count /= boolean_query_results.count then
				Result := False
			else
				from
					boolean_query_results.start
					l_break := False
					Result := True
				until
					boolean_query_results.after or l_break
				loop
					if not other.boolean_query_results.has (boolean_query_results.key_for_iteration) or else
						other.boolean_query_results.at (boolean_query_results.key_for_iteration) /= boolean_query_results.item_for_iteration
					then
						l_break := True
						Result := False
					end

					boolean_query_results.forth
				end
			end
		end

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	boolean_query_results_attached: boolean_query_results /= Void

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
