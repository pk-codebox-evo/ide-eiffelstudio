note
	component:   "openEHR Archetype project"
	description: "[
				 Generic class defining an interval (i.e. range) of a comparable type, allowing half-ranges, i.e. with
				 -infinity as lower limit or +infinity as upper limit.
				 FIXME: should really be defined as INTERVAL[COMPARABLE] but DATE_TIME_DURATION (one of the types occurring
				 as a generic parameter of this type) is strangely only PART_COMPARABLE.
				 ]"
	keywords:    "intervals"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2000-2010 openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: https://svn.origo.ethz.ch/abel/trunk/libraries/openehr/src/basic/interval.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class INTERVAL [G -> PART_COMPARABLE]

inherit
	ANY
		redefine
			default_create
		end

	STRING_UTILITIES
		export
			{NONE} all
		undefine
			is_equal, default_create
		end

create
	default_create,
	make_bounded, make_bounded_included,
	make_lower_unbounded,
	make_upper_unbounded,
	make_unbounded,
	make_point,
	make

feature -- Initialization

	default_create
			-- Create satisfying the invariant.
		do
			lower_unbounded := True
			upper_unbounded := True
		ensure then
			unbounded: lower_unbounded and upper_unbounded
		end

	make_point (a_value: G)
			-- make with both limits set to the same value
		require
			Value_exists: a_value /= Void
		do
			lower := a_value
			upper := a_value
			lower_included := True
			upper_included := True
		ensure
			Lower_set: lower = a_value
			Upper_set: upper = a_value
			lower_included_set: lower_included
			upper_included_set: upper_included
			Is_point: is_point
		end

	make_bounded (a_lower, an_upper: G; lower_included_flag, upper_included_flag: BOOLEAN)
			-- make with both limits set
		require
			Lower_exists: a_lower /= Void
			Upper_exists: an_upper /= Void
			Valid_order: a_lower <= an_upper
		do
			lower := a_lower
			upper := an_upper
			lower_included := lower_included_flag
			upper_included := upper_included_flag
		ensure
			Lower_set: lower = a_lower
			Upper_set: upper = an_upper
			lower_included_set: lower_included = lower_included_flag
			upper_included_set: upper_included = upper_included_flag
		end

	make_bounded_included (a_lower, an_upper: G)
			-- make with both limits set and included, the most typical situation
		require
			Lower_exists: a_lower /= Void
			Upper_exists: an_upper /= Void
			Valid_order: a_lower <= an_upper
		do
			lower := a_lower
			upper := an_upper
			lower_included := True
			upper_included := True
		ensure
			Lower_set: lower = a_lower
			Upper_set: upper = an_upper
			lower_included_set: lower_included
			upper_included_set: upper_included
		end

	make_lower_unbounded (an_upper: G; upper_included_flag: BOOLEAN)
			-- make an interval from -infinity to `an_upper'
		require
			Upper_exists: an_upper /= Void
		do
			upper := an_upper
			lower_unbounded := True
			upper_included := upper_included_flag
		ensure
			Lower_unbounded: lower_unbounded
			Upper_set: upper = an_upper
			upper_included_set: upper_included = upper_included_flag
		end

	make_upper_unbounded (a_lower: G; lower_included_flag: BOOLEAN)
			-- make an interval from `a_lower' to +infinity
		require
			Lower_exists: a_lower /= Void
		do
			lower := a_lower
			upper_unbounded := True
			lower_included := lower_included_flag
		ensure
			Lower_set: lower = a_lower
			Upper_unbounded: upper_unbounded
			lower_included_set: lower_included = lower_included_flag
		end

	make_unbounded
			-- make an interval from -infinity to +infinity, usually
			-- only sensible as the result of two half-intervals
		do
			lower_unbounded := True
			upper_unbounded := True
		ensure
			Lower_unbounded: lower_unbounded
			Upper_unbounded: upper_unbounded
		end

	make (a_lower, an_upper: G; a_lower_unbounded, an_upper_unbounded, a_lower_included, an_upper_included: BOOLEAN)
			-- make from parts of another interval
		do
			lower := a_lower
			upper := an_upper
			lower_unbounded := a_lower_unbounded
			upper_unbounded := an_upper_unbounded
			lower_included := a_lower_included
			upper_included := an_upper_included
		ensure
			Lower_set: lower = a_lower
			Upper_set: upper = an_upper
			Lower_unbounded_set: lower_unbounded = a_lower_unbounded
			Upper_unbounded_set: upper_unbounded = an_upper_unbounded
			lower_included_set: lower_included = a_lower_included
			upper_included_set: upper_included = an_upper_included
		end

feature -- Access

	lower: G
			-- lower limit of interval

	upper: G
			-- upper limit of interval

	midpoint: G
			-- generate midpoint of limits
		do

		end

