note
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_VIEWERS_DIALOG

inherit

	EB_OBJECT_VIEWERS_I
		undefine
			default_create, copy, is_equal
		end

	ES_DIALOG

create
	make_with_command

convert
	dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	make_with_command (cmd: EB_OBJECT_VIEWER_COMMAND)
			-- Initialize `Current'.
		require
			cmd_not_void: cmd /= Void
		do
			command := cmd
			make
		end

	build_dialog_interface (vb: EV_VERTICAL_BOX)
		local
			hb: EV_HORIZONTAL_BOX
			but: EV_BUTTON
		do
			create viewers_manager.make

			create viewer_header_cell

			create but.make_with_text (interface_names.l_select_viewer)
			but.select_actions.extend (agent open_viewer_selector_menu (but))
			but.drop_actions.extend (agent viewers_manager.set_stone )
			but.drop_actions.set_veto_pebble_function (agent viewers_manager.is_stone_valid)

			create hb
			hb.extend (viewer_header_cell)
			hb.disable_item_expand (viewer_header_cell)
			hb.extend (create {EV_CELL})
			hb.extend (but); hb.disable_item_expand (but)
			layout_constants.set_default_width_for_button (but)

			vb.extend (hb);	vb.disable_item_expand (hb)

			vb.extend (viewers_manager.widget)
			viewers_manager.viewer_changed_actions.extend (agent update_current_viewer)

			set_button_text (dialog_buttons.close_button, interface_names.b_close)
			set_button_action_before_close (dialog_buttons.close_button, agent on_close)

			set_size (400, 300)
		end

	update_current_viewer (v: EB_OBJECT_VIEWER)
		local
			t: STRING_GENERAL
		do
				--| Toolbar
			if v /= Void then
				v.build_tool_bar
				if attached {EV_WIDGET} v.tool_bar as w then
					if attached {EV_WIDGET} w.parent as wp then
						if wp /= viewer_header_cell then
							--| wp is already parented somewhere
							--| then let's wipe out `viewer_header_cell'
							viewer_header_cell.wipe_out
						end
					else
						--| We don't move `tool_bar' if already parented
						viewer_header_cell.replace (w)
					end
				else
					viewer_header_cell.wipe_out
				end
			else
				viewer_header_cell.wipe_out
			end
				--| Title
			if v /= Void then
				t := v.title
			end
			if t = Void then
				t := viewers_manager.title
			end
			if t /= Void then
				set_title (t)
			else
				remove_title
			end
		end

feature {NONE} -- Initialization

	open_viewer_selector_menu (w: EV_WIDGET)
			--
		local
			m: EV_MENU
		do
			m := viewers_manager.menu
			check m.parent = Void end
			m.show_at (w, 1, 1)
		end

feature -- Access

	viewer_header_cell: EV_CELL

	viewers_manager: EB_OBJECT_VIEWERS_MANAGER

	current_object: OBJECT_STONE
		do
			Result := viewers_manager.current_object
		end

	refresh
		do
			if is_initialized then
				viewers_manager.refresh
			end
		end

	set_stone (st: OBJECT_STONE)
			-- Give a new object to `Current' and refresh the display.
		do
			viewers_manager.set_stone (st)
		end

	is_destroyed: BOOLEAN
			-- Is viewer manager destroyed ?

feature -- Status setting

	set_size (a_width, a_height: INTEGER_32)
			-- Assign `a_width' to width and `a_height' to height in pixels.
		do
			if is_initialized then
				internal_dialog.set_size (a_width, a_height)
			end
		end

	set_title (s: STRING_GENERAL)
			-- Set title
		do
			if is_initialized then
				internal_dialog.set_title (s)
			end
		end

	remove_title
			-- Remove title
		do
			if is_initialized then
				internal_dialog.remove_title
			end
		end

	close
		do
			if is_interface_usable and is_initialized then
				on_dialog_button_pressed (default_cancel_button)
			end
		end

	on_close
			-- Destroy Current
		do
			viewers_manager.destroy
			viewers_manager := Void
			is_destroyed := True
			command.remove_entry (Current)
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.new_object_icon_buffer
		end

	title: STRING_32
			-- The dialog's title
		do
			if viewers_manager /= Void and then viewers_manager.title /= Void then
				Result := viewers_manager.title
			else
				Result := interface_names.m_object_viewer_tool
			end
		end

	buttons: DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			Result := dialog_buttons.close_buttons
		end

	default_button: INTEGER
			-- The dialog's default action button
		once
			Result := dialog_buttons.close_button
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
		once
			Result := dialog_buttons.close_button
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button
		once
			Result := dialog_buttons.close_button
		end

feature {NONE} -- Implementation

	Layout_constants: EV_LAYOUT_CONSTANTS
			-- Constants for vision2 layout
		once
			create Result
		end

	command: EB_OBJECT_VIEWER_COMMAND;
			-- Command that created `Current' and knows about it.

invariant
	has_command: command /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
