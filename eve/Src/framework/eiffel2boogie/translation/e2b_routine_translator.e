note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_ROUTINE_TRANSLATOR

inherit

	E2B_ROUTINE_TRANSLATOR_BASE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize routine translator.
		do
		end

feature -- Basic operations

	translate_routine_signature (a_feature: FEATURE_I; a_type: TYPE_A)
			-- Translate signature of feature `a_feature' of type `a_type'.
		do
			translate_signature (a_feature, a_type, False)
		end

	translate_creator_signature (a_feature: FEATURE_I; a_type: TYPE_A)
			-- Translate signature of feature `a_feature' of type `a_type'.
		do
			translate_signature (a_feature, a_type, True)
		end

	translate_default_create_signature (a_feature: FEATURE_I; a_type: TYPE_A)
			-- Translate signature of feature `a_feature' of type `a_type'.
		do
			translate_signature (a_feature, a_type, True)
			-- TODO: create special signature
		end

	translate_signature (a_feature: FEATURE_I; a_type: TYPE_A; a_for_creator: BOOLEAN)
			-- Translate signature of feature `a_feature' of type `a_type'.
		require
			routine: a_feature.is_routine
		local
			l_proc_name: STRING
			l_contracts: like contracts_of
			l_fields: LINKED_LIST [TUPLE [o: IV_EXPRESSION; f: IV_ENTITY]]
			l_modifies: IV_MODIFIES
			l_type: TYPE_A
		do
			set_context (a_feature, a_type)

				-- Set up name
			if a_for_creator then
				l_proc_name := name_translator.boogie_name_for_creation_routine (current_feature, current_type)
			else
				l_proc_name := name_translator.boogie_name_for_feature (current_feature, current_type)
			end

				-- Initialize procedure
			set_up_boogie_procedure (l_proc_name)

				-- Arguments
			add_argument_with_property ("Current", current_type, types.ref)
			across arguments_of_current_feature as i loop
				add_argument_with_property (i.item.name, i.item.type, i.item.boogie_type)
			end

				-- Result type
			add_result_with_property

				-- Modifies
			create l_modifies.make ("Heap")
			l_modifies.add_name ("Writes")
			current_boogie_procedure.add_contract (l_modifies)

				-- Pre- and postconditions
			if options.is_precondition_predicate_enabled then
				add_precondition_predicate
			end
			if options.is_postcondition_predicate_enabled then
				add_postcondition_predicate
			end
			l_contracts := contracts_of (current_feature, current_type)
			across l_contracts.pre as j loop
				process_precondition (j.item)
			end
			create l_fields.make
			across l_contracts.post as j loop
				process_postcondition (j.item, l_fields)
			end

			if not l_contracts.modifies.is_empty then
				check True end
			end
			if not l_contracts.reads.is_empty then
				check True end
			end

			generate_writes_set_function

				-- Framing
			if options.is_using_ownership then
					-- Ownership default
				add_ownership_conditions

				if a_for_creator then
						-- Creator
					add_ownership_conditions_for_creator
				elseif a_feature.is_exported_for (system.any_class.compiled_class) then
						-- Public routine
					add_ownership_conditions_for_public
				end
			else
				if helper.feature_note_values (current_feature, "framing").has ("False") then
						-- No frame condition
				elseif helper.feature_note_values (current_feature, "pure").has ("True") then
						-- Pure feature
					add_pure_frame_condition
				elseif helper.feature_note_values (current_feature, "pure_fresh").has ("True") then
					add_pure_fresh_frame_condition
				else
						-- Normal frame condition
					process_fields_list (l_fields)
				end
			end

			add_invariant_conditions
		end

	add_invariant_conditions
		local
			l_fcall: IV_FUNCTION_CALL
			l_pre: IV_PRECONDITION
			l_post: IV_POSTCONDITION
			l_info: IV_ASSERTION_INFORMATION
		do
			translation_pool.add_type (current_type)
			l_fcall := factory.function_call (
				name_translator.boogie_name_for_invariant_function (current_type),
				<< "Heap", "Current" >>,
				types.bool)
			create l_pre.make (l_fcall)
			l_pre.set_free
			current_boogie_procedure.add_contract (l_pre)
			create l_post.make (l_fcall)
