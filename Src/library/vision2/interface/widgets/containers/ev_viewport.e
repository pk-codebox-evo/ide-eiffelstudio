indexing
	description:
		"[
			Displays a single widget that may be larger than the container.
			Clipping may occur though item size is not effected by viewport.
		]"
	appearance:
		"[
		 - - - - - - - - - - - - - - -  ^
		|             `item'          |`y_offset'
		                                v
		|          ---------------    |
		           |             |
		|          |  viewport   |    |
		           |             |
		|          ---------------    |
		 - - - - - - - - - - - - - - -
		<`x_offset'>
		]"
	status: "See notice at end of class"
	keywords: "container, virtual, display"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VIEWPORT

inherit
	EV_CELL
		redefine
			implementation,
			create_implementation,
			is_in_default_state
		end

create
	default_create

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.x_offset
		ensure
			bridge_ok: Result = implementation.x_offset
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.y_offset
		ensure
			bridge_ok: Result = implementation.y_offset
		end

feature -- Element change

	set_x_offset (an_x: INTEGER) is
			-- Assign `an_x' to `x_offset'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_x_offset (an_x)
		ensure
			assigned: x_offset = an_x
		end

	set_y_offset (a_y: INTEGER) is
			-- Assign `a_y' to `y_offset'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_y_offset (a_y)
		ensure
			assigned: y_offset = a_y
		end

	set_offset (an_x, a_y: INTEGER) is
			-- Assign `an_x' to `x_offset'.
			-- Assign `a_y' to `y_offset'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_offset (an_x, a_y)
		ensure
			assigned: x_offset = an_x
			assigned: y_offset = a_y
		end
		
	set_item_width (a_width: INTEGER) is
			-- Assign `a_width' to `a_widget.width'.
		require
			not_destroyed: not is_destroyed
			has_item: item /= Void
			a_width_not_smaller_than_minimum_width:
				a_width >= item.minimum_width
		do
			implementation.set_item_width (a_width)
		ensure
			an_item_width_assigned: item.width = a_width
		end

	set_item_height (a_height: INTEGER) is
			-- Assign `a_height' to `a_widget.height'.
		require
			not_destroyed: not is_destroyed
			has_item: item /= Void
			a_height_not_smaller_than_minimum_height:
				a_height >= item.minimum_height
		do
			implementation.set_item_height ( a_height)
		ensure
			an_item_height_assigned: item.height = a_height
		end

	set_item_size (a_width, a_height: INTEGER) is
			-- Assign `_width' to `a_widget.width'.
			-- Assign `a_height' to `a_widget.height'.
		require
			not_destroyed: not is_destroyed
			has_item: item /= Void
			a_width_not_smaller_than_minimum_width:
				a_width >= item.minimum_width
			a_height_not_smaller_than_minimum_height:
				a_height >= item.minimum_height
		do
			implementation.set_item_size (a_width, a_height)
		ensure
			an_item_width_assigned: item.width = a_width
			an_item_height_assigned: item.height = a_height
		end
		
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_CELL} and x_offset = 0 and
				y_offset = 0
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_VIEWPORT_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_VIEWPORT_IMP} implementation.make (Current)
		end

invariant

	item_void_means_offset_zero: is_usable implies
		(item = Void implies x_offset = 0 and y_offset = 0)

end -- class EV_VIEWPORT

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

