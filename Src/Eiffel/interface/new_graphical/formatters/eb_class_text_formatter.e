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
		undefine
			internal_recycle,
			is_editor_formatter
		redefine
			force_stone
		end

	EB_EDITOR_FORMATTER
		undefine
			force_stone
		end

	SHARED_EIFFEL_PROJECT

feature -- Access

	widget: EV_WIDGET is
			-- Graphical representation of the information provided.
		do
			if editor = Void or else class_cmd = Void then
				Result := empty_widget
			else
				Result := editor.widget
			end
		end

	class_cmd: E_CLASS_CMD
			-- Class command that is used to generate text output (especially in files).

feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text generated by `Current' editable?
		do
			Result := False
		end

	is_dotnet_formatter: BOOLEAN is
			-- Is Current formatter also a .NET formatter?
		do
			Result := False
		end

feature -- Setting

	set_focus is
			-- Set focus to current formatter.
		do
			if editor /= Void then
				editor.set_focus
			end
		end

feature -- Formatting

	format is
			-- Refresh `widget'.
		do
			if
				associated_class /= Void and then
				associated_class.is_valid and then
				selected and then
				displayed and then
				editor /= Void and then
				editor.is_initialized and then
				actual_veto_format_result
			then
				display_temp_header
				reset_display
				setup_viewpoint
				generate_text
				if not last_was_error then
					go_to_position
					if has_breakpoints then
						editor.enable_has_breakable_slots
					else
						editor.disable_has_breakable_slots
					end
					editor.set_read_only (not is_editable)
				else
					editor.clear_window
					editor.put_string (Warning_messages.w_Formatter_failed)
					editor.refresh_now
				end
				display_header
				stone.set_pos_container (Current)
				if editor.stone /= Void then
					editor.stone.set_pos_container (Current)
				end
			end
		end

feature {NONE} -- Implementation

	reset_display is
			-- Clear all graphical output.
		do
				-- The contract in the editor library is insuficient.
				-- Ideally `is_initialized' is needed as precondition of almost each call.
				-- Here `is_initialized' is not contract driven protection in the case that
				-- the editor has been recycled.
			if editor /= Void and then editor.is_initialized  then
				editor.clear_window
			end
		end

	generate_text is
			-- Fill `formatted_text' with information concerning `class'.
		local
			retried: BOOLEAN
		do
			if not retried then
				if class_cmd /= Void then
					if has_breakpoints then
						set_is_with_breakable
					else
						set_is_without_breakable
					end
					editor.handle_before_processing (false)
					class_cmd.execute
					editor.handle_after_processing
				end
				last_was_error := False
			else
				last_was_error := True
			end
		rescue
			retried := True
			retry
		end

	create_class_cmd is
			-- Create `class_cmd' depending on its actual type.
		require
			associated_class_non_void: associated_class /= Void
			associated_class_is_compiled: associated_class.has_feature_table
		deferred
		ensure
			class_cmd /= Void
		end

feature -- Status setting

	set_stone (new_stone: CLASSI_STONE) is
			-- Associate current formatter with class contained in `a_stone'.
		local
			a_stone: CLASSC_STONE
		do
			force_stone (new_stone)
			a_stone ?= new_stone
			if a_stone /= Void then
				if (not a_stone.class_i.is_external_class) or is_dotnet_formatter then
					set_class (a_stone.e_class)
				end
			else
				associated_class := Void
				class_cmd := Void
				reset_display
				ensure_display_in_widget_owner
			end
		end

	force_stone (a_stone: STONE) is
			-- Directly set `stone' with `a_stone'
		local
			l_stone: CLASSC_STONE
		do
			Precursor (a_stone)
			l_stone ?= a_stone
			if l_stone /= Void then
				set_associated_class (l_stone.e_class)
			end
		end

	set_associated_class (a_class: CLASS_C) is
			-- Set `associated_class' with `a_class'.
		do
			if a_class = Void or else not a_class.has_feature_table then
				associated_class := Void
			else
				associated_class := a_class
			end
		end

	set_class (a_class: CLASS_C) is
			-- Associate current formatter with `a_class'.
		do
			set_associated_class (a_class)
			if associated_class /= Void then
				create_class_cmd
			else
				class_cmd := Void
			end
			must_format := True
			format
			ensure_display_in_widget_owner
		ensure
			class_set: (a_class /= Void and then a_class.has_feature_table) implies (a_class = associated_class)
			cmd_created_if_possible: (a_class = Void or else not a_class.has_feature_table) = (class_cmd = Void)
		end

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

end -- class EB_CLASS_TEXT_FORMATTER
