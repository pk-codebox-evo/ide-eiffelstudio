indexing
	description: "Write the signature of procedures"
	author: "Bernd Schoeller"
	date: "$Date$"
	revision: "$Revision$"

class
	BPL_BN_SIGNATURE_WRITER

inherit
	BPL_BN_ITERATOR

create
	make

feature -- Generation

	write_signature (a_feature: FEATURE_I) is
			-- Write the signature for `a_feature'.
		require
			not_void: a_feature /= Void
			not_attribute: a_feature.body.body /= Void
		local
			i: INTEGER
			arg_name: STRING
			arg_type: TYPE_A
			byte_code: BYTE_CODE
			ass_list: BYTE_LIST[BYTE_NODE]
		do
			setup_function_writer
			current_feature := a_feature
			function_writer.set_current_feature (a_feature)
			if byte_server.has (current_feature.code_id) then
				-- TODO: it's unclear what we can do for features which have no bytecode
				
				byte_code := byte_server.disk_item (current_feature.code_id)
			
				bpl_out ("// Signature: " + a_feature.feature_name + " of class " + current_class.name + "%N")
				bpl_out ("procedure proc.")
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
				if a_feature.is_function or a_feature.is_attribute or a_feature.is_constant then
					bpl_out (" returns (Result:")
				bpl_out (bpl_type_for_type_a (a_feature.type))
				bpl_out (")")
				end
				bpl_out (";%N")
				bpl_out ("  requires Current != null;%N")
				
				ass_list := byte_code.precondition
				if ass_list /= Void then
					from
						ass_list.start
					until
						ass_list.off
					loop
						function_writer.reset
						ass_list.item.process (function_writer)
						bpl_out ("  requires ")
						bpl_out (function_writer.expr)
						bpl_out (";%N")
						ass_list.forth
					end
				end

				ass_list := inv_byte_server.item (current_class.class_id).byte_list

				if ass_list /= Void then
					from
						ass_list.start
					until
						ass_list.off
					loop
						function_writer.reset
						ass_list.item.process (function_writer)
						
						bpl_out ("  free requires ")
						bpl_out (function_writer.expr)
						bpl_out (";%N")
						ass_list.forth
					end
				end

				if a_feature.type /= Void then
					bpl_out ("  modifies Heap;%N")
				end
				ass_list := byte_code.postcondition
				if ass_list /= Void then
					from
						ass_list.start
					until
						ass_list.off
					loop
						function_writer.reset
						ass_list.item.process (function_writer)
						bpl_out ("  ensures ")
						bpl_out (function_writer.expr)
						bpl_out ("; ")
						bpl_out (location_info (ass_list.item))
						ass_list.forth
					end
				end

				ass_list := inv_byte_server.item (current_class.class_id).byte_list
				if ass_list /= Void then
					from
						ass_list.start
					until
						ass_list.off
					loop
						function_writer.reset
						ass_list.item.process (function_writer)
						bpl_out ("  ensures ")
						bpl_out (function_writer.expr)
						bpl_out (";")
						bpl_out (location_info (ass_list.item))
						ass_list.forth
					end
				end
				if a_feature.is_constant then
					function_writer.reset
					byte_code.process (function_writer)
					bpl_out ("  ensures Result == ")
					bpl_out (function_writer.expr)
					bpl_out (";")
					bpl_out (location_info (byte_code))
				end
			end
			bpl_out ("%N")
		end

feature{NONE} -- Implementation

	function_writer: BPL_BN_FUNCTION_WRITER

	setup_function_writer is
			-- Setup the function_writer.
		do
			create function_writer.make (current_class)
			function_writer.set_result_call ("Result")
			function_writer.set_heap_ref ("Heap")
			function_writer.set_this_ref ("Current")
			function_writer.set_leaf_list (match_list_server.item (current_class.class_id))
		end

end
