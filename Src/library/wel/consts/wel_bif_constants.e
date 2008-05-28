indexing
	description: "Browse Info Folder (BIF) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BIF_CONSTANTS

feature -- Access

	Bif_browseforcomputer: INTEGER is 4096
			-- Only return computers. If the user selects
			-- anything other than a computer, the OK button is grayed.

	Bif_browseforprinter: INTEGER is 8192
			-- Only return printers. If the user selects
			-- anything other than a printer, the OK button is grayed.

	Bif_browseincludefiles: INTEGER is 16384
			-- Requires MVC Version 4.71 or greater. The browse dialog
			-- will display files as well as folders.

	Bif_dontgobelowdomain: INTEGER is 2
			-- Do not include network folders below the domain level
			-- in the tree view control.

	Bif_editbox: INTEGER is 16
			-- Requires MVC Version 4.71 or greater. The browse dialog
			-- includes an edit control in which the user can type
			-- the name of an item

	Bif_returnfsancestors: INTEGER is 8
			-- Only return file system ancestors. If the user selects
			-- anything other than a file system ancestor, the OK button
			-- is grayed.

	Bif_returnonlyfsdirs: INTEGER is 1
			-- Only return file system directories. If the user selects
			-- folders that are not part of the file system, the OK button
			-- is grayed.

	Bif_statustext: INTEGER is 4
			-- Include a status area in the dialog box. The callback
			-- function can set the status text by sending messages to the
			-- dialog box.

	Bif_usenewui: INTEGER is 80
			-- Use the new user-interface. Setting this flag provides the
			-- user with a larger dialog box that can be resized. It has
			-- several new capabilities including: drag and drop capability
			-- within the dialog box, reordering, context menus, new folders,
			-- delete, and other context menu commands. To use this flag,
			-- you must call OleInitialize or CoInitialize before
			-- calling SHBrowseForFolder.
			-- IMPORTANT: to use, requires SHELL32.DLL version 5.00 or higher.
			-- See class WEL_WINDOWS_VERSION. Is not defined as external
			-- because it is not yet included in latest versions of "shlobj.h".

	Bif_validate: INTEGER is 32
			-- Requires Shell32.dll Version 4.71 or greater. If the user types an
			-- invalid name into the edit box, the browse dialog will call
			-- the application's BrowseCallbackProc with the
			-- BFFM_VALIDATEFAILED message. This flag is ignored if
			-- BIF_EDITBOX is not specified.

	Bif_newdialogstyle : INTEGER is 64
			-- Use the new dialog layout with the ability to resize
			-- Caller needs to call OleInitialize() before using this API
				
	Bif_nonewfolderbutton : INTEGER is 512;
			-- Do not add the "New Folder" button to the dialog.
			-- Only applicable with BIF_NEWDIALOGSTYLE.

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




end -- class WEL_BIF_CONSTANTS

