indexing

	description: "General definitions for drawable elements";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class DRAWING_I 
	
feature 

	add_expose_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current area is exposed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end;

	clear is
			-- Clear the entire area.
		deferred
		end;

	copy_bitmap (a_point: COORD_XY; a_bitmap: PIXMAP) is
			-- Copy `a_bitmap' to the drawing at `a_point'.
		require
			a_point_exists: not (a_point = Void);
			a_bitmap_exists: not (a_bitmap = Void);
			a_bitmap_valid: a_bitmap.is_valid
		deferred
		end;

	copy_pixmap (a_point: COORD_XY; a_pixmap: PIXMAP) is
			-- Copy `a_pixmap' to the drawing at `a_point'.
		require
			a_point_exists: not (a_point = Void);
			a_pixmap_exists: not (a_pixmap = Void);
			a_pixtmap_valid: a_pixmap.is_valid
		deferred
		end;

	draw_arc (center: COORD_XY; radius1, radius2: INTEGER; angle1, angle2, orientation: REAL; arc_style: INTEGER) is
			-- Draw an arc centered in (`x', `y') with a great radius of
			-- `radius1' and a small radius of `radius2'
			-- beginnning at `angle1' and finishing at `angle1'+`angle2'
			-- and with an orientation of `orientation'.
		require
			center_exits: not (center = Void);
			radius1 >= 0;
			radius2 >= 0;
			angle1 >= 0;
			angle2 >= 0;
			angle1+angle2 <= 23040;
			orientation >= 0;
			orientation < 360;
			arc_style >= -1;
			arc_style <= 1
		deferred
		end;

	draw_image_text (base: COORD_XY; text: STRING) is
			-- Draw text
		require
			text_exists: not (text = Void);
			base_exists: not (base = Void)
		deferred
		end;

	draw_inf_line (point1, point2: COORD_XY) is
			-- Draw an infinite line traversing `point1' and `point2'.
		require
			point1_exists: not (point1 = Void);
			point2_exists: not (point2 = Void)
		deferred
		end;

	draw_point (a_point: COORD_XY) is
			-- Draw `a_point'.
		require
			a_point_exists: not (a_point = Void)
		deferred
		end;

	draw_polyline (points: LIST [COORD_XY]; is_closed: BOOLEAN) is
			-- Draw a polyline, close it automatically if `is_closed'.
		require
			points_exists: not (points = Void);
			list_not_empty: not points.empty;
			list_not_too_large: points.count <= max_count_for_draw_polyline
		deferred
		end;

	draw_rectangle (center: COORD_XY; width, height: INTEGER; an_orientation: REAL) is
			-- Draw a rectangle whose center is `center' and
			-- whose size is `width' and `height'.
		require
			center_exists: not (center = Void);
			width_positive: width >= 0;
			height_positive: height >= 0;
			an_orientation_positive: an_orientation >= 0;
			an_orientation_less_than_360: an_orientation < 360
		deferred
		end;

	draw_segment (point1, point2: COORD_XY) is
			-- Draw a segment between `point1' and `point2'.
		require
			point1_exists: not (point1 = Void);
			point2_exists: not (point2 = Void)
		deferred
		end;

	draw_text (base: COORD_XY; text: STRING) is
			-- Draw text
		require
			text_exists: not (text = Void);
			base_exists: not (base = Void)
		deferred
		end;

	fill_arc (center: COORD_XY; radius1, radius2: INTEGER; angle1, angle2, orientation: REAL; arc_style: INTEGER) is
			-- Fill an arc centered in (`x', `y') with a great radius of
			-- `radius1' and a small radius of `radius2'
			-- beginnning at `angle1' and finishing at `angle1'+`angle2'
			-- and with an orientation of `orientation'.
		require
			center_exits: not (center = Void);
			radius1 >= 0;
			radius2 >= 0;
			angle1 >= 0;
			angle2 >= 0;
			angle1+angle2 <= 23040;
			orientation >= 0;
			orientation < 360;
			arc_style >= 0;
			arc_style <= 1
		deferred
		end;

	fill_polygon (points: LIST [COORD_XY]) is
			-- Fill a polygon.
		require
			points_exists: not (points = Void);
			list_with_two_points_at_least: points.count >= 3;
			list_not_too_large: points.count <= max_count_for_draw_polyline
		deferred
		end;

	fill_rectangle (center: COORD_XY; width, height: INTEGER; an_orientation: REAL) is
			-- Fill a rectangle whose center is `center' and
			-- whose size is `width' and `height'.
		require
			center_exists: not (center = Void);
			width_positive: width >= 0;
			height_positive: height >= 0;
			an_orientation_positive: an_orientation >= 0;
			an_orientation_less_than_360: an_orientation < 360
		deferred
		end;

	is_drawable: BOOLEAN is
			-- If the GC has not been created,
			--   create it and return true if a window X exists.
			--   return false if there's no window X.
			-- If there's a GC created,
			--   true if a window X exists, false else.
		deferred
		end;

	max_count_for_draw_polyline: INTEGER is
			-- Maximum value for `points.count' for `draw_polyline'
		deferred
		ensure
			Result >= 1
		end;

	remove_expose_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current area is exposed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end;

	set_background_gc_color (background_color: COLOR) is
			-- Set background value of GC.
		require
			color_not_void: not (background_color = Void)
		deferred
		end;

	set_cap_style (cap_style: INTEGER) is
			-- Specifies the appearance of ends of line.
		require
			cap_style >= 0;
			cap_style <= 3
		deferred
		end;

	set_clip (a_clip: CLIP) is
			-- Set a clip area.
		require
			a_clip_exists: not (a_clip = Void)
		deferred
		end;

	set_dash_pattern (a_dash: DASH) is
			-- Set pattern of dash lengths.
		require
			a_dash_exists: not (a_dash = Void);
			a_dash_valid: not a_dash.empty
		deferred
		end;

	set_drawing_font (font: FONT) is
			-- Set a font.
		require
			font_exists: not (font = Void)
		deferred
		end;

	set_fill_style (a_fill_style: INTEGER) is
			-- Set the style of fill.
		deferred
		end;

	set_foreground_gc_color (foreground_color: COLOR) is
			-- Set foreground value of GC.
		require
			color_not_void: not (foreground_color = Void)
		deferred
		end;

	set_join_style (join_style: INTEGER) is
			-- Specifies type appearance of joints between consecutive lines.
		require
			join_style >= 0;
			join_style <= 2
		deferred
		end;

	set_line_style (line_style: INTEGER) is
			-- Set line style.
		require
			line_style >= 0;
			line_style <= 2
		deferred
		end;

	set_line_width (new_width: INTEGER) is
			-- Set line to be displayed with width of `new_width'.
		require
			width_large_enough: new_width >= 0
		deferred
		end;

	set_logical_mode (a_mode: INTEGER) is
			-- Set drawing logical function to `a_mode'.
		require
			a_mode >= 0;
			a_mode <= 15
		deferred
		end;

	set_no_clip is
			-- Remove all clip area.
		deferred
		end;

	set_stipple (a_stipple: PIXMAP) is
			-- Set stipple used to fill figures
		require
			a_stipple_exists: not (a_stipple = Void);
			a_stipple_valid: a_stipple.is_valid
		deferred
		end;

	set_subwindow_mode (mode: INTEGER) is
			-- Set subwindow mode.
		deferred
		end;

	set_tile (a_tile: PIXMAP) is
			-- Set tile used to fill figures
		require
			a_tile_exists: not (a_tile = Void);
			a_tile_valid: a_tile.is_valid
		deferred
		end

end -- class DRAWING_I


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
