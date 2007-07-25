indexing
	description: "Cells containing an item"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

class
	CC_CELL [G]

inherit
	CC_ANY

create
	default_create,
	put

feature -- Access

	item: G
			-- Content of cell.

feature -- Element change

	put, replace (v: like item) is
			-- Make `v' the cell's `item'.
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		do
			item := v
		ensure
			item_inserted: item = v
			model_corresponds: model.contains (v)
			confined representation
		end

feature -- Model

	model: MML_BAG [G] is
			-- Model of a general cell
		use
			use_own_representation: representation
		do
			create {MML_DEFAULT_BAG [G]} Result.make_empty
			Result := Result.extended (item)
		ensure
			result_not_void: Result /= Void
		end

feature -- Framing

	representation: FRAME is
			-- Representation of a general cell
		use
			use_own_representation: representation
		do
			create Result.make_empty
			Result := Result.extended (Current)
			Result := Result.extended (item)
		ensure
			result_not_void: Result /= Void
		end

invariant

	model_contains_item: item /= Void implies model.contains (item)

end
