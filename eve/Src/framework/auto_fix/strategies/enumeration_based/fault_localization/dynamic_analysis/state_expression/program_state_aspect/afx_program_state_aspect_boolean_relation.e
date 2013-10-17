note
	description: "Summary description for {AFX_PROGRAM_STATE_ASPECT_BOOLEAN_RELATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AFX_PROGRAM_STATE_ASPECT_BOOLEAN_RELATION

inherit
	AFX_PROGRAM_STATE_ASPECT

	AFX_BOOLEAN_RELATION_OPERATOR

create
	make_boolean_relation

feature{NONE} -- Initialization

	make_boolean_relation (a_context_class: CLASS_C; a_context_feature: FEATURE_I; a_written_class: CLASS_C;
					a_left_operand, a_right_operand: EPA_AST_EXPRESSION; a_boolean_operator: INTEGER)
			-- Initialization
		require
			context_attached: a_context_class /= Void and then a_context_feature /= Void and then a_written_class /= Void
			operands_type_correct: (a_left_operand /= VOid and then a_left_operand.is_boolean)
							and then (a_right_operand /= Void implies a_right_operand.is_boolean)
			operator_valid: is_valid_boolean_operator (a_boolean_operator)
		local
			l_exp_text: STRING
		do
			left_operand := a_left_operand
			right_operand := a_right_operand
			operator := a_boolean_operator

			create operand_expressions.make_equal (2)
			operand_expressions.force (left_operand)

			if a_boolean_operator = Operator_boolean_null then
				l_exp_text := a_left_operand.text
			elseif a_boolean_operator = Operator_boolean_negation then
				l_exp_text := boolean_operator_text (a_boolean_operator) + " (" + a_left_operand.text + ")"
			else
				l_exp_text := "(" + a_left_operand.text + ") " + boolean_operator_text (a_boolean_operator) + " (" + a_right_operand.text + ")"
				operand_expressions.force (right_operand)
			end

			make_with_text (a_context_class, a_context_feature, l_exp_text, a_written_class)
		end

feature -- Basic operation

	evaluate (a_state: EPA_STATE)
			-- <Precursor>
		local
			l_left_value, l_right_value: EPA_EXPRESSION_VALUE
		do
			if left_operand /= Void then
				if attached {AFX_PROGRAM_STATE_ASPECT} left_operand as lt_left_aspect then
					lt_left_aspect.evaluate (a_state)
					l_left_value :=lt_left_aspect.last_value
				elseif attached {EPA_EQUATION} a_state.item_with_expression_text (left_operand.text) as lt_left_equation then
					l_left_value := lt_left_equation.value
				end
			end
			if right_operand /= Void then
				if attached {AFX_PROGRAM_STATE_ASPECT} right_operand as lt_right_aspect then
					lt_right_aspect.evaluate (a_state)
					l_right_value := lt_right_aspect.last_value
				elseif attached {EPA_EQUATION} a_state.item_with_expression_text (right_operand.text) as lt_right_equation then
					l_right_value := lt_right_equation.value
				end
			end

			last_value := evaluate_boolean_relation (l_left_value, l_right_value, operator)
		end

	derived_change_requirements : DS_ARRAYED_LIST [AFX_STATE_CHANGE_REQUIREMENT]
			-- <Precursor>
		local
			l_requirements: DS_LINKED_LIST[TUPLE[expr1: EPA_AST_EXPRESSION; expr2: EPA_AST_EXPRESSION]]
			l_new_expr: EPA_AST_EXPRESSION
		do
				-- For the moment, the boolean expression takes the form of either an expression, or the negation of an expression.
			Result := change_requirements_for_one_boolean_expression (Current)
		end

feature -- Access

	left_operand: EPA_AST_EXPRESSION
			-- Expression appearing to the left of the operator.

	right_operand: EPA_AST_EXPRESSION
			-- Expression appearing to the right of the operator.

	operator: INTEGER
			-- Operator used to connect the two operands.

end
