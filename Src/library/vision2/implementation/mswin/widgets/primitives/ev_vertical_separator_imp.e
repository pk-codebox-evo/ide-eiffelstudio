indexing 
	description: "EiffelVision vertical separator. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_VERTICAL_SEPARATOR_IMP

inherit
	EV_VERTICAL_SEPARATOR_I
		redefine
			interface
		end

	EV_SEPARATOR_IMP
		redefine
			set_default_minimum_size,
			interface
		end

create
	make

feature -- Status setting

   	set_default_minimum_size is
   			-- Set `default_minimum_size'.
   		do
			ev_set_minimum_width (2)
 		end

feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Repaint 3D separator.
		local
			cur_width_div_two: INTEGER
			r: WEL_RECT
			bk_brush: WEL_BRUSH
			pen: WEL_PEN
		do
			cur_width_div_two := ev_width // 2

			if cur_width_div_two > 1 then
					-- We need to draw a background.
				bk_brush := background_brush
				create r.make (0, 0, cur_width_div_two - 1, height)
				paint_dc.fill_rect (r, bk_brush)
			end

			pen := shadow_pen
			draw_vertical_line (paint_dc, pen,
				cur_width_div_two - 1)
			pen.delete

			pen := highlight_pen
			draw_vertical_line (paint_dc, pen,
				cur_width_div_two)
			pen.delete

			if cur_width_div_two < width then
					-- We need to draw a background.
				if bk_brush = Void then
					bk_brush := background_brush
				end
				create r.make (cur_width_div_two + 1, 0, width, height)
				paint_dc.fill_rect (r, bk_brush)
			end

			if bk_brush /= Void then
				bk_brush.delete
			end
		end

	draw_vertical_line (paint_dc: WEL_PAINT_DC;
			a_pen: WEL_PEN; a_x: INTEGER) is
			-- Draw graphical component of `Current'.
		do
			paint_dc.select_pen (a_pen)
			paint_dc.line (a_x, 0, a_x, ev_height)
			paint_dc.unselect_pen
		end

	interface: EV_VERTICAL_SEPARATOR

end -- class EV_VERTICAL_SEPARATOR_IMP

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

