note
	description	: "Abstract description of a tagged expression. %
				  %Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	TAGGED_AS

inherit
	EXPR_AS
		redefine
			is_detachable_expression
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like tag; e: like expr; s_as: like colon_symbol)
			-- Create a new TAGGED AST node.
		do
			tag := t
			expr := e
			if s_as /= Void then
				colon_symbol_index := s_as.index
			end
		ensure
			tag_set: tag = t
			expr_set: expr = e
			colon_symbol_set: s_as /= Void implies colon_symbol_index = s_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_tagged_as (Current)
		end

feature -- Roundtrip

	colon_symbol_index: INTEGER
			-- Index of symbol colon associated with this structure

	colon_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS
			-- Symbol colon associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := colon_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	is_complete: BOOLEAN
			-- Is this tagged structure complete?
			-- e.g. in form of "tag:expr", "expr", but not "tag:".
		do
			Result := (expr /= Void)
		end

feature -- Attributes

	tag: ID_AS
			-- Expression tag

	expr: EXPR_AS
			-- Expression

feature -- Status report

	is_detachable_expression: BOOLEAN
			-- <Precursor>
		do
			Result := expr.is_detachable_expression
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if tag /= Void then
				Result := tag.first_token (a_list)
			else
				Result := expr.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if expr /= Void then
				Result := expr.last_token (a_list)
			elseif a_list /= Void and colon_symbol_index /= 0 then
				Result := colon_symbol (a_list)
			else
				Result := tag.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (tag, other.tag) and then
				equivalent (expr, other.expr)
		end

	is_equiv (other: like Current): BOOLEAN
			-- Is `other' tagged as equivalent to Current?
		do
			Result := equivalent (tag, other.tag) and then equivalent (expr, other.expr)
		end;

invariant
	not_both_tag_and_expr_void: not (tag = Void and expr = Void)

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

end -- class TAGGED_AS
