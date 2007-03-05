indexing
	description: "Write the signature of procedures"
	author: "Bernd Schoeller"
	date: "$Date$"
	revision: "$Revision$"

class
	BPL_SIGNATURE_WRITER

inherit
	BPL_VISITOR

create
	make

feature -- Generation

	write_signature (a_feature: FEATURE_I) is
			-- Write the signature for `a_feature'.
		require
			not_void: a_feature /= Void
			not_attribute: a_feature.body.body /= Void
		local
			a_list: EIFFEL_LIST [TAGGED_AS]
			content: ROUTINE_AS
			l_as: FEATURE_AS
		do
			setup_function_writer
			current_feature := a_feature
			function_writer.set_current_feature (a_feature)
			bpl_out ("// Signature: "+a_feature.feature_name+" of class "+current_class.name+"%N")
			bpl_out ("procedure proc.")
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
			bpl_out (";%N")
			content ?= a_feature.body.body.content
			if content /= Void then
				if content.has_precondition then
					a_list := content.precondition.assertions
					from a_list.start until a_list.off loop
						function_writer.reset
						a_list.item.expr.process (function_writer)
						bpl_out ("  requires ")
						bpl_out (function_writer.expr)
						bpl_out (";%N")
						a_list.forth
					end
				end
				bpl_out ("  modifies Heap;%N")
				if content.has_postcondition then
					a_list := content.postcondition.assertions
					from a_list.start until a_list.off loop
						function_writer.reset
						a_list.item.expr.process (function_writer)
						bpl_out ("  ensures ")
						bpl_out (function_writer.expr)
						bpl_out (";%N")
						a_list.forth
					end
				end
			else
				check
					constants_not_implemented: False
				end
			end
			bpl_out ("%N")
		end

feature{NONE} -- Implementation

	function_writer: BPL_FUNCTION_WRITER

	setup_function_writer is
			-- Setup the function_writer.
		do
			create function_writer.make (current_class)
			function_writer.set_result_call ("Result")
			function_writer.set_heap_ref ("Heap")
			function_writer.set_this_ref ("Current")
			function_writer.setup (current_class.ast, match_list, will_process_leading_leaves, will_process_trailing_leaves)
		end

end
