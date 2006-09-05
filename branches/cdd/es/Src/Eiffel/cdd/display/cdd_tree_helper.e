indexing
	description: "Objects that support displaying test cases in tree structures"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_TREE_HELPER


feature -- Access

	i_th alias "[]" (i: INTEGER): EV_TREE_NODE is
			-- Item at 'i'-th position
		require
			within_bounds: i > 0 and i <= count
		deferred
		ensure
			not_void: Result /= Void
		end

	i_th_cdd_item (i: INTEGER): CDD_TREE_ITEM is
			-- CDD_TREE_ITEM at 'i'-th position
		require
			within_bounds: i > 0 and i <= count
		do
			Result ?= i_th (i)
		ensure
			not_void: Result /= Void
		end

	last_located_item: like item_type
			-- last item set by 'locate_item'

feature -- Measurement

	count: INTEGER is
			-- Number of items
		deferred
		end

feature -- Status report

	after: BOOLEAN is
			-- Is there no valid cursor position to the right of cursor?
		deferred
		end

feature -- Cursor movement

	go_i_th (an_index: INTEGER) is
			-- Move to 'i'-th position.
		deferred
		end


feature -- Element change

	put_right (an_item: EV_TREE_NODE) is
			-- Add `an_item' to the right of cursor position. Do not move cursor.
		deferred
		ensure
			count_increased: count = old count + 1
		end

feature -- Transformation

	locate_item (some_data: like data_type) is
			-- Find item where data is equal to 'some_data'. If item is not
			-- found, add it at the correct position. Let last_located_item
			-- point to appropriate item.
		local
			i: INTEGER
			l_found: BOOLEAN
			l_item: CDD_TREE_ITEM
		do
			from
				last_located_item := Void
				i := 1
			until
				i > count or l_found or last_located_item /= Void
			loop
				l_item := i_th_cdd_item (i)
				if l_item.data.is_equal (some_data) then
					last_located_item := l_item
				elseif some_data < l_item.data then
					l_found := True
				else
					i := i + 1
				end
			end
			if last_located_item = Void then
				last_located_item := new_item (some_data)
				go_i_th (i-1)
				put_right (last_located_item)
			end
		ensure
			last_located_item_not_void: last_located_item /= Void
			last_located_item_valid: last_located_item.data = some_data
		end

	new_item (some_data: like data_type): CDD_TREE_ITEM is
			-- Create new item with data set to 'some_data'.
		require
			some_data_not_void: some_data /= Void
		deferred
		ensure
			not_void: Result /= Void
			data_set: Result.data = some_data
		end

feature {NONE} -- Implementation

	item_type: CDD_TREE_ITEM
			-- Type anchor

	data_type: COMPARABLE
			-- Type anchor

invariant
	invariant_clause: True -- Your invariant here

end
