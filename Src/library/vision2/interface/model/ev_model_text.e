indexing
	description: "[

				`text's in a `font' displayed on p1 == point.
		
					p0---------------------------p2
					|fooooooooooooooooooooooooooo
					| p3
					|bar        center
					|foobar
					p1
					
					p4.y - p1.y  is the should height of a character to match scale
					p4.x - p1.x  is the should width of a character to match scale
		
				]"
	status: "See notice at end of class"
	keywords: "figure, text, string"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_TEXT

inherit
	EV_MODEL_ATOMIC
		undefine
			is_equal
		redefine
			default_create,
			recursive_transform,
			set_x_y
		end

	EV_FONT_CONSTANTS
		export
			{NONE} all
			{ANY} valid_family, valid_weight, valid_shape
		undefine
			default_create,
			out,
			is_equal
		end
		
	EV_MODEL_SINGLE_POINTED
		undefine
			default_create,
			point_count,
			is_equal
		end
		
	COMPARABLE
		undefine
			default_create
		end
		
	EV_SHARED_SCALE_FACTORY
		undefine
			default_create,
			is_equal
		end

create
	default_create,
	make_with_text,
	make_with_position

feature {NONE} -- Initialization

	default_create is
			-- Create in (0, 0)
		do
			Precursor {EV_MODEL_ATOMIC}
			create point_array.make (4)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 0)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 1)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 2)
			create text.make (0)
			id_font := default_font
			scaled_font := font
			point_array.put (create {EV_COORDINATE}.make (font.width, font.height), 3)
			is_default_font_used := True
			is_center_valid := True
		ensure then
			center_is_valid: is_center_valid
		end

	make_with_text (a_text: STRING) is
			-- Create with `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			default_create
			set_text (a_text)
			set_center
		ensure
			center_is_valid: is_center_valid
		end

feature -- Access

	text: STRING 
			-- Text that is displayed.

	font: EV_FONT is
			-- Typeface `text' is displayed in.
		do
			Result := id_font.font
		end
			
	angle: DOUBLE is 0.0
			-- Since not rotatable.
			
	is_scalable: BOOLEAN is True
			-- Is scalable? (Yes)
			
	is_rotatable: BOOLEAN is False
			-- Not yet.
			
	is_transformable: BOOLEAN is False
			-- No.

	point_x: INTEGER is
			-- x position of `point'.
		do
			Result := point_array.item (0).x
		end
		
	point_y: INTEGER is
			-- y position of `point'.
		do
			Result := point_array.item (0).y
		end

feature -- Status report

	width: INTEGER is
			-- Horizontal dimension.
		local
			l_point_array: like point_array
		do
			l_point_array := point_array
			Result := (l_point_array.item (2).x_precise - l_point_array.item (0).x_precise).truncated_to_integer
		end

	height: INTEGER is
			-- Vertical dimension.
		local
			l_point_array: like point_array
		do
			l_point_array := point_array
			Result := (l_point_array.item (1).y_precise - l_point_array.item (0).y_precise).truncated_to_integer
		end

	is_default_font_used: BOOLEAN
			-- Is `Current' using a default font?
			
	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := text < other.text
		end

feature -- Status setting
		
	set_point_position (ax, ay: INTEGER) is
			-- Set position of `point' to (`ax', `ay').
		local
			a_delta_x, a_delta_y: DOUBLE
			l_point_array: like point_array
			p0, p1, p2, p3: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			p2 := l_point_array.item (2)
			p3 := l_point_array.item (3)
			
			a_delta_x := ax - p0.x_precise
			a_delta_y := ay - p0.y_precise
			
			p0.set (ax, ay)
			p1.set_precise (p1.x_precise + a_delta_x, p1.y_precise + a_delta_y)
			p2.set_precise (p2.x_precise + a_delta_x, p2.y_precise + a_delta_y)
			p3.set_precise (p3.x_precise + a_delta_x, p3.y_precise + a_delta_y)
			invalidate
			center_invalidate
		end

	set_font (a_font: like font) is
			-- Assign `a_font' to `font'.
		require
			a_font_not_void: a_font /= Void
		do
			set_identified_font (font_factory.registered_font (a_font))
		ensure
			font_assigned: font = a_font
		end
		
	set_identified_font (an_id_font: EV_IDENTIFIED_FONT) is
			-- Set `id_font' to `an_id_font' initialize `scaled_font'.
		require
			an_id_font_not_Void: an_id_font /= Void
		local
			l_point_array: like point_array
			p0: EV_COORDINATE
			should_height: INTEGER
		do
			id_font := an_id_font
			font_factory.register_font (id_font)
			if is_default_font_used then
				scaled_font := font
				is_default_font_used := False
				l_point_array := point_array
				p0 := l_point_array.item (0)
				l_point_array.item (3).set_precise (p0.x_precise + font.width, p0.y_precise + font.height)
			else
				l_point_array := point_array
				should_height := (l_point_array.item (3).y_precise - l_point_array.item (0).y_precise).truncated_to_integer.max (1)

				scaled_font := font_factory.scaled_font (id_font, should_height)
			end
			update_dimensions
			invalidate
			center_invalidate
		ensure
			set: id_font = an_id_font
		end

	set_text (a_text: like text) is
			-- Assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
		do
			text := a_text
			update_dimensions
			invalidate
		ensure
			text_assigned: text = a_text
		end
