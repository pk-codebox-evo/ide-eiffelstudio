
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	
	make is
		local
		do
			!ARRAY [ $ACTUAL_GENERIC ]!x.make (1, 10);
		end;
	
	x: ANY;
end
