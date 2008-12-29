note
	description: "Object that is responsible for launching c compiler in workbench mode."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FREEZING_LAUNCHER

inherit
	EB_C_COMPILER_LAUNCHER
		redefine
			on_start, generation_path
		end

create
	make

feature{NONE} -- Actions

	on_start
			-- Handler called before c compiler starts
		do
			Precursor
			idle_printing_manager.add_printer ({EB_IDLE_PRINTING_MANAGER}.freezing_printer)
		end

feature{NONE} -- Data storage

	data_storage: EB_PROCESS_IO_STORAGE
		do
			Result := freezing_storage
		end

feature{NONE} -- Generation path

	generation_path: STRING
			-- Path on which c compiler will be launched.
			-- Used when we need to open a console there.
		do
			Result := project_location.workbench_path
		end

feature -- Message

	c_compilation_launched_msg: STRING
			-- Message to indicate c compilation launched successfully
		do
			Result := interface_names.ee_freezing_launched
		end

	c_compilation_launch_failed_msg: STRING
			-- Message to indicate c compilation launch failed
		do
			Result := interface_names.ee_freezing_launch_failed
		end

	c_compilation_succeeded_msg: STRING
			-- Message to indicate c compilation exited successfully
		do
			Result := interface_names.ee_freezing_succeeded
		end

	c_compilation_failed_msg: STRING
			-- Message to indicate c compilation failed
		do
			Result := interface_names.ee_freezing_failed
		end

	c_compilation_terminated_msg: STRING
			-- Message to indicate c compilation has been terminated
		do
			Result := interface_names.ee_freezing_terminated
		end

feature -- Setting

	set_c_compilation_type
			-- Set c compilation type, either freezing or finalizing.
		do
			set_is_last_c_compilation_freezing (True)
		ensure then
			compilation_type_set: is_last_c_compilation_freezing
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

end
