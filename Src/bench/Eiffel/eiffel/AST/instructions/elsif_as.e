indexing
	description:
			"Abstract description of a elsif clause of a condition %
			%instruction. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class ELSIF_AS

inherit
	AST_EIFFEL
		redefine
			number_of_breakpoint_slots, 
			is_equivalent, 
			type_check, 
			byte_node
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (e: like expr; c: like compound) is
			-- Create a new ELSIF AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			compound := c
		ensure
			expr_set: expr = e
			compound_set: compound = c
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_elseif_as (Current)
		end

feature -- Attributes

	expr: EXPR_AS
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := expr.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if compound /= Void then
				Result := compound.end_location
			else
				Result := expr.end_location
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr) and
				equivalent (compound, other.compound)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			Result := 1 -- condition test
			if compound /= Void then
				Result := Result + compound.number_of_breakpoint_slots
			end
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an alternative of a conditional instruction
		local
			current_context: TYPE_A
			vwbe2: VWBE2
		do
				-- Type check test first
			expr.type_check

				-- Check conformance to boolean
			current_context := context.item
			if 	not current_context.is_boolean then
				create vwbe2
				context.init_error (vwbe2)
				vwbe2.set_type (current_context)
				vwbe2.set_location (expr.end_location)
				Error_handler.insert_error (vwbe2)
			end

				-- Update the type stack
			context.pop (1)
		
				-- Type check on compound
			if compound /= Void then
				compound.type_check
			end

		end

	byte_node: ELSIF_B is
			-- Associated byte code
		do
			create Result
			Result.set_expr (expr.byte_node)
			if compound /= Void then
				Result.set_compound (compound.byte_node)
			end
			Result.set_line_number (expr.start_location.line)
		end

feature {ELSIF_AS} -- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end

	set_compound (c: like compound) is
		do
			compound := c
		end

invariant
	expr_not_void: expr /= Void

end -- class ELSIF_AS
