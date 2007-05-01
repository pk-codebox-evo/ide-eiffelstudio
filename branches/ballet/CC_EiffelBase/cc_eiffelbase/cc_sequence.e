indexing
	description: "[
		Finite sequences: structures where existing items are arranged
		and accessed sequentially, and new ones can be added at the end.
		]"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_SEQUENCE [G]

inherit
	CC_BILINEAR [G]
		select
			model_container
		end

-- TODO probleme mit repeated inheritance - select clause nötig. korrekt so? unschön? wtf?
	CC_COLLECTION [G]
		rename
			model as model_collection
		export
			{NONE}
				model_collection
		redefine
			prune_all
		end

feature -- Status report

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		use
			use_own_representation: representation
		do
			Result := not off
		end


	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		use
			use_own_representation: representation
		do
			Result := not off
		end

feature -- Element change

	force (v: like item) is
			-- Add `v' to end.
		require
--			extendible: extendible
		modify
			modify_own_representation: representation
		do
--			extend (v)
		ensure
	 		new_count: count = old count + 1
			item_inserted: has (v)
		end

	append (s: SEQUENCE [G]) is
			-- Append a copy of `s'.
		require
			argument_not_void: s /= Void
		local
			l: like s
		do
			if s = Current then
				l := s.twin
			else
				l := s
			end
			from
				l.start
			until
				l.exhausted
			loop
--				extend (l.item)
				l.forth
			end
		ensure
	 		new_count: count >= old count
		end

	put (v: like item) is
			-- Add `v' to end.
		do
--			extend (v)
		ensure then
	 		new_count: count = old count + 1
		end

feature -- Removal

	prune (v: like item) is
			-- Remove the first occurrence of `v' if any.
			-- If no such occurrence go `off'.
		do
			start
			search (v)
			if not exhausted then
--				remove
			end
		end

	prune_all (v: like item) is
			-- Remove all occurrences of `v'; go `off'.
		do
			from
				start
			until
				exhausted
			loop
				search (v)
				if not exhausted then
--					remove
				end
			end
		end

invariant

end
