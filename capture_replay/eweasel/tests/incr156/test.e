
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation 
	make
feature
	make is
		do
			!!x
  		end
			
	x: TEST1 [STRING, TEST2 [NONE, NONE, NONE], TEST2 [STRING, SEQ_STRING, TEST1 [NONE, NONE, NONE]]]
			
end
