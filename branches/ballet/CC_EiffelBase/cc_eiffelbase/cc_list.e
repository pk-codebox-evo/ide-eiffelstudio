indexing
	description: "Sequential lists, without commitment to a particular representation"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_LIST [G]

inherit
	-- TODO checken
	CC_SEQUENCE [G]
		select
			model_container,
			prune_all,
			put,
			extend
		end

	CC_INDEXABLE [G]
		rename
			model as model_indexable,
			prune_all as prune_all_indexable,
			valid_index as valid_index_indexable,
			item as i_th
		export
			{NONE}
				model_indexable,
				prune_all_indexable,
				valid_index_indexable
		end

end
