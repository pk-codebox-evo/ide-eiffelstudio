indexing
	description: "Write out the implementation of a feature"
	author: "Bernd Schoeller"
	date: "$Date$"
	revision: "$Revision$"

class
	BPL_IMPLEMENTATION_WRITER

inherit
	BPL_VISITOR
		redefine
			process_assign_as,
			process_keyword_as,
			process_id_as,
			process_reverse_as,
			process_check_as,
			process_bang_creation_as,
			process_create_creation_as,
			process_debug_as,
			process_if_as,
			process_inspect_as,
			process_loop_as,
			process_instr_call_as
		end

create
	make


feature -- Generation

	write_implementation (a_feature: FEATURE_I) is
			-- Write out the implementation of `a_feature'.
		local
			content: ROUTINE_AS
			l_as: FEATURE_AS
		do
			current_feature := a_feature
			create function_writer.make (current_class)
			function_writer.setup (current_class.ast, match_list, will_process_leading_leaves, will_process_trailing_leaves)
			function_writer.set_current_feature (current_feature)
			function_writer.set_heap_ref ("Heap")
			function_writer.set_this_ref ("Current")
			function_writer.set_result_call ("Result")
			code := ""
			reset_labels
			bpl_out ("// Implementation: "+a_feature.feature_name+" of class "+current_class.name+"%N")
			bpl_out ("implementation proc.")
			bpl_out (current_class.name)
			bpl_out (".")
			bpl_out (a_feature.feature_name)
			bpl_out ("(Current:ref")
			l_as := a_feature.body
			if l_as.body.arguments /= Void then
				from
					l_as.body.arguments.start
				until
					l_as.body.arguments.off
				loop
					from
						l_as.body.arguments.item.id_list.start
					until
						l_as.body.arguments.item.id_list.off
					loop
						bpl_out (",")
						bpl_out ("arg.")
						bpl_out (l_as.body.arguments.item.names_heap.item (l_as.body.arguments.item.id_list.item))
						bpl_out (":")
						bpl_out (bpl_type_for (l_as.body.arguments.item.type))
						l_as.body.arguments.item.id_list.forth
					end
					l_as.body.arguments.forth
				end
			end
			bpl_out (")")
			if a_feature.is_function then
				bpl_out (" returns (Result:")
				bpl_out (bpl_type_for_type_a (a_feature.type))
				bpl_out (")")
			end
			bpl_out (" {%N")
			content ?= l_as.body.content
			if content /= Void then
				bpl_out ("   var dump_ref:ref;%N")
				bpl_out ("   var dump_bool:bool;%N")
				bpl_out ("   var dump_int:int;%N")
				if content.locals /= Void then
					from
						content.locals.start
					until
						content.locals.off
					loop
						from
							content.locals.item.id_list.start
						until
							content.locals.item.id_list.off
						loop
							bpl_out ("  var l.")
							bpl_out (content.locals.item.names_heap.item (content.locals.item.id_list.item))
							bpl_out (":")
							bpl_out (bpl_type_for (content.locals.item.type))
							bpl_out (";%N")
							content.locals.item.id_list.forth
						end
						content.locals.forth
					end
				end

				content.routine_body.process (Current)
				bpl_out ("  entry:%N")
				bpl_out (code)
				bpl_out ("    return;%N")
			else
				check
					no_constants: False
				end
			end
			bpl_out ("}%N")
		end

feature -- Environment

	code: STRING

	last_label: STRING

	next_free_label: INTEGER

	reset_labels is
			-- Reset the label counter.
		do
			next_free_label := 0
			new_label ("l")
		end

	new_label (a_prefix: STRING) is
			-- Create a new label.
		require
			not_void: a_prefix /= Void
			not_empty: a_prefix.count >= 1
		do
			last_label := a_prefix+next_free_label.out
			next_free_label := next_free_label + 1
		end

	is_local_variable (a_name: STRING): BOOLEAN is
			-- Is `a_name' the name of a local variable ?
		local
			content: ROUTINE_AS
		do
			content ?= current_feature.body.body.content
			if content.locals /= Void then
				from
					content.locals.start
				until
					content.locals.off or Result
				loop
					from
						content.locals.item.id_list.start
					until
						content.locals.item.id_list.off or Result
					loop
						Result := content.locals.item.names_heap.item (content.locals.item.id_list.item).is_equal (a_name)
						content.locals.item.id_list.forth
					end
					content.locals.forth
				end
			end
		end

	function_writer: BPL_FUNCTION_WRITER

