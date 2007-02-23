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
			process_result_as,
			process_binary_as,
			process_integer_as,
			process_access_feat_as,
			process_nested_expr_as,
			process_nested_as,
			process_void_as,
			process_bin_ne_as
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

	reset is
			-- Reset `expr' to the empty string.
		do
			expr := ""
		ensure
			expr_reset: expr.is_equal ("")
		end

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
		do
			-- TODO
			target_type := type_for (l_as.left)
			if target_type.is_integer then
				l_as.left.process (Current)
				expr.append (l_as.op_name)
				l_as.right.process (Current)
			else
				expr.append ("fun.")
				expr.append (target_type.associated_class.name)
				expr.append ("(")
				expr.append (heap_ref)
				expr.append (",")
				l_as.left.process (Current)
				expr.append (",")
				l_as.right.process (Current)
				expr.append (")")
			end
		end

	process_integer_as (l_as: INTEGER_AS) is
			-- Process `l_as'.
		do
			expr.append (l_as.integer_64_value.out)
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
			-- Process `l_as'.
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
				expr.append ("fun.")
				expr.append (current_class.name)
				expr.append (".")
				expr.append (l_as.feature_name)
				expr.append ("(")
				expr.append (heap_ref)
				expr.append (",")
				expr.append (this_ref)
				expr.append (")")
			end
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS) is
			-- Process `l_as'.
		local
			afa: ACCESS_FEAT_AS
		do
			-- TODO
			afa ?= l_as.message
			if afa /= Void then
				expr.append ("fun.")
				expr.append (type_for (l_as.target).associated_class.name)
				expr.append (".")
				expr.append (afa.feature_name)
				expr.append ("(")
				expr.append (heap_ref)
				expr.append (",")
				l_as.target.process (Current)
				expr.append (")")
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
			expr.append ("Void")
		end

end
