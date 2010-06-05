indexing
	component:   "openEHR Archetype Project"
	description: "Representation of an archetype repository in some medium."
	keywords:    "ADL"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2007 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/components/archetype_repository/src/directory/archetype_repository_i.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

deferred class
	ARCHETYPE_REPOSITORY_I

inherit
	SHARED_APPLICATION_CONTEXT
		export
			{NONE} all
			{ANY} current_language, set_current_language
		end

	ARCHETYPE_DEFINITIONS
		export
			{NONE} all
		end

feature -- Access

	text: STRING
			-- Contents of the last opened archetype file.
		deferred
		end

	text_timestamp: INTEGER
			-- Modification time of last opened file as an integer, for comparison purposes.
		deferred
		end

	group_id: INTEGER
			-- Id of the group to which this repository belongs.

	first_line (full_path: STRING): STRING
			-- return the first line of the file at `full_path' (up to LF or end of file)
			-- or Void if the file is empty
		require
			path_valid: is_valid_path (full_path)
		deferred
		ensure
			Result_exists: Result /= Void
		end

feature -- Status Report

	is_valid_path (path: STRING): BOOLEAN
			-- Is `path' a valid, existing file on the repository medium?
		deferred
		ensure
			false_if_void: Result implies path /= Void
		end

	is_valid_directory (path: STRING): BOOLEAN
			-- Is `path' a valid, existing directory on the repository medium?
		deferred
		ensure
			false_if_void: Result implies path /= Void
		end

	is_valid_directory_part (path: STRING): BOOLEAN
			-- Is the directory part of `path' valid on the repository medium?
		deferred
		ensure
			false_if_void: Result implies path /= Void
		end

	has_file_changed_on_disk (a_path: STRING; a_timestamp: INTEGER): BOOLEAN
			-- Has the loaded archetype designated by `path' changed on disk since last read?
		require
			path_valid: a_path /= Void and then not a_path.is_empty
		deferred
		end

feature -- Commands

	read_text_from_file (full_path: STRING)
			-- Read `text' and `text_timestamp' from the file designated by `full_path' on the repository medium.
		require
			path_valid: is_valid_directory_part (full_path)
		deferred
		ensure
			text_attached: text /= Void
		end

	save_text_to_file (full_path, a_text: STRING)
			-- Save `a_text' to the file designated by `full_path' on the repository medium.
		require
			path_valid: is_valid_directory_part (full_path)
			text_valid: a_text /= Void and then not a_text.is_empty
		deferred
		end

invariant
	timestamp_natural: text_timestamp >= 0
	group_id_valid: group_id > 0

end


--|
--| ***** BEGIN LICENSE BLOCK *****
--| Version: MPL 1.1/GPL 2.0/LGPL 2.1
--|
--| The contents of this file are subject to the Mozilla Public License Version
--| 1.1 (the 'License'); you may not use this file except in compliance with
--| the License. You may obtain a copy of the License at
--| http://www.mozilla.org/MPL/
--|
--| Software distributed under the License is distributed on an 'AS IS' basis,
--| WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
--| for the specific language governing rights and limitations under the
--| License.
--|
--| The Original Code is adl_node_control.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2003-2004
--| the Initial Developer. All Rights Reserved.
--|
--| Contributor(s):
--|
--| Alternatively, the contents of this file may be used under the terms of
--| either the GNU General Public License Version 2 or later (the 'GPL'), or
--| the GNU Lesser General Public License Version 2.1 or later (the 'LGPL'),
--| in which case the provisions of the GPL or the LGPL are applicable instead
--| of those above. If you wish to allow use of your version of this file only
--| under the terms of either the GPL or the LGPL, and not to allow others to
--| use your version of this file under the terms of the MPL, indicate your
--| decision by deleting the provisions above and replace them with the notice
--| and other provisions required by the GPL or the LGPL. If you do not delete
--| the provisions above, a recipient may use your version of this file under
--| the terms of any one of the MPL, the GPL or the LGPL.
--|
--| ***** END LICENSE BLOCK *****
--|
