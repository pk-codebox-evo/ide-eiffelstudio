indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_FILE_PATH_BOX_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			initialize, is_in_default_state
		end
			
	WIZARD_CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_BOX}
			initialize_constants
			
				-- Create all widgets.
			create path_label
			create path_text_box
			create path_combo
			create path_button
			
				-- Build_widget_structure.
			extend (path_label)
			extend (path_text_box)
			path_text_box.extend (path_combo)
			path_text_box.extend (path_button)
			
			path_label.set_text ("Path:")
			path_label.align_text_left
			path_text_box.set_padding_width (7)
			path_text_box.disable_item_expand (path_button)
			path_button.set_text ("...")
			path_button.set_minimum_width (40)
			set_padding_width (5)
			disable_item_expand (path_label)
			disable_item_expand (path_text_box)
			
				--Connect events.
			path_combo.select_actions.extend (agent on_select)
			path_combo.change_actions.extend (agent on_change)
			path_combo.return_actions.extend (agent on_return)
			path_combo.focus_in_actions.extend (agent on_mouse_enter)
			path_combo.focus_out_actions.extend (agent on_mouse_leave)
			path_button.select_actions.extend (agent on_browse)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	path_combo: EV_COMBO_BOX
	path_text_box: EV_HORIZONTAL_BOX
	path_label: EV_LABEL
	path_button: EV_BUTTON

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
	
	on_select is
			-- Called by `select_actions' of `path_combo'.
		deferred
		end
	
	on_change is
			-- Called by `change_actions' of `path_combo'.
		deferred
		end
	
	on_return is
			-- Called by `return_actions' of `path_combo'.
		deferred
		end
	
	on_mouse_enter is
			-- Called by `focus_in_actions' of `path_combo'.
		deferred
		end
	
	on_mouse_leave is
			-- Called by `focus_out_actions' of `path_combo'.
		deferred
		end
	
	on_browse is
			-- Called by `select_actions' of `path_button'.
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
end -- class WIZARD_FILE_PATH_BOX_IMP
