note
	component:   "openEHR Archetype Project"
	description: "[
				 Comparator of two archetypes.
		         ]"
	keywords:    "archetype, comparison, constraint model"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2007 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/openehr/src/am/archetype/comparator/archetype_comparator.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class ARCHETYPE_COMPARATOR

create
	make

feature -- Initialisation

	make(a_reference_archetype, an_other_archetype: ARCHETYPE)
			-- create with two archetypes for comparison
		require
			Valid_reference_archetype: valid_reference_archetype(a_reference_archetype)
			An_other_archetype_valid: an_other_archetype /= Void
		do
			reference_archetype := a_reference_archetype
			other_archetype := an_other_archetype
		end

feature -- Access

	reference_archetype: ARCHETYPE
			-- reference archetype

	other_archetype: ARCHETYPE
			-- archetype being compared

feature -- Comparison

	is_specialised: BOOLEAN
			-- True if other_archetype is a legal specialisation of reference_archetype
		do
		end

	diff: ARCHETYPE_DIFF
			-- Generate a diff object from the two archetypes
		do
		ensure
			Result_exists: Result /= Void
		end

feature {NONE} -- Implementation

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
--| The Original Code is archetype_comparator.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2007
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
