indexing
	description: "Implemented `IEiffelCompiler' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_COMPILER_IMPL_PROXY

inherit
	IEIFFEL_COMPILER_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_ieiffel_compiler_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Access

	is_successful: BOOLEAN is
			-- Was last compilation successful?
		do
			Result := ccom_is_successful (initializer)
		end

	freezing_occurred: BOOLEAN is
			-- Did last compile warrant a call to finish_freezing?
		do
			Result := ccom_freezing_occurred (initializer)
		end

	compiler_version: STRING is
			-- Compiler version.
		do
			Result := ccom_compiler_version (initializer)
		end

	freeze_command_name: STRING is
			-- Eiffel Freeze command name
		do
			Result := ccom_freeze_command_name (initializer)
		end

	freeze_command_arguments: STRING is
			-- Eiffel Freeze command arguments
		do
			Result := ccom_freeze_command_arguments (initializer)
		end

	has_signable_generation: BOOLEAN is
			-- Is the compiler a trial version.
		do
			Result := ccom_has_signable_generation (initializer)
		end

	output_pipe_name: STRING is
			-- Output pipe's name
		do
			Result := ccom_output_pipe_name (initializer)
		end

	is_output_piped: BOOLEAN is
			-- Is compiler output sent to pipe `output_pipe_name'
		do
			Result := ccom_is_output_piped (initializer)
		end

	can_run: BOOLEAN is
			-- Can product be run? (i.e. is it activated or was run less than 10 times)
		do
			Result := ccom_can_run (initializer)
		end

feature -- Basic Operations

	compile is
			-- Compile.
		do
			ccom_compile (initializer)
		end

	finalize is
			-- Finalize.
		do
			ccom_finalize (initializer)
		end

	precompile is
			-- Precompile.
		do
			ccom_precompile (initializer)
		end

	compile_to_pipe is
			-- Compile with piped output.
		do
			ccom_compile_to_pipe (initializer)
		end

	finalize_to_pipe is
			-- Finalize with piped output.
		do
			ccom_finalize_to_pipe (initializer)
		end

	precompile_to_pipe is
			-- Precompile with piped output.
		do
			ccom_precompile_to_pipe (initializer)
		end

	expand_path (a_path: STRING): STRING is
			-- Takes a path and expands it using the env vars.
			-- `a_path' [in].  
		do
			Result := ccom_expand_path (initializer, a_path)
		end

	generate_msil_keyfile (filename: STRING) is
			-- Generate a cyrptographic key filename.
			-- `filename' [in].  
		do
			ccom_generate_msil_keyfile (initializer, filename)
		end

	remove_file_locks is
			-- Remove file locks
		do
			ccom_remove_file_locks (initializer)
		end

	set_output_pipe_name (return_value: STRING) is
			-- Set output pipe's name
			-- `return_value' [in].  
		do
			ccom_set_output_pipe_name (initializer, return_value)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_ieiffel_compiler_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_compile (cpp_obj: POINTER) is
			-- Compile.
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"]()"
		end

	ccom_finalize (cpp_obj: POINTER) is
			-- Finalize.
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"]()"
		end

	ccom_precompile (cpp_obj: POINTER) is
			-- Precompile.
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"]()"
		end

	ccom_compile_to_pipe (cpp_obj: POINTER) is
			-- Compile with piped output.
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"]()"
		end

	ccom_finalize_to_pipe (cpp_obj: POINTER) is
			-- Finalize with piped output.
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"]()"
		end

	ccom_precompile_to_pipe (cpp_obj: POINTER) is
			-- Precompile with piped output.
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"]()"
		end

	ccom_is_successful (cpp_obj: POINTER): BOOLEAN is
			-- Was last compilation successful?
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"](): EIF_BOOLEAN"
		end

	ccom_freezing_occurred (cpp_obj: POINTER): BOOLEAN is
			-- Did last compile warrant a call to finish_freezing?
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"](): EIF_BOOLEAN"
		end

	ccom_compiler_version (cpp_obj: POINTER): STRING is
			-- Compiler version.
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_expand_path (cpp_obj: POINTER; a_path: STRING): STRING is
			-- Takes a path and expands it using the env vars.
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"](EIF_OBJECT): EIF_REFERENCE"
		end

	ccom_generate_msil_keyfile (cpp_obj: POINTER; filename: STRING) is
			-- Generate a cyrptographic key filename.
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_freeze_command_name (cpp_obj: POINTER): STRING is
			-- Eiffel Freeze command name
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_freeze_command_arguments (cpp_obj: POINTER): STRING is
			-- Eiffel Freeze command arguments
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_has_signable_generation (cpp_obj: POINTER): BOOLEAN is
			-- Is the compiler a trial version.
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"](): EIF_BOOLEAN"
		end

	ccom_remove_file_locks (cpp_obj: POINTER) is
			-- Remove file locks
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"]()"
		end

	ccom_output_pipe_name (cpp_obj: POINTER): STRING is
			-- Output pipe's name
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_set_output_pipe_name (cpp_obj: POINTER; return_value: STRING) is
			-- Set output pipe's name
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_is_output_piped (cpp_obj: POINTER): BOOLEAN is
			-- Is compiler output sent to pipe `output_pipe_name'
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"](): EIF_BOOLEAN"
		end

	ccom_can_run (cpp_obj: POINTER): BOOLEAN is
			-- Can product be run? (i.e. is it activated or was run less than 10 times)
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"](): EIF_BOOLEAN"
		end

	ccom_delete_ieiffel_compiler_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"]()"
		end

	ccom_create_ieiffel_compiler_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompiler_impl_proxy %"ecom_eiffel_compiler_IEiffelCompiler_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IEIFFEL_COMPILER_IMPL_PROXY