--			create l_info.make ("post")
--			l_info.set_tag ("invariant")
--			l_post.set_information (l_info)
			l_post.set_assertion_type ("post")
			current_boogie_procedure.add_contract (l_post)
		end

	add_ownership_conditions
		local
			l_fcall: IV_FUNCTION_CALL
			l_pre: IV_PRECONDITION
			l_post: IV_POSTCONDITION
		do
			create l_pre.make (factory.function_call ("global", << "Heap", "Writes" >>, types.bool))
			l_pre.set_free
			current_boogie_procedure.add_contract (l_pre)

			create l_fcall.make (name_translator.boogie_name_for_writes_set_function (current_feature, current_type), types.set (types.ref))
			l_fcall.add_argument (create {IV_ENTITY}.make ("Heap", types.heap_type))
			across current_boogie_procedure.arguments as i loop
				l_fcall.add_argument (i.item.entity)
			end
			create l_pre.make (
				factory.function_call (
					"Set#Subset",
					<<
						l_fcall,
						"Writes"
					>>,
					types.bool))
			l_pre.set_assertion_type ("pre")
			current_boogie_procedure.add_contract (l_pre)

			create l_post.make (factory.function_call ("global", << "Heap", "Writes" >>, types.bool))
			l_post.set_free
			current_boogie_procedure.add_contract (l_post)

			create l_post.make (
				factory.function_call (
					"writes_changed",
					<<
						factory.old_ (create {IV_ENTITY}.make ("Heap", types.heap_type)),
						create {IV_ENTITY}.make ("Heap", types.heap_type),
						factory.old_ (create {IV_ENTITY}.make ("Writes", types.set (types.ref))),
						create {IV_ENTITY}.make ("Writes", types.set (types.ref))
					>>,
					types.bool))
			l_post.set_free
			current_boogie_procedure.add_contract (l_post)

			create l_fcall.make (name_translator.boogie_name_for_writes_set_function (current_feature, current_type), types.set (types.ref))
			l_fcall.add_argument (factory.old_ (create {IV_ENTITY}.make ("Heap", types.heap_type)))
			across current_boogie_procedure.arguments as i loop
				l_fcall.add_argument (i.item.entity)
			end
			create l_post.make (
				factory.function_call (
					"writes",
					<<
						factory.old_ (create {IV_ENTITY}.make ("Heap", types.heap_type)),
						create {IV_ENTITY}.make ("Heap", types.heap_type),
						l_fcall
					>>,
					types.bool))
			l_post.set_free
			current_boogie_procedure.add_contract (l_post)
