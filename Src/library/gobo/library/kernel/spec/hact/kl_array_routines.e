indexing

	description:

		"Routines that ought to be in class ARRAY"

	library:    "Gobo Eiffel Kernel Library"
	author:     "Eric Bezault <ericb@gobosoft.com>"
	copyright:  "Copyright (c) 1999, Eric Bezault and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

class KL_ARRAY_ROUTINES [G]

feature -- Initialization

	make_from_array (an_array: ARRAY [G]; min_index: INTEGER): ARRAY [G] is
			-- Create a new array and initialize it
			-- with items from `an_array'.
		require
			an_array_not_void: an_array /= Void
		do
			Result := subarray (an_array, an_array.lower, an_array.upper, min_index)
		ensure
			array_not_void: Result /= Void
			lower_set: Result.lower = min_index
			count_set: Result.count = an_array.count
--			same_items: forall i in Result.lower .. Result.upper,
--				Result.item (i) = an_array.item (i + an_array.lower - min_index)
		end

feature -- Status report

	has (an_array: ARRAY [G]; v: G): BOOLEAN is
			-- Does `v' appear in `an_array'?
		require
			an_array_not_void: an_array /= Void
		do
			Result := an_array.has (v)
		end

feature -- Access

	subarray (an_array: ARRAY [G]; start_pos, end_pos, min_index: INTEGER): ARRAY [G] is
			-- Array made up of items from `an_array' within
			-- bounds `start_pos' and `end_pos'
		require
			an_array_not_void: an_array /= Void
			start_pos_large_enough: start_pos >= an_array.lower
			end_pos_small_enough: end_pos <= an_array.upper
			valid_bounds: start_pos <= end_pos + 1
		do
			!! Result.make (min_index, min_index + end_pos - start_pos)
			subcopy (Result, an_array, start_pos, end_pos, min_index)
		ensure
			array_not_void: Result /= Void
			lower_set: Result.lower = min_index
			count_set: Result.count = end_pos - start_pos + 1
--			same_items: forall i in Result.lower .. Result.upper,
--				Result.item (i) = an_array.item (i + start_pos - min_index)
		end

feature -- Element change

	subcopy (an_array, other: ARRAY [G]; start_pos, end_pos, index_pos: INTEGER) is
			-- Copy items of `other' within bounds `start_pos' and `end_pos'
			-- to `an_array' starting at index `index_pos'.
		require
			an_array_not_void: an_array /= Void
			other_not_void: other /= Void
			not_same: an_array /= other
			start_pos_large_enough: start_pos >= other.lower
			end_pos_small_enough: end_pos <= other.upper
			valid_bounds: start_pos <= end_pos + 1
			index_pos_large_enough: index_pos >= an_array.lower
			enough_space: (an_array.upper - index_pos) >= (end_pos - start_pos)
		do
			if start_pos <= end_pos then
				an_array.subcopy (other, start_pos, end_pos, index_pos)
			end
		ensure
			-- copied: forall i in 0 .. (end_pos - start_pos),
			--     an_array.item (index_pos + i) = other.item (start_pos + i)
		end

feature -- Removal

	clear_all (an_array: ARRAY [G]) is
			-- Reset all items to default values.
		require
			an_array_not_void: an_array /= Void
		do
			an_array.clear_all
		ensure
			-- all_cleared: forall i in an_array.lower .. an_array.upper,
			--		an_array.item (i) = Void or else
			--		an_array.item (i) = an_array.item (i).default
		end

end -- class KL_ARRAY_ROUTINES
