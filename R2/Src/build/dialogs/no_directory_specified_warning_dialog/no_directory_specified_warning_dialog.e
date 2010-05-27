note
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NO_DIRECTORY_SPECIFIED_WARNING_DIALOG

inherit
	NO_DIRECTORY_SPECIFIED_WARNING_DIALOG_IMP

	EIFFEL_RESERVED_WORDS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	BUILD_RESERVED_WORDS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	GB_NAMING_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	EV_STOCK_COLORS
		rename
			implementation as stock_colors_implementation
		export
			{NONE} all
		undefine
			copy, is_equal, default_create
		end

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS)
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

feature {NONE} -- Initialization

	user_initialization
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			pixmap: EV_PIXMAP
		do
			pixmap := ((create {EV_STOCK_PIXMAPS}).warning_pixmap).twin
			pixmap.set_minimum_size (pixmap.width, pixmap.height)
			pixmap_cell.extend (pixmap)
			set_default_cancel_button (cancel_button)
		end

feature -- Access

	cancelled: BOOLEAN
			-- Has `Current' been cancelled?

	directory_name: STRING
			-- `Result' is name of directory entered by user, or `Void'
			-- if `cancelled'.

feature {NONE} -- Implementation


	text_changed
			-- Called by `change_actions' of `l_text_field_1'.
		local
			current_text: STRING
		do
			current_text := directory_name_field.text.as_lower
			if valid_class_name (current_text) and not Reserved_words.has (current_text) and not
				Build_reserved_words.has (current_text) and not
				components.object_handler.string_used_globally_as_object_or_feature_name (current_text)
				and not components.constants.all_constants.has (current_text) then
				directory_name_field.set_foreground_color (black)
				ok_button.enable_sensitive
			else
				directory_name_field.set_foreground_color (red)
				ok_button.disable_sensitive
			end
		end

	return_pressed
			-- Called by `return_actions' of `directory_name_field'.
		do
				-- Check the sensitivity of `ok_button' as it
				-- is automatically disabled when entered text is not
				-- valid.
			if ok_button.is_sensitive then
				ok_button_pressed
			end
		end

	ok_button_pressed
			-- Called by `select_actions' of `ok_button'.
		do
			hide
			directory_name := directory_name_field.text.as_lower
		end


	cancel_button_pressed
			-- Called by `select_actions' of `cancel_button'.
		do
			hide
			cancelled := True
		end

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


end -- class NO_DIRECTORY_SPECIFIED_WARNING_DIALOG

