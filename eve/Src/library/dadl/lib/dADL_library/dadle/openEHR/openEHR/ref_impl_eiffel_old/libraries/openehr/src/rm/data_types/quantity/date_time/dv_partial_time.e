indexing
	component:   "openEHR Data Types"

	description: "Implementation of DV_PARTIAL_TIME"
	keywords:    "time"

	requirements:"ISO 18308 TS V1.0 STR 3.8"
	design:      "openEHR Data Types Reference Model 1.7"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2000-2004 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/openehr/src/rm/data_types/quantity/date_time/dv_partial_time.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class DV_PARTIAL_TIME

inherit
	DV_TIME
		redefine
			magnitude, as_string
		end

feature -- Access

	minute_known: BOOLEAN
			-- Indicates whether minute in hour is known. If so, the time 
			-- is of the form y/m/?, if not, it is of the form y/?/

	magnitude: DOUBLE is
		do
		ensure
			Result = enclosing_interval.midpoint.magnitude
		end

	enclosing_interval: DV_INTERVAL[DV_TIME] is
		do
		ensure
			minute_known implies Result.lower.second = 1 and Result.upper.second = seconds_in_minute
			not minute_known implies Result.lower.minute = 1 and Result.upper.minute = Minutes_in_hour and 
				Result.lower.second = 1 and Result.upper.second = seconds_in_minute
		end

feature -- Output

	as_string: STRING is
			-- Result has form �hh:mm:??� where mm, ss might be �??�	Result = follows ISO 8601
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
--| The Original Code is dv_partial_time.e.
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
