note
	description: "Pixel buffer that replaces orignal image file.%
		%The orignal version of this class has been generated by Image Eiffel Code."
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	SD_ICON_MATRIX_16_8

inherit
	EV_PIXEL_BUFFER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			make_with_size (19, 19)
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
				A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)
				A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)
				A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,F1,EB,E7)A(FF,00,00,00)
				A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,DA,E2,F3)
				A(00,DA,E2,F3)A(00,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3);
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


end -- SD_MATRIX_8_16_HORIZONTAL
