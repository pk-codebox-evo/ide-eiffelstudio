note
	component:   "openEHR Archetype Project"
	description: "cADL serialisers"
	keywords:    "test, ADL"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2003, 2004 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/BRANCHES/specialisation/libraries/common_libs/src/structures/data_tree/shared_dt_serialisers.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class SHARED_DT_SERIALISERS

feature -- Access

	dt_serialiser_formats: ARRAYED_LIST[STRING]
			-- list of format names
		once
			create Result.make(0)
			from
				dt_serialisers.start
			until
				dt_serialisers.off
			loop
				Result.extend(dt_serialisers.key_for_iteration)
				dt_serialisers.forth
			end
			Result.compare_objects
		end

	dt_serialiser_for_format (a_format: STRING): DT_SERIALISER
			-- get a specific ADL serialiser
		require
			Format_valid: a_format /= Void and then has_dt_serialiser_format(a_format)
		do
			Result := dt_serialisers.item(a_format)
		ensure
			Result_exists: Result /= Void
		end

feature -- Status Report

	has_dt_serialiser_format (a_format: STRING): BOOLEAN
			--
		require
			a_format /= Void
		do
			Result := dt_serialisers.has(a_format)
		end

feature {NONE} -- Implementation

	dt_serialisers: HASH_TABLE [DT_SERIALISER, STRING]
		once
			create Result.make(0)
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
--| The Original Code is shared_dadl_serialisers.e.
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
