indexing
	description: "Only name is displayed as displaying a local."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_LOCAL_ITEM_NAME_STYLE

inherit
	EB_GRID_LOCAL_ITEM_STYLE

	SHARED_TEXT_ITEMS

feature -- Access

	text (a_item: EB_GRID_LOCAL_ITEM): LIST [EDITOR_TOKEN] is
			-- Text of current style for `a_item'
		do
			token_writer.new_line
			token_writer.process_local_text (a_item.name)
			Result := token_writer.last_line.content
		end

feature{NONE} -- Implementation

	setup_tooltip (a_item: EB_GRID_LOCAL_ITEM) is
			-- Setup tooltip for `a_item'.
		do
			if a_item.general_tooltip /= Void then
				a_item.remove_general_tooltip
			end
			a_item.set_general_tooltip (tooltip (a_item))
			a_item.general_tooltip.veto_tooltip_display_functions.extend (agent a_item.should_tooltip_be_displayed)
		end

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

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
