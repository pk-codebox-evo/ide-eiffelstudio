
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class A

feature

	f (an_array: ARRAY [like item]) is
		do
			$INST
			print (an_array.generating_type)
			print ("%N")
		end

	item: X [like toto]

	toto: A

end
