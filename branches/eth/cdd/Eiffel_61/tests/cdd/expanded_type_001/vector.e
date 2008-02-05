indexing
	description	: "Objects that represent 2 dimensional vectors"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	VECTOR

feature -- Access

	x, y: DOUBLE
			-- Coordinates

feature -- Status setting

	set_x (a_x: like x) is
			-- Set `x' to `a_x'.
		do
			x := a_x
		ensure
			x_set: x = a_x
		end

	set_y (a_y: like y) is
		  -- Set `y' to `a_y'.
		do
			y := a_y
		ensure
			y_set: y = a_y
		end

feature -- Basic operations

	norm: DOUBLE is
			-- Length of `Current'
		do
			Result := x*x + y*y
		ensure
			triangle_equation: Result.abs <= x.abs + y.abs
		end

end
