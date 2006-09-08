indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TESTER_PRINTER

feature -- Access

	print_test_case (a_test_suite: CDD_TEST_SUITE; a_file: FILE) is
		require
			a_file_writeable: a_file /= Void and then a_file.is_writable
		local
			rlist: DS_LIST [CDD_COMPOSITE_OBJECT]
			root_object: CDD_COMPOSITE_OBJECT
			l_feature: E_FEATURE
		do
			output_file := a_file

			output_file.flush
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

	append_indexing (a_reflection: CDD_REFLECTED_OBJECT) is
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
