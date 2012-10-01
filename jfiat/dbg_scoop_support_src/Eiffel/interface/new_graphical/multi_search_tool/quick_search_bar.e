note
	description: "Quick search bar for editors in EiffelStudio.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	QUICK_SEARCH_BAR

inherit
	QUICK_SEARCH_BAR_IMP
		redefine
			destroy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create,
			is_equal,
			copy
		end

	EB_SEARCH_OPTION_OBSERVER
		undefine
			default_create,
			is_equal,
			copy
		end

	EB_RECYCLABLE
		undefine
			default_create,
			is_equal,
			copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_option_manager: EB_SEARCH_OPTION_OBSERVER_MANAGER)
			-- Set `option_manager' with `a_option_manager'
		require
			a_option_manager_not_void: a_option_manager /= Void
		do
			option_manager := a_option_manager
			option_manager.add_observer (Current)
			default_create
		end

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			next_button.set_tooltip (interface_names.b_next)
			previous_button.set_tooltip (interface_names.b_previous)
			match_case_button.set_text (interface_names.l_match_case)
			match_case_button.set_tooltip (interface_names.f_match_case_question)
			regular_expression_button.set_text (interface_names.l_regexp)
			regular_expression_button.set_tooltip (interface_names.f_use_regular_expression_question)
			advanced_button.set_tooltip (interface_names.f_advanced_search)
			close_button.set_tooltip (interface_names.f_close)
			l_ev_label_1.set_text (interface_names.t_find)

			next_button.set_pixmap (stock_pixmaps.general_arrow_down_icon)
			next_button.set_pixel_buffer (stock_pixmaps.general_arrow_down_icon_buffer)
			previous_button.set_pixmap (stock_pixmaps.general_arrow_up_icon)
			previous_button.set_pixel_buffer (stock_pixmaps.general_arrow_up_icon_buffer)
			advanced_button.set_pixmap (stock_pixmaps.tool_advanced_search_icon)
			advanced_button.set_pixel_buffer (stock_pixmaps.tool_advanced_search_icon_buffer)
			create first_reached_pixmap
			create bottom_reached_pixmap
			first_reached_pixmap.set_minimum_size (stock_pixmaps.search_first_reached_icon.width,
													stock_pixmaps.search_first_reached_icon.height)
			bottom_reached_pixmap.set_minimum_size (stock_pixmaps.search_first_reached_icon.width,
														stock_pixmaps.search_first_reached_icon.height)
			first_reached_pixmap.set_tooltip (interface_names.t_first_match_reached)
			bottom_reached_pixmap.set_tooltip (interface_names.t_bottom_reached)
			message_box.extend (first_reached_pixmap)
			message_box.extend (bottom_reached_pixmap)
			first_reached_pixmap.hide
			bottom_reached_pixmap.hide
			first_reached_pixmap.expose_actions.extend (agent on_pixmap_expose (?, ?, ?, ?, first_reached_pixmap, stock_pixmaps.search_first_reached_icon))
			bottom_reached_pixmap.expose_actions.extend (agent on_pixmap_expose (?, ?, ?, ?, bottom_reached_pixmap, stock_pixmaps.search_bottom_reached_icon))
			close_button.set_pixmap (stock_pixmaps.general_close_icon)
			close_button.set_pixel_buffer (stock_pixmaps.general_close_icon_buffer)
			keyword_field.change_actions.extend (agent trigger_sensibility)
			match_case_button.select_actions.extend (agent check_button_changed (match_case_button))
			regular_expression_button.select_actions.extend (agent check_button_changed (regular_expression_button))
			trigger_sensibility
			initialize_lose_focus_action (Current)
			initialize_key_pressed_action (Current)
		end

feature -- Access

	lose_focus: PROCEDURE [ANY, TUPLE]
			-- Any widget loses focus.

	key_press_action: PROCEDURE [ANY, TUPLE [EV_KEY]]
			-- Key is pressed on any widget.

