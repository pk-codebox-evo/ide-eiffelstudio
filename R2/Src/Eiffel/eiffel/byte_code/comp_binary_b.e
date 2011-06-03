note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Binary expression byte code for a comparable expression

deferred class
	COMP_BINARY_B

inherit
	NUM_BINARY_B
		redefine
			is_built_in, is_type_fixed,
			is_binary_comparison
		end

feature

	is_built_in: BOOLEAN
			-- Is the current binary operator a built-in one ?
		local
			l_char: CHARACTER_A
		do
			Result := Precursor {NUM_BINARY_B}
			if not Result then
				l_char ?= context.real_type (left.type)
				Result := l_char /= Void
			end
		end

	is_type_fixed: BOOLEAN
			-- Is type of the expression statically fixed,
			-- so that there is no variation at run-time?
		do
			Result := is_built_in
		end

	is_binary_comparison: BOOLEAN = True
			-- <Precursor>

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
