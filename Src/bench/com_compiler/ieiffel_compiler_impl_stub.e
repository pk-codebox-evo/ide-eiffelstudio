indexing
	description: "Implemented `IEiffelCompiler' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_COMPILER_IMPL_STUB

inherit
	IEIFFEL_COMPILER_INTERFACE

	ECOM_STUB

feature -- Access

	is_successful: BOOLEAN is
			-- Was last compilation successful?
		do
			-- Put Implementation here.
		end

	freezing_occurred: BOOLEAN is
			-- Did last compile warrant a call to finish_freezing?
		do
			-- Put Implementation here.
		end

	compiler_version: STRING is
			-- Compiler version.
		do
			-- Put Implementation here.
		end

	freeze_command_name: STRING is
			-- Eiffel Freeze command name
		do
			-- Put Implementation here.
		end

	freeze_command_arguments: STRING is
			-- Eiffel Freeze command arguments
		do
			-- Put Implementation here.
		end

feature -- Basic Operations

	compile is
			-- Compile.
		do
			-- Put Implementation here.
		end

	finalize is
			-- Finalize.
		do
			-- Put Implementation here.
		end

	remove_file_locks is
			-- Remove file locks
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IEIFFEL_COMPILER_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_eiffel_compiler::IEiffelCompiler_impl_stub %"ecom_eiffel_compiler_IEiffelCompiler_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IEIFFEL_COMPILER_IMPL_STUB