feature -- Element change

	set_x_y (a_x, a_y: INTEGER) is
			-- Set `x' to `a_x' and `y' to `a_y'.
		do
			center_invalidate -- FIX_ME: should not be required at all.
			Precursor {EV_MODEL_ATOMIC} (a_x, a_y)
		end
		
feature -- Events

	position_on_figure (a_x, a_y: INTEGER): BOOLEAN is
			-- Is the point on (`a_x', `a_y') on this figure?
			--| Used to generate events.
		local
			l_point_array: like point_array
			p0: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			Result := point_on_rectangle (a_x, a_y, p0.x_precise, p0.y_precise, l_point_array.item (2).x_precise, l_point_array.item (1).y_precise)
		end
		
feature {EV_MODEL_GROUP} -- Figure group

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION) is
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center.
		local
			l_font: like font
			l_point_array: like point_array
			should_height: INTEGER
		do
			Precursor {EV_MODEL_ATOMIC} (a_transformation)
			
			l_font := scaled_font
			l_point_array := point_array
			should_height := (l_point_array.item (3).y_precise - l_point_array.item (0).y_precise).truncated_to_integer.max (1)
			if should_height /= l_font.height then
			
				scaled_font := font_factory.scaled_font (id_font, should_height)

				if should_height > 1 then
					update_dimensions
				end
			end
		end
		
feature {EV_MODEL_DRAWER}

	scaled_font: like font
	
	left_offset: INTEGER

feature {NONE} -- Implementation

	id_font: EV_IDENTIFIED_FONT

	update_dimensions is
			-- Reassign `width' and `height'.
		local
			t: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			l_point_array: like point_array
			p0: EV_COORDINATE
		do
			t := scaled_font.string_size (text)
			
			left_offset := t.integer_item (3)
			
			l_point_array := point_array
			p0 := l_point_array.item (0)
			
			l_point_array.item (1).set_y_precise (p0.y_precise + t.integer_item (2))
			l_point_array.item (2).set_x_precise (p0.x_precise + t.integer_item (1) - left_offset + t.integer_item (4))
			center_invalidate
		end

	default_font: EV_IDENTIFIED_FONT is
			-- Font set by `default_create'.
		once
			Result := font_factory.registered_font (create {EV_FONT})
			font_factory.register_font (Result)
		end
		
	set_center is
			-- Set the position to the center
		local
			l_point_array: like point_array
			p0, p1, p2: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			p2 := l_point_array.item (2)
			
			center.set_precise ((p1.x_precise + p2.x_precise) / 2, (p1.y_precise + p2.y_precise) / 2)
			is_center_valid := True
		end

invariant
	text_exists: text /= Void
	font_exists: font /= Void

end -- class EV_MODEL_TEXT

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

