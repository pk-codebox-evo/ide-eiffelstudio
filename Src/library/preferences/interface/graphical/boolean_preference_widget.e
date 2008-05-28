indexing
	description	: "Default widget for viewing and editing boolean preferences.  A combo box with two values ('True' and 'False')"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$ and "

class
	BOOLEAN_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			preference,
			change_item_widget,
			update_changes,
			refresh
		end

create
	make,
	make_with_preference

feature -- Access

	graphical_type: STRING is
			-- Graphical type identifier.
		do
			Result := "BOOLEAN"
		end

	change_item_widget: EV_GRID_CHECKABLE_LABEL_ITEM

feature -- Status Setting

	update_changes is
			-- Update the changes made in `change_item_widget' to `preference'.
		do
			preference.set_value (value_from_displayed)
			Precursor {PREFERENCE_WIDGET}
		end

	show is
			-- Show the widget in its editable state
		do
			-- It is already editable as a checkbox
		end

	refresh is
		do
			Precursor {PREFERENCE_WIDGET}
			change_item_widget.checked_changed_actions.block
			change_item_widget.set_is_checked (preference.value)
			change_item_widget.checked_changed_actions.resume
			change_item_widget.set_text (displayed_value (preference.value))
		end

	set_displayed_booleans (a_true, a_false: STRING_GENERAL) is
			-- Set booleans to display.
			-- {BOOLEAN}.out is used if void.
		do
			displayed_true := a_true
			displayed_false := a_false
			refresh
		end

feature {NONE} -- Implementation

	update_preference is
			-- Updates preference.
		do
		end

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.set_spacing (4)
			change_item_widget.set_is_checked (preference.value)
			change_item_widget.set_text (displayed_value (preference.value))
			change_item_widget.checked_changed_actions.extend (agent checkbox_value_changed)
		end

	checkbox_value_changed (v: EV_GRID_CHECKABLE_LABEL_ITEM) is
		do
			preference.set_value (v.is_checked)
			change_item_widget.set_text (displayed_value (preference.value))
			update_changes
		end

	preference: BOOLEAN_PREFERENCE
			-- Actual preference.	

	last_selected_value: BOOLEAN
			-- Last selected value in the combo widget.

	displayed_value (a_b: BOOLEAN): STRING_GENERAL is
			-- Displayed value according to `a_b'
		do
			if a_b then
				if displayed_true /= Void then
					Result := displayed_true
				end
			else
				if displayed_false /= Void then
					Result := displayed_false
				end
			end
			if Result = Void then
				Result := a_b.out
			end
			if a_b then
				last_displayed_true := Result
			else
				last_displayed_false := Result
			end
		ensure
			Result_not_void: Result /= Void
		end

	value_from_displayed: BOOLEAN is
			-- Value from what have been displayed.
		local
			l_str: STRING_32
		do
			l_str := change_item_widget.text
			if l_str.is_equal (last_displayed_true.as_string_32) then
				Result := True
			else
				Result := False
			end
		end

	displayed_true, displayed_false: STRING_GENERAL

	last_displayed_true, last_displayed_false: STRING_GENERAL;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class BOOLEAN_PREFERENCE_WIDGET
