indexing

	component:   "openEHR Common Archetype Model"
	
	description: "Constrainer type for instances of DATE"
	keywords:    "archetype, date, data"
	
	design:      "openEHR Common Archetype Model 0.2"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2000-2004 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/openehr/src/am/archetype/constraint_model/primitive/c_date.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class C_DATE

inherit
	C_PRIMITIVE

	ADL_DEFINITIONS
		export
			{NONE} all
		undefine
			out
		end

	DATE_TIME_ROUTINES
		export
			{NONE} all;
			{ANY} valid_iso8601_date_constraint_pattern, valid_iso8601_date, iso8601_string_to_date
		undefine
			out
		end

create
	make_interval, make_string_interval, make_from_pattern

feature -- Initialisation
	
	make_interval(an_interval: INTERVAL[ISO8601_DATE]) is
		require
			Interval_exists: an_interval /= Void
		do
			interval := an_interval
		ensure
			interval = an_interval
		end

	make_string_interval(a_lower, an_upper: STRING) is
			-- make from two iso8601 strings. Either but not both may be Void, indicating an 
			-- open-ended interval; they may also be the same, meaning a single point. 
			-- Limits are automatically included in the range
		require
			valid_interval: a_lower /= Void or an_upper /= Void
			lower_exists: a_lower /= void implies valid_iso8601_date(a_lower)
			upper_exists: an_upper /= void implies valid_iso8601_date(an_upper)
			valid_order: (a_lower /= Void and an_upper /= Void) implies 
						(iso8601_string_to_date(a_lower) <= iso8601_string_to_date(an_upper))
		do
			if a_lower = Void then
				create interval.make_lower_unbounded(create {ISO8601_DATE}.make_from_string(an_upper), True)			
			else
				if an_upper = Void then
					create interval.make_upper_unbounded(create {ISO8601_DATE}.make_from_string(a_lower), True)
				else
					create interval.make_bounded(create {ISO8601_DATE}.make_from_string(a_lower), 
						create {ISO8601_DATE}.make_from_string(an_upper), True, True)
				end
			end
		end

	make_from_pattern(a_pattern: STRING) is
			-- create Result from an ISO8601-based pattern like "yyyy-mm-XX"
			-- allowed patterns:
			--	"yyyy-mm-dd" - full date required
			--	"yyyy-mm-??" - day optional
			--	"yyyy-??-??" - any date ok
			-- 	"yyyy-??-XX" - day not allowed
			-- 	"yyyy-XX-XX" - month and day not allowed
		require
			a_pattern_valid: a_pattern /= Void and then valid_iso8601_date_constraint_pattern(a_pattern)
		do
			pattern := a_pattern
		ensure
			pattern_set: pattern = a_pattern
		end
		
feature -- Access

	interval: INTERVAL[ISO8601_DATE]

	pattern: STRING
			-- ISO8601-based pattern like "yyyy-mm-??"

	default_value: ISO8601_DATE is
		do
			if interval /= Void then
				Result := interval.lower
			else
				-- Result := FIXME - generate a default from a pattern
			end
		end
	
feature -- Status Report

	valid_value (a_value: ISO8601_DATE): BOOLEAN is 
		do
			if interval /= Void then
				Result := interval.has(a_value)
			else
				-- Result := a_value matches pattern FIXME - to be implemented
				Result := True
			end
		end

feature -- Output

	as_string: STRING is
		do
			create Result.make(0)
			if interval /= Void then
				Result.append("|" + interval.as_string + "|")
			else
				Result.append(pattern)
			end
			if assumed_value /= Void then
				Result.append("; " + assumed_value.out)
			end
		end

invariant
	Validity: interval /= Void xor pattern /= Void

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
--| The Original Code is c_date.e.
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
