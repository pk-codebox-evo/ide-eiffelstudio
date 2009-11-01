note
	description: "Summary description for {AFX_BREAKPOINT_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AFX_BREAKPOINT_MANAGER

inherit
	SHARED_DEBUGGER_MANAGER

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize Current.
		do
			create breakpoints.make (initial_capacity)
			create hit_actions.make (initial_capacity)
		end

feature -- Access

	breakpoints: HASH_TABLE [AFX_STATE_SKELETON, BREAKPOINT_LOCATION]
			-- Breakpoints where the debuggee should be stopped and expressions should be evaluated.
			-- Key is the breakpoint, value is the state consisting expressions to be evaluated
			-- at the breakpoint.

	hit_actions: HASH_TABLE [LINKED_LIST [BREAKPOINT_WHEN_HITS_ACTION_I], BREAKPOINT_LOCATION]
			-- Actions to perform when a breakpoint is hit.
			-- Key is the breakpoint, value is a list of actions to perform when that breakpoint is hit.

feature -- Basic operations

	set_hit_action_with_agent (a_state: AFX_STATE_SKELETON; a_action: PROCEDURE [ANY, TUPLE [a_bp: BREAKPOINT; a_state: AFX_STATE]]; a_feature: FEATURE_I)
			-- Set `a_action' to all break points to `a_feature'.
		local
			l_bp_location: BREAKPOINT_LOCATION
			l_slot_count: INTEGER
			i: INTEGER
			l_act_list: LINKED_LIST [BREAKPOINT_WHEN_HITS_ACTION_I]
			l_action:AFX_BREAKPOINT_WHEN_HITS_ACTION_EXPR_EVALUATION
		do
			l_slot_count := a_feature.number_of_breakpoint_slots
			from
				i := 1
			until
				i > l_slot_count
			loop
				create l_act_list.make
				create l_action.make (a_state)
				l_action.on_hit_actions.extend (a_action)
				l_act_list.extend (l_action)
				l_bp_location := breakpoints_manager.breakpoint_location (a_feature.e_feature, i, False)
				hit_actions.put (l_act_list, l_bp_location)
				i := i + 1
			end
		end

	set_breakpoints (a_state: AFX_STATE_SKELETON; a_feature: FEATURE_I)
			-- Set breakpoints in all breakpoints slots in in `a_feature' to evaluate
			-- expressions in `a_state'.
		local
			l_bp_location: BREAKPOINT_LOCATION
			l_slot_count: INTEGER
			i: INTEGER
		do
			breakpoints.wipe_out

			l_slot_count := a_feature.number_of_breakpoint_slots
			from
				i := 1
			until
				i > l_slot_count
			loop
				l_bp_location := breakpoints_manager.breakpoint_location (a_feature.e_feature, i, False)
				breakpoints.put (a_state, l_bp_location)
				i := i + 1
			end
		end

	toggle_breakpoints (b: BOOLEAN)
			-- If `b' is True, enable `breakpoints', otherwise disable `breakpoints'.
		local
			l_bps: like breakpoints
			l_bp_manager: BREAKPOINTS_MANAGER
			l_bp: BREAKPOINT_LOCATION
			l_routine: E_FEATURE
			l_bpslot: INTEGER
			l_actions: detachable LINKED_LIST [BREAKPOINT_WHEN_HITS_ACTION_I]
		do
			l_bp_manager := debugger_manager.breakpoints_manager
			l_bps := breakpoints
			from
				l_bps.start
			until
				l_bps.after
			loop
				l_bp := l_bps.key_for_iteration
				l_routine := l_bp.routine
				l_bpslot := l_bp.breakable_line_number
				l_actions := hit_actions.item (l_bp)
				if b then
					l_bp_manager.set_user_breakpoint (l_routine, l_bpslot)
					l_bp_manager.breakpoint_at (l_bp, False).set_continue_execution (True)

					if l_actions /= Void then
						l_actions.do_all (agent (l_bp_manager.breakpoint_at (l_bp, False)).add_when_hits_action)
					end
				else
					l_bp_manager.disable_user_breakpoint (l_routine, l_bpslot)
					if l_actions /= Void then
						l_actions.do_all (agent (l_bp_manager.breakpoint_at (l_bp, False)).remove_when_hits_action)
					end
				end
				l_bps.forth
			end
		end

feature{NONE} -- Implementation

	initial_capacity: INTEGER is 10
			-- Initial capacity for `breakpoints' and `hit_actions'

invariant

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
