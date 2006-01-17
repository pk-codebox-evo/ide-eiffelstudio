indexing
	description: "Formatter displaying class information in a text area."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CLASS_TEXT_FORMATTER

inherit
	EB_CLASS_INFO_FORMATTER
		redefine
			new_button		
		end
		
	SHARED_EIFFEL_PROJECT

feature -- Access

	new_button: EV_TOOL_BAR_RADIO_BUTTON is
			-- Create a new toolbar button and associate it with `Current'.
		do
			Result := Precursor {EB_CLASS_INFO_FORMATTER}
			Result.drop_actions.extend (agent on_class_drop)
		end

	widget: EV_WIDGET is
			-- Graphical representation of the information provided.
		do
			if editor = Void or else class_cmd = Void then
				Result := empty_widget
			else
				Result := internal_widget
			end
		end	
	
	is_dotnet_formatter: BOOLEAN is 
			-- Is Current formatter also a .NET formatter?
		do
			Result := False
		end

feature -- Formatting

	format is
			-- Refresh `widget'.
		do
			if selected and then displayed then
				if must_format then
					display_temp_header
					generate_text
				end
				if not last_was_error then
					if editor.current_text /= formatted_text then						
						editor.process_text (formatted_text)
						go_to_position
					end					
					if has_breakpoints then
						editor.enable_has_breakable_slots
					else
						editor.disable_has_breakable_slots
					end
					editor.set_read_only (not editable)
				else
					editor.clear_window
					editor.display_message (Warning_messages.w_Formatter_failed)
				end
				display_header
				must_format := last_was_error
			end
		end

feature {NONE} -- Implementation

	reset_display is
			-- Clear all graphical output.
		do
			editor.clear_window
		end

	on_class_drop (cs: CLASSI_STONE) is
			-- Notify `manager' of the dropping of `cs'.
		do
			if not selected then
				execute
			end
--			if cs.class_i /= associated_class.lace_class then
				manager.set_stone (cs)
--			end
		end

	editable: BOOLEAN is
			-- Is the text generated by `Current' editable?
		do
			Result := False
		end

	empty_widget: EV_WIDGET is
			-- Widget displayed when no information can be displayed.
		local
			def: EV_STOCK_COLORS
		do
			create def
			create {EV_CELL} Result
			Result.set_background_color (def.White)
			Result.drop_actions.extend (agent on_class_drop) 
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_CLASS_TEXT_FORMATTER
