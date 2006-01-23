indexing
	description:
		"EiffelVision WEL_DIB version. We do not want the file %
		% given as argument to be closed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_DIB

inherit
	WEL_DIB
	
create
	make_by_file, make_by_stream

feature {NONE} -- Initialization

	make_by_stream (medium: IO_MEDIUM) is
			-- Create `Current' by reading `medium'.
			-- Contrary to `make_by_file', the medium
			-- is not closed when finished.
		require
			medium_not_void: medium /= Void
			medium_exists: medium.exists
			medium_opened: medium.is_open_read
		local
			bitmap_file_header: WEL_BITMAP_FILE_HEADER						
			s: STRING
			a_wel_string1, a_wel_string2: WEL_STRING
		do
			create bitmap_file_header.make
			create info_header.make
			medium.read_stream (bitmap_file_header.structure_size)
			s := medium.last_string
			create a_wel_string1.make (s)
			bitmap_file_header.memory_copy (a_wel_string1.item,
				bitmap_file_header.structure_size)
			structure_size := bitmap_file_header.size -
				bitmap_file_header.structure_size
			structure_make
			medium.read_stream (structure_size)
			s := medium.last_string
			create a_wel_string2.make (s)
					--| FIXME
					--| In the next line, we should use `structure_size' that is
					--| the size read in the header of the bitmap, instead
					--| of `s.count' that is the size of the bitmap actually 
					--| read directly on the disk.
					--| BUT it seems that `structure_size' can have a wrong
					--| value, leading to a `segmentation violation'.
			memory_copy (a_wel_string2.item, s.count)
			info_header.memory_copy (item, info_header.structure_size)
			calculate_palette
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_WEL_DIB

