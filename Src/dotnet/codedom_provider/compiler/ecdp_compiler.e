indexing 
	description: "Eiffel compiler CodeDom interface implementation"
	date: "$$"
	revision: "$$"

class
	ECDP_COMPILER

inherit
	SYSTEM_DLL_ICODE_COMPILER
		undefine
			equals,
			get_hash_code,
			to_string
		end

	ECDP_SHARED_DATA
		redefine
			default_rescue
		end

	ECDP_CODE_DOM_PATH
		redefine
			default_rescue
		end

create
	default_create

feature -- Basic Operations

	compile_assembly_from_source (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_source: SYSTEM_STRING): SYSTEM_DLL_COMPILER_RESULTS is
			-- Creates an assembly based on the specified `a_options' and `source'.
		require else
			non_void_options: a_options /= Void
			non_void_source: a_source /= Void
		do
			Result := from_source (a_options, a_source)
			a_options.temp_files.delete
		ensure then
			non_void_results: Result /= Void
		end

	compile_assembly_from_file (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_file_name: SYSTEM_STRING): SYSTEM_DLL_COMPILER_RESULTS is
			-- Creates an assembly based on the specified `a_options' and `a_file_name'.
		require else
			non_void_options: a_options /= Void
			non_void_file_name: a_file_name /= Void
		do
			Result := from_file (a_options, a_file_name)
			a_options.temp_files.delete
		ensure then
			non_void_results: Result /= Void
		end

	compile_assembly_from_file_batch (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_file_names: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_DLL_COMPILER_RESULTS is
			-- Compiles an assembly based on the specified `a_options' and `file_names'.
		require else
			non_void_options: a_options /= Void
			non_void_file_names: a_file_names /= Void
		do
			Result := from_file_batch (a_options)
			a_options.temp_files.delete
		ensure then
			non_void_results: Result /= Void
		end

	compile_assembly_from_dom (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_compilation_unit: SYSTEM_DLL_CODE_COMPILE_UNIT): SYSTEM_DLL_COMPILER_RESULTS is
			-- Creates an assembly based on the specified `a_options' and `a_compilation_unit' (the text to compile).
		require else
			non_void_options: a_options /= Void
			non_void_compilation_unit: a_compilation_unit /= Void
		do
			Result := from_dom (a_options, a_compilation_unit)
			a_options.temp_files.delete
		ensure then
			non_void_results: Result /= Void
		end

	compile_assembly_from_source_batch (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_sources: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_DLL_COMPILER_RESULTS is
			-- Compiles an assembly based on the specified `a_options' and `sources'.
		require else
			non_void_options: a_options /= Void
			non_void_sources: a_sources /= Void
		do
			Result := from_source_batch (a_options, a_sources)
			a_options.temp_files.delete
		ensure then
			non_void_results: Result /= Void
		end

	compile_assembly_from_dom_batch (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_compilation_units: NATIVE_ARRAY [SYSTEM_DLL_CODE_COMPILE_UNIT]): SYSTEM_DLL_COMPILER_RESULTS is
			-- Compiles an assembly based on the specified a_options.
		require else
			non_void_options: a_options /= Void
			non_void_compilation_units: a_compilation_units /= Void
		do
			Result := from_dom_batch (a_options, a_compilation_units)
			a_options.temp_files.delete
		ensure then
			non_void_results: Result /= Void
		end

feature {NONE} -- Private Implementation

	from_source (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_source:SYSTEM_STRING): SYSTEM_DLL_COMPILER_RESULTS is
		require
			non_void_options: a_options /= Void
			non_void_source: a_source /= Void
		local
			l_sources: NATIVE_ARRAY [SYSTEM_STRING]
		do
			create l_sources.make (1)
			l_sources.put (1, a_source)
			Result := from_source_batch (a_options, l_sources)
		ensure
			non_void_results: Result /= Void
		end

	from_dom (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_compile_unit: SYSTEM_DLL_CODE_COMPILE_UNIT): SYSTEM_DLL_COMPILER_RESULTS is
		require
			non_void_options: a_options /= Void
			non_void_compile_unit: a_compile_unit /= Void
		local
			l_compile_units: NATIVE_ARRAY [SYSTEM_DLL_CODE_COMPILE_UNIT]
		do
			create l_compile_units.make (1)
			l_compile_units.put (0, a_compile_unit)
			Result := from_dom_batch (a_options, l_compile_units)
		ensure
			non_void_results: Result /= Void
		end

	from_file (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_file_name: SYSTEM_STRING): SYSTEM_DLL_COMPILER_RESULTS is
		require
			non_void_options: a_options /= Void
			non_void_file_name: a_file_name /= Void
		local
			l_text_writer: STREAM_WRITER
			l_directory: SYSTEM_STRING
			l_index: INTEGER
			l_res: SYSTEM_OBJECT
			l_class_name, l_path: STRING
		do
				-- Create temporary directory
			l_directory := a_options.temp_files.base_path
			if not feature {SYSTEM_DIRECTORY}.exists (l_directory) then
				l_res := feature {SYSTEM_DIRECTORY}.create_directory (l_directory)
			end

			Ace_file.reset
				-- create ace file to compile file associated to `a_file_name'.
			set_temporary_files (a_options.temp_files)
			Ace_file.set_include_debug_info (a_options.include_debug_information)
			Ace_file.set_extension (assembly_extension)
			create l_class_name.make_from_cil (a_file_name)
			l_index := l_class_name.last_index_of ('\', l_class_name.count)
			l_class_name.remove_head (l_index)
			l_class_name.remove_tail (2)
			Ace_file.set_root_class_name (l_class_name)
			Ace_file.set_root_class_creation_routine ("default_create")
			Ace_file.set_system_name (system_name)
			create l_text_writer.make_from_path (ace_file_path)
			Ace_file.set_text_writer (l_text_writer)
			create l_path.make_from_cil (a_file_name)
			l_path.keep_head (l_path.last_index_of ('\', l_path.count) - 1)
			Ace_file.set_path_to_generated_src (l_path)
			initialize_referenced_assemblies (a_options.referenced_assemblies)
			Ace_file.out_code
			Result := from_file_batch (a_options)
			l_text_writer.close
		ensure
			non_void_results: Result /= Void
		end

	from_source_batch (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_sources: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_DLL_COMPILER_RESULTS is
		require
			non_void_options: a_options /= Void
			non_void_sources: a_sources /= Void
		local
			i: INTEGER
			l_file_name: SYSTEM_STRING
			l_sw: STREAM_WRITER
			l_res: SYSTEM_OBJECT
			l_rescued: BOOLEAN
		do
			if not l_rescued then
				l_res := feature {SYSTEM_DIRECTORY}.create_directory (a_options.temp_files.temp_dir)
				Ace_file.reset
				from
				until
					i = a_sources.count
				loop
					l_file_name := a_options.temp_files.add_extension (Eiffel_file_extension)
					create l_sw.make_from_path (feature {SYSTEM_STRING}.concat (a_options.temp_files.temp_dir, l_file_name))
					l_sw.write_string (a_sources.item (i))
					l_sw.close
					i := i + 1
				end

				Result := from_file_batch (a_options)
			else
				Result := Error_compilation_results (a_options.temp_files)
			end
		ensure
			non_void_results: Result /= Void
		rescue
			(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			l_rescued := True
			retry
		end

	from_dom_batch (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_compile_units: NATIVE_ARRAY [SYSTEM_DLL_CODE_COMPILE_UNIT]): SYSTEM_DLL_COMPILER_RESULTS is
		require
			non_void_options: a_options /= Void
			non_void_compile_units: compile_units /= Void
		local
			i: INTEGER
			l_generator: ECDP_GENERATOR
			l_options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS
			l_output_file_path: STRING
			l_output_file: STREAM_WRITER
			l_directory: SYSTEM_STRING
			l_res: SYSTEM_OBJECT
			l_rescued: BOOLEAN
			l_writer: STREAM_WRITER
		do
			if not l_rescued then
				from
				until
					i = a_compile_units.count
				loop
					l_directory := a_options.temp_files.base_path
					if not feature {SYSTEM_DIRECTORY}.exists (l_directory) then
						l_res := feature {SYSTEM_DIRECTORY}.create_directory (l_directory)
					end

					set_temporary_files (a_options.temp_files)

					create l_generator
					create l_options.make
					Ace_file.reset
					Ace_file.set_extension (Assembly_extension)
					Ace_file.set_include_debug_info (a_options.include_debug_information)
					Ace_file.set_system_name (system_name)
					Ace_file.set_path_to_generated_src (a_options.temp_files.base_path)

					initialize_referenced_assemblies (a_options.referenced_assemblies)

					create l_output_file_path.make_from_cil (a_options.temp_files.base_path)
					l_output_file_path.append ("\generated_code.e")
					create l_output_file.make_from_path (l_output_file_path)

					l_generator.generate_code_from_compile_unit (a_compile_units.item (i), l_output_file, l_options)

					create l_writer.make (ace_file_path)
					Ace_file.set_text_writer (l_writer)
					temporary_files.add_file (ace_file_path, True)
					Ace_file.out_code
					l_writer.close

					i := i + 1
				end
				
				Result := from_file_batch (a_options)
			else
				Result := Error_compilation_results (a_options.temp_files)
			end
		ensure
			non_void_result: Result /= Void
		rescue
			(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			l_rescued := True
			retry
		end

	from_file_batch (a_options: SYSTEM_DLL_COMPILER_PARAMETERS): SYSTEM_DLL_COMPILER_RESULTS is
			-- Launch compilation.
		require
			non_void_options: a_options /= Void
		local
			rescued: BOOLEAN
    	do
			if not rescued then
				Result := compile (a_options)
			else
				Result := error_compilation_results (a_options.temp_files)
			end
		ensure
			non_void_result: Result /= Void
		rescue
			(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			rescued := True
			retry
    	end

	compile (a_options: SYSTEM_DLL_COMPILER_PARAMETERS): SYSTEM_DLL_COMPILER_RESULTS is
			-- Open file with full name: raise an exception if compiler do not exist else
			-- execute launch compiler
		require
			non_void_options: a_options /= Void
		local
			l_exec: EXECUTION_ENVIRONMENT
			l_output_file, l_ace_file_path, l_current_dir, l_dir, l_system: STRING
			l_np: SYSTEM_DLL_PROCESS
			l_nm: SYSTEM_STRING
			l_si: SYSTEM_DLL_PROCESS_START_INFO
			l_ce: SYSTEM_DLL_COMPILER_ERROR
			l_assembly_path, l_assembly_final_path, l_pdb_path, l_pdb_final_path: SYSTEM_STRING
			l_res: INTEGER
		do
			set_environment_variable ("ISE_EIFFEL", Codedom_installation_path)
			set_environment_variable ("ISE_PLATFORM", "windows")
			set_environment_variable ("ISE_C_COMPILER", "msc")
			create l_exec
			create Result.make (a_options.temp_files)

			create l_output_file.make_from_cil (a_options.temp_files.base_path)

				-- Launch ec.exe
			create l_dir.make (l_output_file.count + 14) -- "\EIFGEN\W_code".count = 14
			l_dir.append (l_output_file)
			l_dir.append ("\EIFGEN")
			if feature {SYSTEM_DIRECTORY}.exists (l_dir) then
				feature {SYSTEM_DIRECTORY}.delete (l_dir, True)
			end
			create l_si.make_from_file_name (Eiffel_compiler_path + Compiler_name)
			create l_ace_file_path.make_from_cil (ace_file_path)
			l_si.set_arguments (" -precompile -ace %"" + l_ace_file_path + "%" -batch  -project_path %"" + l_output_file + "%"")
			l_si.set_use_shell_execute (False)
			l_si.set_redirect_standard_error (True)
			l_np := feature {SYSTEM_DLL_PROCESS}.start_process_start_info (l_si)
			l_nm := l_np.standard_error.read_to_end
			l_np.wait_for_exit

				-- Parse result of ec execution.
			parse_compiler_output (l_nm, Result)

				-- Launch finish_freezing.exe
			if not Result.errors.has_errors then
				l_current_dir := l_exec.current_working_directory
				l_dir.append ("\W_code")
				if feature {SYSTEM_DIRECTORY}.exists (l_dir) then
					l_exec.change_working_directory (l_dir)
					create l_si.make_from_file_name ((Eiffel_compiler_path + Finish_freezing_name).to_cil)
					l_si.set_arguments (Finish_freezing_args)
					l_si.set_use_shell_execute (False)
					l_si.set_redirect_standard_error (True)
					l_np := feature {SYSTEM_DLL_PROCESS}.start_process_start_info (l_si)
					l_nm := l_np.standard_error.read_to_end
					l_np.wait_for_exit

						-- finish freezing error?
					create l_system.make_from_cil (system_name)
					l_assembly_path := l_dir + "\" + l_system + "." + Assembly_extension
					if not feature {SYSTEM_FILE}.exists (l_assembly_path) then
						create l_ce.make
						l_ce.set_error_text (l_nm)
						l_res := Result.errors.add (l_ce)
						Result.set_native_compiler_return_value (1)
					else
							-- Entire compilation succeeded.

							-- Copy generated assembly in root directory
						l_assembly_final_path := l_output_file + "\" + l_system + "." + Assembly_extension
						feature {SYSTEM_FILE}.copy (l_assembly_path, l_assembly_final_path)

							-- Copy PDB
						if a_options.include_debug_information then
							l_pdb_path := l_dir + "\" + l_system + ".pdb"
							l_pdb_final_path := l_output_file + "\" + l_system + ".pdb"
							feature {SYSTEM_FILE}.copy (l_pdb_path, l_pdb_final_path)
							Result.temp_files.add_file (l_assembly_final_path, True)
						end

						Result.set_compiled_assembly (feature {ASSEMBLY}.load_from (l_assembly_final_path))
						Result.set_path_to_assembly (l_assembly_final_path)
						a_options.set_output_assembly (l_assembly_final_path)

						delete_compilation_temporary_files (l_output_file, l_system)
					end
				end
				l_exec.change_working_directory (l_current_dir)
			end
		ensure
			non_void_result: Result /= Void
		end

	delete_compilation_temporary_files (a_compilation_path: STRING; a_system_name: STRING) is
			-- Delete EIFGEN, epr and rc files.
		require
			valid_compilation_path: a_compilation_path /= Void and then not a_compilation_path.is_empty
			valid_system_name: a_system_name /= Void and then not a_system_name.is_empty
		local
			l_retried: BOOLEAN
			l_epr_file_path, l_ressource_file_path: SYSTEM_STRING
		do
			if not l_retried then
					-- Delete the epr file.
				l_epr_file_path := a_compilation_path + "\precomp.epr"
				--l_epr_file_path := (a_compilation_path + "\" + a_system_name + ".epr").to_cil
				if feature {SYSTEM_FILE}.exists (l_epr_file_path) then
					feature {SYSTEM_FILE}.delete (l_epr_file_path)
				end

					-- Delete the rc file.
				l_ressource_file_path := a_compilation_path + "\" + a_system_name + ".rc"
				if feature {SYSTEM_FILE}.exists (l_ressource_file_path) then
					feature {SYSTEM_FILE}.delete (l_ressource_file_path)
				end

					-- Delete the entire EIFGEN directory.
				if feature {SYSTEM_DIRECTORY}.exists (a_compilation_path + "\EIFGEN") then
					feature {SYSTEM_DIRECTORY}.delete_string_boolean (a_compilation_path + "\EIFGEN", True)
				end
			end
		rescue
			(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			l_retried := True
			retry
		end
		
feature -- Basic Operations

	initialize_referenced_assemblies (a_referenced_assemblies: SYSTEM_DLL_STRING_COLLECTION) is
			-- initialize referenced assemblies.
		require
			non_void_referenced_assemblies: a_referenced_assemblies /= Void
		do
		end

	parse_compiler_output (a_compiler_output: SYSTEM_STRING; a_options: SYSTEM_DLL_COMPILER_RESULTS) is
			-- Parse `a_compiler_output' and set a_options with result of parsing.
		require
			non_void_a_compiler_output: a_compiler_output /= Void
			not_empty_a_compiler_output: a_compiler_output.length > 0
			non_void_options: a_options /= Void
		local
			l_ce: SYSTEM_DLL_COMPILER_ERROR			
			l_res: SYSTEM_OBJECT
			l_output_compiler_parser: ECDP_COMPILER_OUTPUT_PARSER
		do
			create l_output_compiler_parser.make
			l_output_compiler_parser.parse (a_compiler_output)
			if not l_output_compiler_parser.successfull_compilation then
				create l_ce.make
				l_ce.set_error_text (output_compiler_parser.error_text.to_cil)
				l_ce.set_line (output_compiler_parser.error_line)
				l_ce.set_column (0)
				l_ce.set_error_number (output_compiler_parser.error_code.to_cil)
				l_ce.set_is_warning (False)
				l_ce.set_file_name ("Unknown")
				l_res := a_options.errors.add (l_ce)
				l_res := a_options.output.add (a_compiler_output)
				a_options.set_native_compiler_return_value (1)
			else
				a_options.set_native_compiler_return_value (0)
			end
		end

	error_compilation_results (a_temp_files: SYSTEM_DLL_TEMP_FILE_COLLECTION): SYSTEM_DLL_COMPILER_RESULTS is
			-- Set compiler exception error in `a_results'.
		local
			l_ce: SYSTEM_DLL_COMPILER_ERROR
			l_res: SYSTEM_OBJECT
		do
			create Result.make (a_temp_files)		
			create l_ce.make
			l_ce.set_error_text ("Fatal exception occured during compilation.")
			l_res := Result.errors.add (l_ce)
			Result.set_native_compiler_return_value (1)
		ensure
			compilation_failed: Result /= Void and then Result.native_compiler_return_value = 1
		end

	default_rescue is
			-- Handle exceptions
		local
			l_event_manager: ECDP_EVENT_MANAGER
		do
			create l_event_manager
			l_event_manager.process_exception
		end

feature {NONE} -- Implementation

	set_environment_variable (a_name, a_value: STRING) is
			-- Set environment variable `a_name' with `a_value'
		local
			l_name, l_value: C_STRING
			l_success: BOOLEAN
		do
			create l_name.make (a_name)
			create l_value.make (a_value)
			l_success := c_set_environment_variable (l_name.item, l_value.item)
			check
				environment_variable_set: feature {ENVIRONMENT}.expand_environment_variables ("%%" + a_name + "%%").compare_to_string (a_value) = 0
			end
		end

feature {NONE} -- External

	c_set_environment_variable (a_name, a_value: POINTER): BOOLEAN is
			-- Set environment variable `a_name' with value `a_value'.
			-- Return True if successful.
		external
			"C macro signature (LPCTSTR, LPCTSTR): EIF_BOOLEAN use <windows.h>"
		alias
			"SetEnvironmentVariable"
		end

feature {NONE} -- Private Access

	Assembly_extension: STRING is "dll"
			-- Assembly extension.

	Compiler_name: STRING is "ec.exe"
			-- Eiffel compiler name.

	Finish_freezing_name: STRING is "finish_freezing.exe"
			-- Command line to finsih freezing.

	Finish_freezing_args: STRING is "-silent"
			-- Finish freezing arguments.

invariant
	non_void_Eiffel_file_extension: Eiffel_file_extension /= Void
	non_empty_Eiffel_file_extension: not Eiffel_file_extension.is_empty

end -- class ECDP_COMPILER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------