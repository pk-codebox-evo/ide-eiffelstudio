indexing
	description: "EiffelVision item, gtk implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_ITEM_IMP

inherit
	EV_ITEM_I
		redefine
			interface
		end

	EV_GTK_WIDGET_IMP
		redefine
			interface,
			destroy
		end

	EV_PICK_AND_DROPABLE_IMP
		redefine
			interface,
			destroy
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP
		redefine
			create_pointer_button_press_actions,
			create_pointer_double_press_actions
		end

feature {NONE} -- Initialization

	connect_button_press_switch is
			-- Connect `button_press_switch' to its event sources.
		local
			app_imp: like app_implementation
		do
			if not button_press_switch_is_connected then
				app_imp := app_implementation
				signal_connect (event_widget, App_imp.button_press_event_string, agent (app_imp.gtk_marshal).button_press_switch_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?, ?), app_imp.default_translate, False)
				button_press_switch_is_connected := True
			end
		end

	button_press_switch_is_connected: BOOLEAN
			-- Is `button_press_switch' connected to its event source.

	button_press_switch (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]
		do
			t := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y]
			if a_type = {EV_GTK_EXTERNALS}.gDK_BUTTON_PRESS_ENUM then
				if pointer_button_press_actions_internal /= Void then
					pointer_button_press_actions_internal.call (t)
				end
			else -- a_type = {EV_GTK_EXTERNALS}.gDK_2BUTTON_PRESS_ENUM
				if pointer_double_press_actions_internal /= Void then
					pointer_double_press_actions_internal.call (t)
				end
			end
        end

feature -- Access

	parent_imp: EV_ITEM_LIST_IMP [EV_ITEM] is
			-- The parent of the Current widget
			-- May be void.
		do
			Result := item_parent_imp
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
		do
			Result := Precursor {EV_ITEM_ACTION_SEQUENCES_IMP}
			Result.not_empty_actions.extend (agent connect_button_press_switch)
		end

	create_pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
		do
			Result := Precursor {EV_ITEM_ACTION_SEQUENCES_IMP}
			Result.not_empty_actions.extend (agent connect_button_press_switch)
		end

feature {EV_ANY_IMP} -- Implementation

	destroy is
			-- Destroy `Current'
		do
			if parent_imp /= Void then
					parent_imp.interface.prune_all (interface)
			end
			Precursor {EV_GTK_WIDGET_IMP}
		end

	item_parent_imp: EV_ITEM_LIST_IMP [EV_ITEM]
		-- Used to store parent imp of items where parent stores
		-- items in a list widget instead of the c_object.

	set_item_parent_imp (a_parent: EV_ITEM_LIST_IMP [EV_ITEM]) is
			-- Set `item_parent_imp' to `a_parent'.
		do
			item_parent_imp := a_parent
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM;

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




end -- class EV_ITEM_IMP

