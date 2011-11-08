note
	description: "Summary description for {EPA_SHARED_EQUALITY_TESTERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EPA_SHARED_EQUALITY_TESTERS

inherit
	EPA_TYPE_UTILITY

feature -- Equality tester

	equation_equality_tester: EPA_EQUATION_EQUALITY_TESTER
			-- Equality tester for equations
		once
			create Result
		end

	expression_equality_tester: EPA_EXPRESSION_EQUALITY_TESTER
			-- Equality tester for expressions
		once
			create Result
		end

	expression_value_equality_tester: EPA_EXPRESSION_VALUE_EQUALITY_TESTER
			-- Equality test for expression values
		once
			create Result
		end

	partial_expression_change_equality_tester: EPA_EXPRESSION_CHANGE_PARTIAL_EQUALITY_TESTER
			-- Partial equality tester for {EPA_EXPRESSION_CHANGE}
		once
			create Result
		end

	type_a_equality_tester: AGENT_BASED_EQUALITY_TESTER [TYPE_A]
			-- Equality tester for TYPE_A objects
		once
			create Result.make (agent (a_type, b_type: TYPE_A): BOOLEAN do Result := a_type.is_equivalent (b_type) end)
		end

	function_equality_tester: EPA_FUNCTION_EQUALITY_TESTER
			-- Equality tester for {CI_FUNCTION}
		once
			create Result
		end

	function_argument_value_map_equality_tester: EPA_FUNCTION_ARGUMENT_VALUE_MAP_EQUALITY_TESTER
			-- Equality tester for {EPA_FUNCTION_ARGUMENT_VALUE_MAP}
		once
			create Result
		end

	type_name_equality_tester: AGENT_BASED_EQUALITY_TESTER [TYPE_A]
			-- Equality tester for type names
		once
			create Result.make (
				agent (a_type: TYPE_A; b_type: TYPE_A): BOOLEAN
					do
						Result := output_type_name (a_type.name) ~ output_type_name (b_type.name)
					end)
		end

end
