note
	description: "Summary description for {AFX_STATE_ITEM_VALUE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AFX_PREDICATE

inherit
	HASHABLE

create
	make

feature{NONE} -- Initialization

	make (a_expr: like expression; a_value: like value)
			-- Initialize Current.
		do
			set_state_item (a_expr)
			set_value (a_value)
		ensure
			state_item_set: expression = a_expr
			value_set: value = a_value
		end

feature -- Access

	expression: AFX_EXPRESSION
			-- State item whose value is stored in Current

	value: DUMP_VALUE
			-- Value

	type: detachable TYPE_A
			-- Type of `value'
			-- If `has_error', return Void.
		do
			if not has_error then
				Result := value.dynamic_class.actual_type
			end
		end

feature -- Status report

	has_error: BOOLEAN
			-- Was there an error when `expression' was evaluated?
			-- If True, `value' is not defined.
		do

		end

feature -- Access

	hash_code: INTEGER
			-- Hash code value
		do
			Result := expression.hash_code
		ensure then
			good_result: Result = expression.hash_code
		end

feature -- Setting

	set_state_item (a_state: like expression)
			-- Set `expression' with `a_state'.
		do
			expression := a_state
		ensure
			state_item_set: expression = a_state
		end

	set_value (a_value: like value)
			-- Set `value' with `a_value'.
		do
			value := a_value
		ensure
			value_set: value = a_value
		end

end
