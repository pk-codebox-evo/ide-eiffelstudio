
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.
class TEST
inherit
	TEST1 [$ACTUAL]
creation
	make
feature
	make is
		do
			inspect w
			when '%U' then
			end
		end;
		
end
