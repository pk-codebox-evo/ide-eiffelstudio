indexing
	description: "Objects that print class text for a test case"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_CLASS_PRINTER

inherit

	CDD_ROUTINES
		export
			{NONE} all
		end

	KL_SHARED_STREAMS
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make  is
			-- Initialize `Current'.
		do
			create output_stream.make (null_output_stream)
		ensure
			output_stream_not_void: output_stream /= Void
		end

feature -- Access

	output_stream: ERL_G_INDENTING_TEXT_OUTPUT_FILTER
			-- Output stream

feature -- Status report

	has_last_print_failed: BOOLEAN
			-- Has printing of last routine invocation failed?

	is_ready: BOOLEAN
			-- Is `Current' ready for printing out a routine invocation?
		do
			Result := not has_last_print_failed
		ensure
			definition: Result = not has_last_print_failed
		end

feature -- Status Setting

	reset is
			-- Reset `Current'.
		do
			has_last_print_failed := false
		ensure
			is_ready_for_printing: is_ready
		end

feature {ANY} -- Basic operations

	print_routine_invocation (a_test_class_name: STRING; a_routine_invocation: CDD_ROUTINE_INVOCATION) is
			-- Print out an extracted test case representing a test for `a_routine_invocation'.
		require
			is_ready_for_printing: is_ready
		local
			l_cursor: DS_LIST_CURSOR [TUPLE [id: STRING; type: STRING; inv: BOOLEAN; attributes: DS_LIST [STRING]]]
		do
			if not has_last_print_failed then
				put_indexing
				put_class_header (a_test_class_name)
				put_set_up (a_routine_invocation.target_class_type, a_routine_invocation.represented_feature, a_routine_invocation.is_creation_feature, a_routine_invocation.context)
				put_test_routine (a_routine_invocation.represented_feature, a_routine_invocation.call_stack_id, a_routine_invocation.call_stack_index)
				put_context_header
				from
					l_cursor := a_routine_invocation.context.new_cursor
					l_cursor.start
					printed_objects := 0
				until
					l_cursor.after
				loop
					put_object (l_cursor.item.id, l_cursor.item.type, l_cursor.item.inv, l_cursor.item.attributes)
					l_cursor.forth
				end
				put_class_footer
			end
		rescue
			has_last_print_failed := True
			retry
		end

	set_output_stream (a_stream: KI_TEXT_OUTPUT_STREAM) is
			-- Direct output to `a_stream'
		require
			a_stream_not_void: a_stream /= Void
		do
			output_stream.set_output_stream (a_stream)
		end

feature {NONE} -- Implementation

	printed_objects: INTEGER
			-- Number of objects printed to context since last `start_capturing'

	put_indexing is
			-- Append indexing clause using `an_uuid' for call
			-- stack id and `an_index' for call stack index.
		local
			l_date: DATE_TIME
		do
			output_stream.put_line ("indexing%N")
			output_stream.indent
			output_stream.put_line ("description: %"This class has been automatically created by CDD%"")
			output_stream.put_line ("description: %"Visit " + cdd_homepage_url + " to learn more about extracted test cases%"")
			create l_date.make_now_utc
			output_stream.put_line ("date: %"$Date: " + l_date.formatted_out ("yyyy-[0]mm-[0]dd hh:[0]mi:[0]ss") + "%"")
			output_stream.put_line ("author: %"EiffelStudio CDD Tool%"")
			output_stream.put_line ("cdd_id: %"" + uuid_generator.generate_uuid.out + "%"")
			output_stream.put_line ("tag: %"created." + l_date.formatted_out ("yyyy-[0]mm-[0]dd") + "%"")
			output_stream.dedent
			output_stream.put_line ("")
		end

	put_class_header (a_test_class_name: STRING) is
			-- Append cdd test case class header with name `a_class_name' for testing `a_cut_name'.
			-- The feature under test takes the arguments listed in `a_arg_list'.
		require
			a_test_class_name_not_void: a_test_class_name /= Void and then not a_test_class_name.is_empty
		do
			output_stream.put_line ("class")
			output_stream.indent
			output_stream.put_line (a_test_class_name + "%N")
			output_stream.dedent
			output_stream.put_line ("inherit")
			output_stream.put_new_line
			output_stream.indent
			output_stream.put_line ("CDD_EXTRACTED_TEST_CASE")
			output_stream.dedent
			output_stream.put_new_line
		end

	put_set_up (a_target_object_type: STRING; a_feature: E_FEATURE; an_is_creation_call: BOOLEAN; a_context: DS_LIST [TUPLE [id: STRING_8; type: STRING_8; inv: BOOLEAN; attr: DS_LIST [STRING_8]]]) is
			-- Append class header text for 'test_class_name'
		require
			a_target_object_type_valid: a_target_object_type /= Void and then not a_target_object_type.is_empty
			a_feature_not_void: a_feature /= Void
		local
			i: INTEGER
			l_agent, l_class: STRING
			l_is_fix: BOOLEAN
			l_ops_type_string: STRING_8
			l_ops: LIST [STRING]
		do
			output_stream.put_line ("feature {NONE} -- Setup%N")
			output_stream.indent
			output_stream.put_line ("set_up_routine is")
			output_stream.indent
			output_stream.indent
			output_stream.put_line ("-- Initialize agent that calls feature under test.")
			output_stream.dedent
			output_stream.put_line ("do")
			output_stream.indent
			l_class := a_target_object_type
			l_agent := "routine_under_test := agent"
			l_is_fix := a_feature.is_infix or a_feature.is_prefix
			if an_is_creation_call or l_is_fix then
				create {LINKED_LIST [STRING_8]} l_ops.make
				if a_feature.argument_count > 0 or l_is_fix then
						-- We need a list of generating types for each argument.
						-- This is achieved by parsing the type information of the first entry of `a_context'
					l_ops_type_string := a_context.first.type
						-- Get generic types of "TUPLE"
					operand_types_regex.match (l_ops_type_string)
					check
						arguments_available_means_has_matched: operand_types_regex.has_matched
					end
					l_ops_type_string := operand_types_regex.captured_substring (1)
					l_ops := l_ops_type_string.split (',')

					l_agent.append (" (")
					from
						l_ops.start
					until
						l_ops.after
					loop
						l_agent.append ("an_arg" + l_ops.index.out + ": " + l_ops.item)
						l_ops.forth
						if not l_ops.after then
							l_agent.append ("; ")
						end
					end
					l_agent.append (")")
				end
				output_stream.put_line (l_agent)
				output_stream.indent
				output_stream.put_line ("local")
				output_stream.indent
				output_stream.put_line ("l_result: ANY")
				output_stream.dedent
				output_stream.put_line ("do")
				output_stream.indent
				if an_is_creation_call then
					l_agent := "l_result := create {" + l_class + "}." + a_feature.name
					if a_feature.argument_count > 0 then
						l_agent.append (" (")
						from
							i := 1
						until
							i > a_feature.argument_count
						loop
							l_agent.append ("an_arg" + i.out)
							if i < a_feature.argument_count then
								l_agent.append (", ")
							end
							i := i + 1
						end
						l_agent.append (")")
					end
				elseif a_feature.is_infix then
					l_agent := "l_result := an_arg1 " + a_feature.infix_symbol + " an_arg2"
				else
					l_agent := "l_result := " + a_feature.prefix_symbol + " an_arg1"
				end
				output_stream.put_line (l_agent)
				output_stream.dedent
				output_stream.put_line ("end")
				output_stream.dedent
			else
				output_stream.put_line (l_agent + " {" + l_class + "}." + a_feature.name)
			end
			output_stream.dedent
			output_stream.put_line ("end%N")
			output_stream.dedent
			output_stream.dedent
		end

	put_test_routine (a_feature: E_FEATURE; a_csid: INTEGER_32; a_csindex: INTEGER) is
			-- Append class header text for `test_class_name'.
		require
			a_feature_not_empty: a_feature /= Void
			a_csid_positive: a_csid > 0
			a_csindex_positive: a_csindex > 0
		local
			l_feature_name: STRING
		do
			l_feature_name := unfix_feature_name (a_feature)

			output_stream.put_line ("feature -- Testing%N")
			output_stream.indent
			output_stream.put_line ("test_" + l_feature_name + " is")
			output_stream.indent
			output_stream.indent
			output_stream.put_line ("-- Execute routine under test")
			output_stream.dedent
			output_stream.put_line ("indexing")
			output_stream.indent
			output_stream.put_line ("tag: %"covers." + a_feature.associated_class.name_in_upper + "." + l_feature_name + "%"")
			if a_csindex > 9 then
				output_stream.put_line ("tag: %"failure." + a_csid.out + "." + a_csindex.out + "%"")
			else
				output_stream.put_line ("tag: %"failure." + a_csid.out + ".0" + a_csindex.out + "%"")
			end
			output_stream.dedent
			output_stream.put_line ("do")
			output_stream.indent
			output_stream.put_line ("call_routine_under_test")
			output_stream.dedent
			output_stream.put_line ("end")
			output_stream.dedent
			output_stream.dedent
			output_stream.put_new_line
		end

	put_context_header is
			-- Print feature definition for context.
		do

			output_stream.put_line ("feature {NONE} -- Extracted data%N")

				-- Context
			output_stream.indent
			output_stream.put_line ("context: ARRAY [TUPLE [id: STRING; type: STRING; inv: BOOLEAN; attributes: ARRAY [STRING]]] is")
			output_stream.indent
			output_stream.indent
			output_stream.put_line ("-- Context for executing test case")
			output_stream.put_line ("-- NOTE: by definition first element is operand for calling `routine_under_test'.")
			output_stream.dedent
			output_stream.put_line ("once")
			output_stream.indent
			output_stream.put_line ("Result := <<")
			output_stream.indent
		end

	put_object (an_id, a_type: STRING; an_inv: BOOLEAN; some_attributes: DS_LIST [STRING]) is
			-- Add a captured object of type `a_type' and attributes `some_attributes'.
			-- `an_id' is the associated id for reconstructing the state and `an_inv'
			-- indicated if the object has to fulfill its invariants.
		local
			l_object: STRING
			l_cursor: DS_LIST_CURSOR [STRING]
		do
			if printed_objects > 0 then
				output_stream.put_string (",")
				output_stream.put_new_line
			end
			printed_objects := printed_objects + 1
			create l_object.make (100)
			l_object.append ("[%"")
			l_object.append (an_id)
			l_object.append ("%", %"")
			l_object.append (a_type)
			l_object.append ("%", ")
			l_object.append (an_inv.out)
			l_object.append (", ")
			l_object.append ("<< ")
			l_cursor := some_attributes.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_object.append ("%"" + l_cursor.item + "%"")
				if not l_cursor.is_last then
					l_object.append (", ")
				end
				l_cursor.forth
			end
			l_object.append (" >>]")
			output_stream.put_string (l_object)
		end

	put_class_footer is
			-- Append class footer for test_class_name.
		do
			output_stream.put_new_line
			output_stream.dedent
			output_stream.put_line (">>")
			output_stream.dedent
			output_stream.put_line ("end")
			output_stream.dedent
			output_stream.dedent
			output_stream.put_new_line
			output_stream.put_line ("end")
			output_stream.flush
		end


	unfix_feature_name (a_feature: E_FEATURE): STRING is
			-- format a feature name in order to obtain a syntactically correct name for a non-infix/prefix eiffel feature
			-- This is necessary because prefix and infix features provide the whole "infix 'some_op'" string as name
		require
			a_feature_not_void: a_feature /= Void
		local
			i: INTEGER_32
			l_custom_symbol: STRING_8
		do
			if a_feature.is_prefix then
				Result := "prefix_"
				if a_feature.prefix_symbol.is_equal ("+") then
					Result.append ("plus")
				elseif a_feature.prefix_symbol.is_equal ("-") then
					Result.append ("minus")
				else
						-- Replace all non-alpha-numeric characters with valid representations.
					from
						create l_custom_symbol.make_empty
						i := 1
					until
						i > a_feature.prefix_symbol.count
					loop
						if a_feature.prefix_symbol.item (i).is_alpha_numeric then
							l_custom_symbol.append_character (a_feature.prefix_symbol.item (i))
						else
							inspect a_feature.prefix_symbol.item (i)
							when '#' then
								l_custom_symbol.append_string ("_symb_number_")
							when '|' then
								l_custom_symbol.append_string ("_symb_vertbar_")
							when '@' then
								l_custom_symbol.append_string ("_symb_at_")
							when '&' then
								l_custom_symbol.append_string ("_symb_amp_")
							else
								l_custom_symbol.append_string ("_symb_" + a_feature.prefix_symbol.item (i).code.out + "_")
							end
						end
						i := i + 1
					end
					Result.append (l_custom_symbol)
				end
			elseif a_feature.is_infix then
    			Result := "infix_"
				if a_feature.infix_symbol.is_equal ("+") then
					Result.append ("plus")
				elseif a_feature.infix_symbol.is_equal ("-") then
					Result.append ("minus")
				elseif a_feature.infix_symbol.is_equal ("*") then
					Result.append ("multiply")
				elseif a_feature.infix_symbol.is_equal ("/") then
					Result.append ("division")
				elseif a_feature.infix_symbol.is_equal ("<") then
					Result.append ("less")
				elseif a_feature.infix_symbol.is_equal (">") then
					Result.append ("greater")
				elseif a_feature.infix_symbol.is_equal ("<=") then
					Result.append ("less_or_equal")
				elseif a_feature.infix_symbol.is_equal (">=") then
					Result.append ("greater_or_equal")
				elseif a_feature.infix_symbol.is_equal ("//") then
					Result.append ("integer_division")
				elseif a_feature.infix_symbol.is_equal ("\\") then
					Result.append ("modulo")
				elseif a_feature.infix_symbol.is_equal ("^") then
					Result.append ("power")
				else
						-- Replace all non-alpha-numeric characters with valid representations.
					from
						create l_custom_symbol.make_empty
						i := 1
					until
						i > a_feature.infix_symbol.count
					loop
						if a_feature.infix_symbol.item (i).is_alpha_numeric then
							l_custom_symbol.append_character (a_feature.infix_symbol.item (i))
						else
							inspect a_feature.infix_symbol.item (i)
							when '#' then
								l_custom_symbol.append_string ("_symb_number_")
							when '|' then
								l_custom_symbol.append_string ("_symb_vertbar_")
							when '@' then
								l_custom_symbol.append_string ("_symb_at_")
							when '&' then
								l_custom_symbol.append_string ("_symb_amp_")
							else
								l_custom_symbol.append_character ('_')
							end
						end
						i := i + 1
					end
					Result.append (l_custom_symbol)
				end
			else
				Result := a_feature.name
			end
		ensure
			result_not_void_nor_empty: Result /= Void and then not Result.is_empty
		end

feature {NONE} -- Implementation

	uuid_generator: UUID_GENERATOR is
			-- UUID generator for creating uuid's
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	operand_types_regex: RX_PCRE_REGULAR_EXPRESSION is
			-- Regular matching TUPLE type declaration
		once
			create Result.make
			Result.set_multiline (True)
			Result.set_dotall (True)
			Result.compile (".*TUPLE[^\[]*\[(.*)\]")
		end

invariant

end
