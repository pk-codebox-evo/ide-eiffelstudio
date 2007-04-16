indexing
	description: "Editor token style to generate text which is from an agent."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_AGENT_EDITOR_TOKEN_STYLE

inherit
	EB_EDITOR_TOKEN_STYLE

	EB_SHARED_EDITOR_TOKEN_UTILITY

create
	default_create

feature -- Access

	editor_token_function: FUNCTION [ANY, TUPLE, LIST [EDITOR_TOKEN]]
			-- Function to transform a string to editor tokens

	text: LIST [EDITOR_TOKEN] is
			-- Editor token text generated by `Current' style
		do
			Result := editor_token_function.item (Void)
		end

feature -- Status report

	is_text_ready: BOOLEAN is
			-- Is `text' ready to be displayed?
		do
			Result := editor_token_function /= Void
		end

feature -- Setting

	set_text_function (a_function: FUNCTION [ANY, TUPLE, STRING]) is
			-- Set `text_function' with `a_function'.
		require
			a_text_function_attached: a_function /= Void
		do
			set_editor_token_function (agent editor_token_function_internal (a_function))
		end

	set_editor_token_function (a_function: like editor_token_function) is
			-- Set `editor_token_function' with `a_function'.
		require
			a_function_attached: a_function /= Void
		do
			editor_token_function := a_function
		ensure
			editor_token_function_set: editor_token_function = a_function
		end

feature{NONE} -- Implementation

	editor_token_function_internal (a_string_agent: FUNCTION [ANY, TUPLE, STRING]): LIST [EDITOR_TOKEN] is
			-- Editor token representation of `a_string'.
		require
			a_string_agent_attached: a_string_agent /= Void
		do
			Result := editor_tokens_for_string (a_string_agent.item (Void))
		ensure
			result_attached: Result /= Void
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
