indexing
	description: "Show HTML Help 1.0 help content"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_HELP_ENGINE

inherit
	EV_HELP_ENGINE

	CODE_DOM_PATH
		export
			{NONE} all
		end

feature -- Basic Operations

	show (a_help_context: CODE_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		do
			if not a_help_context.is_empty then
				{WINFORMS_HELP}.show_help (parent, Documentation_path, Documentation_path + "::/" + a_help_context)
			else
				{WINFORMS_HELP}.show_help (parent, Documentation_path)
			end			
		end

feature {NONE} -- Implementation

	parent: WINFORMS_CONTROL is
			-- Dummy windows form control used to parent the Help dialog
		once
			create Result.make_from_text ("")
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
end -- class CODE_HELP_ENGINE

