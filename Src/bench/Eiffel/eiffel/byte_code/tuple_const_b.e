indexing
	description: "Byte code for manifest tuples"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TUPLE_CONST_B

inherit
	EXPR_B
		redefine
			enlarged, enlarge_tree, is_unsafe,
			optimized_byte_node, calls_special_features, size,
			pre_inlined_code, inlined_byte_code,
			allocates_memory, has_call, is_constant_expression
		end

	PREDEFINED_NAMES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (e: like expressions; t: like type) is
			-- New instance of TUPLE_CONST_B
		require
			e_not_void: e /= Void
			t_not_void: t /= Void
		do
			expressions := e
			type := t
		ensure
			expressions_set: expressions = e
			type_set: type = t
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_tuple_const_b (Current)
		end

feature -- Access

	expressions: BYTE_LIST [BYTE_NODE];
			-- Expressions in the tuple

	type: TUPLE_TYPE_I;

feature -- Settings

	set_expressions (e: like expressions) is
			-- Assign `e' to `expressions'.
		do
			expressions := e;
		end;

	set_type (t: like type) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

feature -- Status report

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local access ?
		local
			expr: EXPR_B
			i, nb: INTEGER
			l_area: SPECIAL [BYTE_NODE]
			l_expressions: like expressions
		do
			l_expressions := expressions
			from
				l_area := l_expressions.area
				nb := l_expressions.count
			until
				i = nb or Result
			loop
				expr ?= l_area.item (i)
				check
					expr_not_void: expr /= Void
				end
				Result := expr.used (r)
				i := i + 1
			end
		end

	allocates_memory: BOOLEAN is True;
			-- Current allocates memory.

	has_call: BOOLEAN is
			-- Does current contain a call?
		local
			expr: EXPR_B
			l_expressions: like expressions
		do
			from
				l_expressions := expressions
				l_expressions.start
			until
				l_expressions.after or Result
			loop
				expr ?= l_expressions.item
				check expr_not_void: expr /= Void end
				Result := expr.has_call
				l_expressions.forth
			end
		end

	is_constant_expression: BOOLEAN is
			-- Is current array only made of constant expressions?
		local
			expr: EXPR_B
			l_expressions: like expressions
		do
			from
				l_expressions := expressions
				Result := True
				l_expressions.start
			until
				l_expressions.after or not Result
			loop
				expr ?= l_expressions.item
				check expr_not_void: expr /= Void end
				Result := expr.is_constant_expression
				l_expressions.forth
			end
		end

feature -- Code generation

	enlarge_tree is
			-- Enlarge the expressions.
		do
			expressions.enlarge_tree
		end

	enlarged: TUPLE_CONST_BL is
			-- Enlarge node
		do
			create Result.make (expressions, type)
			Result.enlarge_tree
		end;

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := expressions.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := expressions.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			expressions := expressions.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := expressions.size + 1
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			expressions := expressions.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			expressions := expressions.inlined_byte_code
		end

invariant
	expressions_not_void: expressions /= Void
	type_not_void: type /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
