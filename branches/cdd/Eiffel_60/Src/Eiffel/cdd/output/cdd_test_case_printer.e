indexing
	description: "Objects that print class text for a test case"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_CASE_PRINTER

inherit

	CDD_CLASS_PRINTER
		export
			{NONE} all
		redefine
			initialize,
			is_initialized,
			terminate
		end

	DEBUG_VALUE_EXPORTER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	initialize (a_file: like output_file) is
			-- Set `output_file' to `a_file'.
		do
			Precursor (a_file)
			create object_map.make (20)
			create object_queue.make
			object_count := 1
		end

feature -- Output

	print_test_case (a_cse: EIFFEL_CALL_STACK_ELEMENT; a_class_name: STRING; a_file: like output_file; an_uuid: STRING) is
			-- Create cdd test case class for simulating `a_cse'. Test class shall be named `a_class_name' and be
			-- written to `a_file'. Use `an_uuid' for the call stack's id.
		require
			a_cse_not_void: a_cse /= Void
			a_cse_valid: a_cse.dynamic_class /= Void and then a_cse.dynamic_class.is_eiffel_class_c
			a_class_name_not_empty: a_class_name /= Void and then not a_class_name.is_empty
			a_file_empty: a_file /= Void and then a_file.count = 0
			a_file_writeable: a_file.is_open_write
		local
			l_class: EIFFEL_CLASS_C
			l_feature: E_FEATURE
			l_class_name, l_arg_tuple: STRING
			l_is_creation_call: BOOLEAN
			l_args: E_FEATURE_ARGUMENTS
		do
			l_class := a_cse.dynamic_class.eiffel_class_c
			l_feature := l_feature

				-- Check wheter `l_feature' was used as an creation call
			l_is_creation_call := l_class.creation_feature = l_feature.associated_feature_i
			if not l_is_creation_call then
				l_is_creation_call := l_class.creators /= Void and then l_class.creators.has (l_feature.name)
			end

				-- Initialize generic parameters for test case
			l_class_name := l_class.name_in_upper
			l_arg_tuple := "TUPLE ["
			from
				l_args := l_feature.arguments
				l_args.start
			until
				l_args.after
			loop
				l_arg_tuple.append (l_args.item.dump)
				if not l_args.islast then
					l_arg_tuple.append (", ")
				end
				l_args.forth
			end
			l_arg_tuple.append ("]")

				-- Start printing test case
			initialize (a_file)
			append_indexing (an_uuid, a_cse.level_in_stack)
			append_class_header (l_class.name_in_upper, a_class_name, l_arg_tuple)

			append_set_up (l_feature, l_is_creation_call)
			append_access (a_class_name, l_feature.name)
			append_context (a_cse, l_is_creation_call, l_arg_tuple)

			append_class_footer (a_class_name)
			terminate
		ensure
			a_file_not_empty: a_file.count > 0
		end

feature {NONE} -- Implementation (Access)

	is_initialized: BOOLEAN is
			-- Can we create test case class text?
		do
			Result := Precursor and
				object_map /= Void and
				object_queue /= Void and
				object_count > 0
		end

	object_map: DS_HASH_TABLE [STRING, STRING]
			-- Hash table that maps object addresses to an id in the test case context

	object_queue: DS_LINKED_QUEUE [ABSTRACT_DEBUG_VALUE]
			-- Queue of objects which still need to printed in the context

	object_count: INTEGER
			-- Number of objects inserted to into object queue total

	is_reference_value (an_adv: ABSTRACT_DEBUG_VALUE): BOOLEAN is
			-- Is `an_adv' a reference to some object?
		do
			Result := an_adv.kind = {VALUE_TYPES}.reference_value or an_adv.kind = {VALUE_TYPES}.special_value
		end


