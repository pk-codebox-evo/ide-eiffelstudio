indexing
	description: "Browse for folder dialog."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHOOSE_FOLDER_DIALOG

inherit
	WEL_STANDARD_DIALOG
		rename
			make as standard_make
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEL_BIF_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature -- Initialization

	make is
			-- Initialize structure
		do
			standard_make
			create str_folder_name.make_empty (max_path)
			create str_title.make_empty (max_title_length)
			create str_display_name.make_empty (max_path)
			create imalloc.make
			cwel_browse_info_set_pszdisplayname (item, str_folder_name.item)
			cwel_browse_info_set_lpsztitle (item, str_title.item)
			set_default_title
		end

feature -- Access

	folder_name: STRING is
			-- Selected folder name
			-- Empty if no folder was selected.
		do
			Result := str_folder_name.string
		end

	display_name: STRING is
			-- Display name of selected folder
			-- Empty if no folder was selected.
		do
			Result := str_display_name.string
		end
	
	title: STRING is
			-- Dialog title
		do
			Result := str_title.string
		end

	flags: INTEGER is
			-- Dialog box creation flags
			-- Can be a combination of values defined in 
			-- class WEL_BIF_CONSTANTS.
		do
			Result := cwel_browse_info_get_ulflags (item)
		end

	has_flag (a_flags: INTEGER): BOOLEAN is
			-- Is `a_flags' set in `flags'?
			-- See class WEL_BIF_CONSTANTS for `a_flags' values.
		do
			Result := flag_set (flags, a_flags)
		end

feature -- Element Change

	set_title (a_title: STRING) is
			-- Set `title' with `a_title'
		require
			a_title_not_void: a_title /= Void
		do
			str_title.set_string (a_title)
			cwel_browse_info_set_lpsztitle (item,
				str_title.item)
		ensure
			title_set: title.is_equal (a_title)
		end

	set_default_title is
			-- Set `title' with default title ("Browse for folder")
		do
			cwel_browse_info_set_lpsztitle (item, default_pointer)
		end

	set_flags (a_flags: INTEGER) is
			-- Set `flags' with `a_flags'.
			-- See class WEL_BIF_CONSTANTS for `a_flags' values.
		do
			cwel_browse_info_set_ulflags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	add_flag (a_flags: INTEGER) is
			-- Add `a_flags' to `flags'.
			-- See class WEL_BIF_CONSTANTS for `a_flags' values.
		do
			set_flags (set_flag (flags, a_flags))
		ensure
			has_flag: has_flag (a_flags)
		end

	remove_flag (a_flags: INTEGER) is
			-- Remove `a_flags' from `flags'.
			-- See class WEL_BIF_CONSTANTS for `a_flags' values.
		do
			set_flags (clear_flag (flags, a_flags))
		ensure
			has_not_flag: not has_flag (a_flags)
		end

feature -- Basic operations

	activate (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Activate the dialog box (modal mode) with
			-- `a_parent' as owner.
		local
			id_list: POINTER
		do
			set_parent (a_parent)
			str_folder_name.set_string ("")
			str_display_name.set_string ("")
			selected := False
			id_list := cwin_sh_browse_for_folder (item)
			if not (id_list = default_pointer) then
				cwin_sh_get_path_from_id_list (id_list, str_folder_name.item)
				imalloc.free_buffer (id_list)
				if not str_folder_name.string.empty then
					selected := True
				end
			end
		end

feature {NONE} -- Implementation

	str_folder_name: WEL_STRING
			-- Chosen folder name

	str_display_name: WEL_STRING
			-- Chosen display name

	str_title: WEL_STRING
			-- Dialog title

	imalloc: WEL_IMALLOC
			-- IMalloc interface pointer

	set_parent (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Set parent window with `a_parent'.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			cwel_browse_info_set_hwndowner (item, a_parent.item)
		end

	max_title_length: INTEGER is 256
			-- Max title string length

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_browse_info
		end

feature {NONE} -- External

	c_size_of_browse_info: INTEGER is
		external
			"C [macro %"choose_folder.h%"]"
		alias
			"sizeof (BROWSEINFO)"
		end

	max_path: INTEGER is
			external
				"C [macro %"wel.h%"]"
			alias
				"MAX_PATH"
			end

	cwel_browse_info_get_ulflags (ptr: POINTER): INTEGER is
			external
				"C [macro %"choose_folder.h%"]"
			end

	cwel_browse_info_set_hwndowner (ptr, parent: POINTER) is
			external
				"C [macro %"choose_folder.h%"]"
			end
	
	cwel_browse_info_set_pszdisplayname (ptr, name: POINTER) is
			external
				"C [macro %"choose_folder.h%"]"
			end

	cwel_browse_info_set_ulflags (ptr: POINTER; a_flags: INTEGER) is
			external
				"C [macro %"choose_folder.h%"]"
			end

	cwel_browse_info_set_lpsztitle (ptr, a_title: POINTER) is
			external
				"C [macro %"choose_folder.h%"]"
			end

	cwin_sh_browse_for_folder (browse_info: POINTER): POINTER is
			external
				"C [macro %"wel.h%"] (LPBROWSEINFO): LPITEMIDLIST"
			alias
				"SHBrowseForFolder"
			end
	
	cwin_sh_get_path_from_id_list (id_list, a_folder_name: POINTER) is
			external
				"C [macro %"wel.h%"] (LPCITEMIDLIST, LPSTR)"
			alias
				"SHGetPathFromIDList"
			end

end -- class WEL_CHOOSE_DIRECTORY_DIALOG
