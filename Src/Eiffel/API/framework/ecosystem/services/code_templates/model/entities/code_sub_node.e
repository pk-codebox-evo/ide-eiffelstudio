indexing
	description: "[
		A parentable code node, for all code template nodes with the exception of the code template definition node {CODE_TEMPLATE_DEFINITION}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	CODE_SUB_NODE [G -> CODE_NODE]

inherit
	CODE_NODE

feature -- Access

	definition: !CODE_TEMPLATE_DEFINITION
			-- Top level code file.
		do
			check is_parented: is_parented end
			Result := (({!G}) #? parent).definition
		end

	parent: G assign set_parent
			-- Parent node of Current node.

feature {CODE_NODE} -- Element change

	set_parent (a_parent: like parent)
			-- Set parent node of Current node.
			--
			--| Note: Use this feature with caution and ensure
		do
			parent := a_parent
		ensure
			parent_assigned: parent = a_parent
			is_parented: (a_parent /= Void and is_parented) or else (a_parent = Void and not is_parented)
		end

feature -- Query

	is_parented: BOOLEAN
			-- Is current node parented to another node?
		do
			Result := parent /= Void
		ensure
			parent_attached: Result implies parent /= Void
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