feature {NONE} -- Implementation

	terminate is
			-- Clean up everything we used for creating test case class text.
		do
			Precursor
			object_map := Void
			object_queue := Void
		end

	append_indexing (an_uuid: STRING; an_index: INTEGER) is
			-- Append indexing clause using `an_uuid' for call
			-- stack id and `an_index' for call stack index.
		require
			initialized: is_initialized
			an_uuid_not_empty: an_uuid /= Void and then not an_uuid.is_empty
			an_index_positive: an_index > 0
		do
			append_text ("indexing%N")
			append_text ("%Tdescription: %"Objects that represent a cdd test case%"%N")
			append_text ("%Tcall_stack_uuid: %"" + an_uuid + "%"")
			append_text ("%Tcall_stack_index: " + an_index.out + "")
			-- NOTE: not sure if class/feature information is needed by manager
			-- since it is part of the test case class text -Arno
			--append_text ("%Tcdd_cluster: %"" + l_class.cluster.cluster_name + "%"%N")
			--append_text ("%Tcdd_class: %"" + l_class.name_in_upper + "%"%N")
			--append_text ("%Tcdd_feature: %"" + a_name + "%"%N")
			append_text ("%Tauthor: %"CDD_TEST_CASE_PRINTER%"%N")
			append_text ("%Tdate: %"$Date$%"%N")
			append_text ("%Trevision: %"$Revision$%"%N%N")
		ensure
			file_size_increased: output_file.count > old output_file.count
		end

	append_class_header (a_class_name, a_cut_name, an_arg_list: STRING) is
			-- Append cdd test case class header with name `a_class_name' for testing `a_cut_name'.
			-- The feature under test takes the arguments listed in `a_arg_list'.
		require
			initialized: is_initialized
			a_class_name_not_empty: a_class_name /= Void and then not a_class_name.is_empty
			a_cut_name_not_empty: a_cut_name /= Void and then not a_cut_name.is_empty
			an_arg_list_not_empty: an_arg_list /= Void and then not an_arg_list.is_empty
		do
			append_text ("class%N%T" + a_class_name + "%N%N")
			append_text ("inherit%N%TCDD_SHARED_TESTING [" + a_cut_name + ", " + an_arg_list + "]%N%N")
			append_text ("%N%Ncreate%N%Tmake%N%N")
		ensure
			file_size_increased: output_file.count > old output_file.count
		end

	append_set_up (a_feature: E_FEATURE; an_is_creation_call: BOOLEAN) is
			-- Append class header text for 'test_class_name'
		require
			initialized: is_initialized
			a_feature_not_void: a_feature /= Void
		local
			i: INTEGER
		do
			append_text ("feature -- Initialization%N%N")
			append_text ("%Tset_up_routine is%N")
			append_text ("%T%T%T-- Initialize agent that calls feature under test%N")
			append_text ("%T%Tdo%N")
			append_text ("%T%T%Troutine_under_test := agent ")
			if an_is_creation_call then
				append_text ("(")
				from
					i := 1
				until
					i > a_feature.argument_count
				loop
					append_text ("an_arg" + i.out + ": " + a_feature.arguments.i_th (i).dump)
					if i < a_feature.argument_count then
						append_text ("; ")
					end
					i := i + 1
				end
				append_text (")%N%T%T%T%Tdo%N%T%T%T%T%T")
				append_text ("create object_under_test." + a_feature.name + "(")
				from
					i := 1
				until
					i > a_feature.argument_count
				loop
					append_text ("an_arg" + i.out)
					if i < a_feature.argument_count then
						append_text (", ")
					end
					i := i + 1
				end
				append_text (")%N%T%T%T%Tend")
			else
				append_text ("object_under_test." + a_feature.name)
			end
			append_text ("%N%T%Tend%N%N")
		ensure
			file_size_increased: output_file.count > old output_file.count
		end

	append_access (a_cut_name, a_feature_name: STRING) is
			-- Append class header text for `test_class_name'.
		require
			initialized: is_initialized
			a_cut_name_not_empty: a_cut_name /= Void and then not a_cut_name.is_empty
			a_feature_name_not_empty: a_feature_name /= Void and then not a_feature_name.is_empty
		do
			append_text ("feature -- Access%N%N")
			append_text ("%Tclass_under_test: STRING is %"" + a_cut_name + "%"%N")
			append_text ("%T%T%T-- Name of the class beeing tested%N%N")
			append_text ("%Tfeature_under_test: STRING is %"" + a_feature_name + "%"%N")
			append_text ("%T%T%T-- Name of the feature beeing tested%N%N")
		ensure
			file_size_increased: output_file.count > old output_file.count
		end

	append_context (a_cse: EIFFEL_CALL_STACK_ELEMENT; an_is_creation_call: BOOLEAN; an_arg_list: STRING) is
			-- Append class header text for `test_class_name'
		require
			initialized: is_initialized
			a_cse_valid: a_cse /= Void
			an_arg_list_not_empty: an_arg_list /= Void and then not an_arg_list.is_empty
		local
			l_args: LIST [ABSTRACT_DEBUG_VALUE]
			l_adv: ABSTRACT_DEBUG_VALUE
			i: INTEGER
		do
				-- Reserve second object in context for object under test
			if an_is_creation_call then
				object_count := 2
			else
				add_referenced_object (a_cse.current_object_value)
			end

			append_text ("feature -- Context%N%N")

				-- Context
			append_text ("%Tcontext: ARRAY [TUPLE [STRING, STRING, ARRAY [STRING]]] is%N")
			append_text ("%T%T%T-- Context for executing test case%N")
			append_text ("%T%T%T-- NOTE: by definition first element are arguments, second the object itself%N")
			append_text ("%T%Tonce%N")
			append_text ("%T%T%TResult := <<%N")

				-- Append arguments as first object in context
			append_text ("%T%T%T%T%T-- Arguments for calling `routine_under_test'%N")
			append_text ("%T%T%T%T[#1, %"" + an_arg_list + "%", << ")
			from
				l_args := a_cse.arguments
				i := 1
			until
				i > l_args.count
			loop
				l_adv := l_args.item
				append_text ("%"" + attribute_value (l_adv) + "%"")
				if i < l_args.count then
					append_text (", ")
				end
				i := i + 1
			end
			append_text (" >>],%N")

			append_text ("%T%T%T%T%T-- Actual object under test%N")

			if an_is_creation_call then
					-- Append Void object since routine is an creation call
				append_text ("%T%T%T%TVoid,%N")
			end

			from until
				object_queue.is_empty
			loop
				append_single_object_context (object_queue.item)
				object_queue.remove
			end

			append_text ("%N%T%Tend%N%N")
		ensure
			file_size_increased: output_file.count > old output_file.count
		end

	add_referenced_object (an_adv: ABSTRACT_DEBUG_VALUE) is
			-- Add `an_adv' to `object_map' and `object_queue'.
		require
			object_map_not_void: object_map /= Void
			object_queue_not_void: object_queue /= Void
			an_adv_valid: an_adv /= Void and is_reference_value (an_adv)
			not_yet_added: not object_map.has (an_adv.address)
		local
			l_new_id: STRING
		do
			object_count := object_count + 1
			l_new_id := "#" + object_count.out
			object_map.put (l_new_id, an_adv.address)
			object_queue.put (an_adv)
		ensure
			added_to_mapping: object_map.has (an_adv.address)
			added_to_queue: object_queue.count = old object_queue.count + 1
		end

	attribute_value (an_adv: ABSTRACT_DEBUG_VALUE): STRING is
			-- Value represented by `an_adv' if it is a basic type,
			-- otherwise the mapped id for the object it is pointing to.
			-- Is void in case `an_adv' represents a void or unhandled value.
		require
			initialized: is_initialized
		do
			inspect an_adv.kind
			when {VALUE_TYPES}.reference_value then
				if  an_adv.dynamic_class /= Void and then an_adv.dynamic_class.is_eiffel_class_c then
					if object_map.has (an_adv.address) then
						Result := object_map.item (an_adv.address)
					else
						if object_map.is_full then
							object_map.resize (object_map.capacity * 2)
						end
						object_count := object_count + 1
						Result := "#" + object_count.out
						object_map.put (Result, an_adv.address)
						object_queue.put (an_adv)
					end
				end
			when {VALUE_TYPES}.immediate_value then
				Result := an_adv.output_value
			when {VALUE_TYPES}.void_value then
				Result := "Void"
			else
				create Result.make_empty
			end
		ensure
			not_void: Result /= Void
		end

	append_single_object_context (an_object: ABSTRACT_DEBUG_VALUE) is
			-- Append `an_object' with id `an_id' to test case context.
		require
			initialized: is_initialized
			reference_value: is_reference_value (an_object)
			added_object: object_map.has (an_object.address)
		local
			l_class: EIFFEL_CLASS_C
			l_id, l_value: STRING
			l_ref_adv: ABSTRACT_REFERENCE_VALUE
		do
			l_class := an_object.dynamic_class.eiffel_class_c

			l_id := object_map.item (an_object.address)
			append_text ("%T%T%T%T[%"#" + l_id + "%", %"" + l_class.name_in_upper)
			if l_class.is_generic then
				append_text (" [" + an_object.dump_value.generating_type_representation (True) + "]")
			end
			append_text ("%", ")

			if l_class.name.is_equal ("STRING_8") or l_class.name.is_equal ("STRING_32") then
				l_ref_adv ?= an_object
				check l_ref_adv_not_void: l_ref_adv /= Void end
				append_text ("<< [%"1%", %"" + l_ref_adv.string_value + "%"] >>")
			else
				append_object_attributes (an_object.children, True)
			end
			append_text ("%"]")
		end

	append_object_attributes (an_attr_list: DS_LIST [ABSTRACT_DEBUG_VALUE]; an_use_attr_names: BOOLEAN) is
			-- Append a list of attributes for an object in the context.
		require
			initialized: is_initialized
			object_map_not_void: object_map /= Void
			object_queue_not_void: object_queue /= Void
			an_attr_list_not_void: an_attr_list /= Void
		local
			l_cursor: DS_LIST_CURSOR [ABSTRACT_DEBUG_VALUE]
			l_child: ABSTRACT_DEBUG_VALUE
			l_value: STRING
		do
			append_text ("<< ")
			from
				l_cursor := an_attr_list.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_child := l_cursor.item
				l_value := attribute_value (l_child)
				if l_value /= Void then
					if an_use_attr_names then
						append_text ("[%"" + l_child.name + "%", %"" + l_value + "%"]")
					else
						append_text ("[%"" + l_cursor.index.out + "%", %"" + l_value + "%"]")
					end
				end
				l_cursor.forth
			end
			append_text (">>")
		end

	append_class_footer (test_class_name: STRING) is
			-- Append class footer for test_class_name.
		require
			test_class_name_not_void: test_class_name /= Void
		do
			append_text ("%N%Nend -- " + test_class_name + "%N%N")
		ensure
			file_size_increased: output_file.count > old output_file.count
		end

-- NOTE: everything below (except invariants) is obsolete and will be removed soon...

feature {CDD_OBJECT} -- Testcase generation

	append_object_declaration (an_object: CDD_COMPOSITE_OBJECT) is
			-- Append declaration text for 'an_object'
		require
			an_object_not_void: an_object /= Void
		do
--			append_text ("%T" + an_object.identifier + ": " + an_object.type + "%N")
		end

	append_regular_creation (an_object: CDD_REGULAR_OBJECT) is
			-- Append creation text for 'an_object'
		require
			an_object_not_void: an_object /= Void
		do
			--append_instruction (an_object.identifier + " ?= build_object (%"" +an_object.type + "%")")
		end

	append_regular_assignment (an_object: CDD_REGULAR_OBJECT) is
			-- Append assignment text for 'an_object'.
		require
			an_object_not_void: an_object /= Void
		local
			instr: STRING
			a_key: STRING
			a_value: CDD_OBJECT
		do
			append_instruction ("create attributes.make (" + an_object.attributes.count.out + ")")
			from
				an_object.attributes.start
			until
				an_object.attributes.after
			loop
				a_key := an_object.attributes.key_for_iteration
				a_value := an_object.attributes.item_for_iteration
				instr := "" --"attributes.put (" + a_value.identifier + ", %""
				instr.append (a_key + "%")")
				append_instruction (instr)
				an_object.attributes.forth
			end
			--append_instruction ("set_attributes (" + an_object.identifier + ")")
		end

	append_string_creation (a_string: CDD_STRING_OBJECT) is
			-- Append creation text for 'a_string'
		require
			a_string_not_void: a_string /= Void
		do
--			append_instruction (a_string.identifier + " := " + a_string.representation)
		end

	append_string_assignment (a_string: CDD_STRING_OBJECT) is
			-- Append assignment text for 'a_string'
		require
			a_string_not_void: a_string /= Void
		do
			-- NOTE: do nothing since strings get fully assigned at creation
		end


	append_special_creation (a_special: CDD_SPECIAL_OBJECT) is
			-- Append creation text for 'a_special'
		require
			a_special_not_void: a_special /= Void
		do
--			append_instruction ("create " + a_special.identifier + ".make(" + a_special.attributes.count.out + ")")
		end

	append_special_assignment (a_special: CDD_SPECIAL_OBJECT) is
			-- Append assignment text for 'a_special'.
		require
			a_special_not_void: a_special /= Void
		local
			i: INTEGER
			instr: STRING
		do
			from
				i := 0
			until
				i = a_special.attributes.count
			loop
--				instr := a_special.identifier + ".put ("
--				instr.append (a_special.attributes.item (i.out).identifier)
--				instr.append (", " + i.out + ")")
--				append_instruction (instr)
				i := i + 1
			end
		end

	append_tuple_creation (a_tuple: CDD_TUPLE_OBJECT) is
			-- Append creation text for 'a_tuple'.
		require
			a_tuple_not_void: a_tuple /= Void
		do
--			append_instruction ("create " + a_tuple.identifier)
		end

	append_tuple_assignment (a_tuple: CDD_TUPLE_OBJECT) is
			-- Append assignment text for 'a_tuple'.
		require
			a_tuple_not_void: a_tuple /= Void
		local
			i: INTEGER
			instr: STRING
		do
			from
				i := 1
			until
				i > a_tuple.attributes.count
			loop
--				instr := a_tuple.identifier + ".put ("
--				instr.append (a_tuple.attributes.item (i.out).identifier + ", " + i.out)
--				instr.append (")")
--				append_instruction (instr)
				i := i + 1
			end
		end

invariant
	object_count_not_negative: object_count >= 0

end
