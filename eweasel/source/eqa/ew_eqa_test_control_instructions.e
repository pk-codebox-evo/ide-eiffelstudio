indexing
	description: "[
					Inherit this class to replace old eweasel test control file (tcf)
																							]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EW_EQA_TEST_CONTROL_INSTRUCTIONS

inherit
	EW_INSTRUCTION_TABLES

	EQA_TEST_SET

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation method
		do
			create instructions.make
		end

	init_command (a_test_instruction: EW_TEST_INSTRUCTION; a_name: STRING; a_argument: STRING) is
			-- Initialize `a_test_instruction'
		require
			not_void: a_test_instruction /= Void
		local
			l_control_file: EW_EQA_TEST_CONTROL_FILE
			l_factory: EW_EQA_TEST_FACTORY
		do
			create l_factory
			create l_control_file.make_eqa (instructions, l_factory.environment)
			a_test_instruction.initialize_for_conditional (l_control_file, a_name, a_argument)
		end

feature {NONE} -- Implementation

	execute_inst (a_inst: EW_TEST_INSTRUCTION) is
			-- Modified base on {EW_EIFFEL_EWEASEL_TEST}.execute
		require
			not_void: a_inst /= Void
		local
			l_factory: EW_EQA_TEST_FACTORY
			err: EW_EXECUTION_ERROR;
			orig_text, subst_text: STRING;
			terminated: BOOLEAN

			last_ok: BOOLEAN
		do
			create l_factory
			a_inst.execute (l_factory.eweasel_test)

			last_ok := a_inst.execute_ok;
			terminated := a_inst.test_execution_terminated

			if not last_ok then
				if not terminated then
				--	instructions.finish;	-- Test_end instruction here?
				--	instructions.item.execute (Current);
				end
				create orig_text.make (0);
				orig_text.append (a_inst.command);
				orig_text.extend (' ');
				orig_text.append (a_inst.orig_arguments);
				create subst_text.make (0);
				subst_text.append (a_inst.command);
				subst_text.extend (' ');
				subst_text.append (a_inst.subst_arguments);
				create err.make (a_inst.file_name, a_inst.line_number, orig_text, subst_text, a_inst.failure_explanation);
				-- add_error (err);
				err.display
				assert (a_inst.command, FAlse)
			end
		end

feature -- Command

	Abort_compile is
			--	Abort a suspended Eiffel compilation so that another
			--	compilation can be started from scratch.  There can be at most
			--	one Eiffel compilation in progress at a time.  This
			--	instruction does a `cleanup' after aborting the compilation,
			--	which deletes the entire EIFGENs/test directory tree.
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (abort_compile_keyword)

			execute_inst (l_inst)
		end

	Ace is
			-- Ace command
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Ace_keyword)
			execute_inst (l_inst)
		end

	C_compile_final (a_output_filename: STRING)
			--	Just like `c_compile_work', except that it compiles the C
			--	files generated by a `compile_final' instruction.
		local
			l_inst: EW_TEST_INSTRUCTION
			l_temp: STRING
		do
			l_inst := test_command_table.item (C_compile_final_keyword)
			if a_output_filename = Void then
				l_temp := ""
			else
				l_temp := a_output_filename
			end
			init_command (l_inst, "c_compile_final", l_temp)

			execute_inst (l_inst)
		end

	C_compile_result (a_result: STRING)
			--	Check that the result from the last c_compile_work or
			--	c_compile_final instruction matches <result>.  If it does not,
			--	then the test has failed and the rest of the test instructions
			--	are skipped.  If the result matches <result>, continue
			--	processing with the next test instruction.  <result> can be:

			--		ok
			--			Matches if compiler successfully compiled all
			--			C files and linked an executable.
		require
			not_void: a_result /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (C_compile_result_keyword)
			init_command (l_inst, "c_compile_result", a_result)
			execute_inst (l_inst)
		end

	C_compile_work (a_output_filename: STRING)
			--	Compile the C files generated by a `compile_melted' or
			--	`compile_frozen' instruction.  Note that `compile_melted' can
			--	result in freezing if there are external routines.  The
			--	optional <output-file-name> specifies the name of the file in
			--	the output directory $OUTPUT into which output from this
			--	compilation will be written, so that it can potentially be
			--	compared with a known correct output file.  If
			--	<output-file-name> is omitted, compilation results are written
			--	to a file with an unadvertised but obvious name (which could
			--	possibly change) in the output directory.
		local
			l_inst: EW_TEST_INSTRUCTION
			l_temp: STRING
		do
			l_inst := test_command_table.item (C_compile_work_keyword)
			if a_output_filename = Void then
				l_temp := ""
			else
				l_temp := a_output_filename
			end
			init_command (l_inst, "c_compile_work", l_temp)

			execute_inst (l_inst)
		end

	Cleanup_compile
			--	Clean up a previous Eiffel compilation by deleting the entire
			--	EIFGENs/test directory tree.  The next Eiffel compilation will
			--	start with a clean slate.  If there is a suspended Eiffel
			--	compilation awaiting resumption, the `abort_compile'
			--	instruction must be used instead of this one.
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Cleanup_compile_keyword)
			execute_inst (l_inst)
		end

	Compare (a_output_filename, a_correct_output_filename: STRING)
			--	Compare the file <output-file> in the output directory $OUTPUT
			--	with the file <correct-output-file> in the source directory
			--	$SOURCE.  If they are not identical, then the test has failed
			--	and the rest of the test instructions are skipped.  If they
			--	are identical, continue processing with the next test
			--	instruction.
		require
			not_void: a_output_filename /= Void
			not_void: a_correct_output_filename /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Compare_keyword)

			init_command (l_inst, "compare", a_output_filename + " " + a_correct_output_filename)

			execute_inst (l_inst)
		end

	Compile_final_keep (a_output_filename: STRING)
			--	Similar to `Compile_melted'
			--	Compile_final_keep requests finalizing of the system with
			--	assertions kept
		local
			l_inst: EW_TEST_INSTRUCTION
			l_temp: STRING
		do
			l_inst := test_command_table.item (Compile_final_keep_keyword)
			if a_output_filename = Void then
				l_temp := ""
			else
				l_temp := a_output_filename
			end
			init_command (l_inst, "compile_final_keep", l_temp)
			execute_inst (l_inst)
		end

	Compile_final (a_output_filename: STRING)
			-- Similar to `Compile_melted'
			-- Compile_final requests finalizing of the system with assertions discarded
		local
			l_inst: EW_TEST_INSTRUCTION
			l_temp: STRING
		do
			l_inst := test_command_table.item (Compile_final_keyword)
			if a_output_filename = Void then
				l_temp := ""
			else
				l_temp := a_output_filename
			end
			init_command (l_inst, "compile_final", l_temp)
			execute_inst (l_inst)
		end

	Compile_frozen (a_output_filename: STRING)
			-- Similar to `Compile_melted'
			-- Compile_frozen requests freezing of the system
		local
			l_inst: EW_TEST_INSTRUCTION
			l_temp: STRING
		do
			l_inst := test_command_table.item (Compile_frozen_keyword)
			if a_output_filename = Void then
				l_temp := ""
			else
				l_temp := a_output_filename
			end
			init_command (l_inst, "compile_frozen", l_temp)
			execute_inst (l_inst)
		end

	Compile_melted (a_output_filename: STRING)
			--	Run the Eiffel compiler in the test directory $TEST with the
			--	Ace file specified by the last `ace' instruction.  Since the
			--	Ace file is always assumed to be in the test directory, it
			--	must have previously been copied into this directory.

			--	Compile_melted does not request freezing of the system

			--	The optional <output-file-name> specifies
			--	the name of the file in the output directory $OUTPUT into
			--	which output from this compilation will be written, so that it
			--	can potentially be compared with a known correct output file.
			--	If <output-file-name> is omitted, compilation results are
			--	written to a file with an unadvertised but obvious name (which
			--	could possibly change) in the output directory.
		local
			l_inst: EW_TEST_INSTRUCTION
			l_temp: STRING
		do
			l_inst := test_command_table.item (Compile_melted_keyword)
			if a_output_filename = Void then
				l_temp := ""
			else
				l_temp := a_output_filename
			end
			init_command (l_inst, "compile_melted", l_temp)
			execute_inst (l_inst)
		end

	Compile_quick_melted
			-- Document not found...
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Compile_quick_melted_keyword)
			execute_inst (l_inst)
		end

	Compile_precompiled
			-- Document not found...
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Compile_precompiled_keyword)
			execute_inst (l_inst)
		end

	Compile_result (a_result: STRING)
			--Check that the compilation result from the last
			--compile_melted, compile_frozen, compile_final or
			--resume_compile instruction matches <result>.  If it does not,
			--then the test has failed.  If the result matches <result>,
			--continue processing with the next test instruction.  To
			--specify no class for <class> below, use NONE (which matches
			--only if the compiler does not report the error in a particular
			--class).  <result> can be:

			--	syntax_error  { <class> <line-number> ";" ... }+
			--		
			--		Matches if compiler reported a syntax error on each
			--		of the indicated classes at the given line numbers,
			--		in the order indicated.
			--		If <line-number> is omitted, then matches if
			--		compiler reported a syntax error on class
			--		<class>, regardless of position.  To specify
			--		no class (which means "syntax error on the Ace
			--		file"), use NONE.

			--	validity_error { <class> <validity-code-list> ";" ...}+
			--		
			--		Matches if compiler reported the indicated
			--		validity errors in the named classes in the
			--		order listed.  This validity code list is a
			--		white space separated list of validity codes
			--		from "Eiffel: The Language".

			--	validity_warning { <class> <validity-code-list> ";" ...}+
			--		
			--		Matches if compiler reported the indicated
			--		validity errors in the named classes in the
			--		order listed.  This validity code list is a
			--		white space separated list of validity codes
			--		from "Eiffel: The Language".  This is
			--		identical to validity_error, except that
			--		the compilation is expected to complete
			--		for validity_warning whereas it is expected
			--		to be paused for validity_error.

			--	ok

			--		Matches if compiler did not report any syntax
			--		or validity errors and no system failure or
			--		run-time panic occurred and the system was
			--		successfully recompiled.
		require
			not_void: a_result /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Compile_result_keyword)
			init_command (l_inst, "compile_result", a_result)
			execute_inst (l_inst)
		end

	Copy_bin (a_source_file, a_dest_directory, a_dest_file: STRING)
			--	Copy the binary file named <source-file> from the source directory
			--	$SOURCE to the <dest-directory> under the name <dest-file>.
			--	The destination directory is created if it does not exist.
		require
			not_void: a_source_file /= Void
			not_void: a_dest_directory /= Void
			not_void: a_dest_file /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Copy_bin_keyword)
			init_command (l_inst, "copy_bin", a_source_file + " " + a_dest_directory + " " + a_dest_file)
			execute_inst (l_inst)
		end

	Copy_file (a_source_file, a_dest_directory, a_dest_file: STRING)
			--	Similar to `copy_bin' except that it lets you copy file from anywhere to anywhere.
		require
			not_void: a_source_file /= Void
			not_void: a_dest_directory /= Void
			not_void: a_dest_file /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Copy_file_keyword)
			init_command (l_inst, "copy_file", a_source_file + " " + a_dest_directory + " " + a_dest_file)
			execute_inst (l_inst)
		end

	Copy_raw (a_source_file, a_dest_directory, a_dest_file: STRING)
			--	Copy the file named <source-file> from the source directory
			--	$SOURCE to the <dest-directory> under the name <dest-file>.
			--	The destination directory is created if it does not exist.  No
			--	substitution is done on the lines of <source-file>.
		require
			not_void: a_source_file /= Void
			not_void: a_dest_directory /= Void
			not_void: a_dest_file /= Void
		local
			l_factory: EW_EQA_TEST_FACTORY
			l_dest_directory: STRING
		do
			if attached {EW_COPY_INST} test_command_table.item (Copy_raw_keyword) as l_inst then
				create l_factory
				l_dest_directory := l_factory.environment.substitute (a_dest_directory)
				l_inst.inst_initialize_with (a_source_file, l_dest_directory, a_dest_file)
				init_command (l_inst, "copy_raw", "")
				execute_inst (l_inst)
			else
				check not_possible: False end
			end
		end

	Copy_sub (a_source_file, a_dest_directory, a_dest_file: STRING)
			--	Similar to `copy_raw' except that occurrences of a
			--	substitution variable, such as $NAME, are replaced by the
			--	value given to NAME in the last define, define_file or
			--	define_directory instruction which set it (or are left as
			--	$NAME if NAME has not been defined).
		require
			not_void: a_source_file /= Void
			not_void: a_dest_directory /= Void
			not_void: a_dest_file /= Void
		local
			l_factory: EW_EQA_TEST_FACTORY
		do
			if attached {EW_COPY_INST} test_command_table.item (Copy_sub_keyword) as l_inst then
				create l_factory
				l_inst.inst_initialize_with (a_source_file, a_dest_directory, a_dest_file)
				init_command (l_inst, "copy_sub", "")
				execute_inst (l_inst)
			else
				check not_possible: False end
			end

		end

	Cpu_limit (a_limit: STRING)
			--	Set the limit for Eiffel compilations to <limit> CPU seconds.
			--	If the time limit expires before compilation finishes, the
			--	compiler is presumed to be in an infinite loop and compilation
			--	is aborted.  This will usually cause the test to fail.
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Cpu_limit_keyword)
			init_command (l_inst, "cpu_limit", a_limit)
			execute_inst (l_inst)
		end

	Define_directory (a_name: STRING; a_dir_path: ARRAY [STRING])
			--	Similar to `define', except that <name> is defined to have the
			--	value which is the name of the directory specified by <path>
			--	and the subdirectories (which are components of the path name
			--	to be added onto <path> in an OS-dependent fashion).  This
			--	allows directory name construction to be (more or less)
			--	OS-independent.
		require
			not_void: a_name /= Void
			not_void: a_dir_path /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
			l_path: STRING
			l_count, l_max: INTEGER
			l_factory: EW_EQA_TEST_FACTORY
		do
			l_inst := test_command_table.item (Define_directory_keyword)
			from
				l_count := a_dir_path.lower
				l_max := a_dir_path.upper
				l_path := ""
			until
				l_count > l_max
			loop
				l_path := l_path + " " + a_dir_path.item (l_count)
				l_count := l_count + 1
			end
			create l_factory
			l_path := l_factory.environment.substitute (l_path)
			init_command (l_inst, "define_directory", a_name + " " + l_path)
			execute_inst (l_inst)
		end

	Define_file (a_name: STRING; a_dir_path: ARRAY [STRING]; a_file_name: STRING)
			--	Similar to `define', except that <name> is defined to have the
			--	value which is the name of the file specified by <path>, the
			--	<subdirN> subdirectory names and <filename>.  This allows
			--	construction of full file path names to be (more or less)
			--	OS-independent.
		require
			not_void: a_name /= Void
			not_void: a_dir_path /= Void
			not_void: a_file_name /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
			l_path: STRING
			l_count, l_max: INTEGER
			l_factory: EW_EQA_TEST_FACTORY
		do
			l_inst := test_command_table.item (Define_file_keyword)
			from
				l_count := a_dir_path.lower
				l_max := a_dir_path.upper
				l_path := ""
			until
				l_count > l_max
			loop
				l_path := l_path + " " + a_dir_path.item (l_count)
				l_count := l_count + 1
			end
			l_path := l_path + " " + a_file_name
			create l_factory
			l_path := l_factory.environment.substitute (l_path)
			init_command (l_inst, "define_file", a_name + " " + l_path)

			execute_inst (l_inst)
		end

	Define (a_name, a_value: STRING)
			--	Define the substitution variable <name> to have the value
			--	<value>.  If <value> contains white space characters, it must
			--	be enclosed in double quotes.  Substitution of variable values
			--	for names is triggered by the '$' character, when substitution
			--	is being done.  For example, $ABC will be replaced by the last
			--	value defined for variable ABC.  Case is significant and by
			--	convention substitution variables are normally given names
			--	which are all uppercase.  The name starts with the first
			--	character after the '$' and ends with the first non-identifier
			--	character (alphanumeric or underline) or end of line.
			--	Parentheses may be used to set a substitution variable off
			--	from the surrouding text (e.g., the substitution variable name
			--	in "$(ABC)D" is ABC, not ABCD).  If the named variable has not
			--	been defined, it is left as is during substitution (in the
			--	example above it would remain $(ABC)).  To get a $ character,
			--	use $$.  Substitution is always done when reading the lines of
			--	a test suite control file, test control file or test catalog.
			--	Substitution is done on the lines of a copied file when
			--	`copy_sub' is used, but not when `copy_raw' is used.
			-- See
			-- "http://svn.origo.ethz.ch/viewvc/eiffelstudio/trunk/eweasel/doc/eweasel.doc?annotate=HEAD"
			-- for more information
		require
			not_void: a_name /= Void
			not_void: a_value /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
			l_value: STRING
			l_factory: EW_EQA_TEST_FACTORY
		do
			l_inst := test_command_table.item (Define_keyword)
			l_value := a_value
			if l_value.is_empty then
				l_value := "%"%""
			end

			create l_factory
			l_value := l_factory.environment.substitute (l_value)
			init_command (l_inst, "define", a_name + " " + l_value)
			execute_inst (l_inst)
		end

	Delete (a_dest_directory, a_dest_file: STRING)
			--	Delete the file named <dest-file> from the directory
			--	<dest-directory>.  The destination directory should not
			--	normally be the source directory $SOURCE.
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Delete_keyword)
			init_command (l_inst, "delete", a_dest_directory + " " + a_dest_file)
			execute_inst (l_inst)
		end

	Execute_final (a_input_file: STRING; a_output_file: STRING; a_args: STRING)
			--	Similar to `execute_work', except that the final version of
			--	the system is executed.
		require
			not_void: a_input_file /= Void
			not_void: a_output_file /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
			l_temp: STRING
			l_factory: EW_EQA_TEST_FACTORY
		do
			l_inst := test_command_table.item (Execute_final_keyword)
			l_temp := a_input_file + " " + a_output_file
			if a_args /= Void then
				l_temp := l_temp + " " + a_args
			end

			create l_factory
			l_temp := l_factory.environment.substitute (l_temp)

			init_command (l_inst, "execute_final", l_temp)
			execute_inst (l_inst)
		end

	Execute_result (a_result: STRING)
			--	Check that the result from the last execute_work or
			--	execute_final instruction matches <result>.  If it does not,
			--	then the test has failed and the rest of the test instructions
			--	are skipped.  If the result matches <result>, continue
			--	processing with the next test instruction.  <result> can be:

			--	ok

			--	Matches if no exception trace or run-time
			--	panic occurred and there were no error
			--	messages of any kind.

			--	failed

			--	Matches if system did not complete normally
			--	(did not exit with 0 status) and output includes
			--	a "system execution failed" string

			--	failed_silently

			--	Matches if system did not complete normally
			--	(did not exit with 0 status) but output does not
			--	include a "system execution failed" string

			--	completed_but_failed

			--	Matches if system completed normally
			--	(exited with 0 status) but output includes
			--	a "system execution failed" string
		require
			not_void: a_result /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Execute_result_keyword)
			init_command (l_inst, "execute_result", a_result)
			execute_inst (l_inst)
		end

	Execute_work (a_input_file: STRING; a_output_file: STRING; args: STRING)
			--	Execute the workbench version of the system named by the last
			--	`system' instruction (or `test' if no previous system
			--	instruction).  The system will get its input from <input-file>
			--	in the source directory $SOURCE and will place its output in
			--	<output-file> in the output directory $OUTPUT.  If present,
			--	the optional <argN> will be passed to the system as command
			--	line arguments.  To specify no input file or no output file,
			--	use the name NONE.
		require
			not_void: a_input_file /= Void
			not_void: a_output_file /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
			l_temp: STRING
			l_factory: EW_EQA_TEST_FACTORY
		do
			l_inst := test_command_table.item (Execute_work_keyword)
			l_temp := a_input_file + " " + a_output_file
			if args /= Void then
				l_temp := l_temp + " " + args
			end

			create l_factory
			l_temp := l_factory.environment.substitute (l_temp)

			init_command (l_inst, "execute_work", l_temp)
			execute_inst (l_inst)
		end

	Exit_compile
			--	Abort a suspended Eiffel compilation so that another
			--	compilation can be started from scratch.  There can be at most
			--	one Eiffel compilation in progress at a time.  This
			--	instruction is identical to `abort_compile' except that
			--	it does not delete the EIFGENs/test directory tree.
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Exit_compile_keyword)
			execute_inst (l_inst)
		end

	If_ (a_name, a_controlled_instruction: STRING)
			--	If the substitution variable <name> has a value (or does not
			--	have a value, for an "if not" instruction), execute
			--	<controlled_instruction>.  Otherwise, skip controlled
			--	instruction and do not even attempt to parse it or determine
			--	whether it is a known instruction.  The controlled instruction
			--	of an `if' instruction may also be an `if instruction', with
			--	depth of nesting limited only by available memory.
		require
			not_void: a_name /= Void
			not_void: a_controlled_instruction /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
			l_factory: EW_EQA_TEST_FACTORY
			l_instruction: STRING
		do
			l_inst := test_command_table.item (If_keyword)

			create l_factory
			l_instruction := l_factory.environment.substitute (a_controlled_instruction)

			init_command (l_inst, "if", a_name + " " + l_instruction)
			execute_inst (l_inst)
		end

	if_not (a_name, a_controlled_instruction: STRING)
			-- Similiar to `If_' except if the substitution variable <name>
			-- does not have a value execute <controlled_instruction>.
		require
			not_void: a_name /= Void
			not_void: a_controlled_instruction /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
			l_factory: EW_EQA_TEST_FACTORY
			l_instruction: STRING
		do
			l_inst := test_command_table.item (If_keyword)

			create l_factory
			l_instruction := l_factory.environment.substitute (a_controlled_instruction)

			init_command (l_inst, "if", "not " + a_name + " " + l_instruction)
			execute_inst (l_inst)
		end

	Include (a_directory_name, a_file_name: STRING)
			--	Process the lines of the file named <file-name> in directory
			--	<directory-name> as though they were inserted into the test
			--	control file at the point where the `include' appears.  An
			--	`include' instruction may appear in an include file, with
			--	depth of nesting limited only by the number of files which can
			--	be open simultaneously.  Recursive includes are not currently
			--	detected and will cause eweasel to terminate with a "too many
			--	open files" error.
		require
			not_void: a_directory_name /= Void
			not_void: a_file_name /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Include_keyword)
			init_command (l_inst, "include", a_directory_name + " " + a_file_name)
			execute_inst (l_inst)
		end

	Not_
			-- Document not found. only used with `If_' ?
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Not_keyword)
			execute_inst (l_inst)
		end

	Resume_compile
			--	Resume an Eiffel compilation which was suspended due to
			--	detection of a syntax or validity error.
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Resume_compile_keyword)
			execute_inst (l_inst)
		end

	Setenv (a_name, a_value: STRING)
			--	Set environment variable <name> with <value>.
		require
			not_void: a_name /= Void
			not_void: a_value /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Setenv_keyword)
			init_command (l_inst, "setenv", a_name + " " + a_value)
			execute_inst (l_inst)
		end

	System (a_system_name: STRING)
			--	Set the name of the system, to be used to execute it.  Must
			--	match the system name in the Ace file or unexpected results
			--	will occur.  Defaults to `test' before it has been set in the
			--	current test control file.  Case is not changed since the
			--	system name is really a file name.
		require
			not_void: a_system_name /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
			l_factory: EW_EQA_TEST_FACTORY
			l_system_name: STRING
		do
			l_inst := test_command_table.item (System_keyword)

			create l_factory
			l_system_name := l_factory.environment.substitute (a_system_name)

			init_command (l_inst, "system", l_system_name)
			execute_inst (l_inst)
		end

	Test_description (a_description: STRING)
			--	A description of the test.  Includes all characters starting
			--	with the first non-white space character after `test_description'
			--	and continuing to end of line (with trailing white space
			--	characters stripped).  Case is not changed.
		require
			not_void: a_description /= Void and then not a_description.is_empty
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Test_description_keyword)
			l_inst.inst_initialize (a_description)
			execute_inst (l_inst)
		end

	Test_end
			--	If this instruction is processed, then the test is over and
			--	the test has passed.
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Test_end_keyword)
			execute_inst (l_inst)
		end

	Test_name (a_name: STRING)
			--	The name by which this test is to be known.  May be used by
			--	the automatic tester to display the name of the test it is
			--	working on.  <name> may include white space characters, but
			--	leading and trailing white space is stripped from it.  The
			--	case of the name (uppercase/lowercase) is retained with no
			--	change.
		require
			not_void: a_name /= Void and then not a_name.is_empty
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Test_name_keyword)
			l_inst.inst_initialize (a_name)

			execute_inst (l_inst)
		end

	Undefine_ (a_name: STRING)
			--	Remove any previous definition of substitution variable <name>.
			--	No error if <name> has not been defined.
		require
			not_void: a_name /= Void
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Undefine_keyword)
			init_command (l_inst, "undefine", a_name)
			execute_inst (l_inst)
		end

	Unknown
			-- Document not found...
		local
			l_inst: EW_TEST_INSTRUCTION
		do
			l_inst := test_command_table.item (Unknown_keyword)
			execute_inst (l_inst)
		end

feature -- Query

	instructions: LINKED_LIST [EW_TEST_INSTRUCTION]
			-- All instructions

;indexing
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"







end
