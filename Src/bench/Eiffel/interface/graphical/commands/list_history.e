indexing

	description:
		"Popup a list of all targets in the tool's history. %
		%The contents is created in the descendants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class LIST_HISTORY

inherit
	
	TOOL_COMMAND
		rename
			init as make
		end

create
	make

feature -- Properties

	name: STRING is
			-- Name of the command
		do
			Result := Interface_names.f_List_targets
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_List_targets
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.t_empty
		end

feature {NONE} -- Execution

	work (argument: ANY) is
			-- Execute Current.
		local
			a_button: EB_BUTTON
		do
			a_button ?= argument
			if a_button /= Void then
					--| Argument is a button, CHOICE_W should be
					--| popped up.
				create_and_show_choices (a_button)
			elseif argument = choices then
					--| Arrgument is the CHOICE_W, so retargetting
					--| the text_window will do.
				retarget_text_window
			end
		end

feature {NONE} -- Implementation

	create_and_show_choices (a_button: EB_BUTTON) is
			-- Creates the choice window, fills it,
			-- and pops it up.
			-- `a_button' is used as parent.
		local
			a_list: TWO_WAY_LIST [STRING]
		do
			if choices = Void then
				create choices.make_with_widget (a_button.parent, a_button)
			end
			create a_list.make
			fill_list (a_list)
			choices.popup (Current, a_list, tool.history_window_title)
			choices.select_i_th (tool.history.index)
		end

	fill_list (list: TWO_WAY_LIST [STRING]) is
			-- Fill `list' with strings.
			--| Be careful: `fill_list' may not change
			--| the position of the active item!!
		local
			cur: CURSOR
			history: STONE_HISTORY
		do
			history := tool.history
			cur := history.cursor
			from
				history.start
			until
				history.after
			loop
				list.extend (history.item.history_name)
				history.forth
			end
			history.go_to (cur)
		end

	retarget_text_window is
			-- Retarget `text_window' with the chosen item.
		local
			history: STONE_HISTORY
			pos, i: INTEGER
		do
			pos := choices.position
			if pos = 0 then
				choices.popdown
			else
				history := tool.history
				from
					i := 1
					history.start
				until
					i = pos
				loop
					history.forth
					i := i + 1
				end
				history.set_do_not_update (True)
				tool.receive (history.item)
				history.set_do_not_update (False)
			end
		end

feature {NONE} -- Properties

	choices: CHOICE_W;
			-- Window to popup the choices.
			
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class LIST_HISTORY
