indexing
	description	: "Command to statically verify a class (or feature) with ballet"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_VERIFY_COMMAND

inherit
	EB_MENUABLE_COMMAND
		redefine
			default_create
		end

	SHARED_WORKBENCH
		redefine
			default_create
		end

create
	default_create

feature -- Initialization

	default_create is
			-- Default initialization.
		do
			Precursor {EB_MENUABLE_COMMAND}
			create ballet.make
		end

feature -- Execution

	execute is
			-- Verfication button is clicked.
		local
			cs: CLASSI_STONE
			window: EB_DEVELOPMENT_WINDOW
		do
			window := window_manager.last_focused_development_window
			cs ?= window.stone
			if cs /= Void then
				drop_class (cs)
			end
		end

feature -- Events

		drop_class (cs: CLASSI_STONE) is
				-- Class is dropped onto the verification button.
			local
				eif_class: EIFFEL_CLASS_I
				window: EB_DEVELOPMENT_WINDOW
			do
				window := window_manager.last_focused_development_window
				eif_class ?= cs.class_i
				if eif_class /= Void then
					if eif_class.is_compiled then
						ballet.set_class (eif_class)
						ballet.execute_verification
					else
						print ("Dropped class must be compiled first.%N")
					end
				end
			end

feature {NONE} -- Implementation

	ballet: BALLET

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		once
			Result := "Verify Class"
		end

invariant

	ballet_not_void: ballet /= Void

indexing
	copyright:	"Copyright (c) 2006-2007, Raphael Mack and Bernd Schoeller"
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

end -- class EB_VERIFY_COMMAND

