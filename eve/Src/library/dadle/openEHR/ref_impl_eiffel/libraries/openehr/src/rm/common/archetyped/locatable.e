indexing
	component:   "openEHR Common Reference Model"
	description: "[
				 Root class of all information model classes that can be archetyped.
			     ]"
	keywords:    "locator, locatable"

	design:      "openEHR Common Reference Model"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2000-2007 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/openehr/src/rm/common/archetyped/locatable.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

deferred class LOCATABLE

inherit
	LOCATOR_CONSTANTS
	PATHABLE

feature -- Access
	
	uid: OBJECT_ID
			-- globally unique id for root objects of archetyped structures

	name: DV_TEXT
			-- name of this item in structure; forms an element of runtime path 

	archetype_node_id: STRING
			-- `node_id' from archetype; constitutes the path element from the 
			-- archetype structure, used for re-attaching content to archetypes, 
			-- as well as in querying

	links: SET [LINK]
			-- relationships to other items of any kind

	archetype_details: ARCHETYPED
			-- archetype details if this is an archetype root point

	feeder_audit: FEEDER_AUDIT	
			-- Audit trail from non-openEHR system of original commit of 
			-- information forming the content of the current item.

feature -- Status Report

	is_archetype_root: BOOLEAN is
			-- True if root point of an archetyped structure
		do
			Result := archetype_details /= Void
		end

invariant
	Name_exists: name /= Void
	Archetype_node_id_valid: archetype_node_id /= Void and then not archetype_node_id.is_empty
	Archetyped_validity: archetype_details = Void xor is_archetype_root
	Links_valid: links /= Void implies not links.is_empty

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
--| The Original Code is locatable.e.
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
