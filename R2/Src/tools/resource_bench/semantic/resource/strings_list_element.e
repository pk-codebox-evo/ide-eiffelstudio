note
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Strings_list_element -> stringID "," string_value

class STRINGS_LIST_ELEMENT

inherit
	S_STRINGS_LIST_ELEMENT
		redefine 
			pre_action, post_action
		end

	TABLE_OF_SYMBOLS
		undefine
			is_equal, copy
		end

	TDS_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, copy
		end

create
	make

feature 

	pre_action
		local
			stringtable_element: TDS_STRING
			stringtable: TDS_STRINGTABLE
		do
			create stringtable_element.make

			stringtable ?= tds.current_resource

                        stringtable.insert_string (stringtable_element)
			stringtable.set_current_string (stringtable_element)

			tds.set_identifier_type (Stringtable_id)
		end

	post_action
		do      
			tds.set_identifier_type (Normal)
		end

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
end -- class STRINGS_LIST_ELEMENT

