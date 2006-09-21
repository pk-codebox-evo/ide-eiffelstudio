indexing
	description: "Objects that print a root class for the cdd interpreter"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TESTER_PRINTER

inherit

	CDD_CONSTANTS

feature -- Access

	print_root_class (a_list: DS_LIST [CDD_TEST_CASE]; an_old_root_class: STRING; a_file: KL_OUTPUT_FILE; with_argument: BOOLEAN) is
			-- Print root class for testing 'a_test_suite'.
		require
			a_list_valid: a_list /= Void and then not a_list.is_empty
			root_class_valid: an_old_root_class /= Void and then not an_old_root_class.is_empty
			a_file_valid: a_file /= Void and then a_file.is_open_write
		local
			l_root_class_path: STRING
			l_cursor: DS_LIST_CURSOR [CDD_TEST_CASE]
		do
			output_file := a_file

			append_class_header
			append_text ("%Tmake is%N%T%Tlocal%N")
			if with_argument then
				append_instruction ("l_arg: STRING")
			else
				append_instruction ("l_old_root_class: " + an_old_root_class)
			end
			append_text ("%T%Tdo%N")
			if with_argument then
				append_instruction ("l_arg := command_line.argument (1)")
			end
			if with_argument then
				append_instruction ("if False then")
			end
			from
				l_cursor := a_list.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				if with_argument then
					append_instruction ("elseif l_arg.is_equal (%"" + l_cursor.item.test_class.name + "%") then")
				end
				append_instruction ("%Trun_test (create {" + l_cursor.item.test_class.name + "})")
				l_cursor.forth
			end
			if with_argument then
				append_instruction ("end")
			end
			append_text ("%T%Tend%N%N")
			append_class_footer

			output_file.flush
			output_file := Void
		end

feature {NONE} -- Implementation

	append_text (a_text: STRING) is
			-- Append 'a_text' to 'output_file'.
		require
			output_file_not_void: output_file /= Void
			a_text_not_void: a_text /= Void
		do
			output_file.put_string (a_text)
		end

	append_instruction (a_text: STRING) is
			-- Append 'a_text' to 'output_file' with correct indentation.
		require
			output_file_not_void: output_file /= Void
			a_text_not_void: a_text /= Void
		do
			append_text (indent + a_text + "%N")
		end

	append_comment (a_text: STRING) is
			-- Append 'a_text' to 'output_file' as comment with correct indentation.
		require
			output_file_not_void: output_file /= Void
			a_text_not_void: a_text /= Void
		do
			append_text (indent + "%T-- " + a_text + "%N")
		end

	output_file: KL_OUTPUT_FILE
			-- File class text is written

	indent: STRING is "%T%T%T"
			-- Indentation for instruction text

	append_class_header is
			-- Append class header to output file
		require
			output_file_not_void: output_file /= Void
		do
			append_text ("indexing%N")
			append_text ("%Tdescription: %"Automatic generated root class for cdd tester%"%N")
			append_text ("%Tauthor: %"CDD_TESTER_PRINTER%"%N")
			append_text ("%Tdate: %"$Date$%"%N")
			append_text ("%Trevision: %"$Revision$%"%N%N")
			append_text ("class%N%T " + root_class_name + " %N%N")
			append_text ("inherit%N%TCDD_INTERPRETER_SUPPORT%N%N")
			append_text ("create%N%Tmake%N%N")
			append_text ("feature {NONE} -- Initialization%N%N")
		end

	append_class_footer is
			-- Append class footer to output file
		require
			output_file_not_void: output_file /= Void
		do
			append_text ("%N%Nend -- CDD_TESTER_INTERPRETER%N%N")
		end

invariant
	correct_output_file_status: output_file /= Void implies output_file.is_open_write

end
