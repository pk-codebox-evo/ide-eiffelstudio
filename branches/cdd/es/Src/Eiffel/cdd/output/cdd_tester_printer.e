indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TESTER_PRINTER

feature -- Access

	print_test_case (a_test_suite: CDD_TEST_SUITE) is
		require
			a_test_suite_not_void: a_test_suite /= Void
		local
			l_root_class_path: STRING
			l_cursor: DS_LINKED_LIST_CURSOR [CDD_TEST_CASE]
		do
			l_root_class_path := a_test_suite.tester_cluster.location.build_path ("", "cdd_interpreter.e")
			create output_file.make (l_root_class_path)
			output_file.open_write

			append_class_header

			append_text ("%Tmake is%N%T%Tlocal%N")
			append_instruction ("l_arg: STRING")
			append_text ("%T%Tdo%N")
			append_instruction ("l_arg := command_line.argument (1)")
			append_instruction ("if False then")
			from
				l_cursor := a_test_suite.test_cases.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				append_instruction ("elseif l_arg.is_equal (%"" + l_cursor.item.test_class.name + "%") then")
				append_instruction ("%Trun_test (create {" + l_cursor.item.test_class.name + "})")
				l_cursor.forth
			end
			append_instruction ("end")
			append_text ("%T%Tend%N%N")
			append_class_footer
			output_file.flush
			output_file.close
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

	output_file: PLAIN_TEXT_FILE

	indent: STRING is "%T%T%T"

	append_class_header is
		do
			append_text ("indexing%N")
			append_text ("%Tdescription: %"Automatic generated root class for cdd tester%"%N")
			append_text ("%Tauthor: %"CDD_TESTER_PRINTER%"%N")
			append_text ("%Tdate: %"$Date$%"%N")
			append_text ("%Trevision: %"$Revision$%"%N%N")
			append_text ("class%N%T CDD_INTERPRETER %N%N")
			append_text ("inherit%N%TCDD_INTERPRETER_SUPPORT%N%N")
			append_text ("create%N%Tmake%N%N")
			append_text ("feature {NONE} -- Initialization%N%N")
		end

	append_class_footer is
		do
			append_text ("%N%Nend -- CDD_TESTER_INTERPRETER%N%N")
		end


invariant
	invariant_clause: True -- Your invariant here

end
