note
	description: "[
						Testing tool panel {ES_EWEASEL_TESTING_TOOL_PANEL} shim class
																				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_TESTING_TOOL

inherit
	ES_TOOL [ES_EWEASEL_TESTING_TOOL_PANEL]

create {NONE}
	default_create

feature -- Access

	icon: attached EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.testing_tool_icon_buffer
		end

	icon_pixmap: attached EV_PIXMAP
			-- <Precursor>
		do
			Result := stock_pixmaps.testing_tool_icon
		end

	title: attached STRING_32
			-- <Precursor>
		do
			Result := locale_formatter.translation (t_tool_title)
		end

feature {NONE} -- Factory

	new_tool: attached ES_EWEASEL_TESTING_TOOL_PANEL
			-- <Precursor>
		do
			create Result.make (window, Current)
		end

feature {NONE} -- Internationalization

	t_tool_title: STRING = "Testing"

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
