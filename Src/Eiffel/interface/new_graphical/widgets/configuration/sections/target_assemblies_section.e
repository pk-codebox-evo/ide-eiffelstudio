indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_ASSEMBLIES_SECTION

inherit
	TARGET_GROUPS_BASE_SECTION

create
	make

feature -- Access

	name: STRING is
			-- Name of the section.
		once
			Result := conf_interface_names.group_assembly_tree
		end

	icon: EV_PIXMAP is
			-- Icon of the section.
		once
			Result := pixmaps.icon_pixmaps.top_level_folder_references_icon
		end

	context_menu: EV_MENU is
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result

			create l_item.make_with_text_and_action (conf_interface_names.group_add_assembly, agent add_group)
			Result.extend (l_item)
			l_item.set_pixmap (pixmaps.icon_pixmaps.new_reference_icon)
		end

feature {NONE} -- Implementation

	create_group_section (a_group: like conf_item_type): like section_item_type is
			-- Create a new group section item.
		do
			create Result.make (a_group, target, configuration_window)
		end

	create_add_dialog: like add_dialog_type is
			-- Create a dialog to add a new group.
		do
			create Result.make (target, configuration_window.conf_factory)
		end

	update_toolbar_sensitivity is
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.add_assembly_button.select_actions.wipe_out
			toolbar.add_assembly_button.select_actions.extend (agent add_group)
			toolbar.add_assembly_button.enable_sensitive
		end

feature {NONE} -- Type anchors

	add_dialog_type: CREATE_ASSEMBLY_DIALOG
			-- Type of the dialog to create a new item.

	conf_item_type: CONF_ASSEMBLY
			-- Type of configuration objects represented.

	section_item_type: ASSEMBLY_SECTION;
			-- Type of sections contained.

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
end
