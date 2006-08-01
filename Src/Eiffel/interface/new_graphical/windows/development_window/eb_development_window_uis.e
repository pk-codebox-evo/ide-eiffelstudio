indexing
	description: "User Interfaces of EB_DEVELOPMENT_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_UIS

inherit
	EB_DEVELOPMENT_WINDOW_PART

create
	make

feature -- Query

	editors_widget: EV_VERTICAL_BOX
			-- Editors widget.

	arguments_dialog: EB_ARGUMENT_DIALOG
			-- The arguments dialog for current, if any

	goto_dialog: EB_GOTO_DIALOG
			-- The goto dialog for line number access

	add_editor_to_list (an_editor: EB_EDITOR) is
			-- Adds `an_editor' to `editors'
		do
			editors.extend (an_editor)
		end

	current_editor: EB_EDITOR is
			-- Current editor, if none, main editor
		do
			if current_editor_index /= 0 then
				Result := editors @ current_editor_index
			else
				Result := editors.first
			end
		end

	editors: ARRAYED_LIST [EB_EDITOR]
			-- Editor contained in `Current'

	current_editor_index: INTEGER
			-- Index in `editors' of the editor that has the focus.

	save_backup_dialog: EV_CONFIRMATION_DIALOG is
			-- Save backup_dialog
		do
			create Result.make_with_text (develop_window.Warning_messages.w_save_backup)
			Result.set_buttons_and_actions (<<"Continue", "Cancel">>, <<agent develop_window.continue_save, agent develop_window.cancel_save>>)
			Result.set_default_push_button (Result.button("Continue"))
			Result.set_default_cancel_button (Result.button("Cancel"))
			Result.set_title ("Save Backup")
		ensure
			save_backup_dialog_attached: Result /= Void
		end

feature -- Command

	set_current_editor (an_editor: EB_EDITOR) is
			-- Set `an_editor' as main editor
		local
			old_index: INTEGER
			new_index: INTEGER
		do
			old_index := current_editor_index
			new_index := editors.index_of (an_editor, 1)
			if
				editors.valid_index (new_index) and
				old_index /= new_index
			then
				current_editor_index := new_index
				develop_window.update_paste_cmd
					-- Last thing, update the menu entry for the formatting marks.
				if current_editor.view_invisible_symbols then
					develop_window.formatting_marks_command_menu_item.set_text (develop_window.Interface_names.m_hide_formatting_marks)
				else
					develop_window.formatting_marks_command_menu_item.set_text(develop_window.Interface_names.m_show_formatting_marks)
				end
				develop_window.command_controller.set_current_editor (an_editor)
			end
		end

feature -- Settings

	set_editors_widget (a_widget: like editors_widget) is
			-- Set `editors_widget'
		do
			editors_widget := a_widget
		ensure
			set: editors_widget = a_widget
		end

	set_editors (a_editors: like editors) is
			-- Set `editors'
		do
			editors := a_editors
		ensure
			set: editors = a_editors
		end

	set_goto_dialog (a_dialog: like goto_dialog) is
			-- Set `goto_dialog'
		do
			goto_dialog := a_dialog
		ensure
			set: goto_dialog = a_dialog
		end

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
