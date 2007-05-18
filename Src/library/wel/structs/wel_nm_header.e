indexing
	description: "Contains information about a header control notification%
		%message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_HEADER

inherit
	WEL_STRUCTURE

create
	make,
	make_by_nmhdr,
	make_by_pointer

feature {NONE} -- Initialization

	make_by_nmhdr (a_nmhdr: WEL_NMHDR) is
			-- Make the structure with `a_nmhdr'.
		require
			a_nmhdr_not_void: a_nmhdr /= Void
		do
			make_by_pointer (a_nmhdr.item)
		end

feature -- Access

	hdr: WEL_NMHDR is
			-- Information about the Wm_notify message.
		do
			create Result.make_by_pointer (cwel_nmheader_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	iitem: INTEGER is
			-- Zero-based index of the header item generating message.
		do
			Result := cwel_nmheader_get_iitem (item)
		end

	ibutton: INTEGER is
			-- Value of mouse button used to generate message.
		do
			Result := cwel_nmheader_get_ibutton (item)
		end

	hditem: WEL_HD_ITEM is
			-- `Result' is information about `iitem'.
		do
			create Result.make_by_pointer (cwel_nmheader_get_hditem (item))
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nm_header
		end

feature {NONE} -- Externals

	c_size_of_nm_header: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"sizeof (NMHEADER)"
		end

	cwel_nmheader_get_hdr (ptr: POINTER): POINTER is
		external
			"C [struct <commctrl.h>] (NMHEADER): EIF_POINTER"
		alias
			"&hdr"
		end

	cwel_nmheader_get_iitem (ptr: POINTER): INTEGER is
		external
			"C [struct <commctrl.h>] (NMHEADER): EIF_INTEGER"
		alias
			"iItem"
		end

	cwel_nmheader_get_ibutton (ptr: POINTER): INTEGER is
		external
			"C [struct <commctrl.h>] (NMHEADER): EIF_INTEGER"
		alias
			"iButton"
		end

	cwel_nmheader_get_hditem (ptr: POINTER): POINTER is
		external
			"C [struct <commctrl.h>] (NMHEADER): EIF_POINTER"
		alias
			"pitem"
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

end
