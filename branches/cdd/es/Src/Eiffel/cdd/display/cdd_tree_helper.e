indexing
	description: "Objects that support displaying test cases in tree structures"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_TREE_HELPER


feature -- Access

	i_th alias "[]" (an_index: INTEGER): EV_TREE_NODE is
			--
		deferred
		end


	i_th_cdd_item (an_index: INTEGER): CDD_TREE_ITEM is
			--
		do
			Result ?= i_th (an_index)
		end

	last_located_item: CDD_TREE_ITEM


feature -- Measurement

	count: INTEGER is
			--
		deferred
		end


feature -- Status report

	after: BOOLEAN is
			-- Is there no valid cursor position to the right of cursor?
		deferred
		end


feature -- Status setting

feature -- Cursor movement


	go_i_th (an_index: INTEGER) is
			-- Move to 'i'-th position.
		deferred
		end


feature -- Element change

	put_right (an_item: EV_TREE_NODE) is
			--
		deferred
		end


feature -- Removal

feature -- Resizing

feature -- Transformation

	locate_item (some_data: like data_type) is
			--
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
			--
		deferred
		end

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	data_type: COMPARABLE
			-- Type anchor

invariant
	invariant_clause: True -- Your invariant here

end
