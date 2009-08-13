note
	description: "Pixel buffer that replaces orignal image file.%
		%The orignal version of this class has been generated by Image Eiffel Code."
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	SD_RIGHT_LIGHT_ICON

inherit
	EV_PIXEL_BUFFER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			make_with_size (41, 35)
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
				A(96,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(DA,80,8F,D3)A(76,7E,8D,CF)A(0E,5C,67,97)A(03,00,00,00)A(02,00,00,00)A(01,00,00,00)A(01,00,00,00)A(FF,81,90,D4)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,96,9A,AA)A(FF,8C,95,BE)A(9B,7D,8B,CD)A(14,41,48,6A)A(07,00,00,00)
				A(04,00,00,00)A(02,00,00,00)A(FF,81,90,D4)A(FF,9F,A1,A8)A(FF,A6,A9,B0)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AA,AC,B4)A(FF,A7,AA,B1)A(FF,8F,99,C2)A(7F,75,82,C0)A(0F,00,00,00)A(09,00,00,00)A(05,00,00,00)A(FF,81,90,D4)A(FF,A6,A9,B0)A(FF,C0,C2,CB)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CB,CE,D7)A(FF,C6,C8,D1)A(FF,B0,B4,C6)
				A(DF,7D,8C,CE)A(1B,00,00,00)A(11,00,00,00)A(09,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DC,DF,E9)A(FF,DA,DC,E6)A(FF,CE,D1,DA)A(FF,81,90,D4)A(2B,00,00,00)A(1B,00,00,00)A(0F,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,C0,C7,E2)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,C0,C7,E2)A(FF,DD,E0,EA)A(FF,DD,E0,EA)
				A(FF,DD,E0,EA)A(FF,DA,DC,E6)A(FF,81,90,D4)A(3A,00,00,00)A(25,00,00,00)A(15,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,CF,D9,FC)A(FF,D0,D9,FC)A(FF,CF,D9,FC)A(FF,CF,D9,FC)A(FF,CF,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,CF,D9,FC)A(FF,D0,D9,FC)A(FF,CF,DA,FC)A(FF,CF,D9,FC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DC,DF,E9)A(FF,81,90,D4)A(47,00,00,00)A(2F,00,00,00)A(1B,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,A1,B1,EE)A(FF,A0,AF,ED)A(FF,9F,B1,EC)A(FF,A0,B0,ED)A(FF,9F,B0,ED)A(FF,A0,B0,ED)A(FF,9F,B0,ED)A(FF,9F,AF,ED)A(FF,A0,B0,EC)A(FF,9F,AF,ED)A(FF,A0,AF,ED)A(FF,9F,B0,ED)A(FF,A0,AF,ED)A(FF,9F,B1,ED)A(FF,A0,B0,ED)A(FF,9F,B0,ED)A(FF,A0,B1,ED)A(FF,A0,B0,ED)A(FF,A0,AF,ED)A(FF,9F,B0,ED)A(FF,9F,AF,EC)A(FF,A0,B0,ED)A(FF,A0,B1,ED)A(FF,A0,AF,ED)A(FF,A0,B0,ED)A(FF,A0,B0,ED)A(FF,AB,B5,DC)
				A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(52,00,00,00)A(35,00,00,00)A(20,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,72,87,D2)A(FF,72,86,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,71,85,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,72,86,D2)A(FF,72,85,D2)A(FF,71,85,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,72,86,D2)A(FF,71,86,D2)A(FF,72,86,D2)A(FF,72,86,D2)A(FF,72,86,D2)A(FF,71,85,D2)A(FF,71,86,D2)A(FF,71,85,D2)A(FF,72,86,D2)A(FF,71,86,D2)A(FF,72,86,D2)A(FF,72,86,D2)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(58,00,00,00)A(3A,00,00,00)A(23,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,DE,E4,F8)A(FF,9E,AC,E7)A(FF,D7,DE,F7)A(FF,D4,DA,F5)A(FF,D0,D7,F4)A(FF,CB,D3,F3)A(FF,C7,CE,F1)A(FF,C1,CA,F0)A(FF,BD,C6,EE)A(FF,B9,C2,ED);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	c_colors_1 (a_ptr: POINTER; a_offset: INTEGER)
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
				A(FF,B6,C0,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5B,00,00,00)A(3D,00,00,00)A(24,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FE,FE,FF)A(FF,F8,F9,FE)A(FF,D0,D8,F8)A(FF,E2,E6,FA)A(FF,DE,E3,F8)A(FF,D8,DD,F6)A(FF,D2,D9,F5)A(FF,CB,D3,F3)A(FF,C5,CE,F1)A(FF,C0,C8,F0)A(FF,B9,C4,EE)A(FF,B5,BF,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FE,FF,FF)A(FF,FF,FF,FF)A(FF,FD,FE,FF)A(FF,FF,FF,FF)A(FF,E5,E9,FB)A(FF,E2,E7,FA)A(FF,DE,E3,F9)A(FF,D8,DE,F6)A(FF,D2,D9,F5)A(FF,CC,D3,F3)A(FF,C5,CE,F2)
				A(FF,C0,C8,EF)A(FF,B9,C3,EE)A(FF,B6,C0,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FE,FF)A(FF,FE,FE,FF)A(FF,FD,FD,FF)A(FF,FC,FD,FF)A(FF,EB,EF,FC)A(FF,A0,AF,EC)A(FF,E2,E7,FA)A(FF,DE,E2,F9)A(FF,D8,DE,F7)A(FF,D2,D9,F5)A(FF,CC,D3,F3)A(FF,C5,CD,F1)A(FF,BF,C8,EF)A(FF,BA,C3,ED)A(FF,B5,BF,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,93,93,93)A(FF,F9,F9,F9)A(FF,FC,FC,FC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FE,FF)A(FF,FE,FE,FF)A(FF,FD,FE,FF)A(FF,FC,FD,FF)A(FF,FC,FD,FE)A(FF,EB,EF,FC)A(FF,96,A6,E5)A(FF,E2,E7,FA)A(FF,DD,E2,F9)A(FF,D8,DD,F7)A(FF,D2,D8,F5)
				A(FF,CC,D3,F3)A(FF,C5,CD,F1)A(FF,BF,C8,EF)A(FF,BA,C4,EE)A(FF,B5,BF,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,93,93,93)A(FF,86,85,85)A(FF,EF,EF,EF)A(FF,FC,FB,FC)A(FF,FE,FE,FF)A(FF,FD,FE,FF)A(FF,FD,FE,FF)A(FF,FC,FD,FF)A(FF,FC,FC,FF)A(FF,FA,FB,FF)A(FF,F8,F9,FE)A(FF,D0,D8,F8)A(FF,E2,E6,FA)A(FF,DE,E3,F9)A(FF,D8,DE,F7)A(FF,D2,D8,F5)A(FF,CC,D3,F3)A(FF,C5,CD,F1)A(FF,BF,C8,EF)A(FF,B9,C3,EE)A(FF,B5,BF,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,93,93,93)A(FF,85,85,85)A(FF,71,71,72)A(FF,EE,EE,EF)A(FF,FB,FB,FC)A(FF,FC,FD,FF)A(FF,FB,FC,FF)A(FF,FB,FC,FF)A(FF,FA,FB,FF)A(FF,F9,FA,FF)A(FF,FF,FF,FF)A(FF,E5,EA,FB)A(FF,E2,E6,FA)A(FF,DD,E3,F8)
				A(FF,D8,DE,F7)A(FF,D2,D8,F5)A(FF,CB,D3,F3)A(FF,C5,CE,F1)A(FF,BF,C8,EF)A(FF,B9,C3,ED)A(FF,B5,BF,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,93,93,93)A(FF,85,85,85)A(FF,72,72,72)A(FF,5C,5D,5D)A(FF,EC,ED,EF)A(FF,F8,F9,FC)A(FF,FB,FC,FF)A(FF,F9,FB,FF)A(FF,F9,FA,FF)A(FF,F8,F9,FF)A(FF,EB,EF,FC)A(FF,A0,AF,EC)A(FF,E2,E7,FA)A(FF,DD,E2,F8)A(FF,D9,DD,F7)A(FF,D2,D9,F5)A(FF,CC,D3,F3)A(FF,C5,CD,F1)A(FF,BF,C8,EF)A(FF,BA,C3,ED)A(FF,B5,C0,ED)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,93,93,93)A(FF,85,85,86)A(FF,72,72,71)A(FF,5D,5C,5C)A(FF,50,50,50)A(FF,EA,EC,EF)A(FF,F7,F8,FC)A(FF,F9,FA,FF)A(FF,F8,F9,FE)A(FF,F6,F8,FF)A(FF,EB,EF,FC)A(FF,96,A6,E5)
				A(FF,E2,E7,FA)A(FF,DE,E3,F9)A(FF,D8,DE,F7)A(FF,D2,D8,F5)A(FF,CC,D3,F3)A(FF,C5,CD,F1)A(FF,BF,C8,EF)A(FF,BA,C4,ED)A(FF,B5,BF,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FE,FE,FF)A(FF,93,93,93)A(FF,85,85,85)A(FF,71,72,71)A(FF,5D,5D,5D)A(FF,B0,B1,B3)A(FF,DF,E0,E4)A(FF,F1,F2,F8)A(FF,F6,F8,FF)A(FF,F6,F7,FF)A(FF,F5,F6,FF)A(FF,F8,F9,FE)A(FF,D0,D8,F8)A(FF,E2,E7,F9)A(FF,DD,E2,F9)A(FF,D8,DE,F7)A(FF,D2,D8,F4)A(FF,CC,D3,F3)A(FF,C5,CD,F1)A(FF,BF,C8,EF)A(FF,BA,C3,EE)A(FF,B5,C0,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FE,FF,FF)A(FF,FF,FE,FF)A(FF,FE,FE,FF)A(FF,FD,FD,FF)A(FF,93,93,93)A(FF,85,85,85)A(FF,71,71,71)A(FF,A1,A1,A3)A(FF,D2,D4,D7)A(FF,E5,E5,EB)A(FF,F1,F3,FA)A(FF,F5,F7,FF)A(FF,F5,F6,FF)A(FF,F3,F6,FF);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	c_colors_2 (a_ptr: POINTER; a_offset: INTEGER)
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
				A(FF,FF,FF,FF)A(FF,E5,E9,FB)A(FF,E2,E7,FA)A(FF,DD,E2,F9)A(FF,D8,DE,F7)A(FF,D2,D8,F5)A(FF,CC,D3,F3)A(FF,C5,CE,F1)A(FF,BF,C8,EF)A(FF,B9,C3,ED)A(FF,B5,BF,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FE,FE,FF)A(FF,FE,FF,FF)A(FF,FD,FD,FF)A(FF,FC,FD,FF)A(FF,FC,FD,FF)A(FF,93,93,93)A(FF,86,85,85)A(FF,A8,A9,AA)A(FF,D2,D2,D6)A(FF,E1,E3,E7)A(FF,F0,F1,F7)A(FF,F4,F6,FD)A(FF,F4,F6,FF)A(FF,F2,F5,FF)A(FF,F1,F4,FE)A(FF,EB,EF,FC)A(FF,A0,AF,EC)A(FF,E2,E6,FA)A(FF,DD,E2,F9)A(FF,D8,DD,F7)A(FF,D2,D9,F5)A(FF,CC,D3,F3)A(FF,C5,CD,F1)A(FF,BF,C8,EF)A(FF,BA,C4,EE)A(FF,B5,BF,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FE,FE,FF)A(FF,FD,FD,FF)A(FF,FC,FD,FF)A(FF,FB,FD,FE)A(FF,FB,FB,FF)A(FF,93,93,93)A(FF,B8,B9,BB)A(FF,D1,D3,D7)A(FF,E0,E3,E7)A(FF,EE,F0,F7)A(FF,F4,F6,FE)A(FF,F3,F6,FF)A(FF,F2,F5,FF)
				A(FF,F2,F4,FE)A(FF,F0,F3,FE)A(FF,EA,EE,FC)A(FF,96,A6,E5)A(FF,E2,E6,FA)A(FF,DD,E2,F9)A(FF,D8,DE,F7)A(FF,D2,D8,F5)A(FF,CB,D2,F3)A(FF,C5,CD,F1)A(FF,BF,C8,EF)A(FF,B9,C3,ED)A(FF,B5,BF,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FD,FE,FF)A(FF,FC,FD,FF)A(FF,FB,FC,FF)A(FF,FA,FB,FF)A(FF,F9,FB,FE)A(FF,E5,E7,EC)A(FF,E0,E1,E6)A(FF,E1,E3,E9)A(FF,EE,EF,F6)A(FF,F3,F6,FE)A(FF,F3,F6,FE)A(FF,F2,F4,FF)A(FF,F1,F3,FF)A(FF,EF,F2,FF)A(FF,EE,F2,FE)A(FF,F7,F8,FE)A(FF,D0,D9,F8)A(FF,E2,E7,FA)A(FF,DE,E3,F9)A(FF,D8,DE,F7)A(FF,D2,D9,F5)A(FF,CB,D3,F3)A(FF,C6,CD,F1)A(FF,BF,C8,EF)A(FF,BA,C3,EE)A(FF,B6,BF,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FC,FD,FF)A(FF,FB,FC,FF)A(FF,FA,FB,FF)A(FF,F9,FA,FF)A(FF,F8,F9,FE)A(FF,F3,F5,FB)A(FF,ED,EF,F6)A(FF,EF,F1,F9)A(FF,F3,F5,FD)A(FF,F3,F5,FF)A(FF,F2,F4,FF)
				A(FF,F0,F3,FF)A(FF,EF,F3,FF)A(FF,EE,F1,FE)A(FF,ED,F1,FE)A(FF,FD,FD,FF)A(FF,E6,EA,FB)A(FF,E2,E7,FA)A(FF,DD,E3,F8)A(FF,D8,DE,F7)A(FF,D2,D9,F5)A(FF,CB,D3,F3)A(FF,C5,CE,F1)A(FF,BF,C8,EF)A(FF,BA,C4,ED)A(FF,B5,BF,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AB,B5,DC)A(FF,FB,FC,FF)A(FF,FA,FA,FF)A(FF,F9,FA,FF)A(FF,F8,F9,FF)A(FF,F7,F8,FF)A(FF,F6,F7,FE)A(FF,F3,F6,FE)A(FF,F3,F6,FF)A(FF,F2,F4,FE)A(FF,F1,F4,FF)A(FF,F0,F3,FF)A(FF,EF,F2,FF)A(FF,EE,F1,FE)A(FF,ED,F0,FE)A(FF,EB,EF,FF)A(FF,E9,ED,FC)A(FF,A0,AF,EC)A(FF,E2,E6,FA)A(FF,DD,E2,F9)A(FF,D8,DD,F7)A(FF,D2,D8,F5)A(FF,CB,D3,F3)A(FF,C5,CD,F1)A(FF,C0,C8,EF)A(FF,BA,C3,EE)A(FF,B5,BF,EC)A(FF,AB,B5,DC)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,C0,C7,E2)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)
				A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,C0,C7,E2)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)
				A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,CF,D4,E7)A(EA,77,85,C4)A(5B,00,00,00)A(3D,00,00,00)A(24,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,AA,B4,DD)A(B1,54,5E,8A)A(58,00,00,00)A(3A,00,00,00)A(23,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	c_colors_3 (a_ptr: POINTER; a_offset: INTEGER)
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
				A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,CF,D4,E7)A(FF,AA,B4,DE)A(C9,60,6B,9E)A(70,0C,0D,13)A(52,00,00,00)A(35,00,00,00)A(20,00,00,00)A(9D,7B,8A,CB)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(ED,76,84,C2)A(B8,50,5A,84)A(76,0B,0C,12)A(5E,00,00,00)A(47,00,00,00)A(2F,00,00,00)A(1B,00,00,00)A(0E,00,00,00)A(1C,00,00,00)A(2F,00,00,00)A(46,00,00,00)A(58,00,00,00)A(67,00,00,00)A(70,00,00,00)A(74,00,00,00)A(74,00,00,00)
				A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(73,00,00,00)A(71,00,00,00)A(6A,00,00,00)A(5E,00,00,00)A(4E,00,00,00)A(3A,00,00,00)A(25,00,00,00)A(15,00,00,00)A(0B,00,00,00)A(16,00,00,00)A(25,00,00,00)A(37,00,00,00)A(46,00,00,00)A(51,00,00,00)A(58,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5B,00,00,00)A(58,00,00,00)A(52,00,00,00)A(47,00,00,00)A(3A,00,00,00)A(2B,00,00,00)A(1B,00,00,00)A(0F,00,00,00)A(07,00,00,00)A(0E,00,00,00)A(19,00,00,00)A(25,00,00,00)A(2F,00,00,00)A(36,00,00,00)A(3B,00,00,00)
				A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3A,00,00,00)A(35,00,00,00)A(2F,00,00,00)A(25,00,00,00)A(1B,00,00,00)A(11,00,00,00)A(09,00,00,00)A(04,00,00,00)A(09,00,00,00)A(0E,00,00,00)A(16,00,00,00)A(1C,00,00,00)A(20,00,00,00)A(23,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(24,00,00,00)A(23,00,00,00)A(20,00,00,00)A(1B,00,00,00)A(15,00,00,00)A(0F,00,00,00)A(09,00,00,00)A(05,00,00,00);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	build_colors (a_ptr: POINTER)
			-- Build `colors'.
		do
			c_colors_0 (a_ptr, 0)
			c_colors_1 (a_ptr, 400)
			c_colors_2 (a_ptr, 800)
			c_colors_3 (a_ptr, 1200)
		end

feature {NONE} -- Image data filling.

	fill_memory
			-- Fill image data into memory.
		local
			l_imp: detachable EV_PIXEL_BUFFER_IMP
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

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- SD_RIGHT_LIGHT_ICON
