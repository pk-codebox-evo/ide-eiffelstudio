indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_NAMING_DIALOG

inherit
	GB_NAMING_DIALOG_IMP

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		undefine
			copy, default_create
		end

create
	make_with_values

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
			ok_button.select_actions.extend (agent validate)
			cancel_button.select_actions.extend (agent cancelled_action)
			show_actions.extend (agent name_field.set_focus)
			set_icon_pixmap (Icon_build_window @ 1)
		end

	make_with_values (initial_name, a_title, prompt, an_invalid_message: STRING; a_validation_agent: like validation_agent) is
			-- Create `Current' with `initial_name' displayed in `name_field', a title `a_title', `an_invalid_message' displayed
			-- when `a_validation_agent' returns False.
		require
			strings_not_void: initial_name /= Void and a_title /= Void
				and prompt /= Void and an_invalid_message /= Void
			validation_agent_not_void: a_validation_agent /= Void
		do
				-- We must never return a void, name.
			name := ""
			default_create
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
			set_title (a_title)
			prompt_label.set_text (prompt)
			name_field.set_text (initial_name)
			invalid_message := an_invalid_message
			validation_agent := a_validation_agent
		end

feature -- Basic operation

	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		do
			name := a_name
			name_field.set_text (name)
		end

	name: STRING
		-- The name currently represented by `Current'.

	cancelled: BOOLEAN
		-- Has `Current' been cancelled?

feature {NONE} -- Implementation

	invalid_message: STRING
		-- Message displayed if `text' not valid.

	validation_agent: FUNCTION [ANY, TUPLE [STRING], BOOLEAN]
		-- Agent to validate entry in `initial_text'.

	validate is
			-- Validate entry in `text_field' using `validation_agent'.
		local
			warning_dialog: EV_WARNING_DIALOG
		do
			validation_agent.call ([name_field.text.as_string_8])
			if validation_agent.last_result then
				name := name_field.text
				hide
			else
				create warning_dialog.make_with_text ("'" + name_field.text + "'" + invalid_message)
				warning_dialog.show_modal_to_window (Current)
			end
		end

	cancelled_action is
			-- Respond to a press of `cancel_button', by hiding
			-- `Current', and assigning `True' to `cancelled'.
		do
			cancelled := True
			hide
		ensure
			is_cancelled: cancelled = True
		end

invariant
	name_not_void: name /= Void

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


end -- class GB_NAMING_DIALOG

