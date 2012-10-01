note
	description: "Objects that represent an EV_TITLED_WINDOW generated by Build."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FIND_EIFFEL_FEATURE_NAME_DIALOG

inherit
	FIND_EIFFEL_FEATURE_NAME_DIALOG_IMP

--create
--	make
--	
--feature -- Initialization
--
--	make (a_window: MAIN_WINDOW) is
--			-- init `parent_window'.
--		require
--			non_void_a_window: a_window /= Void
--		do
--			parent_window := a_window
--			initialize
--		ensure
--			parent_window_set: parent_window = a_window implies parent_window /= Void
--		end

feature -- Access

	parent_window: MAIN_WINDOW
			-- parent window.


feature -- Status Setting

	set_parent_window (a_window: MAIN_WINDOW)
			-- init `parent_window'.
		require
			non_void_a_window: a_window /= Void
		do
			parent_window := a_window
		ensure
			parent_window_set: parent_window = a_window implies parent_window /= Void
		end


feature {NONE} -- Implementation

	user_initialization
			-- Called by `select_actions' of `execute'.
		do
			set_size (400, 85)
			--set_default_push_button (ok_btn)
			--set_default_cancel_button (cancel_btn)
		end

	on_search
			-- Called by `change_actions' of `assemblies_combo'.
		local
			types: LINKED_LIST [SPECIFIC_TYPE]
			edit: EDIT_FACTORY
			eiffel_class_name_to_search: STRING
		do
			create edit.make (parent_window)
			eiffel_class_name_to_search := eiffel_class_name.text
			eiffel_class_name_to_search.to_upper
			types := (create {FINDER}).find_eiffel_type_name (eiffel_class_name_to_search)
			edit.edit_result_search_eiffel_type_name (types)
		end

	on_cancel
			-- Called by `change_actions' of `assemblies_combo'.
		do
			destroy
		end

	on_enter (a_key: EV_KEY)
			-- Called by `key_press_actions' of `eiffel_class_name'.
		local
			key_constant: EV_KEY_CONSTANTS
		do
			create key_constant
			if a_key.code = key_constant.key_enter then
				on_search
			end
		end

invariant
	non_void_parent_window: parent_window /= Void

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


end -- FIND_EIFFEL_FEATURE_NAME_DIALOG
