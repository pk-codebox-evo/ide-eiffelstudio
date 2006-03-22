indexing
	description:
		"[
			Top level window. Contains a single widget.
			`title' is not displayed.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			 _____________
			|____________X|
			|             |
			|    item     |
			|_____________|
		]"
	status: "See notice at end of class."
	keywords: "toplevel, window, popup"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WINDOW

inherit
	EV_CELL
		undefine
			create_implementation
		redefine
			implementation,
			is_in_default_state,
			has
		end

	EV_POSITIONABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_WINDOW_ACTION_SEQUENCES
		redefine
			implementation
		end

create
	default_create,
	make_with_title

feature {NONE} -- Initialization

	make_with_title (a_title: STRING) is
			-- Initialize with `a_title'.
		require
			a_title_not_void: a_title /= Void
		do
			default_create
			set_title (a_title)
		end

feature -- Access

	upper_bar: EV_VERTICAL_BOX is
			-- Room at top of window. (Example use: toolbars.)
			-- Positioned below menu bar.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.upper_bar
		ensure
			bridge_ok: Result = implementation.upper_bar
		end

	lower_bar: EV_VERTICAL_BOX is
			-- Room at bottom of window. (Example use: statusbar.)
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.lower_bar
		ensure
			bridge_ok: Result = implementation.lower_bar
		end

	maximum_width: INTEGER is
			-- Upper bound on `width' in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.internal_maximum_width
		ensure
			bridge_ok: (Result = implementation.internal_maximum_width) or
				(Result = implementation.minimum_width)
		end

	maximum_height: INTEGER is
			-- Upper bound on `height' in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.internal_maximum_height
		ensure
			bridge_ok: (Result = implementation.internal_maximum_height) or
				(Result = implementation.minimum_height)
		end

	title: STRING is
			-- A textual name used by the window manager.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.title
		ensure
			bridge_ok: equal (Result, implementation.title)
			not_void: Result /= Void
			cloned: Result /= implementation.title
		end

	menu_bar: EV_MENU_BAR is
			-- Horizontal bar at top of client area that contains menu's.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.menu_bar
		ensure
			bridge_ok: Result = implementation.menu_bar
		end

	maximum_dimension: INTEGER is 32000
			-- Maximum width/height that a window can be set to.

feature -- Status report

	has (v: EV_WIDGET): BOOLEAN is
			-- Does structure include `v'?
		do
			Result := implementation.has (v)
		end

	user_can_resize: BOOLEAN is
			-- Can the user resize?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.user_can_resize
		ensure
			bridge_ok: Result = implementation.user_can_resize
		end

	is_border_enabled: BOOLEAN is
			-- Is a border displayed around `Current'?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_border_enabled
		end

