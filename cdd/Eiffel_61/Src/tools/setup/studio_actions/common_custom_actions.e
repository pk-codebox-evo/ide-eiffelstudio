indexing
	description: "[
		General purpose, common custom actions
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	COMMON_CUSTOM_ACTIONS

inherit
	SHARED_MSI_API
		export
			{NONE} all
			{ANY} is_valid_handle
		end

	MESSAGE_BOX_HELPER

feature -- Basic Operations

	initialize_properties (a_handle: POINTER): INTEGER is
			-- Initializes any MSI properties that require system execution for initialization
		require
			is_valid_handle: is_valid_handle (a_handle)
		local
			l_user_name: STRING
			retried: BOOLEAN
		do
			if not retried then
				Result := {MSI_API}.error_success

					-- Retrieve username variable and set username property
				l_user_name := (create {EXECUTION_ENVIRONMENT}).get (user_name_property)
				if l_user_name /= Void and then not l_user_name.is_empty then
					msi_api.set_property (a_handle, user_name_property, l_user_name)
				end
			else
				Result := {MSI_API}.error_install_failure
				error_box ("Dll failure in routine `initialize_properties'")
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Property names

	user_name_property: STRING = "USERNAME"
			-- Username property

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