--			translation_pool.add_writes_function (current_feature, current_type)
		end

	add_ownership_conditions_for_creator
		local
			l_pre: IV_PRECONDITION
			l_post: IV_POSTCONDITION
			l_heap_access: IV_HEAP_ACCESS
		do
			create l_pre.make (factory.function_call ("is_open", << "Heap", "Current" >>, types.bool))
			current_boogie_procedure.add_contract (l_pre)

			create l_heap_access.make ("Heap", create {IV_ENTITY}.make ("Current", types.ref), create {IV_ENTITY}.make ("observers", types.set (types.ref)))
			create l_pre.make (factory.equal (
				l_heap_access,
				factory.function_call ("Set#Empty", Void, types.set (types.ref))))
			current_boogie_procedure.add_contract (l_pre)

			create l_post.make (factory.function_call ("is_wrapped", << "Heap", "Current" >>, types.bool))
			l_post.set_assertion_type ("post")
			current_boogie_procedure.add_contract (l_post)
		end

	add_ownership_conditions_for_public
		local
			l_pre: IV_PRECONDITION
			l_post: IV_POSTCONDITION
		do
			create l_pre.make (factory.function_call ("is_wrapped", << "Heap", "Current" >>, types.bool))
			l_pre.set_assertion_type ("pre")
			l_pre.set_assertion_tag ("target_wrapped")
			current_boogie_procedure.add_contract (l_pre)

			create l_post.make (factory.function_call ("is_wrapped", << "Heap", "Current" >>, types.bool))
			l_post.set_assertion_type ("post")
			l_post.set_assertion_tag ("target_wrapped")
			current_boogie_procedure.add_contract (l_post)
		end

	translate_routine_implementation (a_feature: FEATURE_I; a_type: TYPE_A)
			-- Translate implementation of feature `a_feature' of type `a_type'.
		require
			routine: a_feature.is_routine
		do
			translate_implementation (a_feature, a_type, False)
		end

	translate_creator_implementation (a_feature: FEATURE_I; a_type: TYPE_A)
			-- Translate implementation of feature `a_feature' of type `a_type'.
		do
			translate_implementation (a_feature, a_type, True)
		end

	translate_implementation (a_feature: FEATURE_I; a_type: TYPE_A; a_for_creator: BOOLEAN)
			-- Translate implementation of feature `a_feature' of type `a_type'.
		local
			l_procedure: IV_PROCEDURE
			l_implementation: IV_IMPLEMENTATION
			l_translator: E2B_INSTRUCTION_TRANSLATOR
			l_type: TYPE_A
			l_proc_name, l_local_name: STRING
			l_values: ARRAYED_LIST [STRING_32]
			l_assign: IV_ASSIGNMENT
			l_attribute: FEATURE_I
		do
			set_context (a_feature, a_type)
			set_inlining_options_for_feature (a_feature)

			if a_for_creator then
				l_proc_name := name_translator.boogie_name_for_creation_routine (current_feature, current_type)
			else
				l_proc_name := name_translator.boogie_name_for_feature (current_feature, current_type)
			end

			l_procedure := boogie_universe.procedure_named (l_proc_name)
			check l_procedure /= Void end
			current_boogie_procedure := l_procedure

			create l_implementation.make (l_procedure)
			boogie_universe.add_declaration (l_implementation)

			create l_translator.make
			l_translator.set_context (l_implementation, current_feature, current_type)

				-- Add initial tracing information
			l_implementation.body.add_statement (factory.trace (l_proc_name))

			if a_for_creator then
					-- Add creator initialization for ownership
				create l_assign.make (factory.heap_current_access (l_translator.entity_mapping, "owns", types.set (types.ref)), factory.function_call ("Set#Empty", <<>>, types.set (types.ref)))
				l_implementation.body.add_statement (l_assign)
				create l_assign.make (factory.heap_current_access (l_translator.entity_mapping, "subjects", types.set (types.ref)), factory.function_call ("Set#Empty", <<>>, types.set (types.ref)))
				l_implementation.body.add_statement (l_assign)
					-- Add creator initialization for attributes
				from
					current_type.base_class.feature_table.start
				until
					current_type.base_class.feature_table.after
				loop
					l_attribute := current_type.base_class.feature_table.item_for_iteration
					if l_attribute.is_attribute then
						translation_pool.add_referenced_feature (l_attribute, current_type)
						l_local_name := name_translator.boogie_name_for_feature (l_attribute, current_type)
						create l_assign.make (
							factory.heap_current_access (l_translator.entity_mapping, l_local_name, types.for_type_a (l_attribute.type)),
							factory.default_value (l_attribute.type))
						l_implementation.body.add_statement (l_assign)
					end
					current_type.base_class.feature_table.forth
				end
			end

				-- Process statements (byte node tree)
			helper.set_up_byte_context (current_feature, current_type)
			if attached Context.byte_code as l_byte_code then
				if l_byte_code.compound /= Void and then not l_byte_code.compound.is_empty then
					if l_byte_code.locals /= Void then
						across l_byte_code.locals as i loop
							l_type := i.item.deep_actual_type.instantiated_in (current_type)
							l_local_name := name_translator.boogie_name_for_local (i.cursor_index)
							l_translator.entity_mapping.set_local (i.cursor_index, create {IV_ENTITY}.make (l_local_name, types.for_type_a (l_type)))
							l_implementation.add_local (l_local_name, types.for_type_a (l_type))
						end
					end
					l_translator.process_compound (l_byte_code.compound)
				end
			end

			if a_for_creator then