feature -- Status report

	has_focus_on_widgets : BOOLEAN
			-- Any widget has focus.
		do
			Result := has_focus_on_widgets_internal (Current)
		end

	is_case_sensitive : BOOLEAN
			-- Match case?
		do
			Result := match_case_button.is_selected
		end

	is_regex : BOOLEAN
			-- Is regular expression used?
		do
			Result := regular_expression_button.is_selected
		end

feature -- Status change

	trigger_first_reached_pixmap (a_b: BOOLEAN)
			-- Show or hide `first_reached_pixmap'.
		do
			if a_b then
				first_reached_pixmap.show
			else
				first_reached_pixmap.hide
			end
		end

	trigger_bottom_reached_pixmap (a_b: BOOLEAN)
			-- Show or hide `bottom_reached_pixmap'.
		do
			if a_b then
				bottom_reached_pixmap.show
			else
				bottom_reached_pixmap.hide
			end
		end

feature {NONE} -- Recyclable

	internal_recycle
			-- Recycle
		do
			option_manager.remove_observer (Current)
			option_manager := Void
			keyword_field := Void
		end

feature {EB_CUSTOM_WIDGETTED_EDITOR} -- Element change

	set_lose_focus (a_pro: like lose_focus)
			-- Set `lose_focus' with `a_pro'.
		require
			a_pro_attached: a_pro /= Void
		do
			lose_focus := a_pro
		end

	record_current_searched
			-- assign `word' to `currently_searched'
		do
			if keyword_field /= Void then
				if keyword_field.text /= Void and then not keyword_field.text.is_empty then
					update_combo_box (keyword_field.text)
				end
			end
		end

	set_key_press_action (a_action: like key_press_action)
			-- Set `key_press_action' with `a_action'
		require
			a_action_attached: a_action /= Void
		do
			key_press_action := a_action
		end

	trigger_sensibility
			-- Show or hide `next_button' and `previous_button' according to content of `keyword_field'.
		do
			if keyword_field.text_length = 0 then
				next_button.disable_sensitive
				previous_button.disable_sensitive
			else
				next_button.enable_sensitive
				previous_button.enable_sensitive
			end
		end

feature {NONE} -- Option observer

	on_case_sensitivity_changed (a_case_sensitive: BOOLEAN)
			-- Case sensitivity option changed
		do
			if match_case_button.is_selected /= a_case_sensitive then
				match_case_button.select_actions.block
				if a_case_sensitive then
					match_case_button.enable_select
				else
					match_case_button.disable_select
				end
				match_case_button.select_actions.resume
			end
		end

	on_match_regex_changed (a_match_regex: BOOLEAN)
			-- Match regex option changed
		do
			if regular_expression_button.is_selected /= a_match_regex then
				regular_expression_button.select_actions.block
				if a_match_regex then
					regular_expression_button.enable_select
				else
					regular_expression_button.disable_select
				end
				regular_expression_button.select_actions.resume
			end
		end

	on_whole_word_changed (a_whole_word: BOOLEAN)
			-- Whole word option changed
		do
		end

	on_backwards_changed (a_bachwards: BOOLEAN)
			-- Backwards option changed
		do
		end

	check_button_changed (a_button: EV_CHECK_BUTTON)
			-- Option check button changed.
		do
			if a_button = match_case_button then
				option_manager.case_sensitivity_changed (a_button.is_selected)
			elseif a_button = regular_expression_button then
				option_manager.match_regex_changed (a_button.is_selected)
			end
		end

feature -- Destroy

	destroy
			-- Destroy
		do
			keyword_field.destroy
			recycle
			Precursor {QUICK_SEARCH_BAR_IMP}
		end

feature {NONE} -- Helpers

    frozen stock_pixmaps: ES_PIXMAPS_16X16
            -- Shared access to stock 16x16 EiffelStudio pixmaps
        once
            Result := (create {EB_SHARED_PIXMAPS}).icon_pixmaps
        ensure
            result_attached: Result /= Void
        end

