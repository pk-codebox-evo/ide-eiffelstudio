note 
	description: "This class stores statements and expressions codedom trees and associate them%
					%with a unique identifier. That identifier is written to the output so that%
					%if a compile unit codedom tree later on uses a snipet that contains the%
					%identifier, we can reuse the stored codedom tree and have the required%
					%contextual information to generate the expression/statement."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_PARTIAL_TREE_STORE

inherit
	CODE_PARTIAL_TREE_ID_PREFIX

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize store.
		do
			create statements_store.make (10)
			create expressions_store.make (10)
		end

feature -- Access

	tree_id: CODE_PARTIAL_TREE_ID
			-- id generated by last call to `store_statement' or `store_expression'

	found_statement: SYSTEM_DLL_CODE_STATEMENT
			-- Last statement found with `search_statement'

	found_expression: SYSTEM_DLL_CODE_EXPRESSION
			-- Last expression found with `search_expression'

feature -- Status Report

	is_valid_id (a_string: STRING): BOOLEAN
			-- Is `a_string' a valid partial tree id?
		do
			a_string.left_adjust
			Result := a_string.count = 40 and is_valid_id_prefix (a_string.substring (1, 4))
							and is_valid_uuid (a_string.substring (5, 40))
		end

	statement_found: BOOLEAN
			-- Did most recent call to `search_statement' yield a result?
	
	expression_found: BOOLEAN
			-- Did most recent call to `search_expression' yield a result?
	
feature -- Basic Operations

	search (a_id: STRING)
			-- Search statement or expression with id `a_id'.
			-- Set `found_statement', `found_expression', `statement_found' and `expression_found' accordingly.
		require
			attached_id: a_id /= Void
			valid_id: is_valid_id (a_id)
		local
			l_id: CODE_PARTIAL_TREE_ID
		do
			a_id.left_adjust
			create l_id.make_from_string (a_id)
			statements_store.search (l_id)
			if statements_store.found then
				statement_found := True
				found_statement := statements_store.found_item
			else
				expressions_store.search (l_id)
				expression_found := expressions_store.found
				found_expression := expressions_store.found_item
			end
		end

	search_statement (a_id: STRING)
			-- Search statement with id `a_id'.
			-- Set `found_statement' and `statement_found' accordingly.
		require
			attached_id: a_id /= Void
			valid_id: is_valid_id (a_id)
		do
			statements_store.search (create {CODE_PARTIAL_TREE_ID}.make_from_string (a_id))
			statement_found := statements_store.found
			found_statement := statements_store.found_item
		end

	search_expression (a_id: STRING)
			-- Search expression with id `a_id'.
			-- Set `expression_found' and `found_expression' accordingly.
		require
			attached_id: a_id /= Void
			valid_id: is_valid_id (a_id)
		do
			expressions_store.search (create {CODE_PARTIAL_TREE_ID}.make_from_string (a_id))
			expression_found := expressions_store.found
			found_expression := expressions_store.found_item
		end

	put_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT)
			-- Store tree `a_statement' and initialize `tree_id' with new unique id
		require
			attached_statement: a_statement /= Void
		do
			create tree_id.make_statement
			statements_store.put (a_statement, tree_id)
		end
	
	put_expression (a_expression: SYSTEM_DLL_CODE_EXPRESSION)
			-- Store tree `a_expression' and initialize `tree_id' with new unique id
		require
			attached_expression: a_expression /= Void
		do
			create tree_id.make_expression
			expressions_store.put (a_expression, tree_id)
		end

feature {NONE} -- Implementation

	statements_store: HASH_TABLE [SYSTEM_DLL_CODE_STATEMENT, CODE_PARTIAL_TREE_ID]
			-- Stored statements
	
	expressions_store: HASH_TABLE [SYSTEM_DLL_CODE_EXPRESSION, CODE_PARTIAL_TREE_ID]
			-- Stored Expressions

invariant
	attached_statements_store: statements_store /= Void
	attached_expressions_store: expressions_store /= Void
	statement_if_found: statement_found implies found_statement /= Void
	expression_if_found: expression_found implies found_expression /= Void

note
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
end -- class CODE_PARTIAL_TREE_STORE

