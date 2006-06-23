indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRETTY_PRINT_DIALOG

inherit
	EB_PRETTY_PRINT_DIALOG_IMP
		rename
			window as dialog
		redefine
			default_create
		end

	EB_CONSTANTS
		undefine
			default_create
		end

	EB_SHARED_DEBUG_TOOLS
		undefine
			default_create
		end

	EB_SHARED_PIXMAPS
		undefine
			default_create
		end

	EB_SHARED_WINDOW_MANAGER
		undefine
			default_create
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create
		end

	REFACTORING_HELPER
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make (cmd: EB_PRETTY_PRINT_CMD) is
			-- Initialize `Current'.
		require
			cmd_not_void: cmd /= Void
		do
			parent := cmd

			slice_min_ref := 0
			slice_max_ref := default_slice_max_value
			default_create
			dialog.set_default_cancel_button (close_button)
		end

	default_create is
			 -- Create `Current'.
		do
			create dialog
			initialize
		ensure then
			dialog_not_void: dialog /= Void
		end

feature {NONE} -- Initialization

	default_slice_max_value: INTEGER is
		do
			Result := preferences.debugger_data.default_expanded_view_size
		end

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			set_slice_button.set_pixmap (pixmaps.icon_pixmaps.general_tick_icon)
			auto_set_slice_button.set_pixmap (icon_pixmaps.debugger_object_expand_icon)
			word_wrap_button.set_pixmap (icon_pixmaps.general_word_wrap_icon)

			editor.set_minimum_height (100)
			editor.set_background_color (No_text_background_color)
			editor.disable_word_wrapping
			editor.disable_edit

			editor.drop_actions.extend (agent on_stone_dropped)
			editor.drop_actions.set_veto_pebble_function (agent is_stone_valid)

			lower_slice_field.set_text (slice_min.out)
			upper_slice_field.set_text (slice_max.out)
			dialog.set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
		end

	Text_format: EV_CHARACTER_FORMAT is
		once
			create Result
			Result.set_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			Result.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			Result.set_font (Preferences.editor_data.font)
		end

	Limits_format: EV_CHARACTER_FORMAT is
		once
			create Result
			Result.set_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			Result.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 0, 0))
			Result.set_font (Preferences.editor_data.font)
		end

	No_text_background_color: EV_COLOR is
		do
--			create Result.make_with_8_bit_rgb (255, 255, 255)
			Result := Preferences.debug_tool_data.expanded_display_bgcolor
		end

feature -- Slice limits

	set_limits (lower, upper: INTEGER) is
			-- Change limits to `lower, upper' values.
		local
			nmin, nmax: INTEGER
		do
			nmin := lower
			nmax := upper

			nmin := nmin.max (0)
			nmax := nmax.max (nmin)

			slice_min_ref.set_item (nmin)
			slice_max_ref.set_item (nmax)
		end

	slice_min: INTEGER is
		do
			Result := slice_min_ref.item
		end

	slice_max: INTEGER is
		do
			Result := slice_max_ref.item
		end

	slice_min_ref: INTEGER_REF
	slice_max_ref: INTEGER_REF

feature -- Status Setting

	is_stone_valid (st: OBJECT_STONE): BOOLEAN is
			-- Is `st' valid stone for Current?
		do
			Result := st /= Void and then parent.accepts_stone (st)
		end

	current_object: OBJECT_STONE
			-- Object `Current' is displaying.

	is_destroyed: BOOLEAN is
			-- Is `dialog' destroyed?
		do
			Result := dialog = Void
		end

	has_object: BOOLEAN is
			-- Has an object been assigned to current?
		do
			Result := current_object /= Void
		end

	current_dump_value: DUMP_VALUE
			-- DUMP_VALUE `Current' is displaying.		

feature -- Status setting

	raise is
			-- Display `dialog' and put it in front.
		do
			dialog.show_relative_to_window (parent.associated_window)
		end

	set_stone (st: OBJECT_STONE) is
			-- Give a new object to `Current' and refresh the display.
		require
			stone_valid: is_stone_valid (st)
			is_running: eb_debugger_manager.application_is_executing
		local
			l_item: EV_ANY
			l_dv: ABSTRACT_DEBUG_VALUE
		do
			current_dump_value := Void
			current_object := st

			l_item := st.ev_item
			if l_item /= Void then
				l_dv ?= l_item.data
				if l_dv /= Void then
					current_dump_value := l_dv.dump_value
				end
			end

			eb_debugger_manager.Application.status.keep_object (st.object_address)
			retrieve_dump_value
			refresh
		end

	retrieve_dump_value is
			-- Retrieve `current_dump_value' from `current_object'.
		require
			has_current_object: has_object
		do
			if current_dump_value = Void then
				current_dump_value := eb_debugger_manager.Application.dump_value_at_address_with_class (current_object.object_address, current_object.dynamic_class)
			end
		end

	refresh is
			-- Recompute the displayed text.
		local
			l_dlg: EV_WARNING_DIALOG
			l_trunc_str: STRING_32
			l_real_str_length: INTEGER
			l_length_str: STRING_32
			l_endpos: INTEGER
		do
			editor.remove_text
			editor.enable_edit
			if
				eb_debugger_manager.application_is_executing
				and then eb_debugger_manager.application_is_stopped
			then
				if has_object then
					retrieve_dump_value
					if current_dump_value /= Void then
						l_trunc_str := current_dump_value.formatted_truncated_string_representation (slice_min, slice_max)
						l_endpos := l_trunc_str.count + 1
						editor.set_text (l_trunc_str)
						editor.format_region (1, l_endpos, Text_format)

						l_real_str_length := current_dump_value.last_string_representation_length
						if slice_min > 0 then
							editor.prepend_text ("... ")
							editor.format_region (1, 5, Limits_format)
							l_endpos := l_endpos + 4
						end
						if slice_max >= 0 and then (slice_max + 1 < l_real_str_length) then
							editor.append_text (" ...")
							l_endpos := l_endpos + 4
							editor.format_region (l_endpos - 4, l_endpos + 2, Limits_format)
						else
							editor.format_region (l_endpos, l_endpos + 1, Limits_format)
							fixme ("this violate assertion, but this is due to a vision2 issue of trailing %%U")
						end
						l_trunc_str := editor.text

						editor.set_background_color (No_text_background_color)
						l_length_str := "Complete length = " + l_real_str_length.out
						dialog.set_title ("Expanded display : " + l_length_str)
						upper_slice_field.set_tooltip (l_length_str)
					else
						create l_dlg.make_with_text ("Sorry a problem occurred, %Nwe are not able to show you the value ...%N")
						l_dlg.show_modal_to_window (dialog)
					end
				end
			end
			editor.disable_edit
		end

	destroy is
			-- Destroy the actual dialog and forget about `Current'.
		require
			not is_destroyed
		do
			clean_dialog_data
			dialog.destroy
			dialog := Void
			parent.remove_dialog (Current)
		ensure
			destroyed: is_destroyed
		end

	--| FIXME XR: Maybe we should add advanced positioning methods (set_position, set_size,...).
	--| FIXME XR: Anyway they wouldn't be used at the moment.

feature {NONE} -- Implementation

	clean_dialog_data is
			-- Clean current data, useless if dialog closed or destroyed
		do
			current_dump_value := Void
			current_object := Void
		end

	text: TEXT_FORMATTER
			-- Text that is displayed in the editor.

	parent: EB_PRETTY_PRINT_CMD
			-- Command that created `Current' and knows about it.

