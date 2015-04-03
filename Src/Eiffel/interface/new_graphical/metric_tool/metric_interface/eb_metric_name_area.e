note
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_NAME_AREA

inherit
	EB_METRIC_NAME_AREA_IMP

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_METRIC_TOOL_INTERFACE
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_METRIC_COMPONENT
		undefine
			is_equal,
			copy,
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make (a_tool: like metric_tool; a_panel: like metric_panel)
			-- Initialize `metric' with `a_metric' mode with `a_mode' and `unit' with `a_unit'.
		require
			a_tool_attached: a_tool /= Void
		do
			set_metric_tool (a_tool)
			set_metric_panel (a_panel)
			default_create
		ensure
			metric_tool_set: metric_tool = a_tool
			metric_panel_set: metric_panel = a_panel
		end

	user_create_interface_objects
			-- <Precursor>
		do
			-- FIXME: Currently code is not void-safe and initialization still takes place in `user_initialization'.
		end

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_text: EV_TEXT_FIELD
		do
			name_lbl.set_text (metric_names.l_name_colon)
			type_lbl.set_text (metric_names.l_type_colon)
			unit_lbl.set_text (metric_names.l_unit_colon)
			description_lbl.set_text (metric_names.l_description_colon)
			name_text_read_only.hide
			description_text_read_only.hide
			create l_text
			name_text_read_only.set_background_color (l_text.background_color)
			description_text_read_only.set_background_color (l_text.background_color)
			attach_non_editable_warning_to_text (metric_names.t_predefined_text_not_editable, name_text_read_only, metric_tool_window)
			attach_non_editable_warning_to_text (metric_names.t_predefined_text_not_editable, description_text_read_only, metric_tool_window)

			name_text.key_press_actions.extend (agent on_key_pressed (?, name_text))
			description_text.key_press_actions.extend (agent on_key_pressed (?, description_text))

				-- Delete following in docking EiffelStudio.
			append_drop_actions (
				<<name_empty_area>>,
				metric_tool
			)
		end

feature -- Status report

	is_read_only_mode_enabled: BOOLEAN
			-- Is current area in read only mode?

feature -- Access

	name: STRING
			-- Name in current area
		do
			if is_read_only_mode_enabled then
				Result := name_text_read_only.text
			else
				Result := name_text.text
			end
		ensure
			result_attached: Result /= Void
		end

	description: STRING
			-- Description in current area
		do
			if is_read_only_mode_enabled then
				Result := description_text_read_only.text
			else
				Result := description_text.text
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Basic operations

	set_name (a_name: STRING)
			-- Set `name' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			if is_read_only_mode_enabled then
				name_text_read_only.set_text (a_name)
			else
				name_text.set_text (a_name)
			end
		end

	set_description (a_description: STRING)
			-- Set `description' with `a_description'.
		require
			a_description_attached: a_description /= Void
		do
			if is_read_only_mode_enabled then
				description_text_read_only.set_text (a_description)
			else
				description_text.set_text (a_description)
			end
		end

	set_type (a_type: INTEGER)
			-- Set text of `type_text' with `a_type'.			
		require
			a_type_valid: is_metric_type_valid (a_type)
		do
			type_text.set_text (displayed_name (name_of_metric_type (a_type)))
			type_pixmap.copy (pixmap_from_metric_type (a_type))
		end

	set_unit (a_unit: QL_METRIC_UNIT)
			-- Set text of `unit_text' with `a_unit'.
		require
			a_unit_attached: a_unit /= Void
		do
			unit_text.set_text (unit_name_table.item (a_unit))
			unit_pixmap.copy (pixmap_from_unit (a_unit))
		end

	enable_read_only_mode
			-- Enable read only mode.
		do
			is_read_only_mode_enabled := True
			name_text.disable_edit
			description_text.disable_edit
			name_text.hide
			description_text.hide
			name_text_read_only.show
			description_text_read_only.show
		ensure
			is_read_only_mode_enabled: is_read_only_mode_enabled
		end

	disable_read_only_mode
			-- Disable read only mode.
		do
			is_read_only_mode_enabled := False
			name_text.enable_edit
			description_text.enable_edit
			name_text.show
			description_text.show
			name_text_read_only.hide
			description_text_read_only.hide
		ensure
			is_read_only_mode_disabled: not is_read_only_mode_enabled
		end

feature{NONE} -- Actions

	on_key_pressed (a_key: EV_KEY; a_text: EV_TEXT_COMPONENT)
			-- Action to be performed when `a_key' is pressed on `a_text'
		require
			a_key_attached: a_key /= Void
			a_text_attached: a_text /= Void
			not_a_text_is_destroyed: not a_text.is_destroyed
		local
			l_key_code: INTEGER
		do
			if ev_application.ctrl_pressed then
				l_key_code := a_key.code
				inspect
					l_key_code
				when {EV_KEY_CONSTANTS}.key_a then
					if a_text.text.count > 0 then
						a_text.select_all
					end
				when {EV_KEY_CONSTANTS}.key_c then
					if a_text.has_selection then
						ev_application.clipboard.set_text (a_text.selected_text)
					end
				else
				end
			end
		end

note
        copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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

end -- class EB_METRIC_NAME_AREA