feature -- Status setting

	enable_user_resize is
			-- Allow user to resize.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_user_resize
		ensure
			user_can_resize: user_can_resize
		end

	disable_user_resize is
			-- Prevent user from resizing.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_user_resize
		ensure
			not_user_can_resize: not user_can_resize
		end

	enable_border is
			-- Ensure a border is displayed around `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_border
		ensure
			is_border_enabled: is_border_enabled
		end

	disable_border is
			-- Ensure no border is displayed around `Current'.
			-- Has no immediate effect if `user_can_resize', although
			-- is reflected at next call to `disable_user_resize'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_border
		ensure
			border_disabled: not user_can_resize implies not is_border_enabled
		end

	set_maximum_width (a_maximum_width: INTEGER) is
			-- Assign `a_maximum_width' to `maximum_width' in pixels.
		require
			not_destroyed: not is_destroyed
			a_maximum_width_non_negative: a_maximum_width >= 0
			a_maximum_width_not_less_than_minimum_width:
				a_maximum_width >= minimum_width
			a_maximum_width_not_greater_than_maximum_dimension:
				a_maximum_width <= maximum_dimension
		do
			implementation.set_maximum_width (a_maximum_width)
		ensure
			maximum_width_assigned: maximum_width = a_maximum_width
		end

	set_maximum_height (a_maximum_height: INTEGER) is
			-- Assign `a_maximum_height' to `maximum_height' in pixels.
		require
			not_destroyed: not is_destroyed
			a_maximum_height_non_negative: a_maximum_height >= 0
			a_maximum_height_not_less_than_minimum_height:
				a_maximum_height >= minimum_height
			a_maximum_height_not_greater_than_maximum_dimension:
				a_maximum_height <= maximum_dimension
		do
			implementation.set_maximum_height (a_maximum_height)
		ensure
			maximum_height_assigned: maximum_height = a_maximum_height
		end

	set_maximum_size (a_maximum_width, a_maximum_height: INTEGER) is
			-- Assign `a_maximum_width' to `maximum_width'
			-- and `a_maximum_height' to `maximum_height' in pixels.
		require
			not_destroyed: not is_destroyed
			a_maximum_width_not_less_than_minimum_width:
				a_maximum_width >= minimum_width
			a_maximum_height_not_less_than_minimum_height:
				a_maximum_height >= minimum_height
			a_maximum_width_not_greater_than_maximum_dimension:
				a_maximum_width <= maximum_dimension
			a_maximum_height_not_greater_than_maximum_dimension:
				a_maximum_height <= maximum_dimension
		do
			implementation.set_maximum_size (a_maximum_width, a_maximum_height)
		ensure
			maximum_width_assigned: maximum_width = a_maximum_width
			maximum_height_assigned: maximum_height = a_maximum_height
		end

	set_title (a_title: STRING) is
			-- Assign `a_title' to `title'.
		require
			not_destroyed: not is_destroyed
			a_title_not_void: a_title /= Void
		do
			implementation.set_title (a_title)
		ensure
			a_title_assigned: title.is_equal (a_title)
			cloned: title /= a_title
		end

	remove_title is
			-- Make `title' empty.
		require
			not_destroyed: not is_destroyed
		do
			set_title ("")
		ensure
			title_empty: title.is_empty
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR) is
			-- Assign `a_menu_bar' to `menu_bar'.
		require
			not_destroyed: not is_destroyed
			no_menu_bar_assigned: menu_bar = Void
			a_menu_bar_not_void: a_menu_bar /= Void
			a_menu_bar_not_parented: a_menu_bar.parent = Void
		do
			implementation.set_menu_bar (a_menu_bar)
		ensure
			assigned: menu_bar = a_menu_bar
		end

	remove_menu_bar is
			-- Make `menu_bar' `Void'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_menu_bar
		ensure
			menu_bar_void: menu_bar = Void
		end

	lock_update is
			-- Lock drawing updates for this window on certain platforms until
			-- `unlock_update' is called.
			--
			-- Note: - Only one window can be locked at a time.
			--       - The window cannot be moved while update is locked.
		require
			not_destroyed: not is_destroyed
			no_locked_window:
				((create {EV_ENVIRONMENT}).application.locked_window = Void)
		do
			implementation.lock_update
		ensure
			locked_window_is_current:
				(create {EV_ENVIRONMENT}).application.locked_window = Current
		end

	unlock_update is
			-- Unlock updates for this widget on certain platforms.
		require
			not_destroyed: not is_destroyed
			locked_window_is_current:
				(create {EV_ENVIRONMENT}).application.locked_window = Current
		do
			implementation.unlock_update
		ensure
			no_locked_window:
				((create {EV_ENVIRONMENT}).application.locked_window = Void)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_WINDOW_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_CELL} and Precursor {EV_POSITIONABLE} and
				user_can_resize = user_can_resize_default_state and
				is_border_enabled = is_border_enabled_default_state and
				menu_bar = Void and maximum_width = maximum_dimension and maximum_height = maximum_dimension
		end

	user_can_resize_default_state: BOOLEAN is
			-- Is the default state of `Current' `user_can_resize'?
		do
			Result := True
		end

	is_border_enabled_default_state: BOOLEAN is
			-- Is the default state of `Current' `is_border_enabled'?
		do
			Result := True
		end

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_WINDOW_IMP} implementation.make (Current)
		end

invariant

	consistent_horizontal_bounds: is_usable implies maximum_width >= minimum_width
	consistent_vertical_bounds: is_usable implies maximum_height >= minimum_height

	upper_bar_not_void: is_usable implies upper_bar /= Void
	lower_bar_not_void: is_usable implies lower_bar /= Void

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




end -- class EV_WINDOW

