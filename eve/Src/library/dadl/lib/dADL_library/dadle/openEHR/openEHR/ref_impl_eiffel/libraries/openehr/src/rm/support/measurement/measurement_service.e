note
	component:   "openEHR common definitions"
	
	description: "Simple measurement service interface definition"
	keywords:    "measurement, units"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2000-2004 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/BRANCHES/specialisation/libraries/openehr/src/rm/support/measurement/measurement_service.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class MEASUREMENT_SERVICE

feature -- Access

	units_for_property(a_property: CODE_PHRASE): ARRAYED_LIST[STRING]
			-- return list of units for this property
		require
			a_property /= Void and then has_property(a_property)
		do
			-- FIXME: to be implemented
			create Result.make(0)
			Result.extend ("m")
		end

feature -- Status Report

	has_property(a_property: CODE_PHRASE): BOOLEAN
			-- True if a_property known in property list
		require
			a_property /= Void
		do
			-- FIXME: to be implemented
			Result := True
		end
		
feature -- Comparison

	is_valid_units_string (units: STRING): BOOLEAN
			-- True if the units string �units� is a valid string according to the UCUM specification [8].
		require
			units /= Void 
		do
		end

	units_equivalent (units1, units2: STRING): BOOLEAN
			-- True if two units strings correspond to the same measured property.
		require
			units1 /= Void and then is_valid_units_string(units1)
			units2 /= Void and then is_valid_units_string(units2)	
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
--| The Original Code is terminology_service.e.
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
