indexing
	description : "scoop_test application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization
	a : X
--	y  : Y [X]
	b  : separate X
--	c1 : separate <p> X
--	c2 : separate <p> X

	make
		local
			-- Run application.
		do
			-- create a.make
			io.put_string ("Testy, yarrr %N")
			-- test4 (a)
		end

	test1 is
		do
			b := a
--			a := b
		end

--	test2 is
--		local
--			d : separate  X
--		do
--			d := a
--			d := b
--			b := d
--			c1 := d
--		end

--	test3 is
--		do
--			a := b.f
--		end

	test4 (a_b : ! separate <px> X) is
		local
 			r: X
		do
			r := a_b.f
		end

--	test5 (a_b : ! separate X) is
--		do
--			a_b.h (a_b)
--		end

--	test6 is
--		do
--			b.g (b)
--		end

--	test7 is
--		local
--			list1 : LIST [! ANY]
--			list2 : LIST [! X]
--		do
--			list1 := list2
--		end

--	test8 is
--		local
--			list1 : LIST [ANY]
--			list2 : LIST [X]
--		do
--			list1 := list2
--		end


--	test9 is
--		local
--			list1 : LIST [!X]
--			list2 : LIST [!X]
--		do
--			list1 := list2
--		end

--	test10 (a10 : ! X) is
--		do
--		end
--	test11 (a11 : X) is
--		do
--		end

	test12 (a12 : ! separate X)
		do
			a12.f.f.do_nothing
		end

	test13 (a13 : ! separate X)
		do
			a13.e.do_nothing
		end
	test14 (a14 : ! separate <px> X)
		local
			ag1 : separate <px> FUNCTION [!X,TUPLE,X]
 			ag2 : FUNCTION [!X, TUPLE, X]
 		do
			ag1 := agent a14.f
 			ag2 := agent a14.f --fail
		end

--	test15 (a15: separate EXP) -- fail, no expanded separates
--		do
--		end	
end
