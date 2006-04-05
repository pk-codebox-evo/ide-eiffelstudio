indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECDM_CONFIGURATION_PROPERTIES_DIALOG

inherit
	ECDM_CONFIGURATION_PROPERTIES_DIALOG_IMP

create
	make

feature {NONE} -- Initialization

	make (a_configuration: ECDM_CONFIGURATION; a_manager: ECDM_MANAGER; a_default_configuration: BOOLEAN) is
			-- Initialize dialog with `a_configuration'.
		require
			non_void_configuration: a_configuration /= Void
			non_void_manager: a_manager /= Void
		do
			configuration := a_configuration
			manager := a_manager
			default_configuration := a_default_configuration
			default_create
		ensure
			configuration_set: configuration = a_configuration
			manager_set: manager = a_manager
		end
		
	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_path: STRING
			l_apps: LIST [STRING]
		do
			set_default_push_button (ok_button)
			name_text_label.set_text (configuration.name)
			l_path := configuration.path
			location_text_field.set_text (l_path)
			location_text_field.set_focus
			location_text_field.set_caret_position (1)
			if {SYSTEM_FILE}.exists (l_path) then
				created_label.set_text (formatted_date_time ({SYSTEM_FILE}.get_creation_time (l_path)))
				modified_label.set_text (formatted_date_time ({SYSTEM_FILE}.get_last_write_time (l_path)))
			end
			if default_configuration then
				applications_box.hide
				set_minimum_height (235)
			else
				l_apps := manager.applications (configuration)
				if l_apps /= Void then
					from
						l_apps.start
					until
						l_apps.after
					loop
						applications_list.extend (create {EV_LIST_ITEM}.make_with_text (l_apps.item))
						l_apps.forth
					end
				end
			end
		end

feature -- Access

	configuration: ECDM_CONFIGURATION
			-- Associated configuration

	manager: ECDM_MANAGER
			-- Associated manager

	default_configuration: BOOLEAN
			-- Are we displaying the properties of the default configuration?

feature {NONE} -- Events

	on_ok is
			-- Called by `select_actions' of `ok_button'.
		do
			destroy			
		end

feature {NONE} -- Implementation

	formatted_date_time (a_date: SYSTEM_DATE_TIME): STRING is
			-- Text corresponding to `a_date'
		do
			Result := a_date.to_long_date_string
			Result.append (", ")
			Result.append (a_date.to_long_time_string)
		ensure
			non_void_format: Result /= Void
		end
		
invariant
	non_void_configuration: configuration /= Void

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
end -- class ECDM_CONFIGURATION_PROPERTIES_DIALOG

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Manager
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------