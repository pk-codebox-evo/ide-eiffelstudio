note
	description: "Pixel buffer that replaces orignal image file.%
		%The orignal version of this class has been generated by Image Eiffel Code."

class
	COPY_TO_CLIPBOARD_ICON

inherit
	EV_PIXEL_BUFFER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			make_with_size (14, 14)
			fill_memory
		end

feature {NONE} -- Image data

	c_colors_0 (a_ptr: POINTER; a_offset: INTEGER)
			-- Fill `a_ptr' with colors data from `a_offset'.
		external
			"C inline"
		alias
			"[
			{
				#define B(q) \
					#q
				#ifdef EIF_WINDOWS
				#define A(a,r,g,b) \
					B(\x##b\x##g\x##r\x##a)
				#else
				#define A(a,r,g,b) \
					B(\x##r\x##g\x##b\x##a)
				#endif
				char l_data[] = 
				A(FF,E5,E5,F8)A(FF,D1,D5,F7)A(FF,BC,C7,F5)A(FF,A9,B8,F5)A(FF,94,A9,F3)A(FF,65,93,EF)A(FF,54,8F,EC)A(FF,85,9C,F3)A(00,00,00,00)A(00,00,00,00)A(00,00,00,00)A(00,00,00,00)A(00,00,00,00)A(00,00,00,00)A(FF,D4,D9,F7)A(FF,EE,EE,F8)A(FF,EC,EC,F8)A(FF,EA,EA,F8)A(FF,E8,E9,F8)A(FF,E3,E5,F8)A(FF,E3,E5,F8)A(FF,85,9C,F3)A(FF,4A,86,DE)A(00,00,00,00)A(00,00,00,00)A(00,00,00,00)A(00,00,00,00)A(00,00,00,00)A(FF,C3,CC,F6)A(FF,ED,ED,F8)A(FF,F2,F2,F8)A(FF,E6,E6,FF)A(FF,CC,D2,FE)A(FF,B1,BF,FC)A(FF,97,AB,FB)A(FF,3E,7B,F3)A(FF,28,75,F0)A(FF,68,86,F9)A(FF,68,86,F9)A(00,00,00,00)A(00,00,00,00)A(00,00,00,00)A(FF,B3,BF,F5)A(FF,EC,EC,F8)A(FF,F1,F2,F8)A(FF,D0,D6,FE)A(FF,F2,F2,FF)A(FF,EF,F0,FF)A(FF,ED,ED,FF)A(FF,E4,E6,FF)A(FF,E4,E6,FF)A(FF,C1,C5,FF)A(FF,68,86,F9)A(FF,1A,6A,DD)A(00,00,00,00)A(00,00,00,00)A(FF,A2,B3,F4)A(FF,EB,EB,F8)A(FF,F0,F1,F8)A(FF,BA,C5,FD)A(FF,F1,F1,FF)A(FF,F7,F8,FF)A(FF,F6,F7,FF)A(FF,F4,F4,FF)A(FF,F4,F4,FF)A(FF,C5,C9,FF)A(FF,50,80,F6)A(FF,FA,FA,FF)A(FF,15,62,CC)A(00,00,00,00)A(FF,91,A6,F3)A(FF,EA,EA,F8)A(FF,BB,BB,BB)A(FF,A4,B5,FC)A(FF,EF,F0,FF)A(FF,F6,F7,FF)A(FF,F5,F6,FF)A(FF,F3,F3,FF)A(FF,F3,F3,FF)A(FF,C9,CC,FF)
				A(FF,80,8C,FD)A(FF,50,80,F6)A(FF,37,79,F2)A(FF,13,5D,C3)A(FF,6F,96,F0)A(FF,E8,E9,F8)A(FF,EE,EE,F8)A(FF,8E,A5,FA)A(FF,EE,EE,FF)A(FF,F5,F6,FF)A(FF,F4,F4,FF)A(FF,F2,F2,FF)A(FF,F2,F2,FF)A(FF,CD,D0,FF)A(FF,CD,D0,FF)A(FF,C9,CC,FF)A(FF,C5,C9,FF)A(FF,1F,73,EF)A(FF,69,94,EF)A(FF,E6,E8,F8)A(FF,BB,BB,BB)A(FF,78,94,F9)A(FF,ED,ED,FF)A(FF,AF,AF,AF)A(FF,A3,A3,A3)A(FF,8B,8B,8B)A(FF,F2,F2,FF)A(FF,EB,EC,FF)A(FF,EA,EB,FF)A(FF,EA,EB,FF)A(FF,E1,E3,FF)A(FF,1F,73,EF)A(FF,63,93,EF)A(FF,E5,E6,F8)A(FF,EC,EC,F8)A(FF,4B,7E,F5)A(FF,EA,EB,FF)A(FF,F2,F2,FF)A(FF,F0,F1,FF)A(FF,EE,EF,FF)A(FF,EC,ED,FF)A(FF,EB,EC,FF)A(FF,EA,EB,FF)A(FF,EA,EB,FF)A(FF,E1,E3,FF)A(FF,1A,6A,DD)A(FF,4D,8D,EC)A(FF,E2,E2,F8)A(FF,BB,BB,BB)A(FF,2D,77,F1)A(FF,E4,E6,FF)A(FF,AF,AF,AF)A(FF,A9,A9,A9)A(FF,9D,9D,9D)A(FF,97,97,97)A(FF,91,91,91)A(FF,8B,8B,8B)A(FF,85,85,85)A(FF,EA,EA,FF)A(FF,10,59,BA)A(FF,5D,97,EC)A(FF,EE,EE,F8)A(FF,EC,ED,F8)A(FF,25,75,F0)A(FF,E3,E5,FF)A(FF,EC,ED,FF)A(FF,EB,EC,FF)A(FF,E8,EA,FF)A(FF,E6,E8,FF)A(FF,E5,E6,FF)A(FF,E4,E5,FF)A(FF,E4,E5,FF)A(FF,EC,EC,FF)A(FF,10,59,BA)A(FF,7C,AA,EF)A(FF,6D,A0,EE)A(FF,5D,97,EC)A(FF,1F,73,EF)A(FF,E2,E3,FF)A(FF,AF,AF,AF)
				A(FF,A9,A9,A9)A(FF,9D,9D,9D)A(FF,97,97,97)A(FF,91,91,91)A(FF,8B,8B,8B)A(FF,85,85,85)A(FF,EE,EE,FF)A(FF,0E,5D,C3)A(00,00,00,00)A(00,00,00,00)A(00,00,00,00)A(FF,33,80,F0)A(FF,F2,F2,FF)A(FF,F0,F1,FF)A(FF,EF,EF,FF)A(FF,EA,EB,FF)A(FF,E7,E8,FF)A(FF,E5,E7,FF)A(FF,E4,E5,FF)A(FF,E2,E4,FF)A(FF,F0,F0,FF)A(FF,0C,61,CC)A(00,00,00,00)A(00,00,00,00)A(00,00,00,00)A(FF,5C,99,F3)A(FF,48,8C,F2)A(FF,33,80,F0)A(FF,19,69,DA)A(FF,13,5E,C5)A(FF,10,58,B8)A(FF,0E,54,B1)A(FF,10,59,BA)A(FF,0E,5D,C3)A(FF,0C,61,CC)A(FF,0B,65,D6);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	build_colors (a_ptr: POINTER)
			-- Build `colors'.
		do
			c_colors_0 (a_ptr, 0)
		end

feature {NONE} -- Image data filling.

	fill_memory
			-- Fill image data into memory.
		local
			l_imp: EV_PIXEL_BUFFER_IMP
			l_pointer: POINTER
		do
			l_imp ?= implementation
			check not_void: l_imp /= Void end

			l_pointer := l_imp.data_ptr
			if l_pointer /= default_pointer then
				build_colors (l_pointer)
				l_imp.unlock
			end
		end

end -- COPY_TO_CLIPBOARD_ICON
