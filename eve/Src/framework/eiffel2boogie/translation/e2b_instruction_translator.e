note
	description: "Translates Eiffel instructions to Boogie."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_INSTRUCTION_TRANSLATOR

inherit

	E2B_VISITOR
		rename
			safe_process as safe_process_b
		redefine
			process_assign_b,
			process_check_b,
			process_debug_b,
			process_guard_b,
			process_if_b,
			process_inspect_b,
			process_instr_call_b,
			process_loop_b,
			process_nested_b,
			process_retry_b,
			process_reverse_b
		end

	E2B_SHARED_CONTEXT
		export {NONE} all end

	IV_SHARED_TYPES

	IV_SHARED_FACTORY

	SHARED_BYTE_CONTEXT
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize instruction translator.
		do
			reset
		end

feature -- Access

	current_implementation: IV_IMPLEMENTATION
			-- Boogie procedure implementation currently being processed.

	current_feature: FEATURE_I
			-- Feature that is currently being processed.

	current_type: TYPE_A
			-- Type containing feature that is currently being processed.

	current_block: IV_BLOCK
			-- Current block that receives statements.

	entity_mapping: E2B_ENTITY_MAPPING
			-- Name mapping used.

feature -- Element change

	set_context (a_implementation: IV_IMPLEMENTATION; a_feature: FEATURE_I; a_type: TYPE_A)
			-- Set context.
		do
			current_implementation := a_implementation
			current_feature := a_feature
			current_type := a_type
			current_block := current_implementation.body
			if a_feature.has_return_value then
				entity_mapping.set_default_result (a_feature.type)
			end

		end

	set_entity_mapping (a_entity_mapping: E2B_ENTITY_MAPPING)
			-- Set `entity_mapping' to `a_entity_mapping'.
		do
			entity_mapping := a_entity_mapping
		ensure
			entity_mapping_set: entity_mapping = a_entity_mapping
		end

	set_current_block (a_block: IV_BLOCK)
			-- Set `current_block' to `a_block'.
		do
			current_block := a_block
		ensure
			current_block_set: current_block = a_block
		end