feature -- Status report

	lower_unbounded: BOOLEAN
			-- True if lower limit open, i.e. -infinity

	upper_unbounded: BOOLEAN
			-- True if upper limit open, i.e. +infinity

	lower_included: BOOLEAN
			-- True if lower limit point included in interval

	upper_included: BOOLEAN
			-- True if upper limit point included in interval

	is_point: BOOLEAN
			-- Is current interval a point (width = 0)?
		do
			Result := not (lower_unbounded or upper_unbounded) and
						lower_included and upper_included and lower.is_equal (upper)
		ensure
			Result = (not (lower_unbounded or upper_unbounded) and
				lower_included and upper_included and lower.is_equal (upper))
		end

	unbounded: BOOLEAN
			-- True if interval is completely open
		do
			Result := lower_unbounded and upper_unbounded
		end

feature -- Comparison

	has (v: G): BOOLEAN
			-- Does current interval have `v' between its bounds?
		require
			exists: v /= Void
		do
			Result := (lower_unbounded or ((lower_included and v >= lower) or v > lower)) and
			(upper_unbounded or ((upper_included and v <= upper or v < upper)))
		-- FIXME: this post-condition fails
		-- ensure
		--	result_definition: Result = (lower_unbounded or ((lower_included and v >= lower) or v > lower)) and
		--	(upper_unbounded or ((upper_included and v <= upper or v < upper)))
		end

	intersects (other: like Current): BOOLEAN
			-- True if there is any overlap between intervals represented by Current and other
		require
			exists: other /= Void
		do
			Result := unbounded or other.unbounded or
				(lower_unbounded and (other.lower_unbounded or upper >= other.lower)) or
				(upper_unbounded and (other.upper_unbounded or lower <= other.upper)) or
				(upper >= other.lower or lower <= other.upper)
		end

	contains (other: like Current): BOOLEAN
			-- Does current interval properly contain `other'? True if at least one limit of other
			-- is stricly inside the limits of this interval
		require
			Other_exists: other /= void
		do
			if other.lower_unbounded then
				if other.upper_unbounded then
					Result := lower_unbounded and upper_unbounded
				else
					Result := lower_unbounded and other.upper < upper
				end
			elseif other.upper_unbounded then
				Result := upper_unbounded and lower < other.lower
			elseif lower_unbounded then
				if upper_unbounded then
					Result := True
				else
					Result := other.upper <= upper
				end
			elseif upper_unbounded then
				Result := lower <= other.lower
			else
				if lower = other.lower then
					Result := other.upper < upper
				elseif upper = other.upper then
					Result := lower < other.lower
				else
					Result :=  lower < other.lower and other.upper < upper
				end
			end
		end

	equal_interval (other: like Current): BOOLEAN
			-- compare two intervals, allows subtypes like MULTIPLICITY_INTERVAL to be compared
		require
			other_attached: other /= Void
		do
			if lower_unbounded then
				Result := other.lower_unbounded
			else
				Result := not other.lower_unbounded and
						((lower_included = other.lower_included) and lower.is_equal(other.lower))
			end

			if Result then
				if upper_unbounded then
					Result := other.upper_unbounded
				else
					Result := not other.upper_unbounded and
					((upper_included = other.upper_included) and upper.is_equal(other.upper))
				end
			end
		end

	limits_equal: BOOLEAN
			-- true if limits bounded and equal
		do
			Result := not (lower_unbounded or upper_unbounded) and (lower.is_equal(upper))
		end

feature -- Output

	as_string: STRING
		do
			create Result.make(0)
			if lower_unbounded then
				if upper_included then
					Result.append("<=" + atomic_value_to_string(upper))
				else
					Result.append("<" + atomic_value_to_string(upper))
				end
			elseif upper_unbounded then
				if lower_included then
					Result.append(">=" + atomic_value_to_string(lower))
				else
					Result.append(">" + atomic_value_to_string(lower))
				end
			elseif not limits_equal then
				if lower_included and upper_included then
					Result.append(atomic_value_to_string(lower) + ".." + atomic_value_to_string(upper))
				elseif lower_included then
					Result.append(atomic_value_to_string(lower) + "..<" + atomic_value_to_string(upper))
				elseif upper_included then
					Result.append(">" + atomic_value_to_string(lower) + ".." + atomic_value_to_string(upper))
				else
					Result.append(">" + atomic_value_to_string(lower) + "..<" + atomic_value_to_string(upper))
				end
			else
				Result.append(atomic_value_to_string(lower))
			end
		end

invariant
	lower_attached_if_bounded: not lower_unbounded implies lower /= Void
	upper_attached_if_bounded: not upper_unbounded implies upper /= Void
	limits_consistent: not (upper_unbounded or lower_unbounded) implies lower <= upper

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
--| The Original Code is interval.e.
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
