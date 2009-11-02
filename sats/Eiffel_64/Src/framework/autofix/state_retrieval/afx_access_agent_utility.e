note
	description: "Summary description for {AFX_ACCESS_UTILITY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AFX_ACCESS_AGENT_UTILITY

inherit
	AUT_AGENT_UTILITY [AFX_ACCESS]

	SHARED_WORKBENCH

feature -- Expression veto agents

	result_expression_veto_agent: FUNCTION [ANY, TUPLE [AFX_ACCESS], BOOLEAN]
			-- An agent to select result access
		do
			Result :=
				agent (a_access: AFX_ACCESS): BOOLEAN
					do
						Result := a_access.is_result
					end
		end

	current_expression_veto_agent: FUNCTION [ANY, TUPLE [AFX_ACCESS], BOOLEAN]
			-- An agent to select current access
		do
			Result :=
				agent (a_access: AFX_ACCESS): BOOLEAN
					do
						Result := a_access.is_current
					end
		end

	argument_expression_veto_agent: FUNCTION [ANY, TUPLE [AFX_ACCESS], BOOLEAN]
			-- An agent to select argument access
		do
			Result :=
				agent (a_access: AFX_ACCESS): BOOLEAN
					do
						Result := a_access.is_argument
					end
		end

	local_expression_veto_agent: FUNCTION [ANY, TUPLE [AFX_ACCESS], BOOLEAN]
			-- An agent to select local access
		do
			Result :=
				agent (a_access: AFX_ACCESS): BOOLEAN
					do
						Result := a_access.is_local
					end
		end

	feature_expression_veto_agent: FUNCTION [ANY, TUPLE [AFX_ACCESS], BOOLEAN]
			-- An agent to select feature access
		do
			Result :=
				agent (a_access: AFX_ACCESS): BOOLEAN
					do
						Result := a_access.is_feature
					end
		end

	feature_with_few_arguments_veto_agent (a_arg_count: INTEGER): FUNCTION [ANY, TUPLE [AFX_ACCESS], BOOLEAN]
			-- An agent to select feature access
		do
			Result :=
				agent (a_access: AFX_ACCESS; a_args: INTEGER): BOOLEAN
					do
						Result := True
						if a_access.is_feature then
							if attached {AFX_ACCESS_FEATURE} a_access as l_feat then
								Result := l_feat.feature_.argument_count <= a_args
							end
						end
					end (?, a_arg_count)
		end

	feature_not_from_any_veto_agent: FUNCTION [ANY, TUPLE [AFX_ACCESS], BOOLEAN]
			-- An agent to select feature not from class ANY
		do
			Result :=
				agent (a_access: AFX_ACCESS): BOOLEAN
					do
						Result := True
						if attached {AFX_ACCESS_FEATURE} a_access as l_feat then
							Result := l_feat.feature_.written_class.class_id /= system.any_class.compiled_representation.class_id
						end
					end
		end

	nested_not_on_basic_veto_agent: FUNCTION [ANY, TUPLE [AFX_ACCESS], BOOLEAN]
			-- An agent to select nested access, but not on basic types.
		do
			Result :=
				agent (a_access: AFX_ACCESS): BOOLEAN
					do
						Result := True
						if attached {AFX_ACCESS_NESTED} a_access as l_nested then
							Result := not l_nested.left.type.is_basic
						end
					end
		end

	integer_expression_veto_agent: FUNCTION [ANY, TUPLE [AFX_ACCESS], BOOLEAN]
			-- An agent to select access of integer type
		do
			Result :=
				agent (a_access: AFX_ACCESS): BOOLEAN
					do
						Result := a_access.is_type_integer
					end
		end

	boolean_expression_veto_agent: FUNCTION [ANY, TUPLE [AFX_ACCESS], BOOLEAN]
			-- An agent to select access of boolean type
		do
			Result :=
				agent (a_access: AFX_ACCESS): BOOLEAN
					do
						Result := a_access.is_type_boolean
					end
		end

end
