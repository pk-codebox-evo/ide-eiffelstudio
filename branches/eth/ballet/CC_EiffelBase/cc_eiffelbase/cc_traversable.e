indexing
	description: "[
		Finite structures for which there exists a traversal policy
		that will visit every element exactly once.
		]"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_TRAVERSABLE [G]

inherit
	CC_CONTAINER [G]
		rename
			model as model_container
		export
			{NONE}
				model_container
		end

feature -- Access

	item: G is
			-- Item at current position
		require
			not_off: not off
		use
			use_own_representation: representation
		deferred
		end

feature -- Status report

	off: BOOLEAN is
			-- Is there no current item?
			-- Either we are before or after the data structure.
		use
			use_own_representation: representation
		deferred
		ensure
			model_cursor_corresponds: Result = (model_cursor = 0) or (model_cursor = count + 1)
		end

feature -- Cursor movement

	start is
			-- Move to first position if any.
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		deferred
		ensure
			model_cursor_corresponds: not is_empty implies (model_cursor = 1)
			model_sequence_not_changed: model_sequence |=| old model_sequence
			confined representation
		end

feature -- Iteration

	do_all (action: PROCEDURE [ANY, TUPLE [G]]) is
			-- Apply `action' to every item.
			-- Semantics not guaranteed if `action' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
		require
			action_exists: action /= Void
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		do
			linear_representation.do_all (action)
		ensure
			confined representation
		end

	do_if (action: PROCEDURE [ANY, TUPLE [G]];
	 test: FUNCTION [ANY, TUPLE [G], BOOLEAN]) is
			-- Apply `action' to every item that satisfies `test'.
			-- Semantics not guaranteed if `action' or `test' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
		require
			action_exists: action /= Void
			test_exits: test /= Void
			-- test.is_pure
		use
			use_own_representation: representation
		modify
			modify_own_representation: representation
		do
			linear_representation.do_if (action, test)
		ensure
			confined representation
		end

	there_exists (test: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN is
			-- Is `test' true for at least one item?
		require
			test_exits: test /= Void
			-- test.is_pure
		use
			use_own_representation: representation
		do
			Result := linear_representation.there_exists (test)
		ensure
			model_corresponds: Result = model.first.there_exists (test)
			no_model_change: model |=| old model
		end

	for_all (test: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN is
			-- Is `test' true for all items?
		require
			test_exits: test /= Void
			-- test.is_pure
		use
			use_own_representation: representation
		do
			Result := linear_representation.for_all (test)
		ensure
			model_corresponds: Result = model.first.for_all (test)
			no_model_change: model |=| old model
		end

feature -- Model

	model_sequence: MML_SEQUENCE [G] is
			-- Model of a general traversable structure
		use
			use_own_representation: representation
		local
			linear: CC_LINEAR [G]
			old_cursor_position: INTEGER
		do
			create {MML_DEFAULT_SEQUENCE [G]} Result.make_empty
			linear := linear_representation
			old_cursor_position := linear.index

			from
				linear.start
			until
				linear.off
			loop
				Result := Result.extended (linear.item)
				linear.forth
			end

			linear.go_i_th (old_cursor_position)
		ensure
			result_not_void: Result /= Void
		end

	model_cursor: INTEGER is
			-- Model of a cursor for traversal
		use
			use_own_representation: representation
		deferred
		end

	model: MML_PAIR [MML_SEQUENCE [G], INTEGER] is
			-- Model of the traversable structure
		use
			use_own_representation: representation
		do
			create {MML_DEFAULT_PAIR [MML_SEQUENCE [G], INTEGER]} Result.make_from (model_sequence, model_cursor)
		ensure
			result_not_void: Result /= Void
		end

invariant

	empty_constraint: is_empty implies off
	cout_from_model_container_corresponds_to_model_sequence: model_container.count = model_sequence.count
	models_equivalent: model_sequence.range |=| model_container.domain

end
