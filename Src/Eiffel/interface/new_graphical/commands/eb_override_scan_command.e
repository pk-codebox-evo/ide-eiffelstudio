indexing
	description: "Scan the override clusters for changes and recompile."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OVERRIDE_SCAN_COMMAND

inherit
	EB_MELT_PROJECT_COMMAND
		redefine
			name, menu_name, description, pixmap,
			perform_compilation, tooltip,
			make, tooltext
		end

create
	make

feature {NONE} --Initialization

	make is
			-- Initialize `Current'.
		do
			Precursor {EB_MELT_PROJECT_COMMAND}
			accelerator := create {EV_ACCELERATOR}.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_f8), False, False, True
			)
			accelerator.actions.extend (agent execute)
		end

feature {NONE} -- Implementation

	perform_compilation is
			-- The actual compilation process.
		do
			eiffel_project.override_scan
		end

feature {NONE} -- Attributes

	name: STRING is "Override_scan"
			-- Name of the command.

	tooltext: STRING_GENERAL is
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_override_scan
		end

	menu_name: STRING_GENERAL is
			-- Name used in menu entry
		do
			Result := Interface_names.m_override_scan
		end

	description, tooltip: STRING_GENERAL is
			-- String displayed as a tooltip and in the toolbar customization dialog.
		do
			Result := Interface_names.e_override_scan
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.project_quick_melt_icon
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
