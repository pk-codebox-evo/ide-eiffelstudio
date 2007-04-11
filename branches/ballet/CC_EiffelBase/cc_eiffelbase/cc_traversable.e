indexing
	description: "[
		Structures for which there exists a traversal policy
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
			model as container_model
		end

feature -- Access

	item: G is
			-- Item at current position
		require
			not_off: not off
		use
			use_own_repr: repr
		deferred
		end

feature -- Status report

	off: BOOLEAN is
			-- Is there no current item?
		use
			use_own_repr: repr
		deferred
		end

feature -- Cursor movement

	start is
			-- Move to first position if any.
		modify
			modify_own_repr: repr
		deferred
		end

feature -- Iteration

	do_all (action: PROCEDURE [ANY, TUPLE [G]]) is
			-- Apply `action' to every item.
			-- Semantics not guaranteed if `action' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
		require
			action_exists: action /= Void
		modify
			modify_own_repr:
		do
			linear_representation.do_all (action)
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
		modify
			modify_own_repr: repr
		do
			linear_representation.do_if (action, test)
		end

	there_exists (test: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN is
			-- Is `test' true for at least one item?
		require
			test_exits: test /= Void
			-- test.is_pure
		use
			use_own_repr: repr
		do
			Result := linear_representation.there_exists (test)
		end

	for_all (test: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN is
			-- Is `test' true for all items?
		require
			test_exits: test /= Void
			-- test.is_pure
		use
			use_own_repr: repr
		do
			Result := linear_representation.for_all (test)
		end

feature -- Model
-- TODO hier schon implementierung oder erst deferred???
	model_sequence: MML_SEQUENCE [G] is
			-- Model of a general traversable structure
		modify
			modify_own_repr: repr
		deferred
		end

	model_cursor: INTEGER is
			-- Model of a cursor for traversal
		modify
			modify_own_repr: repr
		deferred
		end

	model: MML_PAIR [MML_SEQUENCE [G], INTEGER] is
			-- Model of the traversable structure
		modify
			modify_own_repr: repr
		deferred
		end

feature -- Framing

	repr: FRAME is
			-- Representation of a general traversable structure
		use
			use_own_repr: repr
		deferred
		end

invariant

	empty_constraint: is_empty implies off
	empty_defined_through_model: is_empty = container_model.is_empty

end
