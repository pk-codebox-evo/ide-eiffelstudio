note
	component:   "openEHR Support Information Model"

	description: "[
				 Model of ISO’s Object Identifier (oid) as defined by the standard 
				 ISO/IEC 8824 . Oids are formed from integers separated by dots. 
				 Each non-leaf node in an Oid starting from the left corresponds 
				 to an assigning authority, and identifies that authority’s namespace, 
				 inside which the remaining part of the identifier is locally unique.
				 ]"
	keywords:    "unique identifiers, OID"

	design:      "openEHR Support Information Model 1.5"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2006 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/BRANCHES/specialisation/libraries/openehr/src/rm/support/identification/iso_oid.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class ISO_OID

inherit
	UID

create
	default_create, make

feature -- Definitions

	Default_value: STRING = "1"
			-- ISO Oid

feature -- Status Report

	valid_id (an_id: STRING): BOOLEAN
			--
		do
		end

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
