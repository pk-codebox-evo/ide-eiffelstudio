indexing
	description: "Contains information about a tree view notification%
		%message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_TREE_VIEW_GETINFOTIP

inherit
	WEL_STRUCTURE

create
	make,
	make_by_pointer

feature -- access

	hdr: WEL_NMHDR is
			-- Information about the Wm_notify message.
		do
			create Result.make_by_pointer (cwel_nmtvinfotip_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	psztext: POINTER is
			-- Address of text to be displayed.
		do
			Result := cwel_nmtvinfotip_get_psztext (item)
		ensure
			Result_not_void: Result /= Void
		end

	cchtextmax: INTEGER is
			-- Size of buffer at `psztext'.
		do
			Result := cwel_nmtvinfotip_get_cchtextmax (item)
		ensure
			Result_not_void: Result /= Void
		end

	hitem: POINTER is
			-- Handle to item for which the tooltip is displayed.
		do
			Result := cwel_nmtvinfotip_get_hitem (item)
		ensure
			Result_not_void: Result /= Void
		end

	lparam: INTEGER is
			-- Application defined data associated with `hitem'.
		do
			Result := cwel_nmtvinfotip_get_lparam (item)
		ensure
			Result_not_void: Result /= Void
		end

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nm_tvgetinfotip
		end

feature {NONE} -- Externals

	c_size_of_nm_tvgetinfotip: INTEGER is
		external
			"C [macro <nmtvgetinfotip.h>]"
		alias
			"sizeof (TVN_GETINFOTIP)"
		end

	cwel_nmtvinfotip_get_hdr (ptr: POINTER): POINTER is
		external
			"C [macro <nmtvgetinfotip.h>] (NMTVGETINFOTIP *): EIF_POINTER"
		end

	cwel_nmtvinfotip_get_psztext (ptr: POINTER): POINTER is
		external
			"C [macro <nmtvgetinfotip.h>] (NMTVGETINFOTIP *): EIF_POINTER"
		end

	cwel_nmtvinfotip_get_cchtextmax (ptr: POINTER): INTEGER is
		external
			"C [macro <nmtvgetinfotip.h>]"
		end

	cwel_nmtvinfotip_get_hitem (ptr: POINTER): POINTER is
		external
			"C [macro <nmtvgetinfotip.h>] (NMTVGETINFOTIP *): EIF_POINTER"
		end

	cwel_nmtvinfotip_get_lparam (ptr: POINTER): INTEGER is
		external
			"C [macro <nmtvgetinfotip.h>]"
		end


end -- class WEL_NM_TREE_VIEW_GETINFOTIP
