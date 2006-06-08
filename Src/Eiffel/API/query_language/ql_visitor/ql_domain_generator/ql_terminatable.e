indexing
	description: "Utilities to support domain generation termination"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_TERMINATABLE

feature -- Access

	interval_tick_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performaed after every `interval_counter' items have been processed.
		do
			Result := interval_tick_actions_cell.item
		ensure
			result_attached: Result /= Void
		end

	interval: NATURAL_64 is
			-- Interval to decide if `interval_tick_actions' should be called.
			-- `interval_tick_actions' will be called after every `interval' number of items have been processed.
			-- Default value is `initial_interval'.
		do
			Result := interval_cell.item
		end

	internal_counter: NATURAL_64 is
			-- Internal counter to indicate how many items have been processed
		do
			Result := internal_counter_cell.item
		end

feature -- Status report

	has_interval_tick_actions: BOOLEAN is
			-- Is there any tick actions registered?
		do
			Result := not interval_tick_actions.is_empty
		end

feature -- Basic operations

--	check_interval_tick_actions is
--			-- Check if `interval_tick_actions' should be called,
--			-- and if it should, invoke all actions in `interval_tick_actions'.
--		do
--			if
--				internal_counter \\ interval = 0 and then
--				not interval_tick_actions.is_empty
--			then
--				interval_tick_actions.call ([])
--			end
--		end

	increase_internal_counter is
			-- Increase `internal_counter' by 1.
		local
			l_counter: like internal_counter
		do
				-- We don't detect overflow here.
				-- If internal_counter overflows, it just restarts from 0. (Jasonw)
			l_counter := internal_counter + 1
			internal_counter_cell.put (l_counter)
			if
				l_counter \\ interval = 0 and then
				not interval_tick_actions.is_empty
			then
				interval_tick_actions.call ([])
			end
		end

feature{NONE} -- Implementation

	interval_tick_actions_cell: CELL [ACTION_SEQUENCE [TUPLE]] is
			-- Cell to hold `interval_tick_actions'.
		once
			create Result.put (create{ACTION_SEQUENCE[TUPLE]})
		ensure
			result_attached: Result /= Void
		end

	internal_counter_cell: CELL [NATURAL_64] is
			-- Cell to hold `internal_counter'.
		once
			create Result.put (0)
		ensure
			result_attached: Result /= Void
		end

	interval_cell: CELL [NATURAL_64] is
			-- Cell to hold `interval'
		once
			create Result.put (initial_interval)
		ensure
			result_attached: Result /= Void
		end

	initial_interval: NATURAL_64 is 5000
			-- Default value of `internval'	

invariant
	interval_tick_actions_cell_attached: interval_tick_actions_cell /= Void
	interval_tick_actions_attached: interval_tick_actions /= Void

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
        license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
        licensing_options:	"http://www.eiffel.com/licensing"
        copying: "[
                        This file is part of Eiffel Software's Eiffel Development Environment.
                        
                        Eiffel Software's Eiffel Development Environment is free
                        software; you can redistribute it and/or modify it under
                        the terms of the GNU General Public License as published
                        by the Free Software Foundation, version 2 of the License
                        (available at the URL listed under "license" above).
                        
                        Eiffel Software's Eiffel Development Environment is
                        distributed in the hope that it will be useful,	but
                        WITHOUT ANY WARRANTY; without even the implied warranty
                        of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
                        See the	GNU General Public License for more details.
                        
                        You should have received a copy of the GNU General Public
                        License along with Eiffel Software's Eiffel Development
                        Environment; if not, write to the Free Software Foundation,
                        Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
                ]"
        source: "[
                         Eiffel Software
                         356 Storke Road, Goleta, CA 93117 USA
                         Telephone 805-685-1006, Fax 805-685-6869
                         Website http://www.eiffel.com
                         Customer support http://support.eiffel.com
                ]"


end
