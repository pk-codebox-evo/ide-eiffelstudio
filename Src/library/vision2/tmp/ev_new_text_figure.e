<<<<<<< ev_new_text_figure.e
indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_NEW_TEXT_FIGURE 

	
inherit
	EV_ATOMIC_FIGURE
		rename
			origin as figure_origin
		end

	EV_INTERIOR
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create a text.
		do
		--	init_fig (Void)
			create text.make (1)
			create font.make
			create top_left.make_default
			ascent := 1
			descent := 1
			string_width := 1
--			font.set_name ("fixed")
			{EV_INTERIOR} Precursor
		end

feature -- 


	set_modified is do end

	unset_modified is do end

	origin_user_type: INTEGER

	origin_user: EV_POINT

	remove is do end
		
	surround_box: EV_CLOSURE is
		do

		end

feature -- Not used 
		
	set_center(cent: like center) is
		do
		end

feature -- Access


	center: EV_FIGURE_POINT is
			-- Center of Current
		do
			Result := figure_origin
		end

	ascent: INTEGER
	
	descent: INTEGER

	string_width: INTEGER

	text: STRING
			-- Text to be drawn

	top_center: like top_left is
			-- Top and center point of the rectangle containing the text
		do
			create Result.make_default
			Result.set (top_left.x + (string_width // 2), top_left.y)
		end

	top_left: EV_FIGURE_POINT
			-- Top left coiner of the rectangle containing the text

	top_right: like top_left is
			-- Top and right point of the rectangle containing the text
		do
			create Result.make_default
			Result.set (top_left.x + string_width, top_left.y)
		end

	base_center: like top_left is
			-- Center point of the baseline of the text
		do
			create Result.make_default
			Result.set (top_left.x + (string_width // 2), top_left.y + ascent)
		end

	base_left: like top_left is
			-- Left point of the baseline of the text
		do
			create Result.make_default
			Result.set (top_left.x, top_left.y + ascent)
		end

	base_right: like top_left is
			-- Right point of the baseline of the text
		do
			create Result.make_default
			Result.set (top_left.x + string_width, top_left.y + ascent)
		end 

	bottom_center: like top_left is
			-- Center and bottom point of the rectangle containing the text
		do
			create Result.make_default
			Result.set (top_left.x + (string_width // 2 ),
						 top_left.y+ascent + descent)
		end

	bottom_left: like top_left is
			-- Left and bottom point of the rectangle containing the text
		do
			create Result.make_default
			Result.set (top_left.x, top_left.y + ascent + descent)
		end 

	bottom_right: like top_left is
			-- Right and bottom point of the rectangle containing the text
		do
			create Result.make_default
			Result.set (top_left.x + string_width,
						top_left.y + ascent + descent)
		end

	font: EV_FONT
			-- Font to be used

	middle_center: like top_left is
			-- Center and middle point of the rectangle containing the text
		do
			create Result.make_default
			Result.set (top_left.x + (string_width // 2),
						top_left.y + ascent + descent)
		end

	middle_left: like top_left is
			-- Left and middle point of the rectangle containing the text
		do
			create Result.make_default
			Result.set (top_left.x, top_left.y + (ascent + descent) // 2)
		end

	middle_right: like top_left is
			-- Right and middle point of the rectangle containing the text
		do
			create Result.make_default
			Result.set (top_left.x + string_width,
						(top_left.y + ascent + descent) // 2)
		end

	origin: EV_POINT is
			-- Origin of picture
		do
			inspect origin_user_type
			when 0 then
			when 1 then
				Result := origin_user
			when 2 then
				Result := top_left
			when 3 then
				Result := top_center
			when 4 then
				Result := top_right
			when 5 then
				Result := middle_left
			when 6 then
				Result := middle_center
			when 7 then
				Result := middle_right
			when 8 then
				Result := base_left
			when 9 then
				Result := base_center
			when 10 then
				Result := base_right
			when 11 then
				Result := bottom_left
			when 12 then
				Result := bottom_center
			when 13 then
				Result := bottom_right
			end
		end

feature -- Element change

	set_base_center (a_point: like top_left) is
			-- Set `base_center' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
			top_left.set (a_point.x - (string_width // 2),  a_point.y-ascent)
			set_modified
		ensure
			base_center.is_superimposable (a_point)
		end

	set_base_left (a_point: like top_left) is
			-- Set `base_left' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
			top_left.set (a_point.x, a_point.y-ascent)
			set_modified
		ensure
			base_left.is_superimposable (a_point)
		end

	set_base_right (a_point: like top_left) is
			-- Set `base_right' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
			top_left.set ( a_point.x-string_width, a_point.y-ascent)
			set_modified
		ensure
			base_right.is_superimposable (a_point)
		end

	set_bottom_center (a_point: like top_left) is
			-- Set `bottom_center' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
			top_left.set (a_point.x-(string_width // 2 ), a_point.y-ascent-descent)
			set_modified
		ensure
			bottom_center.is_superimposable (a_point)
		end

	set_bottom_left (a_point: like top_left) is
			-- Set `bottom_left' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
			top_left.set (a_point.x, a_point.y-ascent-descent)
				set_modified
		ensure
			bottom_left.is_superimposable (a_point)
		end

	set_bottom_right (a_point: like top_left) is
			-- Set `bottom_right' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
		top_left.set (a_point.x-string_width, a_point.y-ascent-descent)
				set_modified
		ensure
			bottom_right.is_superimposable (a_point)
		end

	set_font (a_font: EV_FONT) is
			-- Set `font' to `a_font'.
		require
			a_font_exists: a_font /= Void
--			a_font_specified: a_font.is_specified
		do
			font := a_font
			set_modified
		end

	set_middle_center (a_point: like top_left) is
			-- Set `middle_center' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
			top_left.set (a_point.x - (string_width // 2),
						a_point.y - (ascent + descent) // 2)
			set_modified
		ensure
			middle_center.is_superimposable (a_point)
		end

	set_middle_left (a_point: like top_left) is
			-- Set `middle_left' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
			top_left.set (a_point.x, a_point.y - ((ascent+descent) // 2))
				set_modified
		ensure
			middle_left.is_superimposable (a_point)
		end

	set_middle_right (a_point: like top_left) is
			-- Set `middle_right' to `a_point'.
		require
			a_point_exists: a_point /=Void
		do
			top_left.set (a_point.x - string_width,
						a_point.y - (ascent + descent) // 2)
			set_modified
		ensure
			middle_right.is_superimposable (a_point)
		end

	set_origin_to_base_center is
			-- Set `origin' to `base_center'.
		do
			origin_user_type := 9
		end

	set_origin_to_base_left is
			-- Set `origin' to `base_left'.
		do
			origin_user_type := 8
		end

	set_origin_to_base_right is
			-- Set `origin' to `base_right'.
		do
			origin_user_type := 10
		end

	set_origin_to_bottom_center is
			-- Set `origin' to `bottom_center'.
		do
			origin_user_type := 12
		end

	set_origin_to_bottom_left is
			-- Set `origin' to `bottom_left'.
		do
			origin_user_type := 11
		end

	set_origin_to_bottom_right is
			-- Set `origin' to `bottom_right'.
		do
			origin_user_type := 13
		end

	set_origin_to_middle_center is
			-- Set `origin' to `middle_center'.
		do
			origin_user_type := 6
		end

	set_origin_to_middle_left is
			-- Set `origin' to `middle_left'.
		do
			origin_user_type := 5
		end

	set_origin_to_middle_right is
			-- Set `origin' to `middle_right'.
		do
			origin_user_type := 7
		end

	set_origin_to_top_center is
			-- Set `origin' to `top_center'.
		do
			origin_user_type := 3
		end

	set_origin_to_top_left is
			-- Set `origin' to `top_left'.
		do
			origin_user_type := 2
		end

	set_origin_to_top_right is
			-- Set `origin' to `top_right'.
		do
			origin_user_type := 4
		end 

	set_text (a_text: STRING) is
			-- Set `text' to `a_text'.
		require
			a_text_exists: a_text /= Void
		do
			text := a_text
			set_modified
		end

	set_top_center (a_point: like top_left) is
			-- Set `top_center' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
			top_left.set (a_point.x-(string_width // 2), a_point.y)
			set_modified
		ensure
			top_center.is_superimposable (a_point)
		end

	set_top_left (a_point: like top_left) is
			-- Set `top_left' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
			top_left := a_point
			set_modified
		ensure
			a_point = top_left
		end

	set_top_right (a_point: like top_left) is
			-- Set `top_right' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
			top_left.set (a_point.x-string_width, a_point.y)
				set_modified
		ensure
			top_right.is_superimposable (a_point)
		end


	xyrotate (a: EV_ANGLE; px,py: INTEGER) is
			-- Rotate by `a' relative to (`px', `py').
			-- Warning: don't rotate `pixmap' but just `top_left'.
		do
			top_left.xyrotate (a, px ,py)
			set_modified
		end

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
			-- Warning: don't scale `pixmap' but just `top_left'.
		require else
			scale_factor_positive: f > 0.0
		do
			top_left.xyscale (f, px, py)
			set_modified
		end

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			top_left.xytranslate (vx, vy)
			set_modified
		end

feature -- Output

	draw is
			-- Draw the current text.
	--	require else
	--		a_drawing_attached: drawing /= Void
		local
			lint: EV_INTERIOR
		do
	--		if drawing.is_drawable then
	--			create lint.make
	--			lint.get_drawing_attributes (drawing)
	--			set_drawing_attributes (drawing)
--	-			drawing.set_drawing_font (font)
	---			drawing.draw_text (base_left,text) 
	--			lint.set_drawing_attributes (drawing)
	--		end 
		end

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current picture superimposable to other ?
			-- Don't compare font in structure : Must be the
			-- same in reference.
		do
			Result := top_left.is_superimposable (other.top_left) and 
				text.is_equal (other.text) and (font = other.font)
		end 

--feature {NONE} -- Access
--
--	drawing_i_to_widget_i (a_drawing: EV_DRAWABLE): WIDGET_I is
--			-- Conversion routine
--		do
--			Result ?= a_drawing
--		end

feature {CONFIGURE_NOTIFY} -- Updating

	recompute is
		do
			--if drawing /= Void and then drawing.is_valid (font) then
				ascent := font.ascent
				descent := font.descent
				string_width := font.string_width (text)
				unset_modified
			--end
			surround_box.set (top_left.x, top_left.y, bottom_right.x - top_left.x, bottom_right.y - top_left.y)
		end

invariant
	origin_user_type_constraint: origin_user_type <= 10
	top_left_exists: top_left /= Void
	text_exists: text /= Void
	font_exists: font /= Void
--	font_is_specified: font.is_specified


end -- class EV_NEW_TEXT_FIGURE
--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

=======
>>>>>>> 1.1
