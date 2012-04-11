indexing
	component:   "openEHR Demographic Reference Model"

	description: "[
			 Address of contact, which may be electronic or geographic.
			 ]"
	keywords:    "demographic, address"

	requirements:"ISO 18308 TS V1.0 ???"
	design:      "openEHR Demographic Model 1.3.1"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2000-2004 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/openehr/src/rm/demographic/address.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class ADDRESS

inherit
	LOCATABLE

feature -- Access

	details: ITEM_STRUCTURE	
			-- The details of the address, in the form of a STRUCTURE. 
			-- This may take the form of a SINGLE_S, whose data item is a 
			-- parsable string or a list or tree of many parts.

	type: DV_TEXT is
			-- Type of address, e.g. �electronic�, �locality�. Taken from value of inherited name attribute.
		do
			Result := name.twin
		end

	as_string: STRING	
			-- Address in the form of a single string.

	path_of_item (a_loc: LOCATABLE): STRING is
			-- The path to an item relative to the root of this archetyped structure.
		do
		end

	item_at_path (a_path: STRING): LOCATABLE is
			-- The item at a path (relative to this item).
		do
		end

	parent: CONTACT
			-- parent node of this node in compositional structure
			
feature -- Status Report

	path_exists (a_path: STRING): BOOLEAN is
			-- True if the path is valid with respect to the current item.
		do
		end

invariant
	Type_valid: type.is_equal(name)
	Details_exists: details /= Void	

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
--| The Original Code is address.e.
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