--					-- Creator finalizer: set "initialized" to true
--				create l_assign.make (factory.heap_current_initialized (l_translator.entity_mapping), factory.true_)
--				l_implementation.body.add_statement (l_assign)
			end
		end


	translate_functional_representation (a_feature: FEATURE_I; a_type: TYPE_A)
			-- Translate implementation of feature `a_feature' of type `a_type'.
		local
			l_function: IV_FUNCTION
			l_boogie_type: IV_TYPE
			l_type: TYPE_A
			i: INTEGER
		do
			set_context (a_feature, a_type)
			helper.set_up_byte_context (current_feature, current_type)

				-- Function
			create l_function.make (
				name_translator.boogie_name_for_functional_feature (current_feature, current_type),
				types.for_type_a (a_feature.type.deep_actual_type.instantiated_in (current_type))
			)
			boogie_universe.add_declaration (l_function)

				-- Arguments
			translation_pool.add_type (current_type)
			l_function.add_argument ("heap", types.heap_type)
			l_function.add_argument ("current", types.ref)
			from i := 1 until i > current_feature.argument_count loop
				l_type := current_feature.arguments.i_th (i).deep_actual_type.instantiated_in (current_type)
				translation_pool.add_type (l_type)
				l_boogie_type := types.for_type_a (l_type)
				l_function.add_argument (current_feature.arguments.item_name (i), l_boogie_type)
				i := i + 1
			end

				-- Axiom
			generate_functional_axiom (l_function)

		end

	translate_writes_function (a_feature: FEATURE_I; a_type: TYPE_A)
			-- Translate implementation of feature `a_feature' of type `a_type'.
		local
			l_function: IV_FUNCTION
			l_boogie_type: IV_TYPE
			l_type: TYPE_A
			i: INTEGER
		do
			set_context (a_feature, a_type)
			helper.set_up_byte_context (current_feature, current_type)

				-- Function
			create l_function.make (
				name_translator.boogie_name_for_writes_set_function (current_feature, current_type),
				types.set (types.ref)
			)
			boogie_universe.add_declaration (l_function)

				-- Arguments
			translation_pool.add_type (current_type)
			l_function.add_argument ("heap", types.heap_type)
			l_function.add_argument ("current", types.ref)
			from i := 1 until i > current_feature.argument_count loop
				l_type := current_feature.arguments.i_th (i).deep_actual_type.instantiated_in (current_type)
				translation_pool.add_type (l_type)
				l_boogie_type := types.for_type_a (l_type)
				l_function.add_argument (current_feature.arguments.item_name (i), l_boogie_type)
				i := i + 1
			end

				-- Expression
			l_function.set_body (factory.function_call ("Set#Singleton", << "current" >>, types.set (types.ref)))

		end

	generate_functional_axiom (a_function: IV_FUNCTION)
			-- Generate functional axiom for `a_function'.
		local
			l_contracts: TUPLE [pre: LIST [ASSERT_B]; post: LIST [ASSERT_B]]
			l_axiom: IV_AXIOM
			l_forall: IV_FORALL
			l_pre: IV_EXPRESSION
			l_post: IV_EXPRESSION
			l_and, l_implies: IV_BINARY_OPERATION
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
			l_function_call: IV_FUNCTION_CALL
		do
			l_contracts := contracts_of_current_feature
			if l_contracts.pre.is_empty then
				l_pre := create {IV_ENTITY}.make ("true", types.bool)
			else
				across l_contracts.pre as c loop
					l_translator := translator_for_function (a_function)
					c.item.process (l_translator)
					if attached l_pre then
						l_pre := create {IV_BINARY_OPERATION}.make (l_pre, "&&", l_translator.last_expression, types.bool)
					else
						l_pre := l_translator.last_expression
					end
				end
			end
			if l_contracts.post.is_empty then
				l_post := create {IV_ENTITY}.make ("true", types.bool)
			else
				across l_contracts.post as c loop
					l_translator := translator_for_function (a_function)
					c.item.process (l_translator)
					if attached l_post then
						l_post := create {IV_BINARY_OPERATION}.make (l_post, "&&", l_translator.last_expression, types.bool)
					else
						l_post := l_translator.last_expression
					end
				end
			end
			create l_implies.make (l_pre, "==>", l_post, types.bool)
			create l_forall.make (l_implies)
			l_forall.bound_variables.append (a_function.arguments)
			create l_axiom.make (l_forall)
			boogie_universe.add_declaration (l_axiom)
		end

	translator_for_function (a_function: IV_FUNCTION): E2B_CONTRACT_EXPRESSION_TRANSLATOR
			-- TODO
		local
			i: INTEGER
			l_function_call: IV_FUNCTION_CALL
			l_boogie_type: IV_TYPE
			l_type: TYPE_A
		do
			create Result.make
			Result.entity_mapping.set_current (create {IV_ENTITY}.make ("current", types.ref))
			Result.entity_mapping.set_heap (create {IV_ENTITY}.make ("heap", types.heap_type))
			Result.set_context (current_feature, current_type)
			create l_function_call.make (a_function.name, a_function.type)
			l_function_call.add_argument (Result.entity_mapping.heap)
			l_function_call.add_argument (Result.entity_mapping.current_expression)
			from i := 1 until i > current_feature.argument_count loop
				l_type := current_feature.arguments.i_th (i).deep_actual_type.instantiated_in (current_type)
				l_boogie_type := types.for_type_a (l_type)
				l_function_call.add_argument (create {IV_ENTITY}.make(current_feature.arguments.item_name (i), l_boogie_type))
				i := i + 1
			end
			Result.entity_mapping.set_result (l_function_call)
		end

	translate_precondition_predicate (a_feature: FEATURE_I; a_type: TYPE_A)
			-- Translate preconditino predicate of feature `a_feature' of type `a_type'.
		do

		end

	translate_postcondition_predicate (a_feature: FEATURE_I; a_type: TYPE_A)
			-- Translate postconditino predicate of feature `a_feature' of type `a_type'.
		local
			l_procedure: IV_PROCEDURE
			l_function: IV_FUNCTION
			l_axiom: IV_AXIOM
		do
			set_context (a_feature, a_type)

			l_procedure := boogie_universe.procedure_named (name_translator.boogie_name_for_feature (current_feature, current_type))
			check l_procedure /= Void end
			current_boogie_procedure := l_procedure

				-- Function declaration
			create l_function.make (name_translator.postcondition_predicate_name (current_feature, current_type), types.bool)
			l_function.add_argument ("heap", types.heap_type)
			l_function.add_argument ("old_heap", types.heap_type)
			across current_boogie_procedure.arguments as i loop
				l_function.add_argument (i.item.name, i.item.type)
			end
			if a_feature.has_return_value then
				l_function.add_argument ("result", types.for_type_a (a_feature.type))
			end
			boogie_universe.add_declaration (l_function)

				-- Axioms per redefinition.
			generate_postcondition_axiom (current_feature, current_type, current_type)
				-- TODO: generate postcondition axiom for all known subtypes with redefined contracts
			if not current_feature.written_class.name_in_upper.is_equal ("ANY") then
				across current_feature.written_class.direct_descendants as d loop
					generate_postcondition_axiom (d.item.feature_named_32 (current_feature.feature_name_32), current_type, d.item.actual_type)
				end
			end
