note
	description: "Object that represents a concatenated grid editor token style"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_BIN_EDITOR_TOKEN_STYLE

inherit
	EB_EDITOR_TOKEN_STYLE

create
	make

feature{NONE} -- Initialization

	make (a_style, b_style: EB_EDITOR_TOKEN_STYLE)
			-- Initialize `first_style' with `a_style' and
			-- `second_style' with `b_style'.
		require
			a_style_attached: a_style /= Void
			b_style_attached: b_style /= Void
		do
			set_first_style (a_style)
			set_second_style (b_style)
		end

feature -- Status report

	is_text_ready: BOOLEAN
			-- Is `text' ready to be returned?
		do
			Result := True
		end

feature -- Access

	first_style: EB_EDITOR_TOKEN_STYLE
			-- Style whose text appears first in result `text'

	second_style: EB_EDITOR_TOKEN_STYLE
			-- Style whose text appears after `first_style' in result `text'

	text: LIST [EDITOR_TOKEN]
			-- Editor token text generated by `Current' style
		do
			Result := first_style.text
			Result.append (second_style.text)
		end

feature -- Setting

	set_first_style (a_style: like first_style)
			-- Set `first_style' with `a_style'.
		do
			first_style := a_style
		ensure
			first_style_set: first_style = a_style
		end

	set_second_style (a_style: like second_style)
			-- Set `second_style' with `a_style'.
		do
			second_style := a_style
		ensure
			second_style_set: second_style = a_style
		end

invariant
	first_style_attached: first_style /= Void
	second_style_attached: second_style /= Void

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

end

