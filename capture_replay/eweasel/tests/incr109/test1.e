
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

inherit

	PARENT

creation

	make

feature -- Creation

	make is
		do
			$TEST1_MAKE_BODY
		end;

	new_bitmap: BIT 8 is do end;

end
