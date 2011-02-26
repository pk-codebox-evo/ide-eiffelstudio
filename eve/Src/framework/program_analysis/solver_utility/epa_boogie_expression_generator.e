note
	description: "Summary description for {AFX_BOOGIE_EXPRESSION_GENERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EPA_BOOGIE_EXPRESSION_GENERATOR

inherit
	EPA_SOLVER_EXPRESSION_GENERATOR
		redefine
			process_unary_as,
			process_binary_as
		end

	EPA_SOLVER_CONSTANTS

create
	make

feature -- Basic operations

	generate_void_function
			-- Generate a dummy function for the expression "Void'.
			-- Store result in `last_statements'.
		local
			l_stmt: STRING
		do
			create l_stmt.make (32)
			l_stmt.append (once "const Void: ref;")
			last_statements.extend (l_stmt)
		end

	generate_current_function (a_class: CLASS_C)
			-- Generate a dummy function for the expression "Void'.
			-- Store result in `last_statements'.
		local
			l_stmt: STRING
		do
			create l_stmt.make (32)
			l_stmt.append (once "const ")
			l_stmt.append (solver_prefix ("", a_class))
			l_stmt.append (once "Current: ref;")
			last_statements.extend (l_stmt)
		end

	generate_argument_function (a_feature: FEATURE_I; a_class: CLASS_C)
			-- Generate arguments of `a_feature' as functions,
			-- store result in `last_statement'.
		local
			i: INTEGER
			c: INTEGER
			l_type: TYPE_A
			l_name: STRING
			l_stmt: STRING
		do
			from
				i := 1
				c := a_feature.argument_count
			until
				i > c
			loop
				l_name := a_feature.arguments.item_name (i)
				l_type := a_feature.arguments.i_th (i).instantiation_in (a_class.actual_type, a_class.class_id).actual_type
				create l_stmt.make (64)
				l_stmt.append (once "const ")
				l_stmt.append (l_name)
				l_stmt.append (": ")
				l_stmt.append (solver_type (l_type))
				l_stmt.append (once ";")
				last_statements.extend (l_stmt)
				i := i + 1
			end
		end

	generate_local_function (a_feature: FEATURE_I; a_class: CLASS_C)
			-- Generate locals of `a_feature' as solver expresessions,
			-- store result in `last_statement'.
		local
			l_locals: HASH_TABLE [LOCAL_INFO, INTEGER]
			l_stmt: STRING
			l_type: TYPE_A
		do
			l_locals := expression_type_checker.local_info (a_class, a_feature)
			from
				l_locals.start
			until
				l_locals.after
			loop
				create l_stmt.make (64)
				l_stmt.append ("var ")
				l_stmt.append (names_heap.item (l_locals.key_for_iteration))
				l_stmt.append (": ")
				l_stmt.append (solver_type (l_locals.item_for_iteration.type.instantiation_in (context_class.actual_type, context_class.class_id).actual_type))
				l_stmt.append_character (';')
				last_statements.extend (l_stmt)
				l_locals.forth
			end
		end

	generate_function (a_feature: FEATURE_I; a_class: CLASS_C)
			-- Generate boogie function for `a_feature' in `a_class'.
			-- Store result in `last_statement'. Update `needed_theory' when necessary.
		local
			l_stmt: STRING
			l_type: TYPE_A
			i: INTEGER
			l_arg_count: INTEGER
		do
			set_context_class (a_class)
			set_context_feature (a_feature)

			create l_stmt.make (64)
			l_stmt.append (boogie_function_header)
			l_stmt.append (solver_prefix ("", context_class))
			l_stmt.append (context_feature.feature_name.as_lower)
			l_stmt.append_character ('(')

				-- Process routine argument types.
			from
				i := 1
				l_arg_count := a_feature.argument_count
			until
				i > l_arg_count
			loop
				l_stmt.append (a_feature.arguments.item_name (i))
				l_stmt.append (once ": ")
				l_stmt.append (solver_type (a_feature.arguments.i_th (i).instantiation_in (context_class.actual_type, context_class.class_id).actual_type))
				if i < l_arg_count then
					l_stmt.append (once ", ")
				end
				i := i + 1
			end
			l_stmt.append (") returns (")

				-- Process result type.
			l_stmt.append (solver_type (a_feature.type.actual_type))
			l_stmt.append (");")

			last_statements.extend (l_stmt)
		end

feature{NONE} -- Implementation

	solver_type (a_type: TYPE_A): STRING
			-- type used in solver from `a_type'
		do
			if a_type.is_boolean then
				Result := once "bool"
			elseif a_type.is_integer then
				Result := once "int"
			else
				Result := once "ref"
			end
		end

	dummy_paranthesis: STRING
			-- Dummy paranthesis
		do
			Result := once "()"
		end

	dummy_semicolon: STRING
			-- Dummy semicolon
		do
			Result := once ";"
		end

feature{NONE} -- Process

	process_unary_as (l_as: UNARY_AS)
		do
			output_buffer.append_character ('(')
			if l_as.operator_ast.name.is_case_insensitive_equal (once "not") then
				output_buffer.append (once "! ")
			else
				check no_support: False end
			end
			output_buffer.append (once " (")
			l_as.expr.process (Current)
			output_buffer.append (once "))")
		end

	process_binary_as (l_as: BINARY_AS)
		local
			l_opt: STRING
			l_is_not_equal: BOOLEAN
		do
			output_buffer.append_character ('(')

			l_opt := l_as.operator_ast.name

			if l_opt.is_case_insensitive_equal (once "and") or l_opt.is_case_insensitive_equal (once "and then") then
				l_opt := once "&&"
			elseif l_opt.is_case_insensitive_equal (once "or") or l_opt.is_case_insensitive_equal (once "or else") then
				l_opt := once "||"
			elseif l_opt.is_equal (once "/=") then
				l_opt := once "!="
			elseif l_opt.is_equal (once "=") or l_opt.is_equal (once "~") then
				l_opt := once "=="
			elseif l_opt.is_case_insensitive_equal ("implies") then
				l_opt := once "==>"
			end

			output_buffer.append (once " (")
			l_as.left.process (Current)
			output_buffer.append (once ") ")
			output_buffer.append (l_opt)
			output_buffer.append (once " (")
			l_as.right.process (Current)
			output_buffer.append ("))")
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
