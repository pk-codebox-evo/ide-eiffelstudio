note
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_GROUP_NODE_WIDGET

inherit
	ER_GROUP_NODE_WIDGET_IMP


feature {NONE} -- Initialization

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_list_item: EV_LIST_ITEM
		do
			-- Check if size definition valid when typing
			size_combo_box.focus_in_actions.extend (agent size_definition_checker.on_focus_in (size_combo_box))
			size_combo_box.focus_out_actions.extend (agent size_definition_checker.on_focus_out (size_combo_box))
			size_combo_box.change_actions.extend (agent size_definition_checker.on_text_change (size_combo_box))

			add_customize_size_definitions

			create l_list_item.make_with_text ("OneButton")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("TwoButtons")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("ThreeButtons")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("ThreeButtons-OneBigAndTwoSmall")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("ThreeButtonsAndOneCheckBox")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("FourButtons")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("FiveButtons")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("FiveOrSixButtons")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("SixButtons")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("SixButtons-TwoColumns")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("SevenButtons")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("EightButtons")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("EightButtons-LastThreeSmall")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("NineButtons")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("TenButtons")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("ElevenButtons")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("OneFontControl")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("IntFontOnly")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("IntRichFont")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("IntFontWithColor")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("OneInRibbonGallery")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("BigButtonsAndSmallButtonsOrInputs")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("InRibbonGalleryAndBigButton")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("InRibbonGalleryAndButtons-GalleryScalesFirst")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("InRibbonGalleryAndThreeButtons")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("ButtonGroupsAndInputs")
			size_combo_box.extend (l_list_item)
			create l_list_item.make_with_text ("ButtonGroups")
			size_combo_box.extend (l_list_item)
		end

	user_create_interface_objects
			-- <Precursor>
		do
				-- Initialize before calling Precursor all the attached attributes
				-- from the current class.

				-- Proceed with vision2 objects creation.
			create size_definition_checker
		end

	add_customize_size_definitions
			-- Added customized size definitions created by `Size Definition Editor'
		local
			l_list_item: EV_LIST_ITEM
			l_shared: ER_SHARED_TOOLS
			l_root: XML_ELEMENT
		do
			create l_shared
			if attached l_shared.size_definition_cell.item as l_size_definition_tool then
				l_root := l_size_definition_tool.size_definition_writer.root_xml_for_saving
				across l_root as l_xml_cursor
				loop
					if attached {XML_ELEMENT} l_xml_cursor.item as l_one_size_definition then
						if l_one_size_definition.name.same_string ({ER_XML_CONSTANTS}.size_definition) then
							across l_one_size_definition as l_one_size_definition_cursor
							loop
								if attached {XML_ATTRIBUTE} l_one_size_definition_cursor.item as l_attribute and then
								 l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.name) then
									create l_list_item.make_with_text (l_attribute.value)
									size_combo_box.extend (l_list_item)
								end
							end
						else
							check invalid_size_definition_xml: False end
						end
					end
				end
			end
		end

feature -- Command

	set_tree_node_data (a_data: detachable ER_TREE_NODE_GROUP_DATA)
			-- Update GUI with tree node data
		do
			tree_node_data := a_data
			if attached a_data as l_data then
				if attached a_data.command_name as l_command_name then
					command_name.set_text (l_command_name)
				else
					command_name.remove_text
				end

				if attached a_data.label_title as l_label_title then
					label.set_text (l_label_title)
				else
					label.remove_text
				end

				if attached a_data.size_definition as l_size_definition then
					size_combo_box.set_text (l_size_definition)
				else
					size_combo_box.remove_text
				end

				if l_data.is_scale_large_checked then
					scale_large.enable_select
				else
					scale_large.disable_select
				end

				if l_data.is_scale_medium_checked then
					scale_medium.enable_select
				else
					scale_medium.disable_select
				end

				if l_data.is_scale_small_checked then
					scale_small.enable_select
				else
					scale_small.disable_select
				end

				if l_data.is_scale_popup_checked then
					scale_popup.enable_select
				else
					scale_popup.disable_select
				end

				if l_data.is_ideal_sizes_large_checked then
					ideal_sizes_large.enable_select
				end

				if l_data.is_ideal_sizes_medium_checked then
					ideal_sizes_medium.enable_select
				end

				if l_data.is_ideal_sizes_small_checked then
					ideal_sizes_small.enable_select
				end
			end
		end

feature {NONE} -- Implementation

	tree_node_data: detachable ER_TREE_NODE_GROUP_DATA
			-- Group tree node data

	size_definition_checker: ER_GROUP_NODE_SIZE_DEFINITION_CHECKER
			-- Check if a size definition name valid

	on_command_name_text_change
			-- <Precursor>
		local
			l_checker: ER_IDENTIFIER_UNIQUENESS_CHECKER
		do
			create l_checker
			l_checker.on_identifier_name_change (command_name, tree_node_data)
		end

	on_label_text_changs
			-- Called by `change_actions' of `label'.
		do
			if attached tree_node_data as l_data then
				l_data.set_label_title (label.text)
			end
		end

	on_size_text_change
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				l_data.set_size_definition (size_combo_box.text)
			end
		end

	on_ideal_sizes_large_select
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				l_data.set_ideal_sizes_large_checked (ideal_sizes_large.is_selected)

				scale_large.disable_sensitive
				scale_medium.enable_sensitive
				scale_small.enable_sensitive
				scale_popup.enable_sensitive

				update_scale_data_with_gui
			end
		end

	on_ideal_sizes_medium_select
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				l_data.set_ideal_sizes_medium_checked (ideal_sizes_medium.is_selected)

				scale_large.disable_sensitive
				scale_medium.disable_sensitive
				scale_small.enable_sensitive
				scale_popup.enable_sensitive

				update_scale_data_with_gui
			end
		end

	on_ideal_sizes_small_select
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				l_data.set_ideal_sizes_small_checked (ideal_sizes_small.is_selected)

				scale_large.disable_sensitive
				scale_medium.disable_sensitive
				scale_small.disable_sensitive
				scale_popup.enable_sensitive

				update_scale_data_with_gui
			end
		end

	on_scale_large_select
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				l_data.set_scale_large_checked (scale_large.is_selected)
			end
		end

	on_scale_medium_select
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				l_data.set_scale_medium_checked (scale_medium.is_selected)
			end
		end

	on_scale_small_select
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				l_data.set_scale_small_checked (scale_small.is_selected)
			end
		end

	on_scale_popup_select
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				l_data.set_scale_popup_checked (scale_popup.is_selected)
			end
		end

	update_scale_data_with_gui
			-- Update group data with GUI widget statues
		do
			if attached tree_node_data as l_data then
				if scale_large.is_sensitive and scale_large.is_selected then
					l_data.set_scale_large_checked (True)
				else
					l_data.set_scale_large_checked (False)
				end
				if scale_medium.is_sensitive and scale_medium.is_selected then
					l_data.set_scale_medium_checked (True)
				else
					l_data.set_scale_medium_checked (False)
				end
				if scale_small.is_sensitive and scale_small.is_selected then
					l_data.set_scale_small_checked (True)
				else
					l_data.set_scale_small_checked (False)
				end
				if scale_popup.is_sensitive and scale_popup.is_selected then
					l_data.set_scale_popup_checked (True)
				else
					l_data.set_scale_popup_checked (False)
				end
			end
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
