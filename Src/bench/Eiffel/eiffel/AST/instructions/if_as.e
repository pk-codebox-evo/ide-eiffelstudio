indexing
	description	: "Abstract description of a conditional instruction, %
				  %Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class IF_AS

inherit
	INSTRUCTION_AS
		redefine
			number_of_breakpoint_slots, byte_node
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (cnd: like condition; cmp: like compound;
		ei: like elsif_list; e: like else_part; el: like end_keyword) is
			-- Create a new IF AST node.
		require
			cnd_not_void: cnd /= Void
			el_not_void: el /= Void
		do
			condition := cnd
			compound := cmp
			elsif_list := ei
			else_part := e
			end_keyword := el
		ensure
			condition_set: condition = cnd
			compound_set: compound = cmp
			elsif_list_set: elsif_list = ei
			else_part_set: else_part = e
			end_keyword_set: end_keyword = el
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_if_as (Current)
		end

feature -- Attributes

	condition: EXPR_AS
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

	elsif_list: EIFFEL_LIST [ELSIF_AS]
			-- Elsif list

	else_part: EIFFEL_LIST [INSTRUCTION_AS]
			-- Else part

	end_keyword: LOCATION_AS
			-- Line number where `end' keyword is located

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := condition.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := end_keyword
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			Result := 1 -- condition test
			if compound /= Void then
				Result := Result + compound.number_of_breakpoint_slots
			end
			if elsif_list /= Void then
				Result := Result + elsif_list.number_of_breakpoint_slots
			end
			if else_part /= Void then
				Result := Result + else_part.number_of_breakpoint_slots
			end
		end

feature -- Comparison 

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and then
				equivalent (condition, other.condition) and then
				equivalent (else_part, other.else_part) and then
				equivalent (elsif_list, other.elsif_list)
		end

feature -- Type check, byte code and dead code removal

	perform_type_check is
			-- Type check on conditional instruction
		local
			current_context: TYPE_A
			vwbe1: VWBE1
		do
				-- Type check the test
			condition.type_check
	
				-- Check conformance to boolean
			current_context := context.item
			if 	not current_context.is_boolean then
				create vwbe1
				context.init_error (vwbe1)
				vwbe1.set_type (current_context)
				vwbe1.set_location (condition.end_location)
				Error_handler.insert_error (vwbe1)
			end

				-- Update the type stack
			context.pop (1)

				-- Type check on compound
			if compound /= Void then
				compound.type_check
			end
				-- Type check on alternaltives compounds
			if elsif_list /= Void then
				elsif_list.type_check
			end
				-- Type check on default compound
			if else_part /= Void then
				else_part.type_check
			end
		end

	byte_node: IF_B is
			-- Associated byte node
		do
			create Result
			Result.set_condition (condition.byte_node)
			if compound /= Void then
				Result.set_compound (compound.byte_node)
			end
			if elsif_list /= Void then
				Result.set_elsif_list (elsif_list.byte_node)
			end
			if else_part /= Void then
				Result.set_else_part (else_part.byte_node)
			end
			Result.set_line_number (condition.start_location.line)
			Result.set_end_location (end_keyword)
		end

invariant
	condition_not_void: condition /= Void
	end_keyword_not_void: end_keyword /= Void

end -- class IF_AS
