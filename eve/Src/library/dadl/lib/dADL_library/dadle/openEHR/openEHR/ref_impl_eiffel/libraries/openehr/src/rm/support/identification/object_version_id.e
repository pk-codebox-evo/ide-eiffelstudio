note
	component:   "openEHR Common Reference Model"

	description: "[
			 Globally uniqie identifier of a Version within a version
			 container. Supports distributed version control.
			 ]"
	keywords:    "object identifiers"

	design:      "openEHR Support Information Model 1.5"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2006 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/BRANCHES/specialisation/libraries/openehr/src/rm/support/identification/object_version_id.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class OBJECT_VERSION_ID

inherit
	UID_BASED_ID

feature -- Access

	object_id: UID
			-- Unique identifier for logical object of which this identifier identifies one version;
			-- normally the object_id will be the unique identifier of the version container containing
			-- the version referred to by this OBJECT_VERSION_ID instance.
		do
			Result := root
		end

	version_tree_id: VERSION_TREE_ID
			-- tree identifier of this version with respect to other versions in the same version tree,
			-- as either 1 or 3 part dot-separated numbers, e.g. “1”, “2.1.4”.
		local
			sep_pos1, sep_pos2: INTEGER
		do
			sep_pos1 := value.substring_index(Extension_separator, 1) + Extension_separator.count
			sep_pos2 := value.substring_index(Extension_separator, sep_pos1) - 1
			create Result.make(value.substring(sep_pos1, sep_pos2))
		end

	creating_system_id: UID
			-- Identifier of the system that created the Version corresponding to this Object version id.
		do
		end

feature -- Status Report

	valid_id (an_id: STRING): BOOLEAN
			--
		do
		end

invariant
	Object_valid: object_id /= Void
	Version_tree_id: version_tree_id /= Void
	creating_system_id: creating_system_id /= Void

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
--| The Original Code is object_id.e.
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