--			current_feature.written_class.direct_descendants.item.feature_of_rout_id_set (current_feature.rout_id_set)
		end

	generate_postcondition_axiom (a_feature: FEATURE_I; a_context_type: TYPE_A; a_postcondition_type: TYPE_A)
			-- Generate postcondition axiom for `current_feature' of type `a_context_type' for subtype `a_postcondition_type'.
		local
			l_contracts: TUPLE [pre: IV_EXPRESSION; post: IV_EXPRESSION]
			l_mapping: E2B_ENTITY_MAPPING
			l_heap, l_old_heap, l_current, l_result, l_arg: IV_ENTITY
			l_args: LINKED_LIST [IV_ENTITY]
			l_forall: IV_FORALL
			l_axiom: IV_AXIOM
			l_fcall, l_typeof: IV_FUNCTION_CALL
			l_type_value: IV_VALUE
			l_binop1, l_binop2, l_binop3: IV_BINARY_OPERATION
			i: INTEGER
		do
			create l_mapping.make
			create l_fcall.make (name_translator.postcondition_predicate_name (a_feature, a_context_type), types.bool)
			create l_heap.make ("heap", types.heap_type)
			l_fcall.add_argument (l_heap)
			l_mapping.set_heap (l_heap)
			create l_old_heap.make ("old_heap", types.heap_type)
			l_fcall.add_argument (l_old_heap)
			l_mapping.set_old_heap (l_old_heap)
			create l_current.make ("current", types.ref)
			l_fcall.add_argument (l_current)
			l_mapping.set_current (l_current)
			create l_args.make
			from i := 1 until i > a_feature.argument_count loop
				create l_arg.make (a_feature.arguments.item_name (i), types.for_type_a (a_feature.arguments.i_th (i)))
				l_fcall.add_argument (l_arg)
				l_mapping.set_argument (i, l_arg)
				l_args.extend (l_arg)
				i := i + 1
			end
			if a_feature.has_return_value then
				create l_result.make ("result", types.for_type_a (a_feature.type))
				l_fcall.add_argument (l_result)
				l_mapping.set_result (l_result)
			end

			l_contracts := contract_expressions_of (a_feature, a_postcondition_type, l_mapping)
			create l_typeof.make ("type_of", types.type)
			l_typeof.add_argument (l_current)
			create l_type_value.make (name_translator.boogie_name_for_type (a_postcondition_type), types.type)
			create l_binop1.make (l_typeof, "<:", l_type_value, types.bool)
			create l_binop2.make (l_fcall, "==>", l_contracts.post, types.bool)
			create l_binop3.make (l_binop1, "==>", l_binop2, types.bool)

			create l_forall.make (l_binop3)
			l_forall.add_bound_variable (l_heap.name, l_heap.type)
			l_forall.add_bound_variable (l_old_heap.name, l_old_heap.type)
			l_forall.add_bound_variable (l_current.name, l_current.type)
			across l_args as j loop
				l_forall.add_bound_variable (j.item.name, j.item.type)
			end
			if a_feature.has_return_value then
				l_forall.add_bound_variable (l_result.name, l_result.type)
			end
			create l_axiom.make (l_forall)
			boogie_universe.add_declaration (l_axiom)
		end

	generate_writes_set_function
			-- Generate writes function of current feature.
		local
			l_name: STRING
			l_fdecl: IV_FUNCTION
			l_contracts: like contracts_of
		do
			l_name := name_translator.boogie_name_for_writes_set_function (current_feature, current_type)

			create l_fdecl.make (l_name, types.set (types.ref))
			boogie_universe.add_declaration (l_fdecl)

			l_fdecl.add_argument ("heap", types.heap)
			across current_boogie_procedure.arguments as i loop
				l_fdecl.add_argument (i.item.name, i.item.type)
			end

			l_contracts := contracts_of_current_feature
			l_fdecl.set_body (modifies_set (l_contracts.modifies))
		end

	modifies_set (a_modifies: LIST [ASSERT_B]): IV_EXPRESSION
		local
			l_expr: IV_EXPRESSION
		do
			across a_modifies as i loop
				if attached {FEATURE_B} i.item.expr as l_call then
					if attached {TUPLE_CONST_B} l_call.parameters.first.expression as l_tuple then
						across l_tuple.expressions as j loop
							l_expr := factory.function_call ("Set#Singleton", << parse_modifies_expr (j.item) >>, types.set (types.ref))
							if Result = Void then
								Result := l_expr
							else
								Result := factory.function_call ("Set#Union", << Result, l_expr >>, types.set (types.ref))
							end
						end
					else
						l_expr := factory.function_call ("Set#Singleton", << parse_modifies_expr (l_call.parameters.first.expression) >>, types.set (types.ref))
						if Result = Void then
							Result := l_expr
						else
							Result := factory.function_call ("Set#Union", << Result, l_expr >>, types.set (types.ref))
						end
					end
				end
			end
		end

	parse_modifies_expr (a_expr: EXPR_B): IV_EXPRESSION
		local
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
		do
			create l_translator.make
			l_translator.set_context (current_feature, current_type)
			l_translator.entity_mapping.set_heap (create {IV_ENTITY}.make ("heap", types.heap))
