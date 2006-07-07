indexing
	description:
		"Apearance of a screen pointer cursor, typically moved by a mouse."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "mouse, pointer, cursor, arrow"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POINTER_STYLE

inherit
	EV_ANY
		redefine
			implementation
		end

create
	make_from_pixel_buffer,
	make_from_cursor

convert
	make_from_cursor ({EV_CURSOR})

feature {NONE} -- Initlization

	make_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER) is
			-- Creation method
		require
			a_pxiel_buffer_not_void: a_pixel_buffer /= Void
		local
			l_temp_buffer: EV_PIXEL_BUFFER
			l_env: EV_ENVIRONMENT
		do
			default_create
			l_temp_buffer := a_pixel_buffer
			implementation.init_from_pixel_buffer (l_temp_buffer)
		end

	make_from_cursor (a_cursor: EV_CURSOR) is
			-- Initialize from `a_cursor'
		local
			l_temp: EV_CURSOR
			l_cursors: EV_STOCK_PIXMAPS
		do
			default_create
			-- We convert from EV_CURSOR, `a_cursor' maybe void.
			l_temp := a_cursor
			if l_temp = Void then
				create l_cursors
				l_temp := l_cursors.standard_cursor
			end

			init_from_cursor (l_temp)

			set_x_hotspot (l_temp.x_hotspot)
			set_y_hotspot (l_temp.y_hotspot)
		end

	init_from_cursor (a_cursor: EV_CURSOR) is
			-- Initialize Current from `a_cursor'.
		require
			not_void: a_cursor /= Void
		do
			implementation.init_from_cursor (a_cursor)
		end

feature -- Command

	set_x_hotspot (a_x: INTEGER) is
			-- Set `x_hotspot' to `a_x'.
		require
			not_destroyed: not is_destroyed
			valid: 0 <= a_x and a_x <= width
		do
			x_hotspot := a_x
		end

	set_y_hotspot (a_y: INTEGER) is
			-- Set `y_hotspot' to `a_y'.
		require
			not_destoryed: not is_destroyed
			valid: 0 <= a_y and a_y <= height
		do
			y_hotspot := a_y
		end

feature -- Query

	x_hotspot: INTEGER
			-- Specifies the x-coordinate of a cursor's hot spot.

	y_hotspot: INTEGER
			-- Specifies the y-coordinate of a cursor's hot spot.

	width: INTEGER is
			-- Width
		do
			Result := implementation.width
		end

	height: INTEGER is
			-- Height
		do
			Result := implementation.height
		end

feature -- Implementation

	create_implementation is
			-- Create `implementation'.
		do
			create {EV_POINTER_STYLE_IMP} implementation.make (Current)
		end

	implementation: EV_POINTER_STYLE_I;
			-- Implementation.

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



end
