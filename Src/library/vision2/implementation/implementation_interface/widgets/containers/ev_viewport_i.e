indexing
	description: "Eiffel Vision viewport. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "container, virtual, display"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_VIEWPORT_I

inherit
	EV_CELL_I

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		deferred
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		deferred
		end

feature -- Element change

	set_x_offset (an_x: INTEGER) is
			-- Assign `an_x' to `x_offset'.
		deferred
		ensure
			assigned: x_offset = an_x
		end

	set_y_offset (a_y: INTEGER) is
			-- Assign `a_y' to `y_offset'.
		deferred
		ensure
			assigned: y_offset = a_y
		end

	set_offset (an_x, a_y: INTEGER) is
			-- Assign `an_x' to `x_offset'.
			-- Assign `a_y' to `y_offset'.
		do
			set_x_offset (an_x)
			set_y_offset (a_y)
		ensure
			assigned: x_offset = an_x
			assigned: y_offset = a_y
		end
		
	set_item_width (a_width: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
		require
			a_width_not_smaller_than_minimum_width:
				a_width >= item.minimum_width
		do
			set_item_size (a_width, item.height)
		end

	set_item_height (a_height: INTEGER) is
			-- Set `a_widget.height' to `a_height'.
		require
			a_height_not_smaller_than_minimum_height:
				a_height >= item.minimum_height
		do
			set_item_size (item.width, a_height)
		end

	set_item_size (a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		require
			a_width_not_smaller_than_minimum_width:
				a_width >= item.minimum_width
			a_height_not_smaller_than_minimum_height:
				a_height >= item.minimum_height
		deferred
		end

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




end -- class EV_VIEWPORT_I