feature {NONE} -- Implementation

	first_reached_pixmap, bottom_reached_pixmap: EV_DRAWING_AREA

	option_manager: EB_SEARCH_OPTION_OBSERVER_MANAGER
			-- Search option manager

	initialize_lose_focus_action (a_widget: EV_WIDGET)
			-- Set lose focus action for all child widgets of `a_widget', `a_widget' included.
		require
			a_widget_attached: a_widget /= Void
		local
			l_container: EV_CONTAINER
			l_linear_representation: LINEAR [EV_WIDGET]
		do
			a_widget.focus_out_actions.extend (agent focus_lost)
			l_container ?= a_widget
			if l_container /= Void then
				l_linear_representation := l_container.linear_representation
				if l_linear_representation /= Void and then not l_linear_representation.is_empty then
					from
						l_linear_representation.start
					until
						l_linear_representation.after
					loop
						initialize_lose_focus_action (l_linear_representation.item)
						l_linear_representation.forth
					end
				end
			end
		end

	initialize_key_pressed_action (a_widget: EV_WIDGET)
			-- Set lose focus action for all child widgets of `a_widget', `a_widget' included.
		require
			a_widget_attached: a_widget /= Void
		local
			l_container: EV_CONTAINER
			l_linear_representation: LINEAR [EV_WIDGET]
		do
			a_widget.key_press_actions.extend (agent key_pressed)
			l_container ?= a_widget
			if l_container /= Void then
				l_linear_representation := l_container.linear_representation
				if l_linear_representation /= Void and then not l_linear_representation.is_empty then
					from
						l_linear_representation.start
					until
						l_linear_representation.after
					loop
						initialize_key_pressed_action (l_linear_representation.item)
						l_linear_representation.forth
					end
				end
			end
		end

	focus_lost
			-- Any widget loses focus.
		do
			if lose_focus /= Void then
				ev_application.do_once_on_idle (agent lose_focus.call ([Void]))
			end
		end

	key_pressed (a_key: EV_KEY)
			-- Any wiget a key is pressed.
		do
			if key_press_action /= Void then
			 	key_press_action.call ([a_key])
			end
		end

	update_combo_box (word: STRING_32)
			-- add word to combo box list
		local
			l: LIST [STRING_32]
		do
			l := keyword_field.strings
			if l /= Void then
				l.compare_objects
			end
			if l = Void or else not l.has (word) then
				if keyword_field.count = search_history_size then
					keyword_field.start
					keyword_field.remove
				end
				keyword_field.extend (create {EV_LIST_ITEM}.make_with_text (word))
			end
			if keyword_field.text.is_empty or else not word.is_equal (keyword_field.text) then
				keyword_field.set_text (word)
			end
		end

	has_focus_on_widgets_internal (a_widget: EV_WIDGET): BOOLEAN
			-- Any widget has focus.
		local
			l_container: EV_CONTAINER
			l_linear_representation: LINEAR [EV_WIDGET]
		do
			l_container ?= a_widget
			if l_container /= Void then
				l_linear_representation := l_container.linear_representation
				if l_linear_representation /= Void and then not l_linear_representation.is_empty then
					from
						l_linear_representation.start
					until
						l_linear_representation.after or Result
					loop
						if l_linear_representation.item.has_focus then
							Result := True
						else
							Result := has_focus_on_widgets_internal (l_linear_representation.item)
						end
						l_linear_representation.forth
					end
				elseif l_container.has_focus then
					Result := True
				end
			elseif a_widget.has_focus then
				Result := True
			end
		end

	on_pixmap_expose (a_x, a_y, a_width, a_height: INTEGER; a_drawing_area: EV_DRAWING_AREA; a_pixmap: EV_PIXMAP)
			-- Expose action
		require
			a_drawing_area_not_void: a_drawing_area /= Void
			a_pixmap_not_void: a_pixmap /= Void
		do
			a_drawing_area.set_background_color (stock_color.color_dialog)
			a_drawing_area.clear
			a_drawing_area.draw_pixmap (0, 0, a_pixmap)
		end

	search_history_size: INTEGER = 10;

	stock_color : EV_STOCK_COLORS
			-- Stock color
		once
			create Result
		end

invariant
	option_manager_not_void: not is_recycled implies option_manager /= Void

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
end -- class QUICK_SEARCH_BAR

