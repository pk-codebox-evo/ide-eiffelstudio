note
	description: "Summary description for {SEMQ_QUERYABLE_QUERY_TERM_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SEMQ_QUERYABLE_QUERY_TERM_VISITOR

inherit
	SEMQ_TERM_VISITOR
	SEM_FIELD_NAMES

create
	make

feature{NONE} -- Initialization

	make (an_ast_visitor: like ast_visitor)
			-- Initialize `ast_visitor' with `an_ast_visitor'
		do
			ast_visitor := an_ast_visitor
		end

feature -- Access

	ast_visitor: SEMQ_QUERYABLE_QUERY_AST_VISITOR
			-- visitor processing the expressions in the terms

feature -- Process

	process_equation_term (a_term: SEMQ_EQUATION_TERM)
			-- Process `a_term'.
		local
			l_property_kind: INTEGER
		do
--			io.put_string ("FOO%N")
--			-- Determine property_kind_id
--			if a_term.is_precondition then
--				l_property_kind := property_types.at (once "pre")
--			elseif a_term.is_postcondition then
--				l_property_kind := property_types.at (once "post")
--			elseif a_term.is_property then
--				l_property_kind := property_types.at (once "prop")
--			elseif a_term.is_absolute_change then
--				l_property_kind := property_types.at (once "to")
--			elseif a_term.is_relative_change then
--				l_property_kind := property_types.at (once "by")
--			end
--			-- Prepare term
--			ast_visitor.prepare_equation_term (l_property_kind)
--			-- Visit left side of equality
--			a_term.expression.process (ast_visitor)
--			-- Visit right side of equality, if required
--			if a_term.value /= Void then
--				-- Add equality to clause
--				ast_visitor.add_equality
--				a_term.value.process (ast_visitor)
--				ast_visitor.set_expression_in_select (False)
--			else
--				ast_visitor.set_expression_in_select (True)
--			end
--			-- Finish clause
--			ast_visitor.finish_equation_term
--			-- Add select clauses
--			ast_visitor.add_select_clauses_for_equation_term



			process_term (a_term)
			ast_visitor.add_clauses_equation
		end

	process_variable_term (a_term: SEMQ_VARIABLE_TERM)
			-- Process `a_term'.
		local
			l_property_kind: INTEGER
		do
--			-- Determine property_kind_id
--			if a_term.is_precondition then
--				l_property_kind := property_types.at (once "pre")
--			elseif a_term.is_postcondition then
--				l_property_kind := property_types.at (once "post")
--			elseif a_term.is_property then
--				l_property_kind := property_types.at (once "prop")
--			end
--			-- Prepare clause, visit and finish clause
--			ast_visitor.prepare_variable_term (l_property_kind)
--			a_term.variable.process (ast_visitor)
--			ast_visitor.finish_variable_term
--			-- Emit where clause enforcing type
--			ast_visitor.add_select_clauses_for_variable_term




			process_term (a_term)
			ast_visitor.add_clauses_variable
			if a_term.type /= Void then
				ast_visitor.add_type_clause (a_term.type.name)
			end
			if a_term.position /= Void then
				ast_visitor.add_position_clause (a_term.position.position)
			end
		end

	process_meta_term (a_term: SEMQ_META_TERM)
			-- Process `a_term'.
		do
			-- Prepare clause, visit and finish clause
--			ast_visitor.prepare_meta_term
--			a_term.expression.process (ast_visitor)
--			ast_visitor.finish_meta_term

			process_term (a_term)
			ast_visitor.add_clauses_meta
		end

feature -- Helpers

	process_term (a_term: SEMQ_TERM)
			-- Process `a_term'.
		local
			l_property_kind: INTEGER
		do
			if a_term.is_precondition then
				l_property_kind := property_types.at (once "pre")
			elseif a_term.is_postcondition then
				l_property_kind := property_types.at (once "post")
			elseif a_term.is_property then
				l_property_kind := property_types.at (once "prop")
			elseif a_term.is_absolute_change then
				l_property_kind := property_types.at (once "to")
			elseif a_term.is_relative_change then
				l_property_kind := property_types.at (once "by")
			else
				l_property_kind := 0
			end

			ast_visitor.prepare_term (l_property_kind)
			a_term.expression.process (ast_visitor)
			if a_term.value /= Void then
				ast_visitor.add_equality
				a_term.value.process (ast_visitor)
			end
			ast_visitor.finish_term
		end

end
