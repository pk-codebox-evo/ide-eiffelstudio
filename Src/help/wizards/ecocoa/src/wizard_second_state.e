﻿note
	description: "Final state of the wizard."
	author: "Daniel Furrer <danie.furrer@gmail.com>", "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SECOND_STATE

inherit
	BENCH_WIZARD_FINAL_STATE_WINDOW

	EXECUTION_ENVIRONMENT
		rename
			command_line as ex_command_line
		end

	WIZARD_PROJECT_SHARED

create
	make

feature -- Access

	display_state_text
		do
			title.set_text (interface_names.t_completing_wizard)
			message.set_text (
				interface_names.m_you_have_specified_the_following_setting (wizard_information.project_name,
																	wizard_information.project_location.name)
				+ "%N%N"
				+ interface_names.m_click_finish_to (wizard_information.compile_project)
			)
		end

	final_message: STRING_32
		do
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
