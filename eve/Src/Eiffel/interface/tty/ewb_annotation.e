note
	description: "Command for annotation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_ANNOTATION

inherit
	EWB_CMD

	CI_SHARED_SESSION

create
	make_with_arguments

feature {NONE} -- Initialization

	make_with_arguments (a_arguments: LINKED_LIST [STRING])
			-- Initialize `auto_test_arguments' with `a_arguments'.
		require
			a_arguments_attached: a_arguments /= Void
		do
			create {LINKED_LIST [STRING]} contract_inference_arguments.make
			a_arguments.do_all (agent contract_inference_arguments.extend)
		ensure
			arguments_set: contract_inference_arguments /= Void and then contract_inference_arguments.count = a_arguments.count
		end

feature -- Access

	contract_inference_arguments: LINKED_LIST [STRING];
			-- Arguments to AutoFix command line

feature -- Properties

	name: STRING
		do
			Result := "Annotation"
		end

	help_message: STRING_GENERAL
		do
			Result := "Annotation"
		end

	abbreviation: CHARACTER
		do
			Result := 't'
		end

	execute
			-- Action performed when invoked from the
			-- command line.
		do
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
