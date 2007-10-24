indexing
	description	: "launcher for boogie, also handles boogie output"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	BOOGIE_LAUNCHER

inherit
	EB_PROCESS_LAUNCHER

create
	make
	
feature {NONE} -- Initalization
	
	make (a_verifier: BOOGIE_VERIFIER) is
			-- Initialization
		do
			verifier := a_verifier
			set_buffer_size (128)
			set_time_interval (100)
			set_output_handler (agent handle_output)
			set_on_exit_handler (agent on_exit)
			create boogie_output.make(256)
		end

feature -- Output processing

	handle_output (o: STRING) is
			-- Handle output generated by the process.
		do
			boogie_output.append(o)
		end

	on_exit is
			-- Handle output generated by the process.
		do
			verifier.handle_boogie_output (boogie_output)
		end

feature -- Access
	
	data_storage: EB_PROCESS_IO_STORAGE is
			-- Data storage location.
		do
			Result := external_storage
		end

feature {NONE} -- Implementation
	
	verifier: BOOGIE_VERIFIER;

	boogie_output: STRING
	
invariant
	verifier_not_void: verifier /= Void
	
indexing
	copyright:	"Copyright (c) 2007, Raphael Mack and Bernd Schoeller"
	license:	"GPL version 2 or later"
	copying: "[

				 This program is free software; you can redistribute it and/or
				 modify it under the terms of the GNU General Public License as
				 published by the Free Software Foundation; either version 2 of
				 the License, or (at your option) any later version.
				
				 This program is distributed in the hope that it will be useful,
				 but WITHOUT ANY WARRANTY; without even the implied warranty of
				 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
				 GNU General Public License for more details.
				
				 You should have received a copy of the GNU General Public
				 License along with this program; if not, write to the Free Software
				 Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
				 MA 02110-1301  USA
				 ]"

end -- class BPL_BOOGIE_LAUNCHER