feature {NONE} -- Event handling

	return_pressed_in_lower_slice_field is
			-- Called by `return_actions' of `lower_slice_field'.
		do
			upper_slice_field.set_focus
		end

	return_pressed_in_upper_slice_field is
			-- Called by `return_actions' of `lower_slice_field'.
		do
			set_slice_selected
		end

	set_slice_selected is
			-- Called by `select_actions' of `set_slice_button'.
		local
			lower, upper: INTEGER
			valid: BOOLEAN
			error_dialog: EV_WARNING_DIALOG
		do
			valid := True
			if lower_slice_field.text.is_integer then
				lower := lower_slice_field.text.to_integer
			else
				create error_dialog.make_with_text (warning_messages.w_not_an_integer)
				error_dialog.show_modal_to_window (window_manager.last_focused_development_window.window)
				valid := False
				if lower_slice_field.text_length /= 0 then
					lower_slice_field.select_all
				end
				lower_slice_field.set_focus
			end
			if upper_slice_field.text.is_integer then
				upper := upper_slice_field.text.to_integer
			elseif valid then
				create error_dialog.make_with_text (warning_messages.w_not_an_integer)
				error_dialog.show_modal_to_window (window_manager.last_focused_development_window.window)
				valid := False
				if upper_slice_field.text_length /= 0 then
					upper_slice_field.select_all
				end
				upper_slice_field.set_focus
			end
			if valid then
				set_limits (lower, upper)
--				if upper > 0 then
--					application.set_displayed_string_size (upper)
						--| FIXME JFIAT: 2004-01-30 : linking displayed_string_size between pretty and object browser ??
						--| do we really want this to be set ?
						--| prob is the size for the pretty print dialog and
						--| the size of the displayed string in object browser are linked ...			
--				end
				refresh
			end
		end

	auto_slice_selected is
			-- Called by `select_actions' of `auto_set_slice_button'.
		do
			if has_object then
				lower_slice_field.set_text ("0")
				upper_slice_field.set_text ((-1).out) --(current_dump_value.last_string_representation_length - 1).out)
				slice_min_ref.set_item (0)
				slice_max_ref.set_item (-1)
				refresh

				set_limits (0, current_dump_value.last_string_representation_length - 1)
				upper_slice_field.set_text (slice_max.out)
			end
		end

	word_wrap_toggled is
			-- Called by `select_actions' of `word_wrap_button'.
		do
			dialog.lock_update
			if word_wrap_button.is_selected then
				editor.enable_word_wrapping
			else
				editor.disable_word_wrapping
			end
			dialog.unlock_update
		end

	on_stone_dropped (st: OBJECT_STONE) is
			-- A stone was dropped in the editor. Handle it.
		do
			set_stone (st)
		end

	close_action is
			-- Close dialog
		do
			clean_dialog_data
			dialog.destroy
			dialog := Void
			parent.remove_dialog (Current)
		ensure then
			destroyed: is_destroyed
		end

invariant
	has_parent_command: parent /= Void
	valid_stone: has_object implies is_stone_valid (current_object)

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

end -- class EB_PRETTY_PRINT_DIALOG
