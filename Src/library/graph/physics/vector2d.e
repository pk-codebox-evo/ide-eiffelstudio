indexing
	description: "Objects that is a two dimensional vector."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	VECTOR2D [G -> NUMERIC]
	
inherit
	VECTOR [G]
	
create
	make,
	default_create
	
feature -- Initialization

	make, set (ax, ay: G) is
			-- Set `x' to `ax' and `y' to `ay'.
		do
			x := ax
			y := ay
		ensure
			set: x = ax and y = ay
		end
		
feature -- Access

	x: G
			-- X position of `Current'.
			
	y: G
			-- Y position of `Current'.

	one: like Current is
			-- Neutral element for "*" and "/"
		do
			create Result.make (x.one, y.one)
		end

	zero: like Current is
			-- Neutral element for "+" and "-"
		do
			create Result.make (x.zero, y.zero)
		end

feature -- Status report

	divisible (other: like Current): BOOLEAN is
			-- May current object be divided by `other'?
		do
			Result := False
		end

	exponentiable (other: NUMERIC): BOOLEAN is
			-- May current object be elevated to the power `other'?
		do
			Result := True
		end

feature -- Basic operations

	infix "+" (other: like Current): like Current is
			-- Sum with `other' (commutative).
		do
			create Result.make (x + other.x, y + other.y)
		end

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		do
			create Result.make (x - other.x, y - other.y)
		end

	infix "*" (other: like Current): like Current is
			-- Product by `other'
		do
			check
				implement: False
			end
		end

	infix "/" (other: like Current): like Current is
			-- Division by `other'
		do
		end

	prefix "+": like Current is
			-- Unary plus
		do
			create Result.make (x, y)
		end

	prefix "-": like Current is
			-- Unary minus
		do
			create Result.make (-x, -y)
		end
		
	infix "|*" (other: G): like Current is
			-- Scalar product between `Current' and other.
		do
			create Result.make (x * other, y * other)
		end

end -- class VECTOR2D

--|----------------------------------------------------------------
--| EiffelGraph: library of graph components for ISE Eiffel.
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

