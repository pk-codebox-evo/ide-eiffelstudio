indexing
	description: "Description of an area of the display that is %
		%combination of rectangles, other polygons and ellipses."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_REGION

inherit
	WEL_GDI_ANY
		export
			{ANY} is_equal, copy, clone
		redefine
			is_equal
		end

creation
	make_empty,
	make_elliptic,
	make_elliptic_indirect,
	make_polygon_alternate,
	make_polygon_winding,
	make_rect,
	make_rect_indirect

feature {NONE} -- Initialization

	make_empty is
			-- Make an empty rectangle region
		do
			item := cwin_create_rect_rgn (0, 0, 0, 0)
		end

	make_elliptic (left, top, right, bottom: INTEGER) is
			-- Make an elliptical region specified by the
			-- bounding rectangle `left', `top', `right', `bottom'
		do
			item := cwin_create_elliptic_rgn (left, top, right, bottom)
		end

	make_elliptic_indirect (rect: WEL_RECT) is
			-- Make an elliptical region specified by
			-- the bounding rectangle `rect'
		require
			rect_not_void: rect /= Void
		do
			item := cwin_create_elliptic_rgn_indirect (rect.item)
		end

	make_polygon_alternate (points: ARRAY [INTEGER]) is
			-- Make a polygonal region specified by `points'
			-- using alternate mode. Fills area between
			-- odd-numbered and even-numbered polygon sides
			-- on each scan line.
		require
			points_not_void: points /= Void
			points_count: points.count \\ 2 = 0
		local
			a: ANY
		do
			a := points.to_c
			item := cwel_create_polygon_rgn ($a, points.count // 2,
				Alternate)
		end

	make_polygon_winding (points: ARRAY [INTEGER]) is
			-- Make a polygonal region specified by `points'
			-- using winding mode. Fills any region with a nonzero
			-- winding value.
		require
			points_not_void: points /= Void
			points_count: points.count \\ 2 = 0
		local
			a: ANY
		do
			a := points.to_c
			item := cwel_create_polygon_rgn ($a, points.count // 2,
				Winding)
		end

	make_rect (left, top, right, bottom: INTEGER) is
			-- Make a rectangle region specified by
			-- `left', `top', `right', `bottom'.
		do
			item := cwin_create_rect_rgn (left, top, right, bottom)
		end

	make_rect_indirect (rect: WEL_RECT) is
			-- Make a rectangle region specified by
			-- the rectangle `rect'.
		require
			rect_not_void: rect /= Void
		do
			item := cwin_create_rect_rgn_indirect (rect.item)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `Current' equal to `other'?
		do
			Result := cwin_equal_rgn (item, other.item)
		end

feature -- Basic operations

	combine (region: WEL_REGION; mode: INTEGER): WEL_REGION is
			-- Combine `region' with the current one using `mode'.
			-- See class WEL_RGN_CONSTANTS for `mode' values.
		require	
			exists: exists
			region_not_void: region /= Void
			region_exists: region.exists
		do
			!! Result.make_empty
			cwin_combine_rgn (Result.item , item, region.item, mode)
		ensure
			result_not_void: Result /= Void			
		end

	offset (x_offset, y_offset: INTEGER) is
			-- Move the region by the specified offsets
			-- `x_offset' and `y_offset'
		require
			exists: exists
		do
			cwin_offset_rgn (item, x_offset, y_offset)
		end

	set_rect (left, top, right, bottom: INTEGER) is
			-- Change the region to a rectangle region specified
			-- by `left', `top', `right', `bottom'
		require
			exists: exists
		do
			cwin_set_rect_rgn (item, left, top, right, bottom)
		end

feature -- Status report

	point_in (x, y: INTEGER): BOOLEAN is
			-- Is the point `x', `y' is in the region?
		require
			exists: exists
		do
			Result := cwin_pt_in_region (item, x, y)
		end

	rect_in (rect: WEL_RECT): BOOLEAN is
			-- Is any part of the rectangle `rect' is within
			-- the boundaries of the region?
		require
			exists: exists
			rect_not_void: rect /= Void
		do
			Result := cwin_rect_in_region (item, rect.item)
		end

feature {NONE} -- Externals

	cwin_create_elliptic_rgn (x1, y1, x2, y2: INTEGER): POINTER is
			-- SDK CreateEllipticRgn
		external
			"C [macro <wel.h>] (int, int, int, int): EIF_POINTER"
		alias
			"CreateEllipticRgn"
		end

	cwin_create_elliptic_rgn_indirect (rect: POINTER): POINTER is
			-- SDK CreateEllipticRgnIndirect
		external
			"C [macro <wel.h>] (RECT *): EIF_POINTER"
		alias
			"CreateEllipticRgnIndirect"
		end

	cwel_create_polygon_rgn (points: POINTER; num, mode: INTEGER): POINTER is
			-- SDK CreatePolygonRgn
		external
			"C"
		end

	cwin_create_rect_rgn (x1, y1, x2, y2: INTEGER): POINTER is
			-- SDK CreateRectRgn
		external
			"C [macro <wel.h>] (int, int, int, int): EIF_POINTER"
		alias
			"CreateRectRgn"
		end

	cwin_create_rect_rgn_indirect (rect: POINTER): POINTER is
			-- SDK CreateRectRgnIndirect
		external
			"C [macro <wel.h>] (RECT *): EIF_POINTER"
		alias
			"CreateRectRgnIndirect"
		end

	cwin_equal_rgn (hrgn1, hrgn2: POINTER): BOOLEAN is
			-- SDK EqualRgn
		external
			"C [macro <wel.h>] (HRGN, HRGN): EIF_BOOLEAN"
		alias
			"EqualRgn"
		end

	cwin_combine_rgn (hrgn1, hrgn2, hrgn3 : POINTER; mode: INTEGER) is
			-- SDK CombineRgn
		external
			"C [macro <wel.h>] (HRGN, HRGN, HRGN, int)"
		alias
			"CombineRgn"
		end

	cwin_pt_in_region (hrgn: POINTER; x, y: INTEGER): BOOLEAN is
			-- SDK PtInRegion
		external
			"C [macro <wel.h>] (HRGN, int, int): EIF_BOOLEAN"
		alias
			"PtInRegion"
		end

	cwin_rect_in_region (hrgn, rect: POINTER): BOOLEAN is
			-- SDK RectInRegion
		external
			"C [macro <wel.h>] (HRGN, RECT *): EIF_BOOLEAN"
		alias
			"RectInRegion"
		end

	cwin_offset_rgn (hrgn: POINTER; x, y: INTEGER) is
			-- SDK OffsetRgn
		external
			"C [macro <wel.h>] (HRGN, int, int)"
		alias
			"OffsetRgn"
		end

	cwin_set_rect_rgn (hrgn: POINTER; x1, y1, x2, y2: INTEGER) is
			-- SDK SetRectRgn
		external
			"C [macro <wel.h>] (HRGN, int, int, int, int)"
		alias
			"SetRectRgn"
		end

	Alternate: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ALTERNATE"
		end

	Winding: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"WINDING"
		end

end -- class WEL_REGION

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
