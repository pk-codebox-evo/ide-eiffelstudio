indexing
	description: "Write out the functional definition for functions"
	author: "Bernd Schoeller"
	date: "$Date$"
	revision: "$Revision$"

class
	BPL_FUNCTION_WRITER

inherit
	BPL_VISITOR
		redefine
			process_bin_eq_as,
			process_binary_as,
			process_integer_as,
			process_void_as,
			process_bin_ne_as,
			process_id_as,
			process_un_old_as,
			process_expr_call_as,
			process_access_feat_as,
			process_access_id_as,
			process_current_as,
			process_result_as,
			process_nested_as,
			process_nested_expr_as
		end

create
	make

feature -- Main

	write_function (a_function: FEATURE_I) is
			-- Write the definition of the function pointed to by `a_function'.
		require
			as_not_void: a_function /= Void
			as_is_attribute: a_function.is_function
		local
			func_name: STRING
			return_type: STRING
			routine: ROUTINE_AS
			ass_list: LIST[TAGGED_AS]
			intro: STRING
			l_as: FEATURE_AS
		do
			set_this_ref ("C")
			set_heap_ref ("H")
			current_feature := a_function
			l_as := a_function.body
			func_name := "fun."+current_class.name+"."+l_as.feature_name
			return_type := bpl_type_for (l_as.body.type)
			bpl_out ("// Function: "+l_as.feature_name+" of class "+current_class.name+"%N")
			bpl_out ("function "+func_name+"([ref,name]any,ref")
			result_call := func_name+"(H,C"
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
						result_call.append (",")
						bpl_out (bpl_type_for (l_as.body.arguments.item.type))
						result_call.append ("arg.")
						result_call.append (l_as.body.arguments.item.names_heap.item (l_as.body.arguments.item.id_list.item))
						l_as.body.arguments.item.id_list.forth
					end
					l_as.body.arguments.forth
				end
			end
			bpl_out (") returns ("+return_type+");%N")
			result_call.append (")")
			routine ?= l_as.body.content
			intro := "forall H:[ref,name]any,C:ref"
			if routine /= Void then
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
							intro.append (",")
							intro.append ("arg.")
							intro.append (l_as.body.arguments.item.names_heap.item (l_as.body.arguments.item.id_list.item))
							intro.append (":")
							intro.append ( bpl_type_for (l_as.body.arguments.item.type))
							l_as.body.arguments.item.id_list.forth
						end
						l_as.body.arguments.forth
					end
				end
				intro.append ("::")
				if routine.precondition /= Void and then routine.precondition.assertions /= Void then
					ass_list := routine.precondition.assertions
					from
						ass_list.start
					until
						ass_list.off
					loop
						if ass_list.isfirst then
							intro.append ("(")
						end
						expr := ""
						ass_list.item.process (Current)
						intro.append (expr)
						if ass_list.islast then
							intro.append (") ==> ")
						else
							intro.append (") && (")
						end
						ass_list.forth
					end
				end

				if routine.postcondition /= Void and then routine.postcondition.assertions /= Void then
					ass_list := routine.postcondition.assertions
					from
						ass_list.start
					until
						ass_list.off
					loop
						bpl_out ("axiom (")
						bpl_out (intro)
						expr := ""
						ass_list.item.process (Current)
						bpl_out (expr)
						bpl_out (");%N")
						ass_list.forth
					end
				end
			else
				-- TODO: Support constants	
			end
			bpl_out ("%N")
		end

feature -- Processing Environment

	result_call: STRING
		-- String to insert for `Result'

	set_result_call (a_string:STRING) is
			-- Set the text to insert on a Result to `a_string'.
		require
			not_void: a_string /= Void
		do
			result_call := a_string
		ensure
			value_set: result_call = a_string
		end

	heap_ref: STRING

	set_heap_ref (a_string:STRING) is
			-- Set the text to insert on a Heap reference.
		require
			not_void: a_string /= Void
		do
			heap_ref := a_string
		ensure
			value_set: heap_ref = a_string
		end

	this_ref: STRING

	set_this_ref (a_string:STRING) is
			-- Set the text to insert on a reference to the current object.
		require
			not_void: a_string /= Void
		do
			this_ref := a_string
		ensure
			value_set: this_ref = a_string
		end

	expr: STRING
		-- Expression output

	current_expression: EXPR_AS
		-- The current expression processed

	reset is
			-- Reset `expr' to the empty string.
		do
			expr := ""
			create call_list.make (0)
			create type_list.make (0)
		ensure
			expr_reset: expr.is_equal ("")
		end

	call_list: ARRAYED_LIST[STRING]
		-- Strings that describe call that were used during the generation.

	type_list: ARRAYED_LIST[STRING]
		-- BPL types of corresponding to the types of the `call_list' subexpressions.

	heap_removed (a_string: STRING): STRING is
			-- `a_string' with the first occurrence of "Heap," removed.
			-- (needed for using call_list strings for proc calls)
		local
			index: INTEGER
		do
			Result := a_string.twin
			index := Result.substring_index (heap_string,1)
			Result.remove_substring (index, index+heap_string.count-1)
		end

	heap_string: STRING is "Heap,"