feature -- Basic operations

	reset
			-- Reset instruction translator.
		do
			current_feature := Void
			current_type := Void
			current_implementation := Void
			current_block := Void
			create entity_mapping.make
			create locals_map.make (5)
		end

	process_feature_of_type (a_feature: FEATURE_I; a_type: TYPE_A)
			-- Process body of feature `a_feature' of type `a_type'.
		local
			l_type: TYPE_A
			l_name: STRING
		do
			helper.set_up_byte_context (a_feature, a_type)
			if attached Context.byte_code as l_byte_code then
				if l_byte_code.compound /= Void and then not l_byte_code.compound.is_empty then
					if l_byte_code.locals /= Void then
						across l_byte_code.locals as i loop
							l_name := helper.unique_identifier ("local")
							l_type := i.item.deep_actual_type.instantiated_in (current_type)
							entity_mapping.set_local (i.cursor_index, create {IV_ENTITY}.make (l_name, types.for_type_a (l_type)))
							current_implementation.add_local (l_name, types.for_type_a (l_type))
						end
					end
					process_compound (l_byte_code.compound)
				end
			end
		end

	process_compound (a_compound: BYTE_LIST [BYTE_NODE])
			-- Process `a_compound'.
		do
			safe_process_b (a_compound)
		end

feature -- Processing

	process_assign_b (a_node: ASSIGN_B)
			-- <Precursor>
		local
			l_local: LOCAL_B
			l_result: RESULT_B
			l_attribute: ATTRIBUTE_B
			l_feature: FEATURE_I
			l_target_name: STRING

			l_target, l_source: IV_EXPRESSION
			l_assignment: IV_ASSIGNMENT
			l_call: IV_PROCEDURE_CALL
		do
			set_current_origin_information (a_node)

				-- Create target node
			if a_node.target.is_local then
				l_local ?= a_node.target
				check l_local /= Void end
				l_target := entity_mapping.local_ (l_local.position)
			elseif a_node.target.is_result then
				l_result ?= a_node.target
				check l_result /= Void end
				check current_feature.has_return_value end
				l_target := entity_mapping.result_expression
			elseif a_node.target.is_attribute then
				l_attribute ?= a_node.target
				check is_attribute: l_attribute /= Void end

				l_feature := helper.feature_for_call_access (l_attribute, current_type)
				check
					valid_feature: l_feature /= Void
					correct_feature: l_feature.feature_name_id = l_attribute.attribute_name_id
				end
				translation_pool.add_referenced_feature (l_feature, current_type)
				create {IV_HEAP_ACCESS} l_target.make (
					entity_mapping.heap.name,
					entity_mapping.current_expression,
					create {IV_ENTITY}.make (name_translator.boogie_procedure_for_feature (l_feature, current_type), types.field (types.for_type_a (l_feature.type)))
				)
			else
				check should_never_happen: False end
			end

				-- Create source node
			process_expression (a_node.source)
			l_source := last_expression

				-- Check for possible boxing of basic types
			if a_node.target.type.is_reference then
				if a_node.source.type.is_boolean then
					l_source := factory.function_call ("boxed_bool", << l_source >>, types.ref)
				elseif a_node.source.type.is_integer or a_node.source.type.is_natural then
					l_source := factory.function_call ("boxed_int", << l_source >>, types.ref)
				end
			end

				-- Create assignment node
			if a_node.target.is_attribute and options.is_ownership_enabled then
					-- OWNERSHIP: call update heap instead of direct heap assignment
				if l_attribute.attribute_name ~ "subjects" then
					create l_call.make ("update_subjects")
					l_call.add_argument (entity_mapping.current_expression)
				elseif l_attribute.attribute_name ~ "observers" then
					create l_call.make ("update_observers")
					l_call.add_argument (entity_mapping.current_expression)
				else
					-- Regular update_heap
					create l_call.make ("update_heap")
					l_call.add_argument (entity_mapping.current_expression)
					l_call.add_argument (create {IV_ENTITY}.make (name_translator.boogie_procedure_for_feature (l_feature, current_type), types.field (types.for_type_a (l_feature.type))))
				end
				l_call.add_argument (l_source)
				l_call.node_info.set_line (a_node.line_number)
				add_statement (l_call)
			else
				create l_assignment.make (l_target, l_source)
				add_statement (l_assignment)
			end
			add_trace_statement (a_node)
		end

	process_check_b (a_node: CHECK_B)
			-- <Precursor>
		local
			l_assert: ASSERT_B
		do
			if a_node.check_list /= Void then
				from
					a_node.check_list.start
				until
					a_node.check_list.after
				loop
					l_assert ?= a_node.check_list.item
					check l_assert /= Void end
					process_single_check (l_assert)
					a_node.check_list.forth
				end
			end
		end

	process_single_check (a_assert: ASSERT_B)
			-- Process single check statement.
		local
			l_statement: IV_ASSERT
			l_assume: IV_ASSUME
			l_array: ARRAY_CONST_B
			l_other: EXPR_B
		do
			if attached {BIN_TILDE_B} a_assert.expr as l_tilde then
				if attached {ARRAY_CONST_B} l_tilde.left as i then
					l_array := i
					l_other := l_tilde.right
				elseif attached {ARRAY_CONST_B} l_tilde.right as i then
					l_array := i
					l_other := l_tilde.left
				end
			end
			if l_array /= Void then
				check l_other.type.base_class.name.same_string ("ARRAY") end
				process_array_content_check (a_assert, l_array, l_other)
			else
				set_current_origin_information (a_assert)
				process_contract_expression (a_assert.expr)
				if attached a_assert.tag and then a_assert.tag.is_case_insensitive_equal ("assume") then
					create l_assume.make (last_expression)
					add_statement (l_assume)
				else
					create l_statement.make (last_expression)
					l_statement.node_info.set_type ("check")
					l_statement.node_info.set_tag (a_assert.tag)
					l_statement.node_info.set_line (a_assert.line_number)
					add_statement (l_statement)
				end
			end
		end

	process_array_content_check (a_assert: ASSERT_B; a_array: ARRAY_CONST_B; a_other: EXPR_B)
			-- Process a check instruction comparing array contents.
		local
			l_assert: IV_ASSERT
			l_array: IV_EXPRESSION
		do
			set_current_origin_information (a_assert)
			process_contract_expression (a_other)
			l_array := last_expression
				-- Check array size
			create l_assert.make (factory.equal (
				factory.function_call ("fun.ARRAY.count", << entity_mapping.heap, l_array >>, types.int),
				factory.int_value (a_array.expressions.count)))
			l_assert.node_info.set_type ("check")
			l_assert.node_info.set_tag ("array_size_equal")
			l_assert.node_info.set_line (a_assert.line_number)
			add_statement (l_assert)
				-- Check array contents
			across a_array.expressions as i loop
				process_contract_expression (i.item)
				create l_assert.make (factory.equal (
					factory.function_call ("fun.ARRAY.item", << entity_mapping.heap, l_array, factory.int_value (i.cursor_index) >>, types.generic_type),
					last_expression))
				l_assert.node_info.set_type ("check")
				l_assert.node_info.set_tag ("array_item_" + i.cursor_index.out)
				l_assert.node_info.set_line (a_assert.line_number)
				add_statement (l_assert)
			end
		end

	process_debug_b (a_node: DEBUG_B)
			-- Process `a_node'.
		do
			if a_node.compound /= Void then
					-- This debug clause is activated
				process_compound (a_node.compound)
			else
					-- This debug clause is not activated
				-- TODO: what to do?
			end
		end

	process_guard_b (a_node: GUARD_B)
			-- Process `a_node'.
		do
			process_check_b (a_node)
			if a_node.compound /= Void then
				process_compound (a_node.compound)
			end
		end

	process_if_b (a_node: IF_B)
			-- <Precursor>
		local
			l_if: IV_CONDITIONAL
			l_nested_if: IV_CONDITIONAL
			l_elseif: ELSIF_B
			l_temp_block: IV_BLOCK
			i: INTEGER
		do
			set_current_origin_information (a_node)

			l_temp_block := current_block

				-- if condition
			process_expression (a_node.condition)
			create l_if.make (last_expression)
			add_statement (l_if)

				-- then block
			current_block := l_if.then_block
			process_compound (a_node.compound)

				-- elseif blocks
			current_block := l_if.else_block
			if a_node.elsif_list /= Void then
				from
					i := a_node.elsif_list.lower
				until
					i > a_node.elsif_list.upper
				loop
					l_elseif ?= a_node.elsif_list.i_th (i)
					check l_elseif /= Void end
					set_current_origin_information (l_elseif)

						-- elseif condition
					process_expression (l_elseif.expr)
					create l_nested_if.make (last_expression)
					add_statement (l_nested_if)

						-- elseif block
					current_block := l_nested_if.then_block
					process_compound (l_elseif.compound)

						-- else block
					current_block := l_nested_if.else_block

					i := i + 1
				end
			end

				-- else block
			if a_node.else_part /= Void then
				process_compound (a_node.else_part)
			end

				-- restore context
			current_block := l_temp_block
		end

	process_inspect_b (a_node: INSPECT_B)
			-- <Precursor>
		local
			l_case: CASE_B
			l_temp_block, l_head_block, l_else_block, l_end_block: IV_BLOCK
			l_case_blocks: ARRAY [IV_BLOCK]
			l_case_conditions: ARRAY [IV_EXPRESSION]
			l_index: INTEGER
			l_entity: IV_ENTITY
			l_condition, l_lower, l_upper: IV_EXPRESSION
			l_binary: IV_BINARY_OPERATION
			l_assign: IV_ASSIGNMENT
			l_assume: IV_ASSUME
			l_goto: IV_GOTO
		do
			set_current_origin_information (a_node)

			l_temp_block := current_block
			create l_head_block.make
			create l_else_block.make_name (helper.unique_identifier ("inspect_else"))
			create l_end_block.make_name (helper.unique_identifier ("inspect_end"))

			create l_case_blocks.make_empty
			create l_case_conditions.make_empty

			create l_entity.make (helper.unique_identifier ("switch"), types.int)
			current_implementation.add_local (l_entity.name, types.int)

			set_current_block (l_head_block)
			process_expression (a_node.switch)
			create l_assign.make (l_entity, last_expression)
			add_statement (l_assign)

			if a_node.case_list /= Void then
				from
					a_node.case_list.start
				until
					a_node.case_list.after
				loop
					l_index := a_node.case_list.index
					l_case ?= a_node.case_list.item
					check l_case /= Void end

					if l_case.interval /= Void and then not l_case.interval.is_empty then
						from
							l_condition := Void
							l_case.interval.start
						until
							l_case.interval.after
						loop
							process_contract_expression (l_case.interval.item.lower)
							l_lower := last_expression
								-- TODO: check side effect
							process_contract_expression (l_case.interval.item.upper)
							l_upper := last_expression
								-- TODO: check side effect

							l_binary := factory.and_ (
								factory.less_equal (l_lower, l_entity),
								factory.less_equal (l_entity, l_upper))

							if l_condition = Void then
								l_condition := l_binary
							else
								l_condition := factory.or_ (l_condition, l_binary)
							end

							l_case.interval.forth
						end
					else
						create {IV_VALUE} l_condition.make ("false", types.bool)
					end

					set_current_origin_information (l_case)

					l_case_blocks.force (create {IV_BLOCK}.make_name (helper.unique_identifier ("inspect_case")), l_index)
					set_current_block (l_case_blocks.item (l_index))
					create l_assume.make (l_condition)
					add_statement (l_assume)
					process_compound (l_case.compound)
					create l_goto.make (l_end_block)
					add_statement (l_goto)

					l_case_conditions.force (l_condition, l_index)

					a_node.case_list.forth
				end
			end

				-- Else part
			set_current_block (l_else_block)
			across l_case_conditions as i loop
				create l_assume.make (factory.not_ (i.item))
				add_statement (l_assume)
			end
			if a_node.else_part /= Void then
				process_compound (a_node.else_part)
			end
			create l_goto.make (l_end_block)
			add_statement (l_goto)

				-- Switch in head
			set_current_block (l_head_block)
			create l_goto.make (l_else_block)
			across l_case_blocks as i loop
				l_goto.add_target (i.item)
			end
			add_statement (l_goto)

				-- Add blocks
			set_current_block (l_temp_block)
			add_statement (l_head_block)
			across l_case_blocks as i loop
				add_statement (i.item)
			end
			add_statement (l_else_block)
			add_statement (l_end_block)
		end

	process_instr_call_b (a_node: INSTR_CALL_B)
			-- <Precursor>
		do
			set_current_origin_information (a_node)
				-- Instruction call is in the side effect of the expression,
				-- so the generated expression itself is ignored.
			process_expression (a_node.call)
			add_trace_statement (a_node)
		end

	process_loop_b (a_node: LOOP_B)
			-- <Precursor>
		do
			if options.is_automatic_loop_unrolling_enabled and a_node.invariant_part = Void then
				process_loop_unrolled (a_node)
			else
				process_loop_normal (a_node)
			end
		end

	process_loop_normal (a_node: LOOP_B)
			-- Process loop in normal way.
		do
			if a_node.stop /= Void then
				process_from_loop_normal (a_node)
			else
--				process_across_loop_normal (a_node)
			end
		end

	process_from_loop_normal (a_node: LOOP_B)
			-- Process from loop in normal way.
		require
			from_loop: a_node.stop /= Void and a_node.iteration_exit_condition = Void
		local
			l_pre_heap: IV_ENTITY
			l_condition: IV_EXPRESSION
			l_variant_local: STRING
			l_invariant: ASSERT_B
			l_goto: IV_GOTO
			l_temp_block, l_head_block, l_body_block, l_end_block: IV_BLOCK
			l_assert: IV_ASSERT
			l_assume: IV_ASSUME
			l_not: IV_UNARY_OPERATION
			l_op: IV_BINARY_OPERATION
			l_variant: IV_ENTITY
			l_assignment: IV_ASSIGNMENT
		do
			set_current_origin_information (a_node)

			l_temp_block := current_block
			create l_head_block.make_name (helper.unique_identifier("loop_head"))
			create l_body_block.make_name (helper.unique_identifier("loop_body"))
			create l_end_block.make_name (helper.unique_identifier("loop_end"))

				-- Save pre-loop state
			create l_pre_heap.make (helper.unique_identifier ("PreLoopHeap"), types.heap)
			current_implementation.add_local (l_pre_heap.name, l_pre_heap.type)
			create l_assignment.make (l_pre_heap, entity_mapping.heap)
			add_statement (l_assignment)

				-- From part
			if a_node.from_part /= Void then
				a_node.from_part.process (Current)
			end
			create l_goto.make (l_head_block)
			add_statement (l_goto)
			add_statement (l_head_block)
			current_block := l_head_block

				-- Invariants
			if a_node.invariant_part /= Void then
				from
					a_node.invariant_part.start
				until
					a_node.invariant_part.after
				loop
					l_invariant ?= a_node.invariant_part.item
					set_current_origin_information (l_invariant)
					process_contract_expression (l_invariant.expr)
					across last_safety_checks as i loop
						create l_assert.make (i.item.expr)
						l_assert.node_info.load (i.item.info)
						l_assert.set_attribute_string (":subsumption 0")
						add_statement (l_assert)
					end
					if l_invariant.tag /= Void and then l_invariant.tag ~ "assume" then
							-- Free invariants with tag 'assume'
						create l_assume.make (last_expression)
						add_statement (l_assume)
					else
						create l_assert.make (last_expression)
						l_assert.node_info.set_type ("loop_inv")
						l_assert.node_info.set_tag (l_invariant.tag)
						l_assert.node_info.set_line (l_invariant.line_number)
						add_statement (l_assert)
					end
					a_node.invariant_part.forth
				end
			end
				-- Default invariants (free)			
			create l_assume.make (factory.function_call ("HeapSucc", <<l_pre_heap, "Heap">>, types.bool))
			add_statement (l_assume)
			if options.is_ownership_enabled then
				create l_assume.make (factory.writes_frame (current_feature, current_type, current_implementation.procedure,
					factory.old_ (create {IV_ENTITY}.make ("Heap", types.heap_type))))
				add_statement (l_assume)
				create l_assume.make (factory.function_call ("global", << "Heap" >>, types.bool))
				add_statement (l_assume)
			end

				-- Variant
			if a_node.variant_part /= Void then
				set_current_origin_information (a_node.variant_part)
				create l_variant.make (helper.unique_identifier ("variant"), types.int)
				current_implementation.add_local (l_variant.name, types.int)
				process_expression (a_node.variant_part.expr)
				create l_assignment.make (l_variant, last_expression)
				add_statement (l_assignment)
				create l_assert.make (factory.less_equal (factory.int_value (0), l_variant))
				l_assert.node_info.set_type ("loop_var_ge_zero")
				l_assert.node_info.set_tag (a_node.variant_part.tag)
				l_assert.node_info.set_line (a_node.variant_part.line_number)
				add_statement (l_assert)
			end

				-- Condition
			set_current_origin_information (a_node.stop)
			process_contract_expression (a_node.stop)
			l_condition := last_expression
			create l_goto.make (l_body_block)
			l_goto.add_target (l_end_block)
			add_statement (l_goto)
			current_block := l_temp_block

				-- Body
			add_statement (l_body_block)
			current_block := l_body_block

			create l_assume.make (factory.not_ (l_condition))
			add_statement (l_assume)
			process_compound (a_node.compound)
			if a_node.variant_part /= Void then
				set_current_origin_information (a_node.variant_part)
				process_expression (a_node.variant_part.expr)
				create l_assert.make (factory.less (last_expression, l_variant))
				l_assert.node_info.set_type ("loop_var_decr")
				l_assert.node_info.set_tag (a_node.variant_part.tag)
				l_assert.node_info.set_line (a_node.variant_part.line_number)
				add_statement (l_assert)
			end
			create l_goto.make (l_head_block)
			add_statement (l_goto)
			current_block := l_temp_block

			add_statement (l_end_block)
			current_block := l_end_block

			create l_assume.make (l_condition)
			add_statement (l_assume)

			current_block := l_temp_block
		end

	process_across_loop_normal (a_node: LOOP_B)
			-- Process across loop in a normal way.
		require
			from_loop: a_node.stop = Void and a_node.iteration_exit_condition /= Void
		local
			l_condition: IV_EXPRESSION
			l_variant_local: STRING
			l_invariant: ASSERT_B
			l_goto: IV_GOTO
			l_temp_block, l_head_block, l_body_block, l_end_block: IV_BLOCK
			l_assert: IV_ASSERT
			l_assume: IV_ASSUME
			l_not: IV_UNARY_OPERATION
			l_op: IV_BINARY_OPERATION
			l_variant: IV_ENTITY
			l_assignment: IV_ASSIGNMENT

			l_assign: ASSIGN_B
			l_across_handler: E2B_ACROSS_HANDLER
			l_object_test_local: OBJECT_TEST_LOCAL_B
			l_nested: NESTED_B
			l_access: ACCESS_EXPR_B
			l_bin_free: BIN_FREE_B
			l_name: STRING
		do
			set_current_origin_information (a_node.advance_code.first)

			l_assign ?= a_node.iteration_initialization.first
			check l_assign /= Void end
			l_object_test_local ?= l_assign.target
			check l_object_test_local /= Void end
			l_nested ?= l_assign.source
			check l_nested /= Void end
			l_access ?= l_nested.target
			check l_access /= Void end

			l_name := l_nested.target.type.associated_class.name_in_upper
			if l_name ~ "ARRAY" then
--				create {E2B_ARRAY_ACROSS_HANDLER} l_across_handler.make (Current, a_node, l_nested.target, l_object_test_local)
			elseif l_name ~ "INTEGER_INTERVAL" then
				l_bin_free ?= l_access.expr
				check l_bin_free /= Void end
--				create {E2B_INTERVAL_ACROSS_HANDLER} l_across_handler.make (Current, a_node, l_bin_free, l_object_test_local)
			else
				check False end
			end

			l_temp_block := current_block
			create l_head_block.make_name (helper.unique_identifier("loop_head"))
			create l_body_block.make_name (helper.unique_identifier("loop_body"))
			create l_end_block.make_name (helper.unique_identifier("loop_end"))

				-- From part
			if a_node.iteration_initialization /= Void then
				a_node.iteration_initialization.process (Current)
			end
			create l_goto.make (l_head_block)
			add_statement (l_goto)
			add_statement (l_head_block)
			current_block := l_head_block

				-- Invariants
			if a_node.invariant_part /= Void then
				from
					a_node.invariant_part.start
				until
					a_node.invariant_part.after
				loop
					l_invariant ?= a_node.invariant_part.item
					set_current_origin_information (l_invariant)
					process_contract_expression (l_invariant.expr)
					across last_safety_checks as i loop
						create l_assert.make (i.item.expr)
						l_assert.node_info.load (i.item.info)
						l_assert.set_attribute_string (":subsumption 0")
						add_statement (l_assert)
					end
					create l_assert.make (last_expression)
					l_assert.node_info.set_type ("loop_inv")
					l_assert.node_info.set_tag (l_invariant.tag)
					l_assert.node_info.set_line (l_invariant.line_number)
					add_statement (l_assert)
					a_node.invariant_part.forth
				end
			end

				-- Variant
			if a_node.variant_part /= Void then
				set_current_origin_information (a_node.variant_part)
				create l_variant.make (helper.unique_identifier ("variant"), types.int)
				current_implementation.add_local (l_variant.name, types.int)
				process_expression (a_node.variant_part.expr)
				create l_assignment.make (l_variant, last_expression)
				add_statement (l_assignment)
				create l_assert.make (factory.less_equal (factory.int_value (0), l_variant))
				l_assert.node_info.set_type ("loop_var_ge_zero")
				add_statement (l_assert)
			end

				-- Condition
			set_current_origin_information (a_node.iteration_exit_condition)
			process_contract_expression (a_node.iteration_exit_condition)
			l_condition := last_expression
			create l_goto.make (l_body_block)
			l_goto.add_target (l_end_block)
			add_statement (l_goto)
			current_block := l_temp_block

				-- Body
			add_statement (l_body_block)
			current_block := l_body_block

			create l_assume.make (factory.not_ (l_condition))
			add_statement (l_assume)
			process_compound (a_node.compound)
			if a_node.variant_part /= Void then
				set_current_origin_information (a_node.variant_part)
				process_expression (a_node.variant_part.expr)
				create l_assert.make (factory.less (last_expression, l_variant))
				l_assert.node_info.set_type ("loop_var_decr")
				add_statement (l_assert)
			end
			create l_goto.make (l_head_block)
			add_statement (l_goto)
			current_block := l_temp_block

			add_statement (l_end_block)
			current_block := l_end_block

			create l_assume.make (l_condition)
			add_statement (l_assume)

			current_block := l_temp_block
		end

	process_loop_unrolled (a_node: LOOP_B)
			-- Process loop with unrolling.
		local
			l_condition: IV_EXPRESSION
			l_variant_local: STRING
			l_invariant: ASSERT_B
			l_goto: IV_GOTO
			l_temp_block, l_head_block, l_body_block, l_end_block, l_force_end_block: IV_BLOCK
			l_assert: IV_ASSERT
			l_assume: IV_ASSUME
			l_not: IV_UNARY_OPERATION
			l_op: IV_BINARY_OPERATION
			l_variant: IV_ENTITY
			l_assignment: IV_ASSIGNMENT
			l_unroll_counter: INTEGER
		do
			l_temp_block := current_block

				-- Init condition
			set_current_origin_information (a_node.stop)
			process_expression (a_node.stop)
			l_condition := last_expression

				-- Init variant
			if a_node.variant_part /= Void then
				create l_variant.make (helper.unique_identifier ("variant"), types.int)
				current_implementation.add_local (l_variant.name, types.int)
			end

				-- Init end block
			l_temp_block := current_block
			create l_end_block.make_name (helper.unique_identifier("loop_end"))

				-- From part
			set_current_origin_information (a_node)
			if a_node.from_part /= Void then
				a_node.from_part.process (Current)
			end

				-- Unrolled body
			from
				l_unroll_counter := 1
			until
				l_unroll_counter > options.loop_unrolling_depth
			loop
				create l_head_block.make_name (helper.unique_identifier("loop_head"+l_unroll_counter.out))
				create l_body_block.make_name (helper.unique_identifier("loop_body"+l_unroll_counter.out))

					-- goto head
				create l_goto.make (l_head_block)
				add_statement (l_goto)

					-- head
				current_block := l_temp_block
				add_statement (l_head_block)
				current_block := l_head_block

					-- Invariants
				if a_node.invariant_part /= Void then
					from
						a_node.invariant_part.start
					until
						a_node.invariant_part.after
					loop
						l_invariant ?= a_node.invariant_part.item
						set_current_origin_information (l_invariant)
						process_contract_expression (l_invariant.expr)
						create l_assert.make (last_expression)
						l_assert.node_info.set_type ("loop_inv")
						l_assert.node_info.set_tag (l_invariant.tag)
						l_assert.node_info.set_line (l_invariant.line_number)
						add_statement (l_assert)
						a_node.invariant_part.forth
					end
				end

					-- Variant
				if a_node.variant_part /= Void then
					set_current_origin_information (a_node.variant_part)
					process_expression (a_node.variant_part.expr)
					create l_assignment.make (l_variant, last_expression)
					add_statement (l_assignment)
					create l_op.make (l_variant, ">=", create {IV_VALUE}.make ("0", types.int), types.bool)
					create l_assert.make (l_op)
					l_assert.node_info.set_type ("loop_var_ge_zero")
					add_statement (l_assert)
				end

					-- goto end or body
				create l_goto.make (l_body_block)
				l_goto.add_target (l_end_block)
				add_statement (l_goto)

					-- body
				current_block := l_temp_block
				add_statement (l_body_block)
				current_block := l_body_block

				create l_not.make ("!", l_condition, types.bool)
				create l_assume.make (l_not)
				add_statement (l_assume)
				process_compound (a_node.compound)

				if a_node.variant_part /= Void then
					set_current_origin_information (a_node.variant_part)
					process_expression (a_node.variant_part.expr)
					create l_op.make (last_expression, "<", l_variant, types.bool)
					create l_assert.make (l_op)
					l_assert.node_info.set_type ("loop_var_decr")
					add_statement (l_assert)
				end

				l_unroll_counter := l_unroll_counter + 1
			end

			if options.is_sound_loop_unrolling_enabled then
				create l_goto.make (l_head_block)
				add_statement (l_goto)
			else
				create l_force_end_block.make_name (helper.unique_identifier("force_end"))
				create l_goto.make (l_force_end_block)
				add_statement (l_goto)

					-- force end
				current_block := l_temp_block
				add_statement (l_force_end_block)
				current_block := l_force_end_block

					-- Invariants
				if a_node.invariant_part /= Void then
					from
						a_node.invariant_part.start
					until
						a_node.invariant_part.after
					loop
						l_invariant ?= a_node.invariant_part.item
						set_current_origin_information (l_invariant)
						process_contract_expression (l_invariant.expr)
						create l_assert.make (last_expression)
						add_statement (l_assert)
						a_node.invariant_part.forth
					end
				end

					-- Variant
				if a_node.variant_part /= Void then
					set_current_origin_information (a_node.variant_part)
					current_implementation.add_local (l_variant.name, types.int)
					process_expression (a_node.variant_part.expr)
					create l_assignment.make (l_variant, last_expression)
					add_statement (l_assignment)
					create l_op.make (l_variant, ">=", create {IV_VALUE}.make ("0", types.int), types.bool)
					create l_assert.make (l_op)
					add_statement (l_assert)
				end
			end

				-- end
			current_block := l_temp_block
			add_statement (l_end_block)
			current_block := l_end_block

			create l_assume.make (l_condition)
			add_statement (l_assume)

			current_block := l_temp_block
		end

	process_nested_b (a_node: NESTED_B)
			-- <Precursor>
		do
			set_current_origin_information (a_node)
				-- Instruction call is in the side effect of the expression,
				-- so the generated expression itself is ignored.
			process_expression (a_node)
			add_trace_statement (a_node)
		end

	process_retry_b (a_node: RETRY_B)
			-- <Precursor>
		local
			l_havoc: IV_HAVOC
		do
			create l_havoc.make (entity_mapping.heap.name)
			l_havoc.set_origin_information (origin_information (a_node))
			current_block.add_statement (l_havoc)
		end

	process_reverse_b (a_node: REVERSE_B)
			-- <Precursor>
		local
			l_havoc: IV_HAVOC
		do
			create l_havoc.make (entity_mapping.heap.name)
			l_havoc.set_origin_information (origin_information (a_node))
			current_block.add_statement (l_havoc)
		end

feature {NONE} -- Implementation

	current_origin_information: detachable IV_STATEMENT_ORIGIN

	set_current_origin_information (a_node: BYTE_NODE)
			-- Set origin information to be used by first side effect or statement generated.
		do
			current_origin_information := origin_information (a_node)
		end

	origin_information (a_node: BYTE_NODE): IV_STATEMENT_ORIGIN
			-- Origin information of node `a_node'.
		local
			l_error: BOOLEAN
		do
			if l_error then
				create Result
				Result.set_file (current_feature.written_class.file_name.as_string_8)
				Result.set_line (-1)
			else
				create Result
				Result.set_file (current_feature.written_class.file_name.as_string_8)
				Result.set_line (a_node.line_number)
			end
		rescue
				-- a_node.line_number might result in a postcondition violation
			l_error := True
			retry
		end

	add_statement (a_statement: IV_STATEMENT)
			-- Add statement and possibly add origin information.
		do
			if attached current_origin_information as coi then
				a_statement.set_origin_information (coi)
				current_origin_information := Void
			end
			current_block.add_statement (a_statement)
		end

	add_trace_statement (a_node: BYTE_NODE)
			-- Add statement and possibly add origin information.
		do
			if options.is_trace_enabled then
				current_block.add_statement (factory.trace (name_translator.boogie_procedure_for_feature (current_feature, current_type) + ":" + a_node.line_number.out))
			end
		end

	process_expression (a_expr: BYTE_NODE)
			-- Process expression `a_expr'.
		local
			l_translator: E2B_BODY_EXPRESSION_TRANSLATOR
		do
			create l_translator.make
			l_translator.set_context (current_feature, current_type)
			l_translator.set_context_implementation (current_implementation)
			l_translator.set_context_line_number (current_origin_information.line)
			l_translator.copy_entity_mapping (entity_mapping)
			l_translator.locals_map.merge (locals_map)
			a_expr.process (l_translator)
			if not l_translator.side_effect.is_empty and attached current_origin_information as coi then
				l_translator.side_effect.first.set_origin_information (coi)
				current_origin_information := Void
			end
			l_translator.side_effect.do_all (agent current_block.add_statement (?))
			last_expression := l_translator.last_expression
			if last_expression = Void then
				last_expression := factory.false_
			end
			locals_map.merge (l_translator.locals_map)
		end

	process_contract_expression (a_expr: BYTE_NODE)
			-- Process expression `a_expr'.
		local
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
		do
			create l_translator.make
			l_translator.set_context (current_feature, current_type)
			l_translator.copy_entity_mapping (entity_mapping)
			l_translator.locals_map.merge (locals_map)
			a_expr.process (l_translator)
			last_expression := l_translator.last_expression
			last_safety_checks := l_translator.side_effect
			if last_expression = Void then
				last_expression := factory.false_
			end
			locals_map.merge (l_translator.locals_map)
		end

	last_expression: IV_EXPRESSION
			-- Last generated expression.

	last_safety_checks: LINKED_LIST [TUPLE [expr: IV_EXPRESSION; info: IV_NODE_INFO]]
			-- List of last generated safety checks.

	locals_map: HASH_TABLE [IV_EXPRESSION, INTEGER]
			-- Mapping for object test locals.

end
