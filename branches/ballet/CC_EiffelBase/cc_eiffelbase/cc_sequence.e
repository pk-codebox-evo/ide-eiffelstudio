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
	CC_ACTIVE [G]
		rename
			model as model_active
		export
			{NONE}
				model_active
		redefine
			prune_all
		end

feature -- Status report

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
			Result := not off
		end


	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		do
			Result := not off
		end

feature -- Element change

	force (v: G) is
			-- Add `v' to end.
		require
			extendible: extendible
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
	 		new_count: count = old count + 1
			item_inserted: has (v)
			model_updated: model.first |=| old model.first.extended (v)
			confined representation
		end

	append (s: CC_SEQUENCE [G]) is
			-- Append a copy of `s' which is another sequence.
		require
			argument_not_void: s /= Void
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
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
				put (l.item)
				l.forth
			end
		ensure
	 		new_count: count >= old count
	 		model_corresponds: model.first |=| old model.first.concatenated (s.model.first)
	 		confined representation
		end

	extend (v: G) is
			-- Add `v' to end.
		deferred
		ensure then
			new_count: count = old count + 1
		end


	put (v: G) is
			-- Add `v' to end.
		deferred
		ensure then
	 		new_count: count = old count + 1
		end

feature -- Removal

	prune (v: G) is
			-- Remove the first occurrence of `v' if any.
			-- If no such occurrence go `off'.
		do
			start
			search (v)
			if not exhausted then
				remove_item
			end
		end

	prune_all (v: G) is
			-- Remove all occurrences of `v'; go `off'.
		do
			from
				start
			until
				exhausted
			loop
				search (v)
				if not exhausted then
					remove_item
				end
			end
		end

invariant

	-- combine inherited models
	inherited_models_equal: model_active |=| model_container
	--models_equivalent: model_active.domain |=| model.first.range -- TODO underspecification and false...

end
