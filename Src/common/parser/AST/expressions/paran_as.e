indexing
	description:
		"Abstract description of a parenthesized expression. %
		%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class
	PARAN_AS

inherit
	EXPR_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (e: like expr; l_as, r_as: like lparan_symbol) is
			-- Create a new PARAN AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			lparan_symbol := l_as
			rparan_symbol := r_as
		ensure
			expr_set: expr = e
			lparan_symbol_set: lparan_symbol = l_as
			rparan_symbol_set: rparan_symbol = r_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_paran_as (Current)
		end

feature -- Roundtrip

	lparan_symbol, rparan_symbol: SYMBOL_AS
			-- Symbol "(" and ")" associated with this structure

feature -- Attributes

	expr: EXPR_AS
			-- Parenthesized expression

feature -- Location

	start_location: LOCATION_AS is
			-- Start location of Current
		do
			Result := expr.start_location
		end

	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := expr.end_location
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

invariant
	expr_not_void: expr /= Void

end -- class PARAN_AS
