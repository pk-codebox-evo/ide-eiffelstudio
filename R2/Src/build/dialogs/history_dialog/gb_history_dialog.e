note
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_HISTORY_DIALOG

inherit
	GB_HISTORY_DIALOG_IMP

	GB_ICONABLE_TOOL
		undefine
			default_create, copy
		end

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS)
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

feature {NONE} -- Initialization

	user_initialization
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			set_default_push_button (close_button)
			set_default_cancel_button (close_button)
			set_icon_pixmap (icon)
			add_initial_item
		end

feature {NONE} -- Implementation

	close_button_selected
			-- Called by `select_actions' of `close_button'.
		do
			components.commands.show_hide_history_command.execute
		end

feature -- Access

	icon: EV_PIXMAP
			-- Icon displayed in title of `Current'.
		once
			Result := ((create {GB_SHARED_PIXMAPS}).Icon_cmd_history_title @ 1)
		end

feature -- Basic operation

	add_command_representation (output: STRING)
			-- Add a history item represented by `output'.
		require
			output_valid: output /= Void and then not output.is_empty
		local
			list_item: EV_LIST_ITEM
		do
			create list_item.make_with_text (output)
			history_list.extend (list_item)
				-- We must now block the select actions on the list as we are doing it
				-- ourselves. When the user changes a selection, then we want the
				-- actions to be fired again.
			history_list.select_actions.block
			list_item.enable_select
			history_list.select_actions.resume
			if history_list.select_actions.is_empty then
				history_list.select_actions.extend (agent item_selected)
			end
			last_selected_item := history_list.count - 1
		ensure
			history_list.count = old history_list.count + 1
			last_selected_item = history_list.count - 1
		end

feature {GB_GLOBAL_HISTORY} -- Implementation

	select_item (position: INTEGER)
			-- Select item `position' in `history_list'.
		require
			position_valid: position >= 0 and position <= history_list.count
		do
			history_list.select_actions.block;
			(history_list @ position).enable_select
			history_list.select_actions.resume
			last_selected_item := position - 1
		ensure
			item_selected: (history_list @ position).is_selected
		end

	remove_selection
			-- Remove selection from `history_list'.
		do
			if history_list.selected_item /= Void then
				history_list.selected_item.disable_select
			end
				-- When going from no slection to a selection,
				-- without this, `last_selected_item' would still be
				-- 1 and therefore nothing would happen in `item_selected'.
			last_selected_item := 0
		ensure
			no_item_selected: history_list.selected_item = Void
		end

	remove_items_from_position (pos: INTEGER)
			-- Remove all items in `history_list' from
			-- position `pos'.
		do
			from
				history_list.go_i_th (pos)
			until
				history_list.off
			loop
				history_list.remove
			end
			last_selected_item := history_list.count - 1
		end

	remove_all_items
			-- Clear `history_list' completely.
		do
			history_list.wipe_out
			add_initial_item
		ensure
			history_list_empty: history_list.count = 1
		end

feature {NONE} -- Implementation		

	item_selected
			-- Peform processing when `an_item' has been selected.
		local
			index_of_current_item: INTEGER
		do
			index_of_current_item := history_list.index_of (history_list.selected_item, 1)
			if last_selected_item > index_of_current_item - 1 then
				components.history.step_from (last_selected_item, index_of_current_item - 1)
			elseif last_selected_item < index_of_current_item - 1 then
				components.history.step_from (last_selected_item + 1, index_of_current_item - 1)
			end
			last_selected_item := index_of_current_item - 1
				-- We must now update
			components.commands.update
		end

	last_selected_item: INTEGER
		-- Last item selected in `history_list'.

	add_initial_item
			-- Add initial item representing start state to `history_list'.
		require
			history_list_empty: history_list.is_empty
		do
			add_command_representation ("Start of History")
		ensure
			history_list_has_one_item: history_list.count = 1
		end

invariant
	history_list_not_void: history_list /= Void

note
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


end -- class GB_HISTORY_DIALOG
