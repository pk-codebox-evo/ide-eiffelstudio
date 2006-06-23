indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_DEBUGGER_EXCEPTION_DIALOG_IMP

inherit
	EB_DIALOG_CONSTANTS

feature -- Access

	window: EV_DIALOG
		-- `Result' is widget with which `Current' is implemented

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			initialize_constants

				-- Create all widgets.
			create l_ev_vertical_box_1
			create l_ev_horizontal_box_1
			create label
			create l_ev_cell_1
			create wrapping_button
			create message_text
			create details_box
			create details_text
			create l_ev_horizontal_box_2
			create l_ev_cell_2
			create save_button
			create l_ev_cell_3
			create close_button
			create l_ev_cell_4

				-- Build_widget_structure.
			window.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (label)
			l_ev_horizontal_box_1.extend (l_ev_cell_1)
			l_ev_horizontal_box_1.extend (wrapping_button)
			l_ev_vertical_box_1.extend (message_text)
			l_ev_vertical_box_1.extend (details_box)
			details_box.extend (details_text)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (l_ev_cell_2)
			l_ev_horizontal_box_2.extend (save_button)
			l_ev_horizontal_box_2.extend (l_ev_cell_3)
			l_ev_horizontal_box_2.extend (close_button)
			l_ev_horizontal_box_2.extend (l_ev_cell_4)

			l_ev_vertical_box_1.set_padding_width (tiny_padding)
			l_ev_vertical_box_1.set_border_width (small_padding)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_vertical_box_1.disable_item_expand (details_box)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_horizontal_box_1.disable_item_expand (label)
			l_ev_horizontal_box_1.disable_item_expand (wrapping_button)
			label.set_minimum_height (20)
			wrapping_button.enable_select
			wrapping_button.set_text ("wrap")
			message_text.set_minimum_width (300)
			message_text.set_minimum_height (80)
			message_text.disable_edit
			details_box.set_text ("Additional details")
			l_ev_horizontal_box_2.set_padding_width (tiny_padding)
			l_ev_horizontal_box_2.set_border_width (small_padding)
			l_ev_horizontal_box_2.disable_item_expand (save_button)
			l_ev_horizontal_box_2.disable_item_expand (close_button)
			save_button.set_text ("Save")
			save_button.set_minimum_width (default_button_width)
			close_button.set_text (close_string)
			close_button.set_minimum_width (default_button_width)
			window.set_minimum_width (400)

				--Connect events.
			wrapping_button.select_actions.extend (agent set_wrapping_mode)
			save_button.select_actions.extend (agent save_exception_message)
			close_button.select_actions.extend (agent close_dialog)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Basic operation

	show is
			-- Show `Current'.
		do
			window.show
		end

feature -- Access

	save_button, close_button: EV_BUTTON
	message_text: EV_TEXT
	wrapping_button: EV_CHECK_BUTTON
	label, details_text: EV_LABEL
	details_box: EV_FRAME

feature {NONE} -- Implementation

	l_ev_cell_1, l_ev_cell_2, l_ev_cell_3, l_ev_cell_4: EV_CELL
	l_ev_horizontal_box_1, l_ev_horizontal_box_2: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1: EV_VERTICAL_BOX

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end

	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end

	set_wrapping_mode is
			-- Called by `select_actions' of `wrapping_button'.
		deferred
		end

	save_exception_message is
			-- Called by `select_actions' of `save_button'.
		deferred
		end

	close_dialog is
			-- Called by `select_actions' of `close_button'.
		deferred
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

end -- class EB_DEBUGGER_EXCEPTION_DIALOG_IMP
