note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_BODY_EXPRESSION_TRANSLATOR

inherit

	E2B_EXPRESSION_TRANSLATOR
		redefine
			reset,
			process_array_const_b,
			process_creation_expr_b,
			process_tuple_access_b,
			process_tuple_const_b
		end

create
	make

feature -- Access

	context_implementation: IV_IMPLEMENTATION
			-- Context of expression.

	side_effect: LINKED_LIST [IV_STATEMENT]
			-- List of side effect statements.

feature -- Basic operations

	set_context_implementation (a_implementation: IV_IMPLEMENTATION)
			-- Set context of expression.
		do
			context_implementation := a_implementation
		end

	reset
			-- Reset expression translator.
		do
			Precursor
			context_implementation := Void
			create side_effect.make
			create procedure_calls.make
		end

feature -- Visitors

	process_array_const_b (a_node: ARRAY_CONST_B)
			-- <Precursor>
		local
			i, n: INTEGER
			l_expr: EXPR_B
			l_target: IV_EXPRESSION
			l_pcall: IV_PROCEDURE_CALL
			l_assign: IV_ASSIGNMENT
		do
			translation_pool.add_type (a_node.type)

			if a_node.expressions /= Void then
				n := a_node.expressions.count
			else
				n := 0
			end

			create_local (a_node.type)
			l_target := last_local

				-- Create array
			create l_pcall.make ("allocate")
			l_pcall.add_argument (factory.type_value (a_node.type))
			l_pcall.set_target (l_target)
			side_effect.extend (l_pcall)

			create l_pcall.make ("ARRAY.make")
			l_pcall.add_argument (l_target)
			l_pcall.add_argument (factory.int_value (1))
			l_pcall.add_argument (factory.int_value (n))
			side_effect.extend (l_pcall)

				-- Put all elements into array
			from
				i := 1
			until
				i > n
			loop
				l_expr ?= a_node.expressions.i_th (i)
				check l_expr /= Void end
				create l_assign.make (
					factory.array_access (entity_mapping.heap, l_target, factory.int_value (i)),
					process_argument_expression (l_expr))
				side_effect.extend (l_assign)

				i := i + 1
			end
			last_expression := l_target
		end

	process_creation_expr_b (a_node: CREATION_EXPR_B)
			-- <Precursor>
		local
			l_type: CL_TYPE_A
			l_feature: FEATURE_I
			l_target: IV_EXPRESSION
			l_target_type: TYPE_A

			l_local: IV_ENTITY
			l_havoc: IV_HAVOC
			l_assume: IV_ASSUME
			l_assignment: IV_ASSIGNMENT
			l_allocated: IV_ENTITY
			l_binop: IV_BINARY_OPERATION
			l_heap_access: IV_HEAP_ACCESS
			l_call: IV_FUNCTION_CALL
			l_proc_call: IV_PROCEDURE_CALL
			l_type_value: IV_VALUE
			l_handler: E2B_CUSTOM_CALL_HANDLER
		do
			l_type ?= a_node.type.deep_actual_type
			check l_type /= Void end
			l_feature := a_node.type.associated_class.feature_of_rout_id (a_node.call.routine_id)
			check feature_valid: l_feature /= Void end
			translation_pool.add_type (l_type)

				-- Call to `allocate'
			create_local (l_type)
			l_local := last_local

			create l_proc_call.make ("allocate")
			l_proc_call.add_argument (factory.type_value (l_type))
			l_proc_call.set_target (l_local)
			side_effect.extend (l_proc_call)

				-- Call to creation procedure
			l_target := current_target
			l_target_type := current_target_type

			current_target := l_local
			current_target_type := l_type

			l_handler := translation_mapping.handler_for_call (current_target_type, l_feature)
			if l_handler /= Void then
				l_handler.handle_routine_call_in_body (Current, l_feature, a_node.parameters)
			else
				process_routine_call (l_feature, a_node.parameters, True)
			end

			current_target := l_target
			current_target_type := l_target_type

			last_expression := l_local
		end

	process_tuple_access_b (a_node: TUPLE_ACCESS_B)
			-- <Precursor>
		local
			l_proc_call: IV_PROCEDURE_CALL
		do
			if a_node.source = Void then
				Precursor (a_node)
			else
					-- TODO: add check that position is in the range of the tuple
				a_node.source.expression.process (Current)
				create l_proc_call.make ("TUPLE.put")
				l_proc_call.add_argument (current_target)
				l_proc_call.add_argument (last_expression)
				l_proc_call.add_argument (factory.int_value (a_node.position))
				side_effect.extend (l_proc_call)
				last_expression := Void
			end
		end

	process_tuple_const_b (a_node: TUPLE_CONST_B)
			-- <Precursor>
		local
			l_local: IV_ENTITY
			l_proc_call: IV_PROCEDURE_CALL
			l_expr: EXPR_B
		do
			create_local (a_node.type)
			l_local := last_local

			create l_proc_call.make ("allocate")
			l_proc_call.add_argument (create {IV_ENTITY}.make ("TUPLE", types.type))
			l_proc_call.set_target (l_local)
			side_effect.extend (l_proc_call)

			create l_proc_call.make ("TUPLE.make" + a_node.expressions.count.out)
			l_proc_call.add_argument (l_local)
			across a_node.expressions as i loop
				l_expr ?= i.item
				check l_expr /= Void end
				l_proc_call.add_argument (process_argument_expression (l_expr))
			end
			side_effect.extend (l_proc_call)

			last_expression := l_local
		end

feature -- Translation

	process_routine_call (a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B]; a_for_creator: BOOLEAN)
			-- Process feature call.
		local
			l_inlining_depth: INTEGER
		do
			if options.inlining_depth > 0 then
				l_inlining_depth := options.inlining_depth
				options.set_inlining_depth (options.inlining_depth - 1)
				process_inlined_routine_call (a_feature, a_parameters)
				options.set_inlining_depth (l_inlining_depth)
			elseif
				helper.is_inlining_routine (a_feature) and then
				(inlined_routines.has (a_feature.body_index) implies inlined_routines.item (a_feature.body_index) < options.max_recursive_inlining_depth)
			then
				process_inlined_routine_call (a_feature, a_parameters)
			else
				process_normal_routine_call (a_feature, a_parameters, a_for_creator)
			end
		end

	process_normal_routine_call (a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B]; a_for_creator: BOOLEAN)
			-- Process feature call.
		local
			l_target: IV_EXPRESSION
			l_target_type: TYPE_A
			l_call: IV_PROCEDURE_CALL
		do
			if a_for_creator then
				translation_pool.add_referenced_creator (a_feature, current_target_type)
			else
				translation_pool.add_referenced_feature (a_feature, current_target_type)
			end


			if a_for_creator then
				create l_call.make (name_translator.boogie_name_for_creation_routine (a_feature, current_target_type))
			else
				create l_call.make (name_translator.boogie_name_for_feature (a_feature, current_target_type))
			end
			l_call.add_argument (current_target)

			process_parameters (a_parameters)
			l_call.arguments.append (last_parameters)

				-- Process call
			if a_feature.has_return_value then
				create_local (a_feature.type.instantiated_in (current_target_type))
				l_call.set_target (last_local)
				last_expression := last_local
			else
					-- No expression generated, this has to be a call statement
				last_expression := Void
			end
			side_effect.extend (l_call)
		end

	process_builtin_routine_call (a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B]; a_builtin_name: STRING)
			-- Process feature call.
		local
			l_target: IV_EXPRESSION
			l_target_type: TYPE_A
			l_call: IV_PROCEDURE_CALL
		do
			create l_call.make (a_builtin_name)
			l_call.add_argument (current_target)

			process_parameters (a_parameters)
			l_call.arguments.append (last_parameters)

				-- Process call
			if a_feature.has_return_value then
				create_local (a_feature.type.instantiated_in (current_target_type))
				l_call.set_target (last_local)
				last_expression := last_local
			else
					-- No expression generated, this has to be a call statement
				last_expression := Void
			end
			side_effect.extend (l_call)
		end

	process_builtin_function_call (a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B]; a_builtin_name: STRING)
			-- Process feature call.
		require
			a_feature.has_return_value
		local
			l_target: IV_EXPRESSION
			l_target_type: TYPE_A
			l_call: IV_FUNCTION_CALL
			l_pcall: IV_PROCEDURE_CALL
		do
			create l_call.make (a_builtin_name, types.for_type_a (a_feature.type))
			l_call.add_argument (entity_mapping.heap)
			l_call.add_argument (current_target)

			process_parameters (a_parameters)
			l_call.arguments.append (last_parameters)

			current_target := l_target
			current_target_type := l_target_type

			last_expression := l_call
		end

	process_special_routine_call (a_handler: E2B_CUSTOM_CALL_HANDLER; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- <Precursor>
		do
			a_handler.handle_routine_call_in_body (Current, a_feature, a_parameters)
		end

	inlined_routines: HASH_TABLE [INTEGER, INTEGER]
			-- Routines currently being inlined.
		once
			create Result.make (5)
		end

	process_inlined_routine_call (a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- Process feature call.
		local
			l_target: IV_EXPRESSION
			l_target_type: TYPE_A
			l_call: IV_PROCEDURE_CALL
			l_translator: E2B_INSTRUCTION_TRANSLATOR
			l_block: IV_BLOCK
			l_entity_mapping: E2B_ENTITY_MAPPING
			l_features: LIST [FEATURE_I]
		do
				-- TODO: look for all possible descendant-implementations for feature
				-- and add a nondeterministic goto that selects between all of those
				-- implementations

--			if l_features.count > 1 then
--					-- More than one possible feature to inline
--			elseif l_features.count = 1 then
--					-- Exactly one feature to inline
--			else
--					-- No possible feature to inline (deferred or external)
--				process_normal_routine_call (a_feature, a_parameters)
--			end

			if inlined_routines.has (a_feature.body_index) then
				inlined_routines.force (inlined_routines.item (a_feature.body_index) + 1, a_feature.body_index)
			else
				inlined_routines.force (1, a_feature.body_index)
			end


			process_parameters (a_parameters)

				-- Set up entity mapping
			create l_entity_mapping.make_copy (entity_mapping)
			l_entity_mapping.clear_arguments
			l_entity_mapping.clear_locals
				-- Map `Current'
			l_entity_mapping.set_current (current_target)
				-- Map arguments
			across last_parameters as l_args loop
				l_entity_mapping.set_argument (l_args.cursor_index, l_args.item)
			end
				-- Map `Result'
			if a_feature.has_return_value then
				create_local (a_feature.type)
				l_entity_mapping.set_result (last_local)
			end

			create l_block.make
			create l_translator.make
			l_translator.set_context (context_implementation, a_feature, current_target_type)
			l_translator.set_current_block (l_block)
			l_translator.set_entity_mapping (l_entity_mapping)

			l_translator.process_feature_of_type (a_feature, current_target_type)
			helper.set_up_byte_context (context_feature, context_type)

			side_effect.extend (l_block)

			if a_feature.has_return_value then
				last_expression := l_entity_mapping.result_expression
			else
				last_expression := Void
			end

			inlined_routines.force (inlined_routines.item (a_feature.body_index) - 1, a_feature.body_index)
		end

	add_safety_check (a_expression: IV_EXPRESSION; a_name: STRING; a_tag: STRING)
			-- <Precursor>
		local
			l_assert: IV_ASSERT
			l_info: IV_ASSERTION_INFORMATION
		do
			create l_assert.make (implies_safety_expression (a_expression))
			create l_info.make (a_name)
			l_info.set_tag (a_tag)
			l_assert.set_information (l_info)
			side_effect.extend (l_assert)
		end

feature {NONE} -- Implementation

	procedure_calls: LINKED_STACK [IV_PROCEDURE_CALL]
			-- Stack of procedure calls.

	create_local (a_type: TYPE_A)
			-- Create new local.
		do
			create last_local.make (helper.unique_identifier ("temp"), types.for_type_a (a_type))
			context_implementation.add_local (last_local.name, last_local.type)
		end

end