feature -- Processors

	process_assign_as (l_as: ASSIGN_AS) is
			-- Create assignment.
		local
			result_as: RESULT_AS
			new_code: STRING
		do
			new_code := "    "
			result_as ?= l_as.target
			if is_local_variable (l_as.target.access_name) then
				new_code.append ("l.")
				new_code.append (l_as.target.access_name)
			elseif result_as /= Void then
				new_code.append ("Result")
			else
				new_code.append ("Heap[Current,field.")
				new_code.append (current_class.name)
				new_code.append (".")
				new_code.append (l_as.target.access_name)
				new_code.append ("]")
			end
			new_code.append (" := ")
			function_writer.reset
			l_as.source.process (function_writer)
			new_code.append (function_writer.expr)
			new_code.append (";")
			new_code.append (location_info (l_as, Void))
			from
				function_writer.call_list.start
				function_writer.type_list.start
			until
				function_writer.call_list.off
			loop
				code.append ("    call dump_")
				code.append (function_writer.type_list.item)
				code.append (" := proc.")
				code.append (function_writer.heap_removed(function_writer.call_list.item))
				code.append (";")
				bpl_out (location_info (l_as, Void))
				function_writer.call_list.forth
				function_writer.type_list.forth
			end
			code.append (new_code)
		end

	process_keyword_as (l_as: KEYWORD_AS) is
			-- Process `l_as'.
		do

		end

	process_id_as (l_as: ID_AS) is
			-- Process `l_as'.
		do

		end

	process_reverse_as (l_as: REVERSE_AS) is
			-- Process `l_as'.
		do

		end

	process_bang_creation_as (l_as: BANG_CREATION_AS) is
			-- Process `l_as'.
		do

		end

	process_create_creation_as (l_as: CREATE_CREATION_AS) is
			-- Process `l_as'.
		do

		end

	process_debug_as (l_as: DEBUG_AS) is
			-- Process `l_as'.
		do

		end

	process_if_as (l_as: IF_AS) is
			-- Process `l_as'.
		local
			end_label: STRING
			else_label: STRING
			true_label: STRING
			false_label: STRING
			expr: STRING
		do
			new_label ("endif")
			end_label := last_label
			new_label ("else")
			else_label := last_label
			new_label ("true")
			true_label := last_label
			if l_as.elsif_list /= Void then
				new_label ("false")
				false_label := last_label
			else
				false_label := else_label
			end
			code.append ("    goto ")
			code.append (true_label)
			code.append (",")
			code.append (false_label)
			code.append (";%N")
			function_writer.reset
			l_as.condition.process (function_writer)
			expr := function_writer.expr
			code.append ("  ")
			code.append (true_label)
			code.append (":%N")
			code.append ("    assume(")
			code.append (expr)
			code.append (");%N")
			l_as.compound.process (Current)
			code.append ("    goto ")
			code.append (end_label)
			code.append (";%N")
			if l_as.elsif_list /= Void then
				from
					l_as.elsif_list.start
				until
					l_as.elsif_list.off
				loop
					code.append ("  ")
					code.append (false_label)
					code.append (":%N")
					code.append ("    assume(!(")
					code.append (expr)
					code.append ("));%N")
					function_writer.reset
					l_as.elsif_list.item.expr.process (function_writer)
					expr := function_writer.expr
					new_label ("true")
					true_label := last_label
					if l_as.elsif_list.islast then
						false_label := else_label
					else
						new_label ("false")
						false_label := last_label
					end
					code.append ("    goto ")
					code.append (true_label)
					code.append (",")
					code.append (false_label)
					code.append (";%N")
					code.append ("  ")
					code.append (true_label)
					code.append (":%N")
					code.append ("    assume(")
					code.append (expr)
					code.append (");%N")
					l_as.elsif_list.item.compound.process (Current)
					code.append ("    goto ")
					code.append (end_label)
					code.append (";%N")
					l_as.elsif_list.forth
				end
			end
			code.append ("  ")
			code.append (else_label)
			code.append (":%N")
			code.append ("    assume(!(")
			code.append (expr)
			code.append ("));%N")
			if l_as.else_part /= Void then
				l_as.else_part.process (Current)
			end
			code.append ("    goto ")
			code.append (end_label)
			code.append (";%N")
			code.append ("  ")
			code.append (end_label)
			code.append (":%N")
		end

	process_inspect_as (l_as: INSPECT_AS) is
			-- Process `l_as'.
		do
			check
				not_implemented: False
			end
		end

	process_loop_as (l_as: LOOP_AS) is
			-- Process `l_as'.
		local
			loop_label,exit_label:STRING
			expr: STRING
		do
			if l_as.from_part /= Void then
				l_as.from_part.process (Current)
			end

			new_label ("loop")
			loop_label := last_label
			new_label ("exit")
			exit_label := last_label
			code.append ("    goto ")
			code.append (loop_label)
			code.append (",")
			code.append (exit_label)
			code.append (";%N")
			function_writer.reset
			l_as.stop.process (function_writer)
			expr := function_writer.expr
			code.append ("  ")
			code.append (loop_label)
			code.append (":%N")
			code.append ("    assume(!(")
			code.append (expr)
			code.append ("));%N")
			if l_as.compound /= Void then
				l_as.compound.process (Current)
			end
			code.append ("    goto ")
			code.append (loop_label)
			code.append (",")
			code.append (exit_label)
			code.append (";%N")
			code.append ("  ")
			code.append (exit_label)
			code.append (":%N")
			code.append ("    assume(")
			code.append (expr)
			code.append (");%N")
		end

	process_check_as (l_as: CHECK_AS) is
			-- Process `l_as'.
		do
			if l_as.check_list /= Void then
				from
					l_as.check_list.start
				until
					l_as.check_list.off
				loop
					function_writer.reset
					l_as.check_list.item.process (function_writer)
					code.append ("    assert(");
					code.append (function_writer.expr)
					code.append (");%N")
					l_as.check_list.forth
				end
			end
		end

	process_instr_call_as (l_as: INSTR_CALL_AS) is
			-- Process `l_as'.
		local
			nested: NESTED_AS
			nested_expr: NESTED_EXPR_AS
			access_id: ACCESS_AS
			i: INTEGER
		do
			nested ?= l_as.call -- Call with target 'x.foo'
			nested_expr ?= l_as.call -- Call with target '(some expr).foo'
			access_id ?= l_as.call -- Call with just an identifier 'foo'
			if nested /= Void  then
				nested_expr := nested_as_to_nested_expr_as (nested)
			end
			if nested_expr /= Void then
				code.append ("    call proc.")
				code.append (type_for (nested_expr.target).associated_class.name)
				code.append (".")
				access_id ?= nested_expr.message
				check
					need_access: access_id /= Void
				end
				code.append (access_id.access_name)
				code.append ("(")
				function_writer.reset
				nested_expr.target.process (function_writer)
				code.append (function_writer.expr)
				if access_id.parameters /= Void then
					from
						i := 1
					until
						i > access_id.parameters.count
					loop
						code.append (",")
						function_writer.reset
						access_id.parameters.i_th (i).process (function_writer)
						code.append (function_writer.expr)
						i := i + 1
					end
				end
				code.append ("); ")
				code.append (location_info (l_as, Void))
			elseif access_id /= Void then
				code.append ("    call proc.")
				code.append (current_class.name)
				code.append (".")
				code.append (access_id.access_name)
				code.append ("(Current")
				if access_id.parameters /= Void then
					from
						i := 1
					until
						i > access_id.parameters.count
					loop
						code.append (",")
						function_writer.reset
						access_id.parameters.i_th (i).process (function_writer)
						code.append (function_writer.expr)
						i := i + 1
					end
				end
				code.append ("); ")
				code.append (location_info (l_as, Void))
			else
				check
					not_implemented: False
				end
			end
		end


end
