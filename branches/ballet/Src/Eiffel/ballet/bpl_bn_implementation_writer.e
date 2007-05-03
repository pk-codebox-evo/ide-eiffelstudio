indexing
	description: "Generate the implementation clause for a given feature"
	author: "Bernd Schoeller"
	date: "$Date$"
	revision: "$Revision$"

class
	BPL_BN_IMPLEMENTATION_WRITER

inherit
	BPL_BN_ITERATOR
		redefine
			process_byte_code,
			process_assign_b,
			process_check_b,
			process_if_b,
			process_instr_call_b,
			process_instr_list_b,
			process_loop_b
		end

create
	make

feature -- Generation

	write_implementation (a_feature: FEATURE_I) is
			-- Write out the implementation of `a_feature'.
		require
			not_void: a_feature /= Void
		local
			i: INTEGER
			arg_type: TYPE_A
			arg_name: STRING
		do
			create function_writer.make (current_class)
			function_writer.set_leaf_list (leaf_list)
			function_writer.set_current_feature (current_feature)
			function_writer.set_heap_ref ("Heap")
			function_writer.set_this_ref ("Current")
			function_writer.set_result_call ("Result")
			code := ""
			create temp_vars_needed.make (5)
			reset_labels
			bpl_out ("// Implementation: "+a_feature.feature_name+" of class "+current_class.name+"%N")
			bpl_out ("implementation proc.")
			bpl_out (current_class.name)
			bpl_out (".")
			bpl_out (bpl_mangled_feature_name (a_feature.feature_name))
			bpl_out ("(Current:ref")
			from
				i := 1
			until
				i > a_feature.argument_count
			loop
				arg_name := a_feature.arguments.item_name (i)
				arg_type := a_feature.arguments.i_th (i)
				bpl_out (",arg.")
				bpl_out (arg_name)
				bpl_out (":")
				bpl_out (bpl_type_for_type_a (arg_type))
				i := i + 1
			end
			bpl_out (")")
			if a_feature.is_function then
				bpl_out (" returns (Result:")
				bpl_out (bpl_type_for_type_a (a_feature.type))
				bpl_out (")")
			end
			bpl_out (" {%N")
			process_feature_i (a_feature)
			bpl_out ("}%N")
		end

	process_byte_code (a_node: BYTE_CODE) is
			-- Process the byte code.
		local
			i:INTEGER
		do
			-- Fill 'code' first
			safe_process (a_node.compound)

			from
				i := 1
			until
				i > a_node.local_count
			loop
				bpl_out ("  var l")
				bpl_out (i.out)
				bpl_out (":")
				bpl_out (bpl_type_for_type_a (a_node.locals.item (i).type_a))
				bpl_out (";%N")
				i := i + 1
			end
			from
				temp_vars_needed.start
			until
				temp_vars_needed.off
			loop
				bpl_out ("  var ")
				bpl_out (temp_vars_needed.key_for_iteration)
				bpl_out (":")
				bpl_out (temp_vars_needed.item_for_iteration)
				bpl_out (";%N")
				temp_vars_needed.forth
			end
			bpl_out ("  entry:%N")
			bpl_out (code)
			bpl_out ("    return;%N")
		end

	process_assign_b (a_node: ASSIGN_B) is
			-- Process `a_node'.
		local
			new_code: STRING
			local_b: LOCAL_B
			attribute_b: ATTRIBUTE_B
		do
			new_code := "    "
			if a_node.target.is_local then
				local_b ?= a_node.target
				check not_void: local_b /= Void end
				new_code.append ("l")
				new_code.append (local_b.position.out)
			elseif a_node.target.is_Result then
				new_code.append ("Result")
			elseif a_node.target.is_attribute then
				attribute_b ?= a_node.target
				check not_void: attribute_b /= Void end
				new_code.append ("Heap[Current,field.")
				new_code.append (system.class_of_id (attribute_b.written_in).name)
				new_code.append (".")
				new_code.append (attribute_b.attribute_name)
				new_code.append ("]")
			else
				check
					should_not_be_here: false
				end
			end
			new_code.append (" := ")
			function_writer.reset
			a_node.source.process (function_writer)
			new_code.append (function_writer.expr)
			new_code.append (";")
			new_code.append (location_info (a_node))
			code.append (new_code)
		end

	process_check_b (a_node: CHECK_B) is
			-- Process `a_node'.
		do

		end

	process_if_b (a_node: IF_B) is
			-- Process `a_node'.
		do

		end

	process_instr_call_b (a_node: INSTR_CALL_B) is
			-- Process `a_node'.
		do

		end

	process_instr_list_b (a_node: INSTR_LIST_B) is
			-- Process `a_node'.
		do

		end

	process_loop_b (a_node: LOOP_B) is
			-- Process `a_node'.
		do

		end

feature -- Access

	code: STRING
		-- Generated Code for the body

feature{NONE} -- Implementation

	temp_vars_needed: HASH_TABLE[STRING,STRING]

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

	function_writer: BPL_BN_FUNCTION_WRITER

	record_temp_var (a_name: STRING; a_bpl_type: STRING) is
			-- Record the need of a temp variable `a_name' of `a_bpl_type'
		do
			temp_vars_needed.put (a_bpl_type,a_name)
		end

end