--			l_translator.entity_mapping.set_current (create {IV_ENTITY}.make ("current", types.heap))

			a_expr.process (l_translator)

			Result := l_translator.last_expression
		end

feature {NONE} -- Implementation

	set_inlining_options_for_feature (a_feature: FEATURE_I)
			-- Set inlining options for feature `a_feature'.
		do
			options.set_inlining_depth (0)
			if options.is_inlining_enabled then
				if helper.boolean_feature_note_value (a_feature, "inline") then
					options.set_inlining_depth (1)
				elseif helper.integer_feature_note_value (a_feature, "inline") > 0 then
					options.set_inlining_depth (helper.integer_feature_note_value (a_feature, "inline"))
				elseif options.routines_to_inline.has (a_feature.body_index) then
					options.set_inlining_depth (1)
				else
					options.set_inlining_depth (0)
				end
			end
		end

	process_precondition (a_assert: ASSERT_B)
			-- Process `a_assert' as precondition.
		local
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
			l_contract: IV_PRECONDITION
			l_info: IV_ASSERTION_INFORMATION
		do
			create l_translator.make
			l_translator.set_context (current_feature, current_type)
			a_assert.process (l_translator)
			across l_translator.side_effect as i loop
				create l_contract.make (i.item.expr)
				l_contract.set_information (i.item.info)
				current_boogie_procedure.add_contract (l_contract)
			end
			create l_contract.make (l_translator.last_expression)
			create l_info.make ("pre")
			l_info.set_line (a_assert.line_number)
			l_info.set_tag (a_assert.tag)
			l_contract.set_information (l_info)
			if options.is_precondition_predicate_enabled then
				l_contract.set_free
			end
			current_boogie_procedure.add_contract (l_contract)
		end

	process_postcondition (a_assert: ASSERT_B; a_fields: LIST [TUPLE [IV_EXPRESSION, IV_ENTITY]])
			-- Process `a_assert' as postcondition.
		local
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
			l_contract: IV_POSTCONDITION
			l_info: IV_ASSERTION_INFORMATION
		do
			create l_translator.make
			l_translator.set_context (current_feature, current_type)
			a_assert.process (l_translator)
			a_fields.append (l_translator.field_accesses)
			across l_translator.side_effect as i loop
				create l_contract.make (i.item.expr)
				l_contract.set_information (i.item.info)
				current_boogie_procedure.add_contract (l_contract)
			end
			create l_contract.make (l_translator.last_expression)
			create l_info.make ("post")
			l_info.set_line (a_assert.line_number)
			l_info.set_tag (a_assert.tag)
			l_contract.set_information (l_info)
			current_boogie_procedure.add_contract (l_contract)
		end

	process_fields_list (a_fields: LIST [TUPLE [o: IV_EXPRESSION; f: IV_ENTITY]])
			-- Process fields list.
		local
			l_postcondition: IV_POSTCONDITION
			l_forall: IV_FORALL
			l_or: IV_BINARY_OPERATION
			l_expr: IV_EXPRESSION
			l_fcall: IV_FUNCTION_CALL
			l_access, l_old_access: IV_HEAP_ACCESS
			o, f: IV_ENTITY
			l_info: IV_ASSERTION_INFORMATION
		do
			create o.make ("$o", types.ref)
			create f.make ("$f", types.field (types.generic_type))
			across a_fields as i loop
				l_or := factory.or_ (factory.not_equal (o, i.item.o), factory.not_equal (f, i.item.f))
				if l_expr = Void then
					l_expr := l_or
				else
					l_expr := factory.and_ (l_expr, l_or)
				end
			end
			if l_expr = Void then
				l_expr := factory.true_
			end
			create l_access.make ("Heap", o, f)
			create l_old_access.make ("old(Heap)", o, f)
			create l_forall.make (factory.implies_ (l_expr, factory.equal (l_access, l_old_access)))
			l_forall.add_bound_variable ("$o", types.ref)
			l_forall.add_bound_variable ("$f", types.field (types.generic_type))
			create l_postcondition.make (l_forall)
			create l_info.make ("frame")
			l_postcondition.set_information (l_info)
			if not options.is_checking_frame then
				l_postcondition.set_free
			end

			current_boogie_procedure.add_contract (l_postcondition)
		end

	add_precondition_predicate
			-- Add precondition predicate to current feature.
		local
			l_call: IV_FUNCTION_CALL
			l_pre: IV_PRECONDITION
		do
			translation_pool.add_precondition_predicate (current_feature, current_type)
			create l_call.make (name_translator.precondition_predicate_name (current_feature, current_type), types.bool)
			l_call.add_argument (create {IV_ENTITY}.make ("Heap", types.heap_type))
			across current_boogie_procedure.arguments as i loop
				l_call.add_argument (i.item.entity)
			end
			create l_pre.make (l_call)
			current_boogie_procedure.add_contract (create {IV_PRECONDITION}.make (l_call))
		end

	add_postcondition_predicate
			-- Add postcondition predicate to current feature.
		local
			l_call: IV_FUNCTION_CALL
			l_post: IV_POSTCONDITION
		do
			translation_pool.add_postcondition_predicate (current_feature, current_type)
			create l_call.make (name_translator.postcondition_predicate_name (current_feature, current_type), types.bool)
			l_call.add_argument (create {IV_ENTITY}.make ("Heap", types.heap_type))
			l_call.add_argument (create {IV_ENTITY}.make ("old(Heap)", types.heap_type))
			across current_boogie_procedure.arguments as i loop
				l_call.add_argument (i.item.entity)
			end
			if current_feature.has_return_value then
				l_call.add_argument (create {IV_ENTITY}.make ("Result", types.for_type_a (current_feature.type)))
			end
			create l_post.make (l_call)
			l_post.set_free
			current_boogie_procedure.add_contract (l_post)
		end

	add_pure_frame_condition
			-- Add pure frame condition to current feature.
		local
			l_postcondition: IV_POSTCONDITION
			l_info: IV_ASSERTION_INFORMATION
			l_equal: IV_BINARY_OPERATION
			l_heap, l_old_heap: IV_ENTITY
		do
			create l_heap.make ("Heap", types.heap_type)
			create l_old_heap.make ("old(Heap)", types.heap_type)
			create l_equal.make (l_heap, "==", l_old_heap, types.bool)
			create l_postcondition.make (l_equal)
			create l_info.make ("frame")
			l_postcondition.set_information (l_info)
			current_boogie_procedure.add_contract (l_postcondition)
		end

	add_pure_fresh_frame_condition
			-- Add pure frame condition to current feature.
		local
			l_postcondition: IV_POSTCONDITION
			l_forall: IV_FORALL
			l_or: IV_BINARY_OPERATION
			l_expr: IV_EXPRESSION
			l_fcall: IV_FUNCTION_CALL
			l_access, l_old_access, l_old_allocated: IV_HEAP_ACCESS
			o, f: IV_ENTITY
			l_info: IV_ASSERTION_INFORMATION
		do
			create o.make ("$o", types.ref)
			create f.make ("$f", types.field (types.generic_type))
			create l_access.make ("Heap", o, f)
			create l_old_access.make ("old(Heap)", o, f)
			create l_old_allocated.make ("old(Heap)", o, create {IV_ENTITY}.make ("allocated", types.field (types.bool)))
			create l_forall.make (factory.implies_ (l_old_allocated, factory.equal (l_access, l_old_access)))
			l_forall.add_bound_variable ("$o", types.ref)
			l_forall.add_bound_variable ("$f", types.field (types.generic_type))
			create l_postcondition.make (l_forall)
			create l_info.make ("frame")
			l_postcondition.set_information (l_info)
			if not options.is_checking_frame then
				l_postcondition.set_free
			end
			current_boogie_procedure.add_contract (l_postcondition)
		end

end
