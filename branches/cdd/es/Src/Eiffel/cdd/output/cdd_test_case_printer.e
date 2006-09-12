indexing
	description: "Objects that print class text for a test case"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_CASE_PRINTER

feature -- Access

	print_test_case (reflection: CDD_REFLECTED_OBJECT; test_class_name: STRING; a_file: FILE) is
			-- Print class text for a new cdd test case.
		require
			valid_reflection: reflection /= Void and then reflection.reflection_succeded
			valid_test_class_name: test_class_name /= Void and then not test_class_name.is_empty
			a_file_writeable: a_file /= Void and then a_file.is_writable
		local
			rlist: DS_LIST [CDD_COMPOSITE_OBJECT]
			root_object: CDD_COMPOSITE_OBJECT
			l_feature: E_FEATURE
		do
			output_file := a_file
			root_object := reflection.root_object
			l_feature := reflection.called_feature
			rlist := reflection.composite_objects

			append_indexing (reflection)
			append_class_header (test_class_name)

			append_text ("%N%Ttest_feature is%N")
			append_comment ("run tests")
			append_text ("%T%Tlocal%N")

			from
				rlist.start
			until
				rlist.after
			loop
				append_object_declaration (rlist.item_for_iteration)
				rlist.forth
			end
			if l_feature.is_function then
				append_instruction ("l_result: ANY")
			end

			append_text ("%T%Tdo%N")
			append_comment ("Create objects")
			from
				rlist.start
			until
				rlist.after
			loop
				rlist.item_for_iteration.append_creation (Current)
				rlist.forth
			end

			append_comment ("Assign attributes")
			from
				rlist.start
			until
				rlist.after
			loop
				rlist.item_for_iteration.append_assignment (Current)
				rlist.forth
			end

			append_text ("%N%N" + indent)
			if l_feature.is_function then
				append_text ("l_result ?= ")
			end
			append_text (root_object.identifier + "." + l_feature.name)
			if reflection.arguments.count > 0 then
				append_text (" (")
				from
					reflection.arguments.start
				until
					reflection.arguments.after
				loop
					append_text (reflection.arguments.item_for_iteration.identifier)
					reflection.arguments.forth
					if not reflection.arguments.after then
						append_text (", ")
					end
				end
				append_text (")")
			end
			append_text ("%N%N%T%Tend%N%N")
			append_class_footer (test_class_name)
			output_file.flush
		end


feature {CDD_OBJECT} -- Testcase generation

	append_object_declaration (an_object: CDD_COMPOSITE_OBJECT) is
			-- Append declaration text for 'an_object'
		require
			an_object_not_void: an_object /= Void
		do
			append_instruction (an_object.identifier + ": " + an_object.type)
		end

	append_regular_creation (an_object: CDD_REGULAR_OBJECT) is
			-- Append creation text for 'an_object'
		require
			an_object_not_void: an_object /= Void
		do
			append_instruction (an_object.identifier + " ?= build_object (%"" +an_object.type + "%")")
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
				instr := "attributes.put (" + a_value.identifier + ", %""
				instr.append (a_key + "%")")
				append_instruction (instr)
				an_object.attributes.forth
			end
			append_instruction ("set_attributes (" + an_object.identifier + ")")
		end

	append_string_creation (a_string: CDD_STRING_OBJECT) is
			-- Append creation text for 'a_string'
		require
			a_string_not_void: a_string /= Void
		do
			append_instruction (a_string.identifier + " := " + a_string.representation)
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
			append_instruction ("create " + a_special.identifier + ".make(" + a_special.attributes.count.out + ")")
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
				instr := a_special.identifier + ".put ("
				instr.append (a_special.attributes.item (i.out).identifier)
				instr.append (", " + i.out + ")")
				append_instruction (instr)
				i := i + 1
			end
		end

	append_tuple_creation (a_tuple: CDD_TUPLE_OBJECT) is
			-- Append creation text for 'a_tuple'.
		require
			a_tuple_not_void: a_tuple /= Void
		do
			append_instruction ("create " + a_tuple.identifier)
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
				instr := a_tuple.identifier + ".put ("
				instr.append (a_tuple.attributes.item (i.out).identifier + ", " + i.out)
				instr.append (")")
				append_instruction (instr)
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	append_text (a_text: STRING) is
			-- Append 'a_text' to 'output_file'.
		require
			file_writable: output_file /= Void and then output_file.is_writable
			a_text_not_void: a_text /= Void
		do
			output_file.put_string (a_text)
		end

	append_instruction (a_text: STRING) is
			-- Append 'a_text' to 'output_file' with correct indentation.
		require
			file_writable: output_file /= Void and then output_file.is_writable
			a_text_not_void: a_text /= Void
		do
			append_text (indent + a_text + "%N")
		end

	append_comment (a_text: STRING) is
			-- Append 'a_text' to 'output_file' as comment with correct indentation.
		require
			file_writable: output_file /= Void and then output_file.is_writable
			a_text_not_void: a_text /= Void
		do
			append_text (indent + "%T-- " + a_text + "%N")
		end

	output_file: FILE
			-- File class text is written

	indent: STRING is "%T%T%T"
			-- Indentation for instruction text

	append_indexing (a_reflection: CDD_REFLECTED_OBJECT) is
			-- Append indexing clause for 'a_reflection'
		require
			a_reflection_not_void: a_reflection /= Void
		local
			l_class: EIFFEL_CLASS_C
		do
			l_class := a_reflection.root_object.dynamic_type
			append_text ("indexing%N")
			append_text ("%Tdescription: %"Objects used for running tests%"%N")
			append_text ("%Tcdd_cluster: %"" + l_class.cluster.cluster_name + "%"%N")
			append_text ("%Tcdd_class: %"" + l_class.name_in_upper + "%"%N")
			append_text ("%Tcdd_feature: %"" + a_reflection.called_feature.name + "%"%N")
			append_text ("%Tcdd_tag: %"" + a_reflection.exception_tag + "%"%N")
			append_text ("%Tcdd_id: %"" + a_reflection.id + "%"%N")
			append_text ("%Tauthor: %"CDD_TEST_CASE_PRINTER%"%N")
			append_text ("%Tdate: %"$Date$%"%N")
			append_text ("%Trevision: %"$Revision$%"%N%N")
		end


	append_class_header (test_class_name: STRING) is
			-- Append class header text for 'test_class_name'
		require
			test_class_name_not_void: test_class_name /= Void
		do
			append_text ("class%N%T" + test_class_name + "%N%N")
			append_text ("inherit%N%TCDD_SHARED_TESTING%N%N")
			append_text ("feature -- Testing%N%N")
		end

	append_class_footer (test_class_name: STRING) is
			-- Append class footer for test_class_name.
		require
			test_class_name_not_void: test_class_name /= Void
		do
			append_text ("%N%Nend -- " + test_class_name + "%N%N")
		end

end