feature -- Processing

	process_bin_eq_as (l_as: BIN_EQ_AS) is
			-- Process `l_as'.
		do
			l_as.left.process (Current)
			expr.append ("==")
			l_as.right.process (Current)
		end

	process_bin_ne_as (l_as: BIN_NE_AS) is
			-- Process `l_as'.
		do
			l_as.left.process (Current)
			expr.append ("!=")
			l_as.right.process (Current)
		end

	process_result_as (l_as: RESULT_AS) is
			-- Process `l_as'.
		do
			expr.append (result_call)
		end

	process_binary_as (l_as: BINARY_AS) is
			-- Prcoess `l_as'.
		local
			target_type: TYPE_A
			tmp_expr: STRING
			call_string: STRING
			left_arg,right_arg: STRING
		do
			-- TODO
			target_type := type_for (l_as.left)
			if target_type.is_integer or target_type.is_boolean then
				l_as.left.process (Current)
				expr.append (l_as.op_name)
				l_as.right.process (Current)
			else
				tmp_expr := expr
				expr := ""
				l_as.left.process (Current)
				left_arg := expr
				expr := ""
				l_as.right.process (Current)
				right_arg := expr
				expr := tmp_expr
				call_string := ""
				call_string.append (target_type.associated_class.name)
				call_string.append (".")
				call_string.append ("FIXME")
				call_string.append ("(")
				call_string.append (heap_ref)
				call_string.append (",")
				call_string.append (left_arg)
				call_string.append (",")
				call_string.append (right_arg)
				call_string.append (")")
				expr.append ("fun.")
				expr.append (call_string)
				call_list.extend (call_string)
				type_list.extend (bpl_type_for_type_a (type_for (l_as)))
			end
		end

	process_integer_as (l_as: INTEGER_AS) is
			-- Process `l_as'.
		do
			expr.append (l_as.integer_64_value.out)
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
			-- Process `l_as'.
		local
			call_string: STRING
		do
			-- TODO
			if l_as.is_argument then
				expr.append ("arg.")
				expr.append (l_as.feature_name)
			elseif l_as.is_local then
				check
					no_locals_in_contracts: False
				end
			else
				call_string := ""
				call_string.append (current_class.name)
				call_string.append (".")
				call_string.append (l_as.feature_name)
				call_string.append ("(")
				call_string.append (heap_ref)
				call_string.append (",")
				call_string.append (this_ref)
				call_string.append (")")

				expr.append ("fun.")
				expr.append (call_string)
				call_list.extend (call_string)
				type_list.extend (bpl_type_for_type_a (type_for (current_expression)))
			end
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS) is
			-- Process `l_as'.
		local
			afa: ACCESS_FEAT_AS
			call_string: STRING
			tmp_expr: STRING
			target_expr: STRING
		do
			-- TODO
			afa ?= l_as.message
			if afa /= Void then
				tmp_expr := expr
				expr := ""
				l_as.target.process (Current)
				target_expr := expr
				expr := tmp_expr

				call_string := ""
				call_string.append (type_for (l_as.target).associated_class.name)
				call_string.append (".")
				call_string.append (afa.feature_name)
				call_string.append ("(")
				call_string.append (heap_ref)
				call_string.append (",")
				call_string.append (target_expr)
				call_string.append (")")

				expr.append ("fun.")
				expr.append (call_string)
				call_list.extend (call_string)
				type_list.extend (bpl_type_for_type_a (type_for (current_expression)))
			else
				check
					unknown_access: False
				end
			end
		end

	process_nested_as (l_as: NESTED_AS) is
			-- Process `l_as'.
		local
			nested_expr_as: NESTED_EXPR_AS
		do
			nested_expr_as := nested_as_to_nested_expr_as (l_as)
			nested_expr_as.process (Current)
		end

	process_void_as (l_as: VOID_AS) is
			-- Process `l_as'.
		do
			expr.append ("null")
		end


	process_access_id_as (l_as: ACCESS_ID_AS) is
			-- Process `l_as'.
		local
			call_string: STRING
		do
			if l_as.is_local then
				expr.append ("l.")
				expr.append (l_as.access_name)
			elseif l_as.is_argument then
				expr.append ("arg.")
				expr.append (l_as.access_name)
			else
				call_string := current_class.name+"."+
					l_as.access_name+"("+heap_ref+","+
					this_ref+")"
				expr.append ("fun.")
				expr.append (call_string)
				call_list.extend (call_string)
				type_list.extend (bpl_type_for_type_a (type_for (current_expression)))
			end
		end

	process_id_as (l_as: ID_AS) is
			-- Process `l_as'.
		do

		end

	process_current_as (l_as: CURRENT_AS) is
			-- Process `l_as'.
		do
			expr.append (this_ref)
		end

	process_un_old_as (l_as: UN_OLD_AS) is
			-- Process `l_as'.
		do
			expr.append ("old(")
			l_as.expr.process (Current)
			expr.append (")")
		end

	process_expr_call_as (l_as: EXPR_CALL_AS) is
			-- Process `l_as'.
		local
			old_expr: EXPR_AS
		do
			old_expr := current_expression
			current_expression := l_as
			Precursor {BPL_VISITOR} (l_as)
			current_expression := old_expr
		end

invariant
	call_list_not_void: call_list /= Void
	type_list_not_void: type_list /= Void
	type_list_correct_size: type_list.count = call_list.count
end
