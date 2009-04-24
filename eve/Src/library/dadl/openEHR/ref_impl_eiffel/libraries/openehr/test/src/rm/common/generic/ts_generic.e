indexing
	component:   "openEHR Common Reference Model"

	description: "Generic test suite"
	keywords:    "test, participation, attestation"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2000-2004 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/openehr/test/src/rm/common/generic/ts_generic.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class TS_COMMON_GENERIC

inherit 
	TEST_SUITE

creation
	make

feature -- Access

	test_cases: LINKED_LIST[TEST_CASE] is
		local
			tc:TEST_CASE
		once
			create Result.make
			create {TC_PARTICIPATION} tc.make(Void) 		Result.extend(tc)
			create {TC_ATTESTATION} tc.make(Void) 		Result.extend(tc)
			create {TC_PARTY_SELF} tc.make(Void) 		Result.extend(tc)
			create {TC_PARTY_IDENTIFIED} tc.make(Void) 		Result.extend(tc)
			create {TC_PARTY_RELATED} tc.make(Void) 		Result.extend(tc)
			create {TC_REVISION_HISTORY} tc.make(Void) 		Result.extend(tc)
			create {TC_AUDIT_DETAILS} tc.make(Void) 		Result.extend(tc)
		end

	title:STRING is "Generic Package tests"

feature -- Initialisation

	make(arg:ANY) is
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
--| The Original Code is ts_generic.e.
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
