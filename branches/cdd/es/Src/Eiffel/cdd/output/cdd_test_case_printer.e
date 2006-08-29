indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_CASE_PRINTER

feature -- Access

	print_test_case (reflection: CDD_REFLECTED_OBJECT; test_class_name: STRING; a_file: FILE) is
		require
			a_file_writeable: a_file /= Void and then a_file.is_writable
		local
			rlist: DS_LIST [CDD_COMPOSITE_OBJECT]
			root_object: CDD_COMPOSITE_OBJECT
			l_feature: E_FEATURE
		do
			output_file := a_file
			root_object := reflection.root_object
			l_feature := reflection.called_routine
			rlist := reflection.composite_objects

			append_indexing (root_object.dynamic_class.group.name, root_object.dynamic_class.name, l_feature.name)
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

	append_object_declaration (an_object:CDD_COMPOSITE_OBJECT) is
			--
		do
			append_instruction (an_object.identifier + ": " + an_object.full_type)
		end

	append_regular_creation (an_object: CDD_REGULAR_OBJECT) is
			--
		do
			append_instruction (an_object.identifier + " ?= build_object (%"" +an_object.type + "%")")
		end


	append_regular_assignment (an_object: CDD_REGULAR_OBJECT) is
			--
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
			--
		do
			append_instruction (a_string.identifier + " := " + a_string.representation)
		end

	append_string_assignment (a_string: CDD_STRING_OBJECT) is
			--
		do
			-- do nothing since strings get fully assigned at creation
		end


	append_special_creation (a_special: CDD_SPECIAL_OBJECT) is
			--
		do
			append_instruction ("create " + a_special.identifier + ".make(" + a_special.attributes.count.out + ")")
		end


	append_special_assignment (a_special: CDD_SPECIAL_OBJECT) is
			--
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
				instr.append (i.out + ", " + a_special.attributes.item (i.out).identifier)
				instr.append (")")
				append_instruction (instr)
				i := i + 1
			end
		end

	append_tuple_creation (a_tuple: CDD_TUPLE_OBJECT) is
			-- text for creating tuple objects
		do
			append_instruction ("create " + a_tuple.identifier)
		end

	append_tuple_assignment (a_tuple: CDD_TUPLE_OBJECT) is
			--
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

	append_text (s: STRING) is
		require
			file_writable: output_file /= Void and then output_file.is_writable
		do
			output_file.put_string (s)
		end

	append_instruction (l: STRING) is
		require
			file_writable: output_file /= Void and then output_file.is_writable
		do
			append_text (indent + l + "%N")
		end

	append_comment (c: STRING) is
		require
			file_writable: output_file /= Void and then output_file.is_writable
		do
			append_text (indent + "%T-- " + c + "%N")
		end

	output_file: FILE

	indent: STRING is "%T%T%T"

	append_indexing (cluster_name, class_name, feature_name: STRING) is
		do
			append_text ("indexing%N")
			append_text ("%Tdescription: %"Objects used for running tests%"%N")
			append_text ("%Tcdd_cluster: %"" + cluster_name + "%"%N")
			append_text ("%Tcdd_class: %"" + class_name + "%"%N")
			append_text ("%Tcdd_feature: %"" + feature_name + "%"%N")
			append_text ("%Tauthor: %"CDD_TEST_CASE_PRINTER%"%N")
			append_text ("%Tdate: %"$Date$%"%N")
			append_text ("%Trevision: %"$Revision$%"%N%N")
		end


	append_class_header (test_class_name: STRING) is
		do
			append_text ("class%N%T" + test_class_name + "%N%N")
			append_text ("inherit%N%TCDD_SHARED_TESTING%N%N")
			append_text ("feature -- Testing%N%N")
		end

	append_class_footer (test_class_name: STRING) is
		do
			append_text ("%N%Nend -- " + test_class_name + "%N%N")
		end


invariant
	invariant_clause: True -- Your invariant here

end
