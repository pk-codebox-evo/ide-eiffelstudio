indexing
	description: "Summary description for {SCOOP_CLIENT_CONTEXT_AST_PRINTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_CLIENT_CONTEXT_AST_PRINTER

inherit
	SCOOP_CONTEXT_AST_PRINTER
		redefine
			process_access_feat_as,
			process_access_inv_as,
			process_access_id_as,
			process_static_access_as,
			process_parameter_list_as,
			process_feature_as,
			process_nested_as,
			process_nested_expr_as
		end

feature -- Roundtrip: 'Current' as first argument in paramenter list

	process_parameter_list_as (l_as: PARAMETER_LIST_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.lparan_symbol (match_list))
			-- add additional argument 'Current'
			if is_nested_call and then is_last_expr_separate then
				context.add_string ("Current, ")
			end
			safe_process (l_as.parameters)
			safe_process (l_as.rparan_symbol (match_list))
		end

feature -- Roundtrip: process nodes, call expressions with internal parameters.

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
		do
			safe_process (l_as.feature_name)

			-- process internal parameters and add current if target is of separate type.
			process_internal_parameters(l_as.internal_parameters)
			-- get 'is_separate' information about current call for next expr
			is_last_expr_separate := evaluate_id(l_as.feature_name)
		end

	process_access_inv_as (l_as: ACCESS_INV_AS) is
		do
			safe_process (l_as.dot_symbol (match_list))
			safe_process (l_as.feature_name)

			-- process internal parameters and add current if target is of separate type.
			process_internal_parameters(l_as.internal_parameters)
			-- get 'is_separate' information about current call for next expr
			is_last_expr_separate := evaluate_id(l_as.feature_name)
		end

	process_access_id_as (l_as: ACCESS_ID_AS) is
		do
			safe_process (l_as.feature_name)
			-- process internal parameters and add current if target is of separate type.
			process_internal_parameters(l_as.internal_parameters)
			-- get 'is_separate' information about current call for next expr
			is_last_expr_separate := evaluate_id(l_as.feature_name)
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS) is
		do
			safe_process (l_as.feature_keyword (match_list))
			safe_process (l_as.class_type)
			safe_process (l_as.dot_symbol (match_list))
			safe_process (l_as.feature_name)
			-- process internal parameters and add current if target is of separate type.
			process_internal_parameters(l_as.internal_parameters)
			-- get 'is_separate' information about current call for next expr
			is_last_expr_separate := evaluate_id(l_as.feature_name)
		end

	process_nested_as (l_as: NESTED_AS)
			-- Process `l_as'.
		do
			is_last_expr_separate := false
			safe_process (l_as.target)
			safe_process (l_as.dot_symbol (match_list))
			is_nested_call := true
			safe_process (l_as.message)
			is_nested_call := false
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS)
			-- Process `l_as'.
		do
			is_last_expr_separate := false
			safe_process (l_as.lparan_symbol (match_list))
			safe_process (l_as.target)
			safe_process (l_as.rparan_symbol (match_list))
			safe_process (l_as.dot_symbol (match_list))
			is_nested_call := true
			safe_process (l_as.message)
			is_nested_call := false
		end

feature -- Visitor implementation

	process_feature_as (l_as: FEATURE_AS) is
		do
			set_current_feature_as (l_as)
			Precursor (l_as)
		end

feature {NONE} -- Implementation

	process_internal_parameters (l_as: PARAMETER_LIST_AS) is
			-- adds the paramter 'Current' to the list if
			-- it is a nested call and the target of separate type.
		do
			if l_as /= Void then
				-- add additional argument 'Current'
				safe_process (l_as)
			elseif is_nested_call and then is_last_expr_separate then
				context.add_string (" (Current)")
			end
		end

	evaluate_id (l_as: ID_AS): BOOLEAN is
			-- evaluates the separated state of the entity behind id
		local
			l_type_expr_visitor: SCOOP_TYPE_EXPR_VISITOR
		do
			-- get is_separate information of the current call
			create l_type_expr_visitor
			l_type_expr_visitor.setup (parsed_class, match_list, true, true)
			if is_nested_call and then l_last_base_class /= Void then
				l_type_expr_visitor.evaluate_type_from_expr (l_as, feature_as, l_last_base_class)
			else
				l_type_expr_visitor.evaluate_type_from_expr (l_as, feature_as, class_c)
			end
			l_last_base_class := l_type_expr_visitor.get_new_base_class
			Result := l_type_expr_visitor.is_last_type_separate
		end

	is_last_expr_separate: BOOLEAN
		-- indicates that the processed type is separate
		-- therefore we add 'Current' as a first internal parameter.

	is_nested_call: BOOLEAN
		-- indicates that the message of a nested call is processed
		-- the last base class for type evaluation is taken

	l_last_base_class: CLASS_C
		-- last base class for processing nested calls

end
